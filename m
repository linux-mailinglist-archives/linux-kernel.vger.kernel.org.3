Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E710A4D7770
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 19:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiCMSLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 14:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiCMSLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 14:11:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38077DE25
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 11:10:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g20so16939561edw.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ufb3dhCc+RaygURJJfIihlttMucJHhJP5zB8nwebvgc=;
        b=I/9YlFiBZKF4sxHpFHrMRfCuoDO+WYX5/8kYU34r8QY21N/ChJ+O7sw6ED+hnuAwFB
         Pai2d+GtluDaC+NvlPj0YrsA9ZMGPbf9U3Evc+eqwMFC8YhfauHxUUDnGzmdhFBI/utP
         k171CCoCWG/snQ8iKfa3tqaqozONqPr1IHlRZisJbAdd7YRRcLqnwjfdXK1NZ4hbsRFM
         OEYSy1btTwvFJoDMxGjigoy2FF9bsQ1W7bBA0zs8yBW7Xq1GxpwNdhOmEDu+Q6C/dDBO
         Wq6REy3KK3XUNFGUdEz+GyYMBUl1y31aTJBGMBGGpTaqttgemiwUfInRqmRqHGIYd2aq
         MpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ufb3dhCc+RaygURJJfIihlttMucJHhJP5zB8nwebvgc=;
        b=nnURMkfIIkS7LaynAmvA+A5zzjWcmeE+fDUSYCF5iS++/fSP7WBEMR8jeSue/b7yQV
         HD12S3kZHG2ySf1x7fBK9c8IhtJL4zT/wiLu1/60EHw2utJbDmaBKqMKeu2OEwmYyXlY
         oqgAq9gXHfQDQlKfY8dMWuKt1sjVleWWAB6M/ZSzMaPfyARLCXvfU6QkA/25j1guZ2Qp
         9hNfWebe3Ci9e4JMeDN3DTyyULKRsJqdx3vOy9CEb4Xpm+Xx+vaqZgnDq2qVv9m9fH1T
         ZZrQUCG+00DLSh+aAzMiglyEofz2OyHNemFsO8bcxsynemYalF7gfbbTsMQz9kolkylQ
         Kn8A==
X-Gm-Message-State: AOAM532NWDMExesmzL3oa1VdpQ61ecrOoEjmEDsqTlu6bNRAO+DtIQkm
        l+qoU0QUURjDX4YMeqiDzA==
X-Google-Smtp-Source: ABdhPJwdhinSd7OG+Z0G1VcDVWAEeo7shExIBhkQtc1uYhuhK5TAZ3JxYBP9kpiR9HI//wkSuzopYw==
X-Received: by 2002:a50:e696:0:b0:413:3846:20a9 with SMTP id z22-20020a50e696000000b00413384620a9mr17249150edm.96.1647195000203;
        Sun, 13 Mar 2022 11:10:00 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.141])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7cf8a000000b004160af67840sm6464857edx.66.2022.03.13.11.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 11:09:59 -0700 (PDT)
Date:   Sun, 13 Mar 2022 21:09:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] x86/alternative: simplify DUMP_BYTES macro
Message-ID: <Yi4zdkj4Ye4iVj7J@localhost.localdomain>
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <e9c77d12092a4f048992f67d3fa0cf363b8614d4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9c77d12092a4f048992f67d3fa0cf363b8614d4.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 08:36:11AM -0800, Joe Perches wrote:
> On Fri, 2022-03-11 at 17:43 +0300, Alexey Dobriyan wrote:
> > Avoid zero length check with clever whitespace placement in the format
> > string.
> []
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> []
> > @@ -66,13 +66,10 @@ do {									\
> >  	if (unlikely(debug_alternative)) {				\
> >  		int j;							\
> >  									\
> > -		if (!(len))						\
> > -			break;						\
> > -									\
> >  		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
> > -		for (j = 0; j < (len) - 1; j++)				\
> > -			printk(KERN_CONT "%02hhx ", buf[j]);		\
> > -		printk(KERN_CONT "%02hhx\n", buf[j]);			\
> > +		for (j = 0; j < (len); j++)				\
> > +			printk(KERN_CONT " %02hhx", buf[j]);		\
> > +		printk(KERN_CONT "\n");					\
> >  	}								\
> 
> This could also use %02x and not %02hhx

I doubt as there is funky stuff possible with 255 and such values.
Format specifiers aren't the purpose of the patch anyway.

> And MAX_PATCH_LEN is 255 but is that really possible?

Yes if you try hard enough.

> Maybe if the actual patch length is always <= 64 this could use
> 	printk(KERN_CONT "%*ph\n", (int)len, buf);
> instead and avoid all possible interleaving?

It is for debugging feature nobody uses (because it works).
