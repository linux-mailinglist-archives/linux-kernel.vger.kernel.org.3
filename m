Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996C53885B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbiE3U6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiE3U6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:58:19 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F7644DA;
        Mon, 30 May 2022 13:58:17 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 3B79ECAB3A;
        Mon, 30 May 2022 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1653944264; bh=wRrTILtAk1T0hSn3pjrXFhh9i/czq48W4ByfPx0RpNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ppV8WJmRqczGs4V/2Vgsq8lSolM9hcLiWo/YzVVlVbLTbgNZBY1i/jry7fdHePKLe
         As/L3piw+zHzYmGEAunIUocSlDIRHtnGLj1e1t10FvTQd5H5Dlcdv6E49bvfaec6E0
         msei1QJv2n69S1kUKgV+hRIRJCRxmNEPMy1plh40=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andr?? Almeida <andrealmeid@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-hammerhead: Add notification LED
Date:   Mon, 30 May 2022 22:57:43 +0200
Message-ID: <2844866.mvXUDI8C0e@g550jk>
In-Reply-To: <20220530070618.GC1363@bug>
References: <20220505164336.13210-1-luca@z3ntu.xyz> <20220530070618.GC1363@bug>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Montag, 30. Mai 2022 09:06:19 CEST Pavel Machek wrote:
> Hi!
> 
> > From: Andr?? Almeida <andrealmeid@collabora.com>
> > 
> > Nexus 5 has a RGB LED connected to the TRILED and hence channels 7, 6 and
> > 5 of the LPG. Add a node describing this.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > Signed-off-by: Andr?? Almeida <andrealmeid@collabora.com>
> > 
> > --- This patch depends on the PM8941 LPG patch:
> > https://lore.kernel.org/linux-arm-msm/20220504205411.1510667-1-bjorn.ander
> > sson@linaro.org/
> How does this LED end up looking in userland? We want to make sure all the
> phone RGB status LEDs end up using same path in /sys/..

Like this, on both hammerhead and FP2 (in a separate patch):

$ ls -al /sys/class/leds/rgb:status/
total 0
drwxr-xr-x 3 root root         0 Jan  5  1970 .
drwxr-xr-x 3 root root         0 Jan  5  1970 ..
-rw-rw-r-- 1 root feedbackd 4096 Jan  5  1970 brightness
lrwxrwxrwx 1 root root         0 May 30 13:59 device -> ../../../fc4cf000.spmi:pm8941@1:lpg
-r--r--r-- 1 root root      4096 Jan  5  1970 max_brightness
-r--r--r-- 1 root root      4096 Jan  5  1970 multi_index
-rw-rw-r-- 1 root feedbackd 4096 Jan  5  1970 multi_intensity
drwxr-xr-x 2 root root         0 May 30 13:59 power
lrwxrwxrwx 1 root root         0 Jan  5  1970 subsystem -> ../../../../../../../../../class/leds
-rw-r--r-- 1 root root         0 Jan  5  1970 trigger
-rw-r--r-- 1 root root      4096 Jan  5  1970 uevent

Regards
Luca

> 
> Best regards,
> 
> 									Pavel




