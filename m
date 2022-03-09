Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485074D3D32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbiCIWlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiCIWln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:41:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE712220F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:40:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g19so3493483pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pvPyQOUK1Gw9CokGjQgnCkQhkHHplgDsrtGMviZ3X7A=;
        b=BaBvApgiq6eKkKHjV5y9VNHSX8YDVNOkXj5MayW95Bs0iCadLeVSVrBWCSdznB/PA4
         0gKQ2wbaRy7xLMnNrIapT0t2YDCwEkZbX6Z2RsTW+Vxjk9bX0Nl42o76dLzzL3OdIF+b
         8qXFqJI1VXyVwT/F93OTri8tbdhSHqlQOdcASY9uXy8RcNqd6XwZwMCNRWhyh2QG/Nea
         9XCa2PeR7oijZX6OcHOj3mt6MMzGw0+QbQea2MlyfD7hGKunuDfDz2l+8uzuyyeBH6fr
         TBk2OQETxmRVJeM0n+PhbCEGu8kAyfbQXYuQNAAZ2ouSFjKQ+gE076+73neyZ7eCz52M
         wcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pvPyQOUK1Gw9CokGjQgnCkQhkHHplgDsrtGMviZ3X7A=;
        b=iMcOhwtH+Off9uiIP4pGERoxZUFR5Pc/LN/v8KYU8g7IkcUsQR1NiFbd4cAJE8IOjG
         sxQ8xF//tyc/mhax3I3dFvCrJ1ZMai3+Q/kuse+D19xLUVZM35Itut/Tk6/zU0boS0Qj
         91CeWRDm7DB6SODU9+up3vLVIuXwJPO8iaAqpHyCPmSWP+HC5SNqg7F3xibWU6CEebl/
         KST59KEZsGb0us5vqdyAEJUkceG7runt/ng7C0GbMEV6oVZJTTBYzgCaGCcstA9sQIU4
         SdvmmNohUo3B5J8ndgjLeQOveZ4Q2iyLD/5oBamZ+N5eJ+KM17A18j6iEguTXbqgatRB
         h9bA==
X-Gm-Message-State: AOAM532PE52OzgmBjTz/LqFUawq1NS0ogWSIjIoKkYdicdMgRdf36Tmc
        7ryj56MfvAzjYeOmRwMqVvU=
X-Google-Smtp-Source: ABdhPJw3G9FAPbU5cZQShJnDrdis4xALn9ruAKxBY0EJXFu4TjXvyQ0wqkxKipN1LGB2EDM5nIH+dg==
X-Received: by 2002:a65:61ad:0:b0:378:8f01:7674 with SMTP id i13-20020a6561ad000000b003788f017674mr1576104pgv.314.1646865643638;
        Wed, 09 Mar 2022 14:40:43 -0800 (PST)
Received: from google.com ([2620:15c:211:201:aee3:831e:b1d0:905f])
        by smtp.gmail.com with ESMTPSA id 2-20020a631342000000b0037487b6b018sm3166928pgt.0.2022.03.09.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:40:43 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 9 Mar 2022 14:40:41 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fs: fix lru_cache_disabled race in bh_lru
Message-ID: <Yiks6WHATBtLZtmM@google.com>
References: <20220308180709.2017638-1-minchan@kernel.org>
 <20220309140627.eeaa069daa921dbef64f8970@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309140627.eeaa069daa921dbef64f8970@linux-foundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:06:27PM -0800, Andrew Morton wrote:
> On Tue,  8 Mar 2022 10:07:09 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Check lru_cache_disabled under bh_lru_lock. Otherwise, it could
> > introduce race below and it fails to migrate pages containing
> > buffer_head.
> > 
> >    CPU 0					CPU 1
> > 
> > bh_lru_install
> >                                        lru_cache_disable
> >   lru_cache_disabled = false
> >                                        atomic_inc(&lru_disable_count);
> > 				       invalidate_bh_lrus_cpu of CPU 0
> > 				       bh_lru_lock
> > 				       __invalidate_bh_lrus
> > 				       bh_lru_unlock
> >   bh_lru_lock
> >   install the bh
> >   bh_lru_unlock
> 
> What are the user-visible runtime effects of this bug?

Once the race happens, CMA allocation fails, which is critical for
the workload CMA allocation depends.

> 
> Is a cc:stable needed?

Ah, missed it. I think it would be rare to trigger the race considering
how CMA allocation would be rare but once it happens, it makes the CMA
allocation failure, which is critical for some. And the patch size is
small enough so I think it's worth to add in the stable.

> 
> Should there be a reported-by?

I found it on my own while I reviewed Marcelo's other patchset so
I don't think we need to add my reported-by.

Andrew, please tell me if you want me resend it.
