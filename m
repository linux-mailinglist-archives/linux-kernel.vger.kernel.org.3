Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222C4B1782
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbiBJVRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:17:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbiBJVRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:17:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6CB26C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:17:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso2339574pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=17Wd9VZDSOB+nZkIHBHopkVTOYm7CGsey4V1v+U3EFs=;
        b=q0RzZLGmDnL6quoiqHZ65sqv5PykSXNqdb9+2sQd+vnKa6X5AWyC5haucLs8T/SQHg
         w9Yw986B5QeJPKSVIpzOwx0WorL40gAdFfaQ1cc0qZ9mNVxxqmpJLAfOitmJDMHHlY5E
         XW4kxhfZ7pIlpD+h372lZEsHH7XNbSbqXnOcwuMIyIHGzoZMLcw5gq9eaYKfQPOd2UeX
         c91Z4YhNlHXF1pgTKvBnM4JYoYRwTwhOsWV3H2ScUkBXMZq1gkS5aTSB/U4SLAcdKY5q
         m+3/7QWCLVweBcLFYLXjRIcZSKRtHlj9O1KRAXSIbLEyFwhXKQ7jEnpPmqnDG2wa2tHy
         2NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=17Wd9VZDSOB+nZkIHBHopkVTOYm7CGsey4V1v+U3EFs=;
        b=JSDCguhxODtvfDypKJPyx7xvI7F5S+ZV59xrQ4Sg4LanNKEA828OzNrzLThBp6EGl+
         uk49GWf4i+W/CLq6nNm7E8A0AxbekL4oJw4lMLpu/vAw4ZXJt1uR+ZcagCq4QyimNsuz
         zbBso3QRmmAsjYfjncPMN4ysAqo5Z2JCY9rWDgTZfHiETyjcsW9fEt2hNLJcXrdhD3qM
         6ztKlw0lk5QW9oTtyEAGwIrmweHzbTawMIAmrvE6Qe83Y96y16xFonCGiCPxDcTmboJ+
         GE0K7j66odwOaoABMF8BSMxFMF1HcV1Y3JQys08GEeYgKPZ5DdOtLPOMMbqJz5X/NbB7
         Tp9A==
X-Gm-Message-State: AOAM531d9qtbgjFq7L/9p15c+fH1VjLGaR6Ghf9JWF361/3MXT3S1XfF
        QrhxymHCzOkbzdXYwqMrDdDwDQDvpQo=
X-Google-Smtp-Source: ABdhPJzbDUswAcBLWyy+uZdpy13ki7D3sk4jsS4Arwzqmj3OZfvVw0yCLk+VkNvkHyoiEELbzXsLnQ==
X-Received: by 2002:a17:903:1c4:: with SMTP id e4mr9388727plh.147.1644527828548;
        Thu, 10 Feb 2022 13:17:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4c8c:3496:9911:5b66])
        by smtp.gmail.com with ESMTPSA id pj8sm3300485pjb.26.2022.02.10.13.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:17:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Feb 2022 13:17:06 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: pin_user_pages supports NULL pages arguments?
Message-ID: <YgWA0ghrrzHONehH@google.com>
References: <YgVkxwYtLov6Z5WZ@google.com>
 <7b19b521-01cf-fafb-e616-21deced2cd5b@nvidia.com>
 <YgVntJO3E+8ILRDV@google.com>
 <f79a2d94-9877-90aa-927c-d765fbdda7b2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79a2d94-9877-90aa-927c-d765fbdda7b2@nvidia.com>
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

On Thu, Feb 10, 2022 at 12:20:47PM -0800, John Hubbard wrote:
> On 2/10/22 11:29, Minchan Kim wrote:
> > On Thu, Feb 10, 2022 at 11:20:31AM -0800, John Hubbard wrote:
> > > On 2/10/22 11:17, Minchan Kim wrote:
> > > >    * pin_user_pages() - pin user pages in memory for use by other devices
> > > >    < snip >
> > > >    * @pages:      array that receives pointers to the pages pinned.
> > > >    *              Should be at least nr_pages long. Or NULL, if caller
> > > >    *              only intends to ensure the pages are faulted in.
> > > > 
> > > > pin_user_pages(,, pages = NULL, );
> > > >     gup_flags |= FOLL_PIN
> > > >     __get_user_pages_locked
> > > >       __get_user_pages
> > > >         ..
> > > >         VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
> > > 
> > > Only FOLL_GET or FOLL_PIN are supposed to fill in the **pages array. So
> > > if a caller passes a null **pages arg, then that caller must not also
> > > set FOLL_GET or FOLL_PIN. That's what the VM_BUG_ON() is expressing.
> > 
> > Yub, but pin_user_pages adds FOLL_PIN unconditinally and the comments
> > says it supports NUU pages argument. Isn't it conflict?
> > 
> 
> Oh right, that is a conflict. The documentation should *not* say that a
> NULL **pages arg is supported. Because the whole point of the FOLL_PIN
> APIs is to actually pin struct pages. The NULL cases are only useful for
> get_user_pages*().
> 
> So removing that last sentence is appropriate, plus also looking around
> for similar documentation claims, including in pin_user_pages.rst. I
> don't see anything from a very quick scan, though.
> 
> Sending out a fix will also trigger the observation that both the
> kerneldoc headers mm/gup.c, and the writings in pin_user_pages.rst,
> could use some updating. However, it is also true that this can be
> reasonably treated as a documentation bug fix, and therefore allowed to
> be limited to just this change.
> 
> Were you going to send out a formal patch? If not, I can include it in
> an upcoming gup series, with your Reported-by tag. Up to you.

Yes, please.

Thank you, John.
