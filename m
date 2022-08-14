Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4F591F44
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiHNJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 05:25:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B7DB1B;
        Sun, 14 Aug 2022 02:25:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so6274595edd.4;
        Sun, 14 Aug 2022 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=kE8WibN1v5dkHUmz0R+NQjJ+YVKJVhVn9I/8MpEJ5rY=;
        b=FVuxuioFy4+6sp3uZiew3t12myqNZE2uBQCnSX/AI22/H0t99BMI/eHUPr0QIodYbf
         Hiq++3KEFKHdX2bVc2S9wy9EvtXAM72xhz+T1+2I0fgHjUEU8QIyOb/06iqm9PzDlCn0
         Gqb6neKYSzf+d4q9561Azbuh+4f5074UzuPu+/rkf7bPHntBB1+JKw5Lt7U/07nhBhCb
         Rls2doWHBqjgYan+Me8K5Zp+OwgM5bXda74bW/QCGszS0nSZaD26ZIYbanFyuH+TQQyl
         +q9/a8aFeStktjHfjNgnRqdenWd1Dlysi8AJ/WiiYbLS+MY9/mPCnFj+fTxt4huUL91P
         IxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=kE8WibN1v5dkHUmz0R+NQjJ+YVKJVhVn9I/8MpEJ5rY=;
        b=OxehwoXfCNriAgON7z5sLjW2ZKWldNLyYaDTzM3X33ziygmrJVON2oVPLf7n80Jq4l
         6dIK7jo77VasGtrLY7UcOIeMSiNP6E7fFleldMno93CMBhXs/Q4XGhVhyNkc8LoqxSc7
         Xetuz9GiljQ4vAAVkx47FNlfShFIyHD6LhOZIUIw7Q+onE5Px8FuQI66AmCXbC/mEo6L
         KLf7riwxGDG7XL7j7y2JxeFoAbZ/NY/Zsve+4ekLhKRz5Oh8adBGGEV7cRQSNLwS8Sfp
         BJXIFTsT4kHhDSamQ4rxHlDnKUK5+fjdWk+8hbQsL31Hl2gzU0IUhzErj8md8IRWQ9I+
         RrzQ==
X-Gm-Message-State: ACgBeo3MCuM6dNPwPe3T0X8mSvjunoyMINSrj4IGYSYhAK8L5EMhgGuM
        s01yNVu3sq8lWfjm8qV1TgOyCp8mKXA=
X-Google-Smtp-Source: AA6agR4B+eoDDHA6KSgFcph8LPH6dVGmEklRaEwrDjzPC3JNpOIE5DUE1bWacrb8q6m+uCZvl17vUA==
X-Received: by 2002:aa7:db44:0:b0:43d:267c:edd9 with SMTP id n4-20020aa7db44000000b0043d267cedd9mr10243703edt.385.1660469116741;
        Sun, 14 Aug 2022 02:25:16 -0700 (PDT)
Received: from gmail.com (195-38-113-253.pool.digikabel.hu. [195.38.113.253])
        by smtp.gmail.com with ESMTPSA id e1-20020a170906844100b0072f4f4dc038sm2766339ejy.42.2022.08.14.02.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 02:25:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 14 Aug 2022 11:25:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 1/2] x86/rtc: rewrite mach_get_cmos_time to delete
 duplicated code
Message-ID: <Yvi/eq7/IPsUAGVc@gmail.com>
References: <20220813131034.768527-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220813131034.768527-1-mat.jonczyk@o2.pl>
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mateusz Jończyk <mat.jonczyk@o2.pl> wrote:

> There are functions in drivers/rtc/rtc-mc146818-lib.c that handle
> reading from / writing to the CMOS RTC clock. mach_get_cmos_time() in
> arch/x86/kernel/rtc.c did not use them and was mostly a duplicate of
> mc146818_get_time(). Modify mach_get_cmos_time() to use
> mc146818_get_time() and remove the duplicated code.
> 
> mach_get_cmos_time() used a different algorithm than
> mc146818_get_time(), but these functions are equivalent. The major
> differences are:
> 
> - mc146818_get_time() is better refined and handles various edge
>   conditions,
> 
> - when the UIP ("Update in progress") bit of the RTC is set,
>   mach_get_cmos_time() was busy waiting with cpu_relax() while
>   mc146818_get_time() is using mdelay(1) in every loop iteration.
>   (However, there is my commit merged for Linux 5.20 / 6.0 to decrease
>   this period to 100us:
> commit d2a632a8a117 ("rtc: mc146818-lib: reduce RTC_UIP polling period")
>   ),
> 
> - mach_get_cmos_time() assumed that the RTC year is >= 2000, which
>   may not be true on some old boxes with a dead battery,
> 
> - mach_get_cmos_time() was holding the rtc_lock for a long time
>   and could hang if the RTC is broken or not present.
> 
> The RTC writing counterpart, mach_set_rtc_mmss() is already using
> mc146818_get_time() from drivers/rtc. This was done in
>         commit 3195ef59cb42 ("x86: Do full rtc synchronization with ntp")
> It appears that mach_get_cmos_time() was simply forgotten.
> 
> mach_get_cmos_time() is really used only in read_persistent_clock64(),
> which is called only in a few places in kernel/time/timekeeping.c .

LGTM, I've added the following background to the commit description:

   These changes are not supposed to change behavior, but they are not 
   identity transformations either, as mc146818_get_time() is a better but 
   different implementation of the same logic - so regressions are possible 
   in principle.

Queued up both patches in tip:x86/timers and will push it out after 
testing.

Thanks!

	Ingo
