Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6C48822C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 08:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiAHH3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 02:29:45 -0500
Received: from box.trvn.ru ([194.87.146.52]:33981 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbiAHH3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 02:29:44 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 70BE04038B;
        Sat,  8 Jan 2022 12:29:42 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641626982; bh=BDOoNJU08j6Y2WEJp0zPmdWV3cy+R14uzOjvfVoYobE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AUOQ+gqvtUCYb1LjGXJSlpNtbrLaEZzscSnETqamvKwkD6s5NjDFWNlB7x1YTejYx
         gl1wDsoOyTQ6L529MLDd0DLDiVY6LrRD5hev3Bh1lVQtWXiBtWOVbDVaoC3wibp/A5
         +YIwa2htCHL+PMlzZtF4exfv2VPwK7YXqEfoFiPNFJJoQT/ucmbkyXGYpiULemyZhf
         JKoEEXLNohpEgIFSBFNrDjdKN6OzRy/0XS6gcqCTeIxs5IBZ6KKdvc387oQrOMl1ZI
         ovvHE3q5L8gQJm177nLVfvTch/nq8gGxZRZ5GeY4IkSXCXMOSqBgPyCA1tVBSXr1dK
         nP0xnzJXdPTiQ==
MIME-Version: 1.0
Date:   Sat, 08 Jan 2022 12:29:42 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linus.walleij@linaro.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        svarbanov@mm-sol.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/4] clk: qcom: clk-rcg2: Make sure to not write d=0 to
 the NMD register
In-Reply-To: <20220108005604.05575C36AEB@smtp.kernel.org>
References: <20211209163720.106185-1-nikita@trvn.ru>
 <20211209163720.106185-3-nikita@trvn.ru>
 <20220108005604.05575C36AEB@smtp.kernel.org>
Message-ID: <b55dc8e9ec0e8549fe61e6439a02f912@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stephen Boyd писал(а) 08.01.2022 05:56:
> Quoting Nikita Travkin (2021-12-09 08:37:18)
>> Sometimes calculation of d value may result in 0 because of the
>> rounding after integer division. This causes the following error:
>>
>> [  113.969689] camss_gp1_clk_src: rcg didn't update its configuration.
>> [  113.969754] WARNING: CPU: 3 PID: 35 at drivers/clk/qcom/clk-rcg2.c:122 update_config+0xc8/0xdc
>>
>> Make sure that D value is never zero.
>>
>> Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for RCG")
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  drivers/clk/qcom/clk-rcg2.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index 6964cf914b60..fdfd43e2a01b 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -424,6 +424,10 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
>>         if (d > mask)
>>                 d = mask;
>>
>> +       /* Hardware can't handle d=0, make sure it's at least 1 */
>> +       if (!d)
>> +               d = 1;
> 
> Maybe clamp() would be better
> 
> 	/*
>  	 * Check bit widths of 2d. If D is too big reduce duty cycle and
> 	 * ensure it is non-zero.
> 	 */
> 	clamp(d, 1, mask);
> 

Yes, this looks nicer, will use it in v2. Thanks for the suggestion!

Nikita

>> +
>>         if ((d / 2) > (n - m))
>>                 d = (n - m) * 2;
>>         else if ((d / 2) < (m / 2))
