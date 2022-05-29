Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07118536F2A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiE2C60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 22:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiE2C6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 22:58:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C549CC87
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 19:58:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so7640996pjt.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 19:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xqZyFR77LZa5HhEYDYSFVBgW+mJdeOilKX5Bk1mPIAU=;
        b=c8lMNY/sSIphdNiJshAYMu1CqUjbD5PanBJG75iQdDbbSaL+tBEsMNufhxMbyMmLq9
         S6I3H22KxlNT+gAJkNrkj6Bz0b16LryVW0uLjqQqQTSnundCo/WIqxpvHttLS/ACJfLJ
         HVLY3NDiSnjjB5erjgkc8B3XunjQa7waGRcwPiLNAXldXON1Fk1mbG1Dp3dymRnZ6tjn
         8zVpsbRj7VGyqBKb7jNxV70lfvZxznUS0G8RwR8IzMrj0uV+qiiJQepoHH0r2Xm03TSU
         J2H/kBaD+5EmHU0V97btF9mL0slO+zMalJunTAkzK7WsPs+AjvE1QDElNKacsjg+omgK
         P1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xqZyFR77LZa5HhEYDYSFVBgW+mJdeOilKX5Bk1mPIAU=;
        b=z+RsfuGDPyX0qfhl/0GmbbkHFf6ywOm3Qxq0NXmCUGQ9DdX/k4D3pbt7NydX4XowNo
         Kc4ooszDJN3U8174ovsxuWGPPmxY+78kJIuiXVEYbs+vRf/zeT46skI311n+Rh1gdNyP
         iOjEqTDvr8w07nWhZEbU2+XUuUtZuESa1lGlNdGfcYXjJGOUAhxNEDe7o774076wj1Ah
         +ShFCyrThtrKhZOQkIbMQ79eLDDnPQoSDguFub9NJ9IQJyvCCnP2desNvp/hBCfN088r
         6mNFtLQOUuZpFcKKw+v99TqDkICzp1PJvbG8ebG6AO1swkXZ+yvIAVsnarpkmDVuXiAg
         ndeA==
X-Gm-Message-State: AOAM5335P3lxueOKe2fafC8C5JB/k2lOuj5a1cvpkgOhnr2M/YHfa33V
        fO3m5fwGlo8MPMlVQVf++4jwpw==
X-Google-Smtp-Source: ABdhPJxWGC7LKAf8hQu669+YBA7+lPsqdEug+mNQnYOi/nQ9+B3jLHYf5/agGPl5H68pJ9yL/Vvvrg==
X-Received: by 2002:a17:903:209:b0:161:7f66:b9e0 with SMTP id r9-20020a170903020900b001617f66b9e0mr33873163plh.73.1653793103197;
        Sat, 28 May 2022 19:58:23 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c2d400b001637704269fsm1974580pla.223.2022.05.28.19.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 19:58:22 -0700 (PDT)
Date:   Sun, 29 May 2022 10:58:18 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     bh1scw@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: replace alloc_pages with folio_alloc
Message-ID: <YpLhSokkrPrXjNXP@FVFYT0MHHV2J.googleapis.com>
References: <20220528161157.3934825-1-bh1scw@gmail.com>
 <YpJNX7PN8hAFgVwj@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpJNX7PN8hAFgVwj@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 05:27:11PM +0100, Matthew Wilcox wrote:
> On Sun, May 29, 2022 at 12:11:58AM +0800, bh1scw@gmail.com wrote:
> > From: Fanjun Kong <bh1scw@gmail.com>
> > 
> > This patch will use folio allocation functions for allocating pages.
> 
> That's not actually a good idea.  folio_alloc() will do the
> prep_transhuge_page() step which isn't needed for slab.
>

You mean folio_alloc() is dedicated for THP allocation?  It is a little
surprise to me.  I thought folio_alloc() is just a variant of alloc_page(),
which returns a folio struct instead of a page.  Seems like I was wrong.
May I ask what made us decide to do this?

Thanks.

