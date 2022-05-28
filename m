Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC65D536CC8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiE1MNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiE1MNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 08:13:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A981D0C1
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 05:13:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p19so3961218wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mNWkEQxztGAhGpLE9wPG3tVmhXvaKJfP7n8Uzm8Bfkw=;
        b=o9WofFj3GcLbd+k+AYKA1UTxb45ypSG2boO+2oiAK7SNNOQ/Ty0npbI0vcWkhRLHdb
         GjhopuD9/iRAftrX/lu1dQBlnkoTu8UKJJHc4Qf3IZ0j22MmsmA146pzgWNTi4VCgJAo
         FivfWqDdOjsjKfbTRNIuYtG4YjavKDSRP6LBjYxThm8Hxhly5mzKnmbabDoSb0RbGuvy
         7L7j9LApPKZkQJUpgxuq1ZSW2d/pEvjhmNgUYWPO6FdEOn5gl8dOxZhniC45akGfvC5v
         6ArW94J3e6eiq8+91roYXcGCC3XIJM940Ik03ScgLa4XkAv9nN4wInUA9vmuc0T0OSd5
         V+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mNWkEQxztGAhGpLE9wPG3tVmhXvaKJfP7n8Uzm8Bfkw=;
        b=Njfci6ibBhqtoW66r/Qm7e6p7TrywDlRZcS9L+uCpUfdIZL267ORVY2B4EEsyfrTZo
         o8+JRruYP3vnqs0VIFlEz+WezBuLZRuK+NA72MWkzA73fapsfkIN/T4VRNDGgAkn26Y5
         G2e5BhpHitx7RF6Gm6p8iPWiOCR8e2QCMc67Xry/h5TLurLCZf1k9bkS0xTrp3E4CftU
         YUe9vYSdZLo26eCmQVrKyNcSDHlcM88J6Tdag3sKNOvGuV7oixU1JsPvxdtFlJIgW+Rq
         7qDjAWTC4DVALVJQQurMHTrxKL54HfC/vH7QYAUkzA0NPL217ZhCJZ8KZaO3mAJkL4/4
         h0WQ==
X-Gm-Message-State: AOAM531a376MucrQ8j7NtM/LjPt3vuH7WHHuh9AAGpfn8SSIsPzTEvcD
        HsatnTmsLMUdTqVlstYhg4nHb0MEAFw=
X-Google-Smtp-Source: ABdhPJwSesuiohtxkUoHbYH8eErO2XjkbMpb70PMEusTxdlGejP/SYYtqgq55+BC7kt8MImi3WSkog==
X-Received: by 2002:a05:600c:4e4d:b0:397:5009:bcf1 with SMTP id e13-20020a05600c4e4d00b003975009bcf1mr11091743wmq.66.1653740013611;
        Sat, 28 May 2022 05:13:33 -0700 (PDT)
Received: from debian (host-2-98-37-191.as13285.net. [2.98.37.191])
        by smtp.gmail.com with ESMTPSA id az18-20020adfe192000000b0021020517639sm1420829wrb.102.2022.05.28.05.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 05:13:33 -0700 (PDT)
Date:   Sat, 28 May 2022 13:13:31 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
Message-ID: <YpIR67FMtTGCwARZ@debian>
References: <YpCUzStDnSgQLNFN@debian>
 <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 06:04:14PM -0700, Linus Torvalds wrote:
> On Fri, May 27, 2022 at 4:41 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > I just tested with various values, sizeof(*edid) is 144 bytes at that place.
> 
> Hmm. What compiler do you have? Because it seems very broken.
> 
> You don't actually have to try with various sizes, you could have just
> done something like
> 
>  int size_of_edid(const struct edid *edid)
>  {
>         return sizeof(*edid);
>  }
> 
> and then "make drivers/gpu/drm/drm_edid.s" to generate assembly and
> see what it looks like (obviously removing the BUG_ON() in order to
> build).

just tried this with
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- drivers/gpu/drm/drm_edid.s

> 
> That obviously generates code like
> 
>         movl    $128, %eax
>         ret

and for me it looks like:

.L1030: 
        .word   .LC40
        .word   .LC41
        .word   -1431655765
        .word   .LC39
        .size   drm_edid_to_sad, .-drm_edid_to_sad
        .align  2
        .global size_of_edid
        .syntax unified
        .arm
        .type   size_of_edid, %function
size_of_edid:
        @ args = 0, pretend = 0, frame = 0
        @ frame_needed = 1, uses_anonymous_args = 0
        mov     ip, sp  @,
        push    {fp, ip, lr, pc}        @
        sub     fp, ip, #4      @,,
@ drivers/gpu/drm/drm_edid.c:1573: }
        mov     r0, #144        @,
        ldmfd   sp, {fp, sp, pc}        @
        .size   size_of_edid, .-size_of_edid



--
Regards
Sudip
