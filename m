Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104994B9577
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiBQBZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:25:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiBQBZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:25:45 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC31F227A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:25:32 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id x3so5457805qvd.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=JSwIX/NYsZ0hu1H4cWPLct5FZqQSU6n5RuasJx3jNYU=;
        b=FYI6wf5rAV7stlDCNtzPtDrK1dHkqGs7MmcJ89nBm65MP2Jvub4XNSSk5HywC2U6lI
         XRZQg4uxL8R9+5lROLpwIQODTFYRZO5cWvoCJdPBg5SP78CjJXMh7DIAeK9QM9HKnUmI
         /ceJRHrJhbUuJWWN6Hxy/P8v0QguslJtOfb1lSOrevd9jgowjV4UJ6rijrqO1Vy70H1z
         yW0aZrxTHZZry3QdUoyGk74AtvQEFrmGt6vLqQQiDpa17ggZbUII4iFsgEtLbA8spb14
         obsc/6yIsOPF3eB+8z3us5wnWZEt0604uHto0CVsg5Yg+7O2m+bR0pr8o+R3ztndiZGm
         2Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=JSwIX/NYsZ0hu1H4cWPLct5FZqQSU6n5RuasJx3jNYU=;
        b=V++1lQGCpDVJV9EvwzKERzlQOHgCGr9hYXsgWhH5fy5FERFxOWu5UMhOdINjHf+7IJ
         f1WizZla1AeJ2kShNSNiBkqij9pVsjnL3imNMpGtzIHQggE7q4IwnZ3Fy/hI27R5MJ5w
         z6gDBEf4es1F2UmVJSGSkJ5qQEQMIViOwpmQgdNJx7+KTRHPuzYBcjcuomqU4/t6sM1Y
         eZm0hC/uk3yz1SDwdLk3ZwkUu1ywWhSgXPBnJ2pk4DbHA4dXp2dj5muIwHnsWl+FZO6y
         H5Tb9kBrNFhKtcmJ2aTnL2qtfRqD8h5MtAqsXf3BcMwIqU3NDxkwjzHoOeP3st/IBS02
         /arQ==
X-Gm-Message-State: AOAM5338wScbFczzAA5Ivc7hBFcZOr3WB+nJB9At/MTnw9P64JxOFai1
        vIXuG+tK5QDyp4/B0U4lti4dqg==
X-Google-Smtp-Source: ABdhPJyOOCKmr8SIw+51Vzp+dRpE7VvJPT+7wvmz2zPTKISknB+5BagXhnJYCc0xuen7LBh6mp7T+g==
X-Received: by 2002:a05:622a:4f:b0:2c9:a3f9:debd with SMTP id y15-20020a05622a004f00b002c9a3f9debdmr544892qtw.689.1645061131319;
        Wed, 16 Feb 2022 17:25:31 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c21sm22843184qte.68.2022.02.16.17.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 17:25:30 -0800 (PST)
Date:   Wed, 16 Feb 2022 17:25:17 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     cgel.zte@gmail.com, hughd@google.com, kirill@shutemov.name,
        songliubraving@fb.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Fix shmem huge page failed to set F_SEAL_WRITE
 attribute problem
In-Reply-To: <1f486393-3829-4618-39a1-931afc580835@oracle.com>
Message-ID: <d6e74520-88bc-9f57-e189-8e4f389726e@google.com>
References: <20220215073743.1769979-1-cgel.zte@gmail.com> <1f486393-3829-4618-39a1-931afc580835@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022, Mike Kravetz wrote:
> On 2/14/22 23:37, cgel.zte@gmail.com wrote:
> > From: wangyong <wang.yong12@zte.com.cn>
> > 
> > After enabling tmpfs filesystem to support transparent hugepage with the
> > following command:
> >  echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> > The docker program adds F_SEAL_WRITE through the following command will
> > prompt EBUSY.
> >  fcntl(5, F_ADD_SEALS, F_SEAL_WRITE)=-1.
> > 
> > It is found that in memfd_wait_for_pins function, the page_count of
> > hugepage is 512 and page_mapcount is 0, which does not meet the
> > conditions:
> >  page_count(page) - page_mapcount(page) != 1.
> > But the page is not busy at this time, therefore, the page_order of
> > hugepage should be taken into account in the calculation.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > ---
> >  mm/memfd.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 9f80f162791a..26d1d390a22a 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -31,6 +31,7 @@
> >  static void memfd_tag_pins(struct xa_state *xas)
> >  {
> >  	struct page *page;
> > +	int count = 0;
> >  	unsigned int tagged = 0;
> >  
> >  	lru_add_drain();
> > @@ -39,8 +40,12 @@ static void memfd_tag_pins(struct xa_state *xas)
> >  	xas_for_each(xas, page, ULONG_MAX) {
> >  		if (xa_is_value(page))
> >  			continue;
> > +
> >  		page = find_subpage(page, xas->xa_index);
> > -		if (page_count(page) - page_mapcount(page) > 1)
> > +		count = page_count(page);
> > +		if (PageTransCompound(page))
> 
> PageTransCompound() is true for hugetlb pages as well as THP.  And, hugetlb
> pages will not have a ref per subpage as THP does.  So, I believe this will
> break hugetlb seal usage.

Yes, I think so too; and that is not the only issue with the patch
(I don't think page_mapcount is enough, I had to use total_mapcount).

It's a good find, and thank you WangYong for the report.
I found the same issue when testing my MFD_HUGEPAGE patch last year,
and devised a patch to fix it (and keep MFD_HUGETLB working) then; but
never sent that in because there wasn't time to re-present MFD_HUGEPAGE.

I'm currently retesting my patch: just found something failing which
I thought should pass; but maybe I'm confused, or maybe the xarray is
working differently now.  I'm rushing to reply now because I don't want
others to waste their own time on it.

Andrew, please expect a replacement patch for this issue, but
I certainly have more testing and checking to do before sending.

Hugh

> 
> I was trying to do some testing via the memfd selftests, but those have some
> other issues for hugetlb that need to be fixed. :(
> -- 
> Mike Kravetz
