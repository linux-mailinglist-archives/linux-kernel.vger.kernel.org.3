Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2823A4AA88F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376328AbiBEMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiBEMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:13:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989AC061346;
        Sat,  5 Feb 2022 04:13:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x3so7420485pll.3;
        Sat, 05 Feb 2022 04:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rnD7bDV7EXBPjEk7+ict90OkiTfaLdo+KW7xFlZ04Ec=;
        b=ChTZk2hx6HG9DD4rCkFrtnHNsgHqwPXLf11lRni/qPRg7NyA+sqSfh3YZJKRbOxSQ5
         3V+sTzLjr+DDUo5bqptv+hLLCd9t0poAtHO5dxwxvSyxtWhLX7UiFHebrGGwsdWDarjG
         qBEcrjXIgid3yZuwu0D+T3YdGw/uk4L/hqn0IRDTtwE/92Q7VN+SsFhdPVTXRH8eNwMt
         A/rgsWArCoQlVn7yAX9XUXj9JQiOLV9sjSVgnSeVigABS9AkY+tPWzoqJFfJjbxp/bt+
         IeDanoogHTZkLuwqsY9/Kh9xTdrf5Tr6ufTQmW8vG5LjFUH+LIpX+VgxHSaJ+gGhmScv
         Z+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rnD7bDV7EXBPjEk7+ict90OkiTfaLdo+KW7xFlZ04Ec=;
        b=k129QiviMyPXsI+6Pgr5c1JrIJy8UrevrrqO4fhjGW9IayrmcxptwsGkrz4GxaIpSo
         7lqc5ESihBdB1bFeAP87xWXzIhXbv+8i1KW5as1aTNc3kmHodwzM1WmhOpKJJYPOX7Uz
         cZ3EDwUqr0qWwc1q1zzpx+s/fM3FqKr+i+Th1Wk0Ru+nnwl+TIxxz8YoZQii4KMjIkIH
         wQ2HEAaIVBYzMZ8amqofc3HNtoGab6cw8ckz65qZvYyu+D2UYyOHe+c983MC65fN5IPl
         xbrAQ3FxqxMIrH92KXA8vqEG3xKoaR+euyz6Z8M4VI8ZhLa9FVEEI+rTh07yQwwsjQ0e
         jTHw==
X-Gm-Message-State: AOAM530+rCRJkjoX1hyLhGF3NR0YafzXsdoPw0qSgiLZiVpYQcsZ515W
        2kfQqzSUTZFqlHCx+tudfbU=
X-Google-Smtp-Source: ABdhPJx9VYuhdB6iV1QdT9Cb9grlmbironJdh/8q1ZBO2A0rL+58/MmYQIxRpkhp1twOW+7IZUnBtQ==
X-Received: by 2002:a17:903:2282:: with SMTP id b2mr7866480plh.91.1644063186295;
        Sat, 05 Feb 2022 04:13:06 -0800 (PST)
Received: from [192.168.1.33] (154.red-83-50-83.dynamicip.rima-tde.net. [83.50.83.154])
        by smtp.gmail.com with ESMTPSA id p4sm5695730pfw.133.2022.02.05.04.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 04:13:05 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= 
        <philippe.mathieu.daude@gmail.com>
Message-ID: <df167547-a1b2-5b20-705c-33403ecf9e47@amsat.org>
Date:   Sat, 5 Feb 2022 13:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 4/4] clk: clps711x: Terminate clk_div_table with
 sentinel element
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Turquette <mturquette@linaro.org>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
 <20220205005232.772726-5-j.neuschaefer@gmx.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
In-Reply-To: <20220205005232.772726-5-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 01:52, Jonathan Neuschäfer wrote:
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div = 0).
> 
> Fixes: 631c53478973d ("clk: Add CLPS711X clk driver")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v3:
> - no changes
> 
> v2:
> - Add Fixes tag
> ---
>   drivers/clk/clk-clps711x.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
> index a2c6486ef1708..d96d96c8752c7 100644
> --- a/drivers/clk/clk-clps711x.c
> +++ b/drivers/clk/clk-clps711x.c
> @@ -28,11 +28,13 @@ static const struct clk_div_table spi_div_table[] = {
>   	{ .val = 1, .div = 8, },
>   	{ .val = 2, .div = 2, },
>   	{ .val = 3, .div = 1, },
> +	{}

Why not use the same style on all patches? Others developers looking
at this code will directly grab this is a sentinel section, instead of
wondering why this empty section is here.

         { /* sentinel */ }

Anyhow the patch logic is correct, so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   };
> 
>   static const struct clk_div_table timer_div_table[] = {
>   	{ .val = 0, .div = 256, },
>   	{ .val = 1, .div = 1, },
> +	{}

(same comment)

>   };
> 
>   struct clps711x_clk {
> --
> 2.34.1
> 

