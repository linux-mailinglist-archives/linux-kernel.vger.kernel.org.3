Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765894C6D41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiB1M5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiB1M5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:57:34 -0500
X-Greylist: delayed 2322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 04:56:52 PST
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B536271CAE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=KXZFUJH9IMivzQ4dLa//v1ZDi0JJT/uywv36ICj5Y9g=; b=lcX1dXwH45zc5S/ujByc+8polV
        2wVY1WEVAM2fPfI4zPWRCs2Xv0uZumsu7N5e7KnSWfgaLVA7HUMJV3J8evpYuZVzJS+rDwjuTwxNz
        2RSb1peVyJmmxy3b6dTCsEzAMnmxfu3eT8ZUQQZH7qIFsCbx6DTS3joA1nDnjeHZ1JqTtuNcMv+oz
        9F2TKAhFqfn2BVdhMbLiRJjPLutAMK6EkL0GdO1e30om1Z7XfLNighHUghScv6EZq9h5i2lgDxfsD
        SnC0r1vzkPDMe4wT/KjMRwmAj1bAHmsqyUrJ+SQ9wV+vYLEd2sbpIaLrhrZr2Pll90EOmHv6hu21x
        3K56qZmQ==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1nOeyc-000qHH-Di; Mon, 28 Feb 2022 12:18:06 +0000
Date:   Mon, 28 Feb 2022 12:18:06 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     pasha.tatashin@soleen.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use strtobool for param parsing
Message-ID: <Yhy9fsyLyY9TU1Yp@gallifrey>
References: <20220227181038.126926-1-linux@treblig.org>
 <20220227135128.3f5aabca43c7a33acea91cc8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220227135128.3f5aabca43c7a33acea91cc8@linux-foundation.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-9-amd64 (x86_64)
X-Uptime: 12:17:30 up 112 days, 21:50,  1 user,  load average: 0.06, 0.01,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@linux-foundation.org) wrote:
> On Sun, 27 Feb 2022 18:10:39 +0000 "Dr. David Alan Gilbert" <linux@treblig.org> wrote:
> 
> > Use strtobool rather than open coding "on" and "off" parsing in
> > mm/hugetlb_vmemmap.c and mm/page_table_check.c.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  mm/hugetlb_vmemmap.c  | 12 +-----------
> >  mm/page_table_check.c | 10 +---------
> >  2 files changed, 2 insertions(+), 20 deletions(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index c540c21e26f5b..919411386e547 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -192,17 +192,7 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
> >  		return 0;
> >  	}
> >  
> > -	if (!buf)
> > -		return -EINVAL;
> > -
> > -	if (!strcmp(buf, "on"))
> > -		hugetlb_free_vmemmap_enabled = true;
> > -	else if (!strcmp(buf, "off"))
> > -		hugetlb_free_vmemmap_enabled = false;
> > -	else
> > -		return -EINVAL;
> > -
> > -	return 0;
> > +	return strtobool(buf, &hugetlb_free_vmemmap_enabled);
> >  }
> >  early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
> 
> This part falls afoul of the changes in
> https://lkml.kernel.org/r/20211101031651.75851-3-songmuchun@bytedance.com

Hmm, yes that's quite different.

> > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > index 3763bd077861a..2458281bff893 100644
> > --- a/mm/page_table_check.c
> > +++ b/mm/page_table_check.c
> > @@ -23,15 +23,7 @@ EXPORT_SYMBOL(page_table_check_disabled);
> >  
> >  static int __init early_page_table_check_param(char *buf)
> >  {
> > -	if (!buf)
> > -		return -EINVAL;
> > -
> > -	if (strcmp(buf, "on") == 0)
> > -		__page_table_check_enabled = true;
> > -	else if (strcmp(buf, "off") == 0)
> > -		__page_table_check_enabled = false;
> > -
> > -	return 0;
> > +	return strtobool(buf, &__page_table_check_enabled);
> >  }
> 
> But this works OK.

Thanks for taking it.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
