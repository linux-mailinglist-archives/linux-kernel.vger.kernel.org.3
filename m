Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B10148F3C1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiAOBFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:05:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:27592 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbiAOBFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642208734; x=1673744734;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=wZ0Ry+mIARE6XgrFHfixgiV08hKw7NCIewYKMb+m2qE=;
  b=nsWw0v+B2ihKsLi6UUAW/b72FV8iBqPWH1YSGV3B4o1lEohdnUz+eYOr
   EANYh8i2LLNBeD3aef7cNwGdtZwf7PmHvUns5omPZ1SoctZH8UieJ6oXf
   mnd2i6yqrx/raFBeM9p+zeURsSAgaUO2VU2jWwqzYmhA63UmcrO6M6i+8
   jgHj7zYfHI9e0iP7rTTaUtskCF718LHOAaPH4gkxGS/ZHp0JAqlaLWl9q
   ey9j0IYJIje25TmtVNnlxz5/o/suriTo/woyojtWoOqFqtlCCu5cSsSvr
   VpJAaJIO6KWWB/iHwcSo1B3yWAu4NFfDVdcYI7FPqdLexyVYTJb2XEfcl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="307703011"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="307703011"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 17:05:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="624531822"
Received: from dsubasic-mobl.amr.corp.intel.com (HELO [10.212.67.37]) ([10.212.67.37])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 17:05:31 -0800
Subject: Re: [PATCH] slimbus: qcom: Fix IRQ check in qcom_slim_probe
To:     Miaoqian Lin <linmq006@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220114061830.13456-1-linmq006@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <239c3b32-6754-02ba-6bfd-7f05fa2adfed@linux.intel.com>
Date:   Fri, 14 Jan 2022 09:14:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114061830.13456-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/22 12:18 AM, Miaoqian Lin wrote:
> platform_get_irq() returns negative error number instead 0 on failure.

the 'instead of' wording is a bit misleading:

platform_get_irq() returns non-zero IRQ number on success, negative
error number on failure. Zero is not a valid return valid.


> And the doc of platform_get_irq() provides a usage example:
> 
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
> 
> Fix the check of return value to catch errors correctly.
> 
> Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/slimbus/qcom-ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
> index f04b961b96cd..ec58091fc948 100644
> --- a/drivers/slimbus/qcom-ctrl.c
> +++ b/drivers/slimbus/qcom-ctrl.c
> @@ -510,9 +510,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
>  	}
>  
>  	ctrl->irq = platform_get_irq(pdev, 0);
> -	if (!ctrl->irq) {
> +	if (ctrl->irq < 0) {
>  		dev_err(&pdev->dev, "no slimbus IRQ\n");
> -		return -ENODEV;
> +		return ctrl->irq;
>  	}
>  
>  	sctrl = &ctrl->ctrl;
> 
