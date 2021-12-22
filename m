Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF58B47CB59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbhLVC2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbhLVC2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:28:50 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D50C061574;
        Tue, 21 Dec 2021 18:28:49 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f9so683496qtk.4;
        Tue, 21 Dec 2021 18:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lBbJ0cNNlYj6EJvQfd0q1bNDKSk0QFiEWVowekGezSc=;
        b=nKTtXIAQv8OY5SnLYPIKNbxRbp/nsYZuehcQVCtQ3j1R86ExUTbR1f+MvE75lvRYpy
         IqWmcsdG9pcey/vn11uxa+8hkcRxqWMaGIH9xykoOJvBrW1DviuSEKZrTWu06c4sH2F0
         QFKuYgdQ9FladRPzBuDMEvkz+L5+mAXaC5gd4E9cN76wuvsFztQNHmmlgvfgXMmDbek/
         ztK4t2xxutn3DuKY8kVDU7GT/3kaexLgG1kdQmZDw431j2F0LsVSJxSrNBK6NLzUr/Lm
         akNQqlo/o7faBeeMXbyN4UW+UtXgiOMPrwWjw1St+4ILGjA+8ipdfZ5RaKG5DsAoAqlP
         8/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lBbJ0cNNlYj6EJvQfd0q1bNDKSk0QFiEWVowekGezSc=;
        b=JGThm4Vrc0pG0Hy7odOCXz4CR/PWqRUUQ2FaYnwGwVQ9cDBM3cRgxMPa5lPqD6E0Wg
         0NLHZnbnWE0X8lL5ia9laByQjBRWQVxDo39ZFWpoQFTq9GZ/Ctlvq80dhvySEOkhe0xH
         duyRIjZ1Kd4AoPYc/543hkCI9pdUIp/G7hCErHk0a+lgUq7Ci+pukCjl4eRQFUVJGZgi
         j59kwpJciV2Ug8NQNkTv5kvKqqaUE+RRtKdLnUXohaawFAKfHN359xesykNcTRpG/9RO
         fRTpDkq4m9A6IffZihnTGlCYktwvQrtxS4xbOim1cJ4SKMRiqbmfD9ETyT/+QmDHlFHV
         F+pw==
X-Gm-Message-State: AOAM533yAVuh/jTtrwVO5Fp3QTBSqTDFuVh0Z12pDSnhin4NQ1n9OSt7
        KkWZdsy6C4d2RT4Bxn7jhaKNArUMGE4=
X-Google-Smtp-Source: ABdhPJxXlgfDLzoTmYUKxRVp7zI7rqyERG0y1sWq4DcxIpqUsRf3PDeggg69og3JMVFqRXKvaa3+bQ==
X-Received: by 2002:ac8:7345:: with SMTP id q5mr823587qtp.410.1640140128984;
        Tue, 21 Dec 2021 18:28:48 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id s4sm755522qko.47.2021.12.21.18.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 18:28:48 -0800 (PST)
Date:   Tue, 21 Dec 2021 21:28:45 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "peda@axentia.se" <peda@axentia.se>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v10 04/14] iio: afe: rescale: expose scale processing
 function
Message-ID: <YcKNXaVXrkdgDMTz@shaak>
References: <20211219223953.16074-1-liambeguin@gmail.com>
 <20211219223953.16074-5-liambeguin@gmail.com>
 <CAHp75VdfPf6FMvkGqhhQg5e5XE1cgE-K8seobe5n0yGarnPGtQ@mail.gmail.com>
 <CAHp75VcRH9ZGYuXteT2WQWqr8sch3EsSYu_AYtNx2jEJY76tow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcRH9ZGYuXteT2WQWqr8sch3EsSYu_AYtNx2jEJY76tow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Dec 21, 2021 at 07:43:52AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 21, 2021 at 7:20 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Monday, December 20, 2021, Liam Beguin <liambeguin@gmail.com> wrote:
> 
> ...
> 
> >> +               tmp = *val * 1000000000LL;
> >
> > I see this is the original code, but perhaps use proper SI multipliers here and there?
> 
> I mean in a separate change.

Will do!

I'll add a separate patch to convert existing multipliers, and will
fixup the ones I'm adding.

Cheers,
Liam

> >> +               do_div(tmp, 1000000000LL);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
