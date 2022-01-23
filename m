Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF849723C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiAWOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 09:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiAWOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 09:46:31 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFCC06173B;
        Sun, 23 Jan 2022 06:46:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so14255328eje.10;
        Sun, 23 Jan 2022 06:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=hgWH+WcZXMlxkNrNUYeXrIrZsOUs50NokRp+9lLtuio=;
        b=bDhWIjq4PSVUuW00XfoEI+VZpml2rFKFdisJ2LLFq8a1sSibrFjyit2wIZICRAUFO+
         DhVT9lY/F3n4ExOnUAze5+POY5jimBX6KmmBYPRbOMcTYlu9RhQpRlqjdN6Ye+Zob2Oe
         KtDA3UWwMV3t5QWy7GZb5q0jlPpio1Ii5r4Zb8nMmoru3/iInyCr0nsS0WN8g9/v3Qnq
         kyMrggZZ6exW11xnsSRDbj6CNMmb+ijowaXXMvRQEVUd+Uf0dN1zDFyp5BYRBVN08Kvv
         b4S3niqnvX40jpGKzkdgghk8q/i9f2je6zoQU2rG0D52trZm/4I/hOiR30e9IKtjd/yl
         OB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=hgWH+WcZXMlxkNrNUYeXrIrZsOUs50NokRp+9lLtuio=;
        b=r6hFXciTKwzffK4VxEVnp+rcodURAUSao7kiOZOo9xBXQ5whX36mENfvC9M3Pz7B3o
         piMeh4SiDMKukI87ijPME79ijPPF+LkwG9HkVzKq3FEXC2F+ERnHKxfvUk3OYfyowZaX
         Z9VStG2caGn0flEgZS6gDlfWXOkQb6BZIz6mKMvzdZztqGGZcGQU+KFx/vDlizYEgCf4
         LV6Ib7Cabmnl1l2kkEoznexyWaWNwJe76JdNu9+/OkeqNJfD3Tur7oYtjRh4wExM17Su
         RIWrg1h5sdXL64M0amsuLOGpZEO7aTlnYkfXqsW5gxGLyN03kTzyYwO9O884o3+YEhLl
         COKw==
X-Gm-Message-State: AOAM531hGysYFlBll54PT5qzzeB/Kom/dJ0U4UMfVWQowlpnlLoaguW4
        FF/ZDMgvNOPltYlaW2UYAuM=
X-Google-Smtp-Source: ABdhPJxexb6SNOjl8nBjHlVlmuVMQjSS2rGSKoTXvLvQSz0ZlvWRxzDR85vXwWCoH5fcXKWhZHmGIQ==
X-Received: by 2002:a17:907:3fa1:: with SMTP id hr33mr6694895ejc.239.1642949189039;
        Sun, 23 Jan 2022 06:46:29 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id f26sm5019979eds.69.2022.01.23.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 06:46:28 -0800 (PST)
Message-ID: <61ed6a44.1c69fb81.35728.5e8b@mx.google.com>
X-Google-Original-Message-ID: <Ye1qQYTvGt7C1FFF@Ansuel-xps.>
Date:   Sun, 23 Jan 2022 15:46:25 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: phy: qcom: ipq806x-usb: conver latch
 function to pool macro
References: <20220117002641.26773-1-ansuelsmth@gmail.com>
 <20220117002641.26773-2-ansuelsmth@gmail.com>
 <Ye1BcvaneH0sWeQV@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye1BcvaneH0sWeQV@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 05:22:18PM +0530, Vinod Koul wrote:
> On 17-01-22, 01:26, Ansuel Smith wrote:
> > Convert latch function to readl pool macro to tidy things up.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> > index 6788e0e8272a..ab2d1431546d 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
> > @@ -112,6 +112,9 @@
> >  #define SS_CR_READ_REG				BIT(0)
> >  #define SS_CR_WRITE_REG				BIT(0)
> >  
> > +#define LATCH_SLEEP				40
> > +#define LATCH_TIMEOUT				100
> > +
> >  struct usb_phy {
> >  	void __iomem		*base;
> >  	struct device		*dev;
> > @@ -156,19 +159,9 @@ static inline void usb_phy_write_readback(struct usb_phy *phy_dwc3,
> >  
> >  static int wait_for_latch(void __iomem *addr)
> >  {
> > -	u32 retry = 10;
> > -
> > -	while (true) {
> > -		if (!readl(addr))
> > -			break;
> 
> we break if read returns non zero value...
> 
> Do you know what is the value expected?
>

If I understand the logic here, we write a value and we wait for it to
get applied. To confirm that we execute a writel and then we readl the
same address until it does return a value. That is the way used to
understand that the write process has finished and that the value has
been applied/we can write again.

> > -
> > -		if (--retry == 0)
> > -			return -ETIMEDOUT;
> > -
> > -		usleep_range(10, 20);
> > -	}
> > +	u32 val;
> 
> Okay this contains garbage..

I think I didn't understand, val value will get replaced by readl in
the pool_timeout function.

> >  
> > -	return 0;
> > +	return readl_poll_timeout(addr, val, !val, LATCH_SLEEP, LATCH_TIMEOUT);
> 
> and we are waiting for it read a garbage value!
> 

Again could be very confused and wrong but the pool_timeout macro does
the exact same thing of the wait_for_latch function with th only
difference of handling the sleep differently. We put in val the return
of readl and the break condition as !val. Or I didn't understand the
concern about garbage value.

> 
> -- 
> ~Vinod

-- 
	Ansuel
