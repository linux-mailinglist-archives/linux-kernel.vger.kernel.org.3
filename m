Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E504E35E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiCVBXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiCVBXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:23:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1319C2DCD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:21:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d5so8185827lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7BLAt/fJYUj0OsISV5J6z9qzVDh6CQrx7wQ/ZZuGFs=;
        b=PsdAyGqfgTpjhTv0nYwzSdVRaR+CB/53R2SZpWfxShtuAAHGPlf2B/Jg5PWRg3yudw
         UotUSXTbQYjhSyEJ9OSNmmJ3VZtgRBv58AMCF7LrO3EJBDZ7K5tuaRPDCVNMbfm8qm9X
         9ID6wa/EDvmSMzIdAZ+B3zN/k2wJoO6rHAcLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7BLAt/fJYUj0OsISV5J6z9qzVDh6CQrx7wQ/ZZuGFs=;
        b=nr0EGJTl+NWtTSkkJbLzoPaKMIzItjRGm311OSkCWo2+X9hAq6dTh1sKQ3c+42bHyl
         1iEcBeclsF0uFEQ7lWTgs0Rd8h1z/d4QoE5mPYf03coaWfVq76OkwAlTuwSFFYvxTpwb
         Mim+zS5MJB5TeG5g6dtKJ4yn0pU37WXKaGS2/bguRShvR3mQm2VOMpNuJYXcv6BVE9MA
         PmL1LihGIFyOg2s0LGtlMqYcAYVtA5OhfQnSVYFpZP6/KBWG9SHNsmTv/oKobSxWwUxX
         nXR49w4EMPwx77S4q7DEQZLq5Re248Mk20kZ3BQXccGuLe+btIr4+j7TfF8QaWWtl8dG
         iS/g==
X-Gm-Message-State: AOAM533qyBtKvcFz5gv+KKFYp9oa3INiKlGeFSt8hNoHpii2vlz7EZuR
        3P4bZ/JpG/PKQdhbAtiz8CfoJwKRJP8srGS07GY=
X-Google-Smtp-Source: ABdhPJxtY5MaCVOcoAIuDyPvNS+qfAKIuFbYyX8v50azwZFdPgvA6LcsmfzzPFnrrGOWsQwS8Fx3Xg==
X-Received: by 2002:a05:6512:3f0a:b0:44a:e3f:2862 with SMTP id y10-20020a0565123f0a00b0044a0e3f2862mr11809562lfa.397.1647912103964;
        Mon, 21 Mar 2022 18:21:43 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m13-20020ac2424d000000b0044859fdd0b7sm1977675lfl.301.2022.03.21.18.21.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 18:21:43 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 17so22177938lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:21:43 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr17545979lja.443.1647912102735; Mon, 21
 Mar 2022 18:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220320231317.2171300-1-linux@roeck-us.net>
In-Reply-To: <20220320231317.2171300-1-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 18:21:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM1uHH1WJ47Zt5OGK5qjtFkvVCZLff+TKA2ahXAM1xQg@mail.gmail.com>
Message-ID: <CAHk-=wgM1uHH1WJ47Zt5OGK5qjtFkvVCZLff+TKA2ahXAM1xQg@mail.gmail.com>
Subject: Re: [GIT PULL] hwmon updates for v5.18
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 4:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Improvements to existing drivers:
> - adt7x10: Convert to use regmap, convert to use with_info API,
>   use hwmon_notify_event, and other cleanup
> - aquacomputer_d5next: Add support for Aquacomputer Farbwerk 360
> - asus_wmi_sensors: Add ASUS ROG STRIX B450-F GAMING II
> - asus_wmi_ec_sensors: Support T_Sensor on Prime X570-Pro
>   Deprecate driver (replaced by new driver)
[...]

To make my life easier, can I ask you to try to format these things a
bit more sanely and legibly?

You had this odd mix of sometimes using new lines to separate
different things (eg that asus_wmi_ec_sensors entry), and sometimes
just multiple different things in a list that then had line-breaks in
the middle.

That kind of stuff is _very_ hard to parse as anything but a random
jumble of words all crammed together.

Whitespace to separate things is good, and some kind of consistent
indentation makes it more legible. I edited it all up (hopefully
correctly), but it would be nice to get it in a readable form to begin
with..

Yeah, if everything does well, nobody will ever need to read that
merge message, but let's try to aim for nice and informative commit
messages anyway.

             Linus
