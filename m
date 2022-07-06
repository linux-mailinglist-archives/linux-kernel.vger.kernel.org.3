Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183355688B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiGFMwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiGFMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:52:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18632125E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:52:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 5so7693693plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eoGuZazZt/0EeqeMlL7HIZZ5ZS3+Jp4x1OJVaifQZgI=;
        b=zHye5Lu/f8z+OaiRL7Im0V+Dc4RbC3r3Ahwyi3l2A8ZNQnADz0pU0wek8ogaXYaqk6
         qGxDOH0UgJ0IDQsGFX4KPf7jXUgPZA2k+sQcj+ktLrNEZCGIT1/Da3tC6mbZNqWCqSEJ
         ViF9QhGmy0d/7F7ziAOCzav+LOC3po0Ao7CVw4jhtBXWUVSbGrome9ooZkiRGvm+kbnw
         XbbFL+XGlMVztUsTrtvsafrrghaiyDWc1f3JPxBugWfoIumyAwFuKntF4tF7XMahXZi2
         dKzLKpWPQwLdoXoGldEi6JQN0PK8TrIQSTKYI6rjJRmhRrpcODutEHOVyXZBFmNyk4EC
         /wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eoGuZazZt/0EeqeMlL7HIZZ5ZS3+Jp4x1OJVaifQZgI=;
        b=vmtubLluIMGWtMm2JuXZdvCPecQafT2xMEb+r062bOaPm99dCDEpXpnPAQIZ/HbRTo
         whA+Knf5FOlYlTeUeZD7W5IhQTGHq4Dd6xBudnStD9NkyNoah7XduzPczQn/peYulUyO
         V4W5h8ufWu1A0+VOtxdSyKcNSA7YvixEIds/bi7ZtRDEnV0MEpkX3YOfbmV39/S3bgmN
         ATBVQB1uTIVCzMB+rbSpJX6RnUtjqF1Zaor77nXvgmAgEUatmms7hi4lyGBmml8+CXB+
         WIuU9Tzf07HyBnOYts7sk0fDnViMyAL+nDv/QMR3EbnxLzf3Qsr752PstwWxM9EkNReh
         wISA==
X-Gm-Message-State: AJIora+RkEMzh1Yl2jIrSr2n3tCec7HBtS4tHX1233VBvhHUjBKmmCtr
        3o7gWs7sI1K0sBY/iDL2GeFe
X-Google-Smtp-Source: AGRyM1uq7M5HT00nmhH2W5TGieARitgSBzSweDfbxTCHYXb39Vr226B5eNFWAaVhFPTnaaKfToRA9Q==
X-Received: by 2002:a17:902:8689:b0:14e:f1a4:d894 with SMTP id g9-20020a170902868900b0014ef1a4d894mr47578859plo.65.1657111939398;
        Wed, 06 Jul 2022 05:52:19 -0700 (PDT)
Received: from thinkpad ([117.202.190.202])
        by smtp.gmail.com with ESMTPSA id mm8-20020a17090b358800b001ef79eb5033sm8938047pjb.11.2022.07.06.05.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:52:18 -0700 (PDT)
Date:   Wed, 6 Jul 2022 18:22:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Chris Lew <quic_clew@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] soc: qcom: smp2p: Add memory barrier for irq_pending
Message-ID: <20220706125214.GA2327@thinkpad>
References: <1657087331-32455-1-git-send-email-quic_clew@quicinc.com>
 <1657087331-32455-4-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1657087331-32455-4-git-send-email-quic_clew@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 11:02:10PM -0700, Chris Lew wrote:
> There is a very tight race where the irq_retrigger function is run
> on one cpu and the actual retrigger softirq is running on a second
> cpu. When this happens, there may be a chance that the second cpu
> will not see the updated irq_pending value from first cpu.
> 
> Add a memory barrier to ensure that irq_pending is read correctly.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---
>  drivers/soc/qcom/smp2p.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index a94cddcb0298..a1ea5f55c228 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -249,6 +249,9 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
>  
>  		status = val ^ entry->last_value;
>  		entry->last_value = val;
> +
> +		/* Ensure irq_pending is read correctly */
> +		mb();

I don't quite understand why you need a barrier here. mb() makes sure all the
prior instructions gets executed before executing the later one. But why is it
needed here?

>  		status |= *entry->irq_pending;
>  
>  		/* No changes of this entry? */
> @@ -356,6 +359,11 @@ static int smp2p_retrigger_irq(struct irq_data *irqd)
>  
>  	set_bit(irq, entry->irq_pending);
>  
> +	/* Ensure irq_pending is visible to all cpus that retried interrupt
> +	 * can run on
> +	 */
> +	mb();
> +

Here it makes sense because you want the CPU to set irq_pending before exiting
from this function. But even then you can use the less strict smp_wmb() that
serves the exact purpose.

Thanks,
Mani

>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
