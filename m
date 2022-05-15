Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777B4527648
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiEOHe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiEOHeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:34:25 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B6614035;
        Sun, 15 May 2022 00:34:23 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nq8lg-00007j-EW; Sun, 15 May 2022 09:34:20 +0200
Message-ID: <2bee6f89-ff32-68a8-c2e6-957254b1b4d6@leemhuis.info>
Date:   Sun, 15 May 2022 09:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clk: bcm2835: fix bcm2835_clock_choose_div
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220428183010.1635248-1-stefan.wahren@i2se.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220428183010.1635248-1-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1652600063;e4c26344;
X-HE-SMSGID: 1nq8lg-00007j-EW
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. Thx for CCing the
regression list in a later mail.

On 28.04.22 20:30, Stefan Wahren wrote:
> The commit 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
> accidentially breaks the behavior of bcm2835_clock_choose_div() and
> booting of Raspberry Pi. The removed do_div macro call had side effects,
> so we need to restore it.
> 
> Fixes: 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

To be sure the issue doesn't fall through the cracks unnoticed as it
mentioned in the weekly reports, I'm adding it to regzbot, my Linux
kernel regression tracking bot:

#regzbot ^introduced 09e3b18ca5de
#regzbot title clk: bcm2835: 09e3b18ca5de broke the behavior of
bcm2835_clock_choose_div() and booting of Raspberry Pi booting of
Raspberry Pi
#regzbot ignore-activity


> ---
>  drivers/clk/bcm/clk-bcm2835.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 3ad20e75fd23..48a1eb9f2d55 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -941,6 +941,7 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
>  	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
>  	u32 div, mindiv, maxdiv;
>  
> +	do_div(temp, rate);
>  	div = temp;
>  	div &= ~unused_frac_mask;
>  

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
