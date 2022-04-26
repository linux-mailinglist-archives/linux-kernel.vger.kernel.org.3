Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1321450EE11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbiDZB1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiDZB1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:27:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A702B113C9F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:24:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so33016849ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4v1Gx6azBNTmUZYoxNhUFaT3zjyoHdwz9pdO9gdvg0=;
        b=iNKj907EFfY5IHqvqrbhrf662SQv5A4DnHTm0fFsbBQQrtjUjQvWZLpFMK2FrkgU1R
         HSbvBzh1fmYejmtW7Ew7iIjjEI230o3ekSMqh3vPfPscp3SiXkb5/RYXkEx0fvpi1KE6
         ZQ+q9yjPvHMZ81oyDhUrgP/RetsWPs85Mms50/l6CxHIB/sZaeh2D6ob8NKcCAPXvHc8
         F7z8Zye8FKQAw0KedsfwNqz6IWGkrE8/KmFQXuYYyF9Mv5BoOkcMlDVWz6Sm4Sax1bAl
         FWg+M9qV2od5/FkbnW26Ha4s9IMHL8bWRLq4hFBR+5cG7WXHdxYf9/bTrCmingFRFQus
         xXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4v1Gx6azBNTmUZYoxNhUFaT3zjyoHdwz9pdO9gdvg0=;
        b=KBerlVRTlSEjk+bjf1WMUg+nGZg/vyE2cuDLv9b6lfzUd+nsai7rjhBiIjYdnmOx7s
         GXP0ZQE6uVeR+fPYov/OTA8zixemeZxVXQJLqv3d0sUOhTVs39/no3v7Rgu2tGuyR0sJ
         sLiTfnDCCK055eNJweqjtqDuxlIi7W99bxgV6rilq1dgPc2scPaawq0Qj+pI8h+638/n
         d3HtgAvS9uddwUBvhsDHRN0TBZsw7fXZwIttbQ+6G76pe005LX3KJ1uBHlQXkxORxdYn
         MBpeAOSlpsIVoYIQsbHMgPbm57MWkgAAGuCXIXFw5bxXNDtvtcQXH1RKodT9v01T6oH8
         xx7w==
X-Gm-Message-State: AOAM531EhqRsYLOVJ9bttDc3pz/IlShGS0pbMHXexht+aX+4qMUUNTa2
        jweQo4/mAgWBV1u6lkP5WfNnk/rqJqPUDCgufUA=
X-Google-Smtp-Source: ABdhPJz6MDnzuW912OuAP3tLXwTKIHl6cwUPTyBVSGtOZ6Y3I3Vu5nFeOLzMqSlqBVVCRXQ4SGdOqCZZ0rNJeIYKh5g=
X-Received: by 2002:a17:906:6a0d:b0:6f3:b341:3b94 with SMTP id
 qw13-20020a1709066a0d00b006f3b3413b94mr345716ejc.31.1650936247162; Mon, 25
 Apr 2022 18:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220425055935.458583-1-starzhangzsd@gmail.com>
 <7558ae3d-a1fa-6c11-cccd-ad0f65cde25b@intel.com> <20220425182456.GL2731@worktop.programming.kicks-ass.net>
 <20220425192856.GG2762@worktop.programming.kicks-ass.net>
In-Reply-To: <20220425192856.GG2762@worktop.programming.kicks-ass.net>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Tue, 26 Apr 2022 09:23:30 +0800
Message-ID: <CANubcdWq5hN8HSs8KhzhipzzjTver0CafHL6uXfyAEVOtmsS2A@mail.gmail.com>
Subject: Re: [PATCH] x86/traps: add CONFIG_BUG to the use of __warn()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, laijs@linux.alibaba.com,
        lihuafei1@huawei.com, fenghua.yu@intel.com,
        chang.seok.bae@intel.com, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As pointed out by Boris, __warn is actually uncondtionally defined in
> panic.c, the below seems to build.
>
> ---
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index edb0e2a602a8..ba1f860af38b 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -21,6 +21,12 @@
>  #include <linux/panic.h>
>  #include <linux/printk.h>
>
> +struct warn_args;
> +struct pt_regs;
> +
> +void __warn(const char *file, int line, void *caller, unsigned taint,
> +           struct pt_regs *regs, struct warn_args *args);
> +
>  #ifdef CONFIG_BUG
>
>  #ifdef CONFIG_GENERIC_BUG
> @@ -110,11 +116,6 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
>  #endif
>
>  /* used internally by panic.c */
> -struct warn_args;
> -struct pt_regs;
> -
> -void __warn(const char *file, int line, void *caller, unsigned taint,
> -           struct pt_regs *regs, struct warn_args *args);
>
>  #ifndef WARN_ON
>  #define WARN_ON(condition) ({                                          \

Thanks.I will make a new version based on this suggestion.
