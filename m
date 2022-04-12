Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF184FD410
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353143AbiDLIkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357219AbiDLHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298341572E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:13:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x33so24162398lfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=emlid.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bCdGhs8/+WdbuSK8w12DNJiZfrFySBvjWoRaQGXzrgo=;
        b=IJlogSJ+lfEbnl7Zbo9UZTCKbCGkMo9dOtOxum9KW7EDQQCEEOH7l76rsQQzzXmSEk
         FwJ7H5uhOHoWWY846y0kUAJWFeK8QVQG6uuHQLTKY/LWq0X1+P9Y74qRBpcfyQK+Iz+L
         xIkr1BMXboRz8afEp1B+QCb2XgwKtXOtTZm52oCWL73jQTWs/BpSNAH1t9wgCknua7t3
         g5emvOmJEASNXfbDxSDcwodextwcLSRFfWnm+b5wKYrBH8oYrYrYR8FciyKw/o7xqRjL
         bgdNbmqE6NdD5FlKQyW3aPun2rlVkL+SyzD3THMqV3phIvaOeuDU4bFItjNtET2pEspk
         24Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bCdGhs8/+WdbuSK8w12DNJiZfrFySBvjWoRaQGXzrgo=;
        b=VqRIgQD8oc9Tp3b/d4suHqreSfovOxGD9G/P0eX9msxq308bLltDLFZIG+KkoR1g/w
         r07FT50FNIdqzO0QaNN0ZmTYkXj+mIROcjgGkq14BiyR9B7CbNs2L4xQuvwYoDIC+tjV
         fKKVggn/Ot6KDzYUIE75DnLTJ1ovBswwUCY8Bh1ooc9WHqujXSrlSkad/yj/APgRW2sV
         QxuqUon/SHPdAGvdHMt703VEJ0WRGwb72XQhL+s9Jv7lymslLg215uZ1njUnLV1Xb+P8
         WVs0CdHZVJbVsUXitNlCUvrNdUgHmy/y1F9BrxezkYREVTu0oXRgWXvsLM7W2Ix8ojJL
         r1fg==
X-Gm-Message-State: AOAM5326Kb9yMIf9KMTuB1VDyEIPYcZuFDr/Dlk9bF47LE5Md+pf6Kh9
        cattLTBkJXuGcXp5gA3wMnTBo+sCFqNm1uHwxIQ=
X-Google-Smtp-Source: ABdhPJxJD8QEh7NEMMkI2Ulc92476UGnYJt1yjhTiCmllJn+nJJiiuZtY64e/smzwquQJo9X0zW+dg==
X-Received: by 2002:a05:6512:2391:b0:46b:a28d:4fe1 with SMTP id c17-20020a056512239100b0046ba28d4fe1mr7508363lfv.448.1649747630450;
        Tue, 12 Apr 2022 00:13:50 -0700 (PDT)
Received: from emlid-ThinkPad-E480.localdomain ([85.143.205.202])
        by smtp.gmail.com with ESMTPSA id b10-20020a056512304a00b0044ac20061e9sm3540725lfb.104.2022.04.12.00.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:13:49 -0700 (PDT)
From:   Andrei Lalaev <andrei.lalaev@emlid.com>
To:     andy.shevchenko@gmail.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Lalaev <andrei.lalaev@emlid.com>
Subject: Re: [PATCH] gpiolib: of: fix bounds check for valid mask
Date:   Tue, 12 Apr 2022 10:03:58 +0300
Message-Id: <20220412070355.139507-1-andrei.lalaev@emlid.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHp75VePiCm6wH7aXcbnrt-4nntqx99s45wYk3+C2AKs=Usang@mail.gmail.com>
References: <CAHp75VePiCm6wH7aXcbnrt-4nntqx99s45wYk3+C2AKs=Usang@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 7:55 PM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> On top of that, it would be nice to be sure that at least all current
> in-kernel users (meaning all DTS provided so far by the kernel) do
> interpret it as start,size.

I checked the DTS and only 36 of them use "gpio-reserved-ranges".
The 33 of them use tuple with the second element that is less than the first.
So it means that the maintainers interpreted it as "start,size".

And only 3 of them use one tuple with the second element is greater than the first.
The list of this DTS:
    1. arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
        AngeloGioacchino Del Regno added it in the commit 9da65e441d4d
        ("arm64: dts: qcom: Add support for SONY Xperia X Performance / XZ / XZs (msm8996, Tone platform)")
        But in another commit 8b36c824b9a77 ("arm64: dts: qcom: sdm630-xperia-nile: Add all RPM and fixed regulators")
        he clearly interpreted it as "start,size" because the second element
        is less than the first.

    2. arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
        The same maintainer as for the previous DTS.
        He added "reserved-range" in the commit 122d2c5f31b6e
        ("arm64: dts: qcom: Add support for MSM8998 F(x)tec Pro1 QX1000")

    3. arch/arm64/boot/dts/qcom/sa8155p-adp.dts
        Bhupesh Sharma added it in the commit 12dd4ebda47ab
        ("arm64: dts: qcom: Fix usb entries for SA8155p adp board")

Should I ask these maintainers how they interpreted this property?

> Otherwise this will be an (unacceptable) ABI change and hence documentation
> would need to be fixed with variable names in the code

I want you to notice that "of_gpiochip_init_valid_mask" uses "bitmap_clear"
that clears "nbits" bits starting from the "start". So it can't be interpreted
as "start,end". That's why I think everyone interprets it as "start,size" because
it works like "start,size" and the documentation tells it is "start,size".
