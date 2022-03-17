Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1A4DBD7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiCQDYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiCQDX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:23:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8FA2981B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:22:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v4so3813743pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NTUDKmpf2s8+A55CL20mSlN2Dv66XsBvgLhWAbPNrdY=;
        b=eii52tCBVMB3/O7gJ+x1BDAVcwbowOLVFylCbMdrYqdSVMtqZYaj7y59Uy+kCPMTCy
         WJ6TBkHZNaeRyuejovqu+F6worG36Czhu43mnDQ1PioGhdAXNS4SoiDTF7Ctc7KVi9DI
         2UNe1GUx6Hen9jL8hY3BRUnoLOoJRF9CNKTwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NTUDKmpf2s8+A55CL20mSlN2Dv66XsBvgLhWAbPNrdY=;
        b=5YInaiVkBUn82bJy7L4f9W1DbUI/+D9l1jRbqcMMfjnJorURRtnL4POkBZerhTUuHU
         cY32NDbtSk0RN2Umqyxmt90JYOZ/1OCOPN6hGMs6A4JfydyksDcZNBm3WQEKbxPqQvNp
         itzwT4MSxb5qVMNS8DCNfIg3B64uQU2PjJJsNGLnBuXIJUv/UjhFac/2Vfar9OO4paUD
         bicmvxuDx+mgpJ3acZ/Z19k0XAlVHi6IF6bzoFfw/KGSt8qAZxxlF5Ue5hzzSaZuejAU
         0CGFN/GOvt+5c7Z+fvAyU6QD9iX5Tj/2/jofkgfJk9vn/YBxt+uFBNw8vLv5L8ScXtxk
         aOvg==
X-Gm-Message-State: AOAM533QwgPyVVAQZdUvNpziUyW8/T5xj83MD/2Frmf624mMirf1ysj5
        36OwfYqCSj17qUbIIFBfCt8EuwwvH/ZBNg==
X-Google-Smtp-Source: ABdhPJxyxNNVBd0XAV1XVrvc92H57LyXll9bFBNUb/4w8R8e/ki5hNFmFudr0XQ9rg0WIMUNeJ7ngw==
X-Received: by 2002:a17:902:ea0e:b0:153:d04a:9193 with SMTP id s14-20020a170902ea0e00b00153d04a9193mr2545538plg.95.1647487361636;
        Wed, 16 Mar 2022 20:22:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 85-20020a621858000000b004fa3bd74fb0sm465394pfy.125.2022.03.16.20.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 20:22:41 -0700 (PDT)
Date:   Wed, 16 Mar 2022 20:22:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     James Jones <linux@theinnocuous.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <202203162014.FEB1496@keescook>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
 <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com>
 <202203161523.857B469@keescook>
 <5161ace381a74a63b58b0a2a2a2cb57d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5161ace381a74a63b58b0a2a2a2cb57d@AcuMS.aculab.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:32:29AM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 16 March 2022 22:30
> > 
> > On Wed, Mar 16, 2022 at 01:38:31PM +0100, Arnd Bergmann wrote:
> > > is in the end, but it's likely easier than a standalone a.out loader
> > > in user space, or a conversion to ELF format.
> > 
> > Yeah, the exec format is really simple. The only tricky bit was preparing
> > the stack and making sure everything landed in the right place for text
> > and data. James, can you try this? aln and mac run for me, but I'm not
> > actually exercising them beyond dumping argument lists, etc:
> 
> Doesn't that restrict the a.out program to the address space below
> the normal base address for elf programs?
> So you'll only be able to load small programs - which might be ok here.
> 
> OTOH it might be possible to link the 'loader program' to a high
> address - the elf loader will probably just load it.
> Best to link it static to avoid shared lib mmaps
> and probably try to avoid libc calls.
> 
> I was wondering what happens when malloc() starts using
> sbrk() - but I guess it sees the top of the bss for the
> loaded and it all works fine.

I'll wait unless something breaks. :) Right now I just wanted to get aln
and mac working -- and that's a pretty small subset of all a.out
binaries. :)

-- 
Kees Cook
