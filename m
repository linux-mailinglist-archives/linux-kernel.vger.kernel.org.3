Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0055D7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiF0Jg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiF0Jg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:36:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2163DC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:36:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z13so15505268lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3HaeNcG7GUwNm8/fRozB97Y4i9x1s+O7tYwK4jHD7M=;
        b=QF8DGzrvzH59XuF11YGPgC2m9vdevVtFLu4cKsHEkVjP5E0eo/k5PcEn0wMOl4eeY6
         Uycf77mBuTJ24IgCm8IhzAUUjCrQm79ID5XfSX9Eg6+CscbLmwa3LvRkzIsrj33PLc0w
         CUQgHWPSwcdPgGEbbF+AxjKzWVhxDrCKJf7W31rezkmauEpSgHJVRZtVeZVMnVTEcWqW
         oqx09f24DL1am2dLozxyQtmgIPUGvRZX0BNxuSDG/nECpVsItM8d5b95TocEHhNUVfXB
         ASDXvIaxD/GHxOb6o9w9Da3cE9BQ+6lHhr6rPARYUyOTlHMa/f3qt3aFtRpFzClUnJQv
         gMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3HaeNcG7GUwNm8/fRozB97Y4i9x1s+O7tYwK4jHD7M=;
        b=VyEr3fyoeHOX1qqP7V7KNSClnvf7IfyZALluZnZNYOyITKdi5m7KNY7ero08Ezc3VM
         MpFEJvQBfQbUOzzs+mD+hQQl+pRvMT1Tbrr7r/O6309RD49pmpMrKsC+0kt5whmnOFhg
         OhuCpSLmL5suofs8CSY4bOkYs8WbdLno6NpxrfG2paCAw9lIvgeWTIR6fuCjCX9llLUH
         DAai3Ey2mp3OGJiIBbravV8IRhm9JnP761koZ0dLIIxozaraIoL7p/gOs3o1l8fobpDP
         JHEkl/Jb601MIW6OMYg0vJmGz+QrtRTki6FmDpGPHq6tp06t6qUV68lyqEZ27ri2fVJM
         zwtw==
X-Gm-Message-State: AJIora/krAiKxmClbdPR5GxhrgcA76JvqiVxwfHW5IuGDgS0Omj7k2EC
        U0OAxSYa185Ft47Vll6s+tF0acA86w2VMvVzVmhT0g==
X-Google-Smtp-Source: AGRyM1vYmbCQxG+ZhuBiTxL9XeaO2JU+1o3ytJ35pL/oYBvWbmwYUIsGf47OtQGSi23B/9gdJnm/5/Bwtcvaf+20MBw=
X-Received: by 2002:ac2:4bcf:0:b0:47f:86f2:812d with SMTP id
 o15-20020ac24bcf000000b0047f86f2812dmr7505512lfq.400.1656322583045; Mon, 27
 Jun 2022 02:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com> <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com> <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Jun 2022 11:36:11 +0200
Message-ID: <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and x86
To:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:21 AM tarumizu.kohei@fujitsu.com
<tarumizu.kohei@fujitsu.com> wrote:

Jumping in here.

> Hi Greg,
>
> > That's not ok.  Linux is a "general purpose" operating system and needs to
> > work well for all applications.  Doing application-specific-tuning based on the
> > specific hardware like this is a nightmare for users,
>
> Hardware prefetch behavior is enabled by default in x86 and A64FX.
> Many applications can perform well without changing the register
> setting. Use this feature for some applications that want to be
> improved performance.

The right way to solve this is to make the Linux kernel contain the necessary
heuristics to identify which tasks and thus cores need this to improve
efficiency and then apply it automatically.

Putting it in userspace is making a human do a machines job which isn't
sustainable.

By putting the heuristics in kernelspace Linux will improve performance also
on workloads the human operator didn't think of as the machine will
detect them from
statictical or other behaviour patterns.

Yours,
Linus Walleij
