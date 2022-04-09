Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0D4FA7CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiDIM4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiDIM4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:56:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0EE11C3D;
        Sat,  9 Apr 2022 05:53:55 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ndAbB-0004qw-9A; Sat, 09 Apr 2022 14:53:53 +0200
Message-ID: <f2fc5822-56fb-26e8-00f3-71d2e359cf80@leemhuis.info>
Date:   Sat, 9 Apr 2022 14:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] si2157: unknown chip version Si2147-A30 ROM 0x50
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Robert Schlabbach <robert_s@gmx.net>,
        LMML <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Piotr Chmura <chmooreck@gmail.com>
References: <c4bcaff8-fbad-969e-ad47-e2c487ac02a1@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c4bcaff8-fbad-969e-ad47-e2c487ac02a1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649508836;f84f5e71;
X-HE-SMSGID: 1ndAbB-0004qw-9A
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Mauro, what's the hold-up here? Below patch is fixing a regression
caused by one of your patches. Why haven't you applied this or provided
feedback to Piotr what needs to be improved? Or am I missing something
and progress was made?

This really is overdue, the first version of this patch was already
posted two and a half weeks ago. Reminder, the newly added document on
handling regressions (
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/handling-regressions.rst#n132
) for this case states this as rule of thumb: "Aim to fix regressions
within one week ".

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.


#regzbot poke


On 31.03.22 17:55, Piotr Chmura wrote:
> Fix firmware file names assignment in si2157 tuner, allow for running
> devices without firmware files needed.
> 
> 
> It's regression in kernel 5.17.0, worked fine in 5.16 series.
> 
> device: 07ca:1871 AVerMedia Technologies, Inc. TD310 DVB-T/T2/C dongle
> modprobe gives error: unknown chip version Si2147-A30 ROM 0x50
> Device initialization is interrupted.
> 
> caused by:
> 1. table si2157_tuners has swapped fields rom_id and required vs struct
> si2157_tuner_info.
> 2. both firmware file names can be null for devices with required ==
> false - device uses build-in firmware in this case
> 
> Fix:
> 1. Rearrange fields in table si2157_tuners
> 2. Allow both firmware file names be NULL for devices defined with
> required == false
> 
> 
> Fixes: 1c35ba3bf972 ("media: si2157: use a different namespace for
> firmware")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215726
> Link:
> https://lore.kernel.org/lkml/5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info/
> 
> Cc: stable@vger.kernel.org # 5.17.x
> Signed-off-by: Piotr Chmura <chmooreck@gmail.com>
> Tested-by: Robert Schlabbach <robert_s@gmx.net>
> 
> ---
> 
> --- a/drivers/media/tuners/si2157.c    2022-03-20 21:14:17.000000000 +0100
> +++ b/drivers/media/tuners/si2157.c    2022-03-22 23:48:05.604408331 +0100
> @@ -77,16 +77,16 @@ err_mutex_unlock:
>  }
> 
>  static const struct si2157_tuner_info si2157_tuners[] = {
> -    { SI2141, false, 0x60, SI2141_60_FIRMWARE, SI2141_A10_FIRMWARE },
> -    { SI2141, false, 0x61, SI2141_61_FIRMWARE, SI2141_A10_FIRMWARE },
> -    { SI2146, false, 0x11, SI2146_11_FIRMWARE, NULL },
> -    { SI2147, false, 0x50, SI2147_50_FIRMWARE, NULL },
> -    { SI2148, true,  0x32, SI2148_32_FIRMWARE, SI2158_A20_FIRMWARE },
> -    { SI2148, true,  0x33, SI2148_33_FIRMWARE, SI2158_A20_FIRMWARE },
> -    { SI2157, false, 0x50, SI2157_50_FIRMWARE, SI2157_A30_FIRMWARE },
> -    { SI2158, false, 0x50, SI2158_50_FIRMWARE, SI2158_A20_FIRMWARE },
> -    { SI2158, false, 0x51, SI2158_51_FIRMWARE, SI2158_A20_FIRMWARE },
> -    { SI2177, false, 0x50, SI2177_50_FIRMWARE, SI2157_A30_FIRMWARE },
> +    { SI2141, 0x60, false, SI2141_60_FIRMWARE, SI2141_A10_FIRMWARE },
> +    { SI2141, 0x61, false, SI2141_61_FIRMWARE, SI2141_A10_FIRMWARE },
> +    { SI2146, 0x11, false, SI2146_11_FIRMWARE, NULL },
> +    { SI2147, 0x50, false, SI2147_50_FIRMWARE, NULL },
> +    { SI2148, 0x32, true,  SI2148_32_FIRMWARE, SI2158_A20_FIRMWARE },
> +    { SI2148, 0x33, true,  SI2148_33_FIRMWARE, SI2158_A20_FIRMWARE },
> +    { SI2157, 0x50, false, SI2157_50_FIRMWARE, SI2157_A30_FIRMWARE },
> +    { SI2158, 0x50, false, SI2158_50_FIRMWARE, SI2158_A20_FIRMWARE },
> +    { SI2158, 0x51, false, SI2158_51_FIRMWARE, SI2158_A20_FIRMWARE },
> +    { SI2177, 0x50, false, SI2177_50_FIRMWARE, SI2157_A30_FIRMWARE },
>  };
> 
>  static int si2157_load_firmware(struct dvb_frontend *fe,
> @@ -178,7 +178,7 @@ static int si2157_find_and_load_firmware
>          }
>      }
> 
> -    if (!fw_name && !fw_alt_name) {
> +    if (required && !fw_name && !fw_alt_name) {
>          dev_err(&client->dev,
>              "unknown chip version Si21%d-%c%c%c ROM 0x%02x\n",
>              part_id, cmd.args[1], cmd.args[3], cmd.args[4], rom_id);
> 

