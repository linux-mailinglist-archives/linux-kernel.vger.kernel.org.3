Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6835848EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiG2ALU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG2ALS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:11:18 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26284F66C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:11:16 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10d6ddda695so4684529fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j3vlQ1+c29TL6mpbmECY5+yY16HdPfE9WGc99Ei1lTA=;
        b=gjG3hrkjszPaHeVvTBCRlrsS5Qgf8pBwLl35vWw0HlVci/jm11c5P23IRYoZvMcrf1
         iQkjlo6thoZ8ODwjf14ufqWBQ+MsrEpfMnUjE1CmW4/NvlcrknXhSLL3rsfvZrPC+Dzd
         4ml/iNJbLAeCUVKzLkptwOU0+JS3447Ju3Vw5Wef/f/NusiGAuPHx+5C+28FcnFUVWhr
         Zq1dBphR89YdmGc0dXm5VNDRTZPOd2mzYCyAopUq5vn8L/2FwIg8ik2WgRw/qzyXkbID
         JkMTjlXjPW5NIcB0ddlo3SEbqLkzZ5BPCGr1aEuPObP4OOGzH3uZa3h7m2HVpwgzxT9R
         +WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=j3vlQ1+c29TL6mpbmECY5+yY16HdPfE9WGc99Ei1lTA=;
        b=U6xNf2ZB3EhlCxMm7f6Sjd4/8A6HG4GLIX7oYQ1kDYGiLAkKiNiiKJhSJROcRMAcDF
         aw3h6GZf05loYZJM4L/ZwW7AanuP7H/n3D+mAez97NM0l1ZTYq0Mv0Uu5vmJNKKo+TI4
         hu6wJHT48tG8mdYg8kQvqimOXRDL03kId69HToRDLTQSuF8ndKPDoEDe3NDxZJp7Kl3w
         95F0U8jaLJdL2+OyNAwQOQjCOi5kIfxJy8kBwItjrRhgGXgcx9cCrBgMSfa8rHz2uUdl
         wni42bFeFd0NgCuaJ9yQV3V+wfDDN+LIuOsSzz3RQRSt4S2Da1GmT084mEkK6bIYR1Eg
         u4Sw==
X-Gm-Message-State: AJIora9u2U9ZKvaeVY7qPpx66qcGjwgb+fKLM8lgDpYASMojBFaiL8IV
        tgov/M6LeuborBEl9VXVo4k=
X-Google-Smtp-Source: AGRyM1vdzFO/fulZy1Zr2qwsOG2c0IEwL0uxVw72ke/1PjyKZPx9VpShAVpSlwvn+5jjk00BQN/ceA==
X-Received: by 2002:a05:6870:e997:b0:10c:6f42:b05e with SMTP id r23-20020a056870e99700b0010c6f42b05emr517826oao.89.1659053476019;
        Thu, 28 Jul 2022 17:11:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w29-20020a056870339d00b00101bd4914f9sm1032441oae.43.2022.07.28.17.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 17:11:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Jul 2022 17:11:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <20220729001113.GA1979316@roeck-us.net>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <Yt+v9brPqxun0nhA@shell.armlinux.org.uk>
 <YuLVRiblUzo18gST@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuLVRiblUzo18gST@shell.armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 07:28:22PM +0100, Russell King (Oracle) wrote:
> On Tue, Jul 26, 2022 at 10:12:21AM +0100, Russell King (Oracle) wrote:
> > First I'm aware of it. Was it reported to linux-arm-kernel? I'm guessing
> > the report wasn't Cc'd to me - I can't find anything in my mailbox about
> > it.
> > 
> > > I think the fix might be something like this:
> > > 
> > >   diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
> > >   index b5e8b9ae4c7d..b36ca301892e 100644
> > >   --- a/arch/arm/lib/findbit.S
> > >   +++ b/arch/arm/lib/findbit.S
> > >   @@ -83,6 +83,8 @@ ENDPROC(_find_first_bit_le)
> > >    ENTRY(_find_next_bit_le)
> > >                 teq     r1, #0
> > >                 beq     3b
> > >   +             cmp     r2, r1
> > >   +             bhs     3b
> > >                 ands    ip, r2, #7
> > >                 beq     1b                      @ If new byte, goto old routine
> > >     ARM(                ldrb    r3, [r0, r2, lsr #3]    )
> > > 
> > > but my ARM asm is so broken that the above is just really random noise
> > > that may or may not build - much less work.
> > > 
> > > I'll leave it to Russell &co to have a tested and working patch.
> > 
> > I think it needs a bit more than that, but as you point out in later
> > emails, the compiler may do a better job for this.
> 
> Okay, I've moved my patch that fixes this (without adding a single line
> of code!) to my fixes branch, which I'll ask you to pull in the next
> couple of days.
> 
I downloaded your patch and ran it through my testbed.
With it applied, the problem is no longer seen.
Feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> Each of the _find_next_* functions had:
> 
> 	teq	r1, #0
> 	beq	3b
> 
> at the beginning to catch the case where size == 0. This is now:
> 
> 	cmp	r2, r1
> 	bhs	3b
> 
> which is the C equivalent of:
> 
> 	if (offset >= size)
> 		goto 3b;
> 
> where both are unsigned, and nicely covers the case where size == 0 as
> before (since if size is 0, the condition is always true irrespective
> of the value of offset.)
> 
> We can sort out the question of keeping this code or not later, but I
> think as this has been spotted as an issue, it's important to get it
> fixed.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
