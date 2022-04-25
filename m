Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9E50EC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiDYXYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbiDYXXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:23:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D42193CB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:20:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q14so19749632ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCteESL2qJwjAahA4hmyXY9OLMALrlUpGNGW2t2pRDI=;
        b=HT1uPZp7s66zomDLhHrQyv5sHuehalu7Po5n5ZQV7yolsfoy8auMhWPK73hglXrLs2
         zr+cR/oLtKkYFbgxtqch5NzgxtnB9wFopVpNTgHIbeqsBNFNZlUkN37lI9dHvbki2tST
         bIL7CrC+wlle5FUtEkt7f48OSU8OUNQe+XWl3mMlUztwS4GabtBmdR0sYooY7nM1ij/E
         do/1WlRsK2TjiEFBKYtNgVc3uIL13DdyfKbA7v9LB1/q6HxlDld6QuTw0OOoCh/6+9Ay
         Av3grWD8jqLDcM3bCOKAunWBGjkQAR5+DUeou3Qx6c5dLcFL/lE0Ssfg28wA3WRGdl6g
         fgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCteESL2qJwjAahA4hmyXY9OLMALrlUpGNGW2t2pRDI=;
        b=aVhZ/xR3OMISJTyBiY/tOUJKJiKKea0P2Xs2aH9JnJ4LdiqV5LjkBFnWeoraNsC575
         2vMA5IHliijO5QcgopNSi4bNMGI1pL2xsw6Z7zHfalS23DT4Yb6duSLe6SW0jtS/Dr63
         +lkA6y/96DA1GSUMa2Kk+u7fY6+M/VNl9l7MtJQpgjhOdxjAN4+PLdlpgtM3R79+ntg9
         9bTPJdJqiGaWPOj6OG7yzyQbQ+VIgohED6drErQVqacGbBh4oAob2USELB5kblH8vdmk
         ulOT2LqlcwnLjaipQ5XBbjIeHQWZ5i7dRuOhQT+Hbx+rfLm5DFWyhlu8SkfSIQQ7sIAR
         yzWA==
X-Gm-Message-State: AOAM532AL6PoZzRvJLE88vTliXRERkjN/Bz3VkfK5bbqpWosVC0Dj69j
        y+B+a79oLwgNmAB/MZFU3dxB/Q1ojZvwwPwiBw4RHQ==
X-Google-Smtp-Source: ABdhPJzoJOs8Y+tExvebbu0gN8AOzNrZusnpf2jwoelPtNoR3MzIxmK6nHZZScRXDF2CT6E8hE/VvvN4SyHZZLQPlFI=
X-Received: by 2002:a2e:9b57:0:b0:24f:12ea:fd26 with SMTP id
 o23-20020a2e9b57000000b0024f12eafd26mr3796665ljj.352.1650928840302; Mon, 25
 Apr 2022 16:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <005001d85413$75e5dce0$61b196a0$@telus.net>
 <CAJZ5v0jf-NGa4-xaNaxehkLGPVqwhZrUhLXw2cJ1avtjgT5yPA@mail.gmail.com>
 <87bkwwvkwa.ffs@tglx> <005501d85503$3b00ca40$b1025ec0$@telus.net> <87pml5180p.ffs@tglx>
In-Reply-To: <87pml5180p.ffs@tglx>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Mon, 25 Apr 2022 16:20:30 -0700
Message-ID: <CAAYoRsUKCnQy6aqVp=-n81tOh3b+o0hss7ydwDHcO_AL_rNWoA@mail.gmail.com>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 8:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, Apr 20 2022 at 15:08, Doug Smythies wrote:
>> On 2022.04.19 14:11 Thomas Gleixner wrote:
>>>> That's because after the changes in this series scaling_cur_freq
>>>> returns 0 if the given CPU is idle.
>>>
>>> Which is sensible IMO as there is really no point in waking an idle CPU
>>> just to read those MSRs, then wait 20ms wake it up again to read those
>>> MSRs again.
>>
>> I totally agree.
>> It is the inconsistency for what is displayed as a function of driver/governor
>> that is my concern.
>
> Raphael suggested to move the show_cpuinfo() logic into the a/mperf
> code. See below.

Hi Thomas,

I tested the patch on top of your 10 patch set on kernel 5.18-rc3.
It addresses my consistency concerns.

Thank you

... Doug

> ---
> Subject: x86/aperfmperf: Integrate the fallback code from show_cpuinfo()
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 25 Apr 2022 15:19:29 +0200
>
...
