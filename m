Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3D4C2D14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiBXNcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiBXNcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:32:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B354F8C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:31:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u16so1850772pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vB1qPinuIx5GJjxM9OclEcDCM4HkOuUdI7J7QIrR8QM=;
        b=CMWX0MHQCq61Rcj3Lh1fYx6ag2pjCyHBbAm3PFhe8VuNHoL4dmtuRGbuoEkThL3SLs
         /CZAsggglroair2/MduxqDWQIqBnmYYEojzVncOpv9ZLaA06+XaNo8CMJr/ZDwKGevNi
         OPrU1ZsR15gYoyDeMerIHUzqjy0fKD5EWJsHLaKAFr0YrURkU35895YhEBeCHOWZWM/F
         j965QZkZWovbjAZkxMaEInABShRIzQzyoQmrDd1O0WUIV6Ih1Puc+sVpJj+h/a2tHvS+
         Hsz9K8gtVF/9yFbK1kxfdJCJ5MoM776lDhCoyh1lidRmpz/mSQq6ya0rMp9HNui6rFBE
         B4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vB1qPinuIx5GJjxM9OclEcDCM4HkOuUdI7J7QIrR8QM=;
        b=3qtoJBJgn5IFFMS9+wFAw8tZf/2vr5EZd39s0BehhtOJNbTOIzlVBiCzHOKmtw7Tc/
         yFYoSSxV7Kan4nCzjsTptM3QM24n9nPDg3YmXNxf5EvEydAW59AJy2YUiEbzQbavRlNi
         q4zvbGEiGL7F1fM3NDRjwNDatLHmXO5I9yL7wO/b38ZbBaNbdln3DOOcQWhjyBcE7qNm
         eOZ1sczTe2P/1+xVthFN0DCWCN9wLkxTPeuWs9gSKpnq8l7LrzyaUaLgJZR+8Hp3ZHfi
         glJQJONQ8dodR/kUZ2FdwV4JTIBA9Di5KSMlQBnA6Xc3nWNXRem/pHOINQFuLge/O9HL
         +LsQ==
X-Gm-Message-State: AOAM533ChE/tDsgMkMjEo1VxcZpZvKGVVtbNwFffvqgVu3tqk41ceDFM
        Tvf6xHJDcPokRpDk0V3KDHg=
X-Google-Smtp-Source: ABdhPJyJwrxYkxGuYUqzQh0P8T0d3Irzg87pct15JGOUsVd4Muoy4g6GUZ84E+A1ouGwDfgLhI4fbw==
X-Received: by 2002:a65:4348:0:b0:375:9840:b064 with SMTP id k8-20020a654348000000b003759840b064mr1083683pgq.270.1645709516842;
        Thu, 24 Feb 2022 05:31:56 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id q1sm3404717pfs.112.2022.02.24.05.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:31:56 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:31:51 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 3/5] mm/slab: Do not call kmalloc_large() for unsupported
 size
Message-ID: <YheIxyO/2lcD+aBR@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-4-42.hyeyoo@gmail.com>
 <8915b858-b46d-0acd-bebd-80a0c9882a7e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8915b858-b46d-0acd-bebd-80a0c9882a7e@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 01:48:47PM +0100, Vlastimil Babka wrote:
> On 2/21/22 11:53, Hyeonggon Yoo wrote:
> > SLAB's kfree() does not support freeing an object that is allocated from
> > kmalloc_large(). Fix this as SLAB do not pass requests larger than
> > KMALLOC_MAX_CACHE_SIZE directly to page allocator.
> 
> AFAICS this issue is limited to build-time constant sizes. Might be better
> to make this a build error rather than build-time NULL?

Right. And sounds better. But what about another direction as Matthew said:
passing large requests to page allocator like SLUB?

I think it's better for maintenance. Any obstacles for this direction?

Thank you!

> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Hyeonggon
