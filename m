Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F290465C3B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351587AbhLBClN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhLBClK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:41:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4292DC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:37:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v11so56465331wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 18:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JsKUM69l0TojRZuPy1zQAdFi3D3NhhZi1Z7olgD9/sg=;
        b=UwbaaiUd4+0K7ufpVawGCjB6Qxq5FmjRZ1WI9BWb5n0R8U9lzK3GUZxUWOUnlDj+h4
         qf1rUQaK5Oi5/ENdo5K2gQuZrrTCAjp77SSLpcsWaVpEvaPIH2hBl5dyF3TJUkzEFiBo
         h/G4VXKtX1CfF103CaXaxTsKHZcVwSbAaCfZptHmGndg3yNpFkL0nqyhuvxuwCJsonQO
         GswOXtsjV0M6YeWK5pgM0NkiBbUl0AtrwVAhghTw6N/4m7510dImyOaz7P/PfjUQIpPY
         FTahIScpg8S74N0PU4OQyQYJDVLO8sR7Kp2mzJ0Tvs6CH/W6zHMJEg6vFMBIZwd/HCxz
         W4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JsKUM69l0TojRZuPy1zQAdFi3D3NhhZi1Z7olgD9/sg=;
        b=LgrOOQ1K+XYT/duM0iXJNZkQ44ctqas3UKMndMv+hT4JF2tBFbsp0YRMO7mVYmOJl/
         pEuNxd+QcFCQJBy88qePEhHWyYWoch6IaBd9jX/5j8bD0cLEjJwYN2FIszVjDqndTzAi
         m0Fls6swuArNSDJRO92yHQZUdGvhGe724Tqbg9a2Uxhv39+2QzCxsFDNFFy+LVoSi9aY
         l8P66QiBWJikkR+DghDZOcGaaTTMZ94UF+Q2Ldrbq5QkYP8r/oTPXQ4HpMzevN3DAC+S
         NGyiV6e1p8UlBgxPF73A4HARrhtfsfCi6H+fRzaeUS2AyrPsYwBwDaTrdoexIHIMCdv6
         2qAQ==
X-Gm-Message-State: AOAM533ajwCUm1Ge8C5okB24UnDoa+k677Qwey+IZo4PhgLaa+0VY2px
        IqTy9DfFK72zp2pS+tjrLGIMfQ==
X-Google-Smtp-Source: ABdhPJyjTle9Ps+4EEM+PNcuHlxXQR8UXLSXw31KTMGezaCDwx8xWEQT069SKux2rRveg3PSunl7oQ==
X-Received: by 2002:adf:dbd1:: with SMTP id e17mr11072097wrj.480.1638412657022;
        Wed, 01 Dec 2021 18:37:37 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i15sm928209wmq.18.2021.12.01.18.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 18:37:36 -0800 (PST)
Message-ID: <829e2ce0-888a-b859-9e94-4b92d6c10d4a@linaro.org>
Date:   Thu, 2 Dec 2021 02:39:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [RESEND PATCH v3 01/10] spmi: pmic-arb: handle spurious interrupt
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Cc:     collinsd@codeaurora.org, subbaram@codeaurora.org,
        tglx@linutronix.de, maz@kernel.org,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com>
 <1638403212-29265-2-git-send-email-quic_fenglinw@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1638403212-29265-2-git-send-email-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2021 00:00, Fenglin Wu wrote:
> Call handle_bad_irq() for handling spurious interrupt. While at it,
> add an error print in cleanup_irq() for any spurious interrupt which
> is fired but not having interrupt handler registered.

Being excruciatingly pedantic, I'd suggest breaking this up into two 
patches, one for the ratelimit one for the logical change to the irq 
handling flow.

> Signed-off-by: Abhijeet Dharmapurikar<adharmap@codeaurora.org>
> Signed-off-by: David Collins<collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu<quic_fenglinw@quicinc.com>
> ---
>   drivers/spmi/spmi-pmic-arb.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index bbbd311..da629cc 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -489,6 +489,8 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
>   	u8 per = ppid & 0xFF;
>   	u8 irq_mask = BIT(id);
>   
> +	dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
> +			__func__, apid, sid, per, id);
>   	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
>   
>   	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
> @@ -502,10 +504,10 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
>   				irq_mask, ppid);
>   }
>   
> -static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
> +static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
>   {
>   	unsigned int irq;
> -	u32 status, id;
> +	u32 status, id, handled = 0;

If handled were an int

>   	u8 sid = (pmic_arb->apid_data[apid].ppid >> 8) & 0xF;
>   	u8 per = pmic_arb->apid_data[apid].ppid & 0xFF;
>   
> @@ -520,7 +522,10 @@ static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
>   			continue;
>   		}
>   		generic_handle_irq(irq);
> +		handled++;
>   	}
> +
> +	return (handled) ? 0 : -EINVAL;
>   }

you could "return handled;" and then have

if (periph_interrupt(pmic_arb, apid))
     handled++;

later on

Its not important I suppose but please do at least break this up into 
two separate patches.

---
bod
