Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC7465C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352756AbhLBClQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbhLBClM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:41:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06514C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:37:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o13so56300558wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 18:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wzqb8iWc4IA7cc3hO/Ueuzi7uxDq1v6KPhK8/gu3O2k=;
        b=D/xc3sCLqDfcEE8dnlrbL/hY7h4ZHenQqbyY6By5miSkrrwWvGBof1kN6KrYTJR5Q8
         u+qeK0Gfr8LoLSkVAxz3Ls5gTvVek+WQZwcRlkV9OvTf7u45kKzByd+n84JOwiAbGVuf
         oYiIYa1vGcBPhjKzuhC3a74RN2UAMgTv+spG0OaU03/+6QPDFOXEnT1q1AdWtV9csBz3
         zitkUkqDnfk//qZmpCa4bzR2DRhs3+ma61wurr4EG7mdZQ4neohlE4dPBlqdN7ERgr2E
         3r+S7cGrx99jGd7eY7Gapu2ZQdVwK4WppYoPx42BoLzdRf/Is7FgzHSTbxr3TlRqKr6j
         JkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wzqb8iWc4IA7cc3hO/Ueuzi7uxDq1v6KPhK8/gu3O2k=;
        b=XRyjkCYvODnXfNrtXeMC1zWY5i5y39txmuNFUGcsRy/4LPefLxFDlVrNl2eAdw7+KA
         g4mJ2DaGfRMqyAULPWRH6K69bQWUTws4IIgwd98whWxHy+krwUzqhZXtkZUARVoHx8VX
         /bES6YVKrWIEV4feSP71H6Nln9m+zNyVOKpZLR+CzNoWjqIkoF1mDXtBVuugabwpDNfw
         zjQ73la0Rjjjfqg0YN0p+hn6PE31CZmkCdCITIvuAGHk6NTxgqSCMd/+nPsE3jKJDG7r
         T+dOLHGMqAGMT2bIDVWJgSZCha9mlObLjBjJHaoUXG2VHPkh94JVTVBzTKUMTiQFsQjD
         bIPg==
X-Gm-Message-State: AOAM531ZUUE6iPbuxZNaVS09jAGGYkBNHUvIWzrbqjNbNuTw9dIx/Rok
        NTNmD2wI6MVuB2+h3qDt2pXJKA==
X-Google-Smtp-Source: ABdhPJxB1qu52ApBFZjaO8eEs7Ko7RcYtljwQ1g/JPPllGD/lobv2GCjKW8HGGI2EGrnALCO+L5NZQ==
X-Received: by 2002:adf:f042:: with SMTP id t2mr11312424wro.180.1638412668564;
        Wed, 01 Dec 2021 18:37:48 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b6sm891713wmq.45.2021.12.01.18.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 18:37:48 -0800 (PST)
Message-ID: <09814d45-3f85-5611-5866-b33ae28cc2bb@linaro.org>
Date:   Thu, 2 Dec 2021 02:39:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [RESEND PATCH v3 02/10] spmi: pmic-arb: do not ack and clear
 peripheral interrupts in cleanup_irq
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Cc:     collinsd@codeaurora.org, subbaram@codeaurora.org,
        tglx@linutronix.de, maz@kernel.org
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com>
 <1638403212-29265-3-git-send-email-quic_fenglinw@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1638403212-29265-3-git-send-email-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2021 00:00, Fenglin Wu wrote:
> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> 
> Currently, cleanup_irq() is invoked when a peripheral's interrupt
> fires and there is no mapping present in the interrupt domain of
> spmi interrupt controller.
> 
> The cleanup_irq clears the arbiter bit, clears the pmic interrupt
> and disables it at the pmic in that order. The last disable in
> cleanup_irq races with request_irq() in that it stomps over the
> enable issued by request_irq. Fix this by not writing to the pmic
> in cleanup_irq. The latched bit will be left set in the pmic,
> which will not send us more interrupts even if the enable bit
> stays enabled.
> 
> When a client wants to request an interrupt, use the activate
> callback on the irq_domain to clear latched bit. This ensures
> that the latched, if set due to the above changes in cleanup_irq
> or when the bootloader leaves it set, gets cleaned up, paving way
> for upcoming interrupts to trigger.
> 
> With this, there is a possibility of unwanted triggering of
> interrupt right after the latched bit is cleared - the interrupt
> may be left enabled too. To avoid that, clear the enable first
> followed by clearing the latched bit in the activate callback.
> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> [collinsd@codeaurora.org: fix merge conflict]
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>   drivers/spmi/spmi-pmic-arb.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index da629cc..ce7ae99 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -492,16 +492,6 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
>   	dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
>   			__func__, apid, sid, per, id);
>   	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
> -
> -	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
> -			(per << 8) + QPNPINT_REG_LATCHED_CLR, &irq_mask, 1))
> -		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed to ack irq_mask = 0x%x for ppid = %x\n",
> -				irq_mask, ppid);spmi: pmic-arb: cleanup unrequested irqs
> -
> -	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
> -			       (per << 8) + QPNPINT_REG_EN_CLR, &irq_mask, 1))
> -		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed to ack irq_mask = 0x%x for ppid = %x\n",
> -				irq_mask, ppid);
>   }
>   
>   static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
> @@ -674,6 +664,7 @@ static int qpnpint_irq_domain_activate(struct irq_domain *domain,
>   	u16 apid = hwirq_to_apid(d->hwirq);
>   	u16 sid = hwirq_to_sid(d->hwirq);
>   	u16 irq = hwirq_to_irq(d->hwirq);
> +	u8 buf;
>   
>   	if (pmic_arb->apid_data[apid].irq_ee != pmic_arb->ee) {
>   		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u: ee=%u but owner=%u\n",
> @@ -682,6 +673,10 @@ static int qpnpint_irq_domain_activate(struct irq_domain *domain,
>   		return -ENODEV;
>   	}
>   
> +	buf = BIT(irq);
> +	qpnpint_spmi_write(d, QPNPINT_REG_EN_CLR, &buf, 1);
> +	qpnpint_spmi_write(d, QPNPINT_REG_LATCHED_CLR, &buf, 1);
> +
>   	return 0;
>   }
>   
> 

Shouldn't this have a

Fixes: 6bc546e71e50 ("spmi: pmic-arb: cleanup unrequested irqs")
Fixes: 02abec3616c1 ("spmi: pmic-arb: rename pa_xx to pmic_arb_xx and 
other cleanup")

so we know to backport as necessary

---
bod

