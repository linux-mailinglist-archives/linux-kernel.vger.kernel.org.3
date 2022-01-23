Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511E049715C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiAWLwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiAWLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:52:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24452C06173B;
        Sun, 23 Jan 2022 03:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8459960BAF;
        Sun, 23 Jan 2022 11:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E74C340E2;
        Sun, 23 Jan 2022 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642938741;
        bh=Hzf1QA1X0U32CcLGCPEgwz1IWeec/ElYEjEy+Y1MEfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MC3PIFON5AL8l6Vt8y2ALb5WDDUTQcqcQoPRXIJeI9v31hm02ikRnD19Ii7EGFd9w
         d1rM/5KtjKrqg6YcDLgA0MXPti1Rr1Rgy6xw4POnnBAZnHJlkAJnSgcvY0WlUzigaM
         yvekd9Njt50K5M4MlBmQDlH9buavfxI1TiIOT4yj7I0PVHZiyJVcInk4W50ivAkU0v
         Be/2+WdcfGksItKbNTl5ui1FZcQdqB7ngn3ux587gBKzoyVFLh8CDNjQseXjHO3iQf
         FOYynusxXKTeTC4T/CasyOYHgADfjFRycg9U5U2ZdfxtdS+nDsBoRcErQJKlnrwk0/
         5leyHViDEODAg==
Date:   Sun, 23 Jan 2022 17:22:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: phy: qcom: ipq806x-usb: conver latch
 function to pool macro
Message-ID: <Ye1BcvaneH0sWeQV@matsya>
References: <20220117002641.26773-1-ansuelsmth@gmail.com>
 <20220117002641.26773-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117002641.26773-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-22, 01:26, Ansuel Smith wrote:
> Convert latch function to readl pool macro to tidy things up.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> index 6788e0e8272a..ab2d1431546d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> @@ -112,6 +112,9 @@
>  #define SS_CR_READ_REG				BIT(0)
>  #define SS_CR_WRITE_REG				BIT(0)
>  
> +#define LATCH_SLEEP				40
> +#define LATCH_TIMEOUT				100
> +
>  struct usb_phy {
>  	void __iomem		*base;
>  	struct device		*dev;
> @@ -156,19 +159,9 @@ static inline void usb_phy_write_readback(struct usb_phy *phy_dwc3,
>  
>  static int wait_for_latch(void __iomem *addr)
>  {
> -	u32 retry = 10;
> -
> -	while (true) {
> -		if (!readl(addr))
> -			break;

we break if read returns non zero value...

Do you know what is the value expected?

> -
> -		if (--retry == 0)
> -			return -ETIMEDOUT;
> -
> -		usleep_range(10, 20);
> -	}
> +	u32 val;

Okay this contains garbage..
>  
> -	return 0;
> +	return readl_poll_timeout(addr, val, !val, LATCH_SLEEP, LATCH_TIMEOUT);

and we are waiting for it read a garbage value!


-- 
~Vinod
