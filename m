Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C863747369C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbhLMVi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbhLMVi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:38:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC695C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:38:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso14448458pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IsCfky9Vc/KufMssEcVvjJJ/SE9sIWiUBthfB+gq2jM=;
        b=BTBWE5wdOCGliz0KcDvorj30xmy0YGpY2PeuWhmw7Z59+tWlahbicdxJbzJT1rlrvu
         LemujgrR7C6ujyw8nq9UVxzreS7EPS9x7i6Mk90cvHkC1Xw6VdTN2ldfHtsuL680Gtru
         7xlXrw2ncdKN80Ek0yC/CIa9Veal1Xks8t0osX8yOV6mfBmSJUqPh9yn0DGPBD3nOEaO
         IZlnJ6/HnGinwhi5aTY2jdYbvQUpINvqmPldbTdlekccH1JUrwZgSHIuG+Z/nC0tiPre
         mDxVUHQwZ1tqrvupP1/QuPpZ7y5l2iWdCLhPrkBgnuHN6hqkNXEmn7Eik6PlJ2F+3qM/
         cCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IsCfky9Vc/KufMssEcVvjJJ/SE9sIWiUBthfB+gq2jM=;
        b=qOjfGGPpI5nLhShSJsjWZz0vqQHooncNBpQXoO40dkVDfkQtLt0/EOBYig3kN72dlO
         UIUoqf8eAm5bJ5Firsk6G7blKxcPkek4OvYISQnMmbY1hN0IziaCG+tKIgeJXvTT8mvw
         HENIncKYRJxTWie5S2wnYuxn4FqS3rSPM0FJ6ZCAsffnEWjiXmAY50QRC411Hn0OmprK
         751hlEECpqkROb0VKCXWI4jiE0C2RWR+TesDQg812PRxBRFwYwaw3zqsvQPjVDUfV00E
         y2cOsFrg8zWKUBNWA2o94XabYWa5NT5sswASJuhBEjM6pLCRZ3/CzPqNf6eH/wH5WrBC
         BkYg==
X-Gm-Message-State: AOAM532mACgq8mSF762iFMrZbuwlhrqcDOy2bH0WwCA0eguR3KXFJuIj
        cTGJ2aXehIQG4NSjiuCrUuM=
X-Google-Smtp-Source: ABdhPJzdo40Ym38bfqmpZcYWl4E08+krhfzb5cx4N8p3rquS8mcmuLr+o3lL6r4g5m33bTCQqLoQSQ==
X-Received: by 2002:a17:90b:3e8c:: with SMTP id rj12mr883491pjb.152.1639431507117;
        Mon, 13 Dec 2021 13:38:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:6d07:5ea2:4ced:3b3d])
        by smtp.gmail.com with ESMTPSA id pj10sm78727pjb.17.2021.12.13.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:38:26 -0800 (PST)
Date:   Mon, 13 Dec 2021 13:38:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joe Perches <joe@perches.com>,
        lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, 282827961@qq.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v20] tty: Fix the keyboard led light display problem
Message-ID: <Ybe9T3XzRK9zX1Gx@google.com>
References: <20211213061244.13732-1-changlianzhi@uniontech.com>
 <Ybc5XPfd5f66L92i@smile.fi.intel.com>
 <97eb3c3f68042443aa71c10766f3bef364e8f90b.camel@perches.com>
 <Ybeh1VGMvL7DkG2I@google.com>
 <YbentBpPYZjz5Fu4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbentBpPYZjz5Fu4@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:06:12PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 13, 2021 at 11:41:09AM -0800, Dmitry Torokhov wrote:
> > On Mon, Dec 13, 2021 at 04:41:24AM -0800, Joe Perches wrote:
> > > On Mon, 2021-12-13 at 14:15 +0200, Andy Shevchenko wrote:
> > > > On Mon, Dec 13, 2021 at 02:12:44PM +0800, lianzhi chang wrote:
> > > 
> > > > > +	struct kbd_struct *kb = &kbd_table[console];
> > > > > +	int ret = 0;
> > > > > +	unsigned long flags;
> > > > 
> > > > Slightly better to read:
> > > > 
> > > > 	struct kbd_struct *kb = &kbd_table[console];
> > > > 	unsigned long flags;
> > > > 	int ret = 0;
> > > 
> > > I don't think so.  Why do you?
> > 
> > I wonder why we comment on cosmetics of a patch
> 
> > (and have the submitter rush to fix that)
> 
> Not sure where you got this from...

That is people's natural reaction.

> 
> > without considering if the proposed solution makes
> > sense in the first place?
> 
> ...but answering your question it's quite natural in open source mailing list
> that people give a comment regarding their area of expertise. One does for
> style another for the whole solution. I don't think anything is wrong with this
> approach, do you?

I think it depends. It is definitely fine when we are putting finishing
touches on a patch, or when there is little indication that the patch is
uncontroversial. In this case we are on iteration #20, with several
initial approaches to solving the problem have been rejected and the
latest one out of blue introduced a whole lot of new
functionality/public facing ABI, so I think waiting a bit to see if this
brand new approach is something that is viable would be prudent.

Thanks.

-- 
Dmitry
