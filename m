Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D60495614
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377990AbiATVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiATVsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:48:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B70C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:48:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so17232931wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=JjVDuclbm/fwd2D1p+3vNEJf8jRpvYGorewRrFiM1Nk=;
        b=BhkPYbE7gJHwnPZPanlfo81NZiNYPU3pUlQRgPPsVwF2iIRRzRA5gL+RYJ2hDgIHb3
         aRU2eMEqs27g0lDG94wnqyLtTNN2ROeLl4IVsIRyl8hFyeYr6WQPEG2Qi9UXyVs3HHRz
         RubuD53ZgUcuVHBMhWAPnvqJvPzTPGJETf/mAkMykQaLCc8IRZU87pGIjCQw43fIeCHS
         WA87ZD/HIQ3sI5dVkDVDMt/g981l0umLfNThnpx1dG+ZSdtHuiPXkpjEF1/uQHd00Vgt
         TYLJffI9ZQblEFIescsXcuZVPO7gE9Y/f1FRv+oGSB95UJI7BxYMl/11mK5D2phSKWYf
         XQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=JjVDuclbm/fwd2D1p+3vNEJf8jRpvYGorewRrFiM1Nk=;
        b=tHG3rV+pnFPDbC/yMzHEIYl9V52KhnklYX8i3taGOcrxZqUrau+eRlORBvbH8JsU0D
         5qgDgak8NK/K+Caj5SUwhlTMAt4KTo0+I3dzK9mKheNNchdaIMbBPd5K27SjmpjP7/cG
         4P1q7jHveuam+E/BLUeeeRHAYxMP76WwlPL00F+ThkaplNR7Q1ojd9DomFLtRYXsCRX6
         HgWT8Vw4luOFUaSq8jNUIx6dULikgnyFsJuBy+Kn5bMMQG+93MoLArSMb4sUso1VdTRo
         D63FlkNyoSwYdZR63/Avz/MIW6w96sLbnPLzTxjYgR7+iFdIuDJUBOGFP0IhjugMkYBJ
         HZuQ==
X-Gm-Message-State: AOAM531OIzYTTifU73UBm+UhjlpnNKOY/4Tgiq6mtJxVceEOU8FoRu1l
        3A9OnmIXtu+SkdCb/GJ8hJemfw==
X-Google-Smtp-Source: ABdhPJyeAzG7rOyZiz2BqoVDEHOnTtESwblpIq6zOwSJ2PM3W38rOTS4SiCV4oVBL9N6rxvZoGT5Mg==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr10699464wmz.61.1642715320804;
        Thu, 20 Jan 2022 13:48:40 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id o15sm4543402wri.86.2022.01.20.13.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:48:40 -0800 (PST)
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <20220118030911.12815-4-yu.tu@amlogic.com>
 <7a8016ba-730b-f599-2032-31cf03990a55@kernel.org>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jiri Slaby <jirislaby@kernel.org>, Yu Tu <yu.tu@amlogic.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V6 3/5] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Date:   Thu, 20 Jan 2022 22:48:05 +0100
In-reply-to: <7a8016ba-730b-f599-2032-31cf03990a55@kernel.org>
Message-ID: <1jbl062i4o.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 18 Jan 2022 at 10:39, Jiri Slaby <jirislaby@kernel.org> wrote:

> On 18. 01. 22, 4:09, Yu Tu wrote:
>> Using the common Clock code to describe the UART baud rate clock
>> makes it easier for the UART driver to be compatible with the
>> baud rate requirements of the UART IP on different meson chips.
> ...
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
> ...
>> @@ -629,57 +640,105 @@ static struct uart_driver meson_uart_driver = {
>>   	.cons		= MESON_SERIAL_CONSOLE,
>>   };
>>   -static inline struct clk *meson_uart_probe_clock(struct device *dev,
>> -						 const char *id)
>> -{
>> -	struct clk *clk = NULL;
>> -	int ret;
>> -
>> -	clk = devm_clk_get(dev, id);
>> -	if (IS_ERR(clk))
>> -		return clk;
>> -
>> -	ret = clk_prepare_enable(clk);
>> -	if (ret) {
>> -		dev_err(dev, "couldn't enable clk\n");
>> -		return ERR_PTR(ret);
>> -	}
>> -
>> -	devm_add_action_or_reset(dev,
>> -			(void(*)(void *))clk_disable_unprepare,
>> -			clk);
>> -
>> -	return clk;
>> -}
>> +static struct clk_div_table xtal_div_table[] = {
>
> This can be const, right?
>
>> +	{0, 3},
>> +	{1, 1},
>> +	{2, 2},
>> +	{3, 2},
>
> Not sure if you didn't remove too much whitespace. I think it should be
> like: "{ 0, 3 },". But I actually don't care, it's a minor thing.

Seconds
It worth fixing in the next version

>
> I cannot comment on the rest (clk and OF part) as my knowledge is pretty
> limited there. Leaving up to others.
>
> thanks,

