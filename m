Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724046D81A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhLHQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhLHQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:31:10 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4EEC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:27:38 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id u74so4771290oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0fAvDAwGpb762D3N/F1VLQfiE3umHXccn2rzhXlp0Ls=;
        b=EEKwi1Fw20jkO8Xpm3cAziHmdaBpBVXKz/ESMqULbMZM4gNHi2Zvy/8tFvDv5DYFB7
         w1G+/5pBHSxaRFW4fEyTo62ojvZ5Q7Ql4tFfaODQRnLIX2gLdDt4lae30AhhbohX3WDe
         rMcmNOLW+aeaIhc6UZKOTwy2H1odq2H8bVlUS3BX4ThLao3qLDd5RLD5ok1VTFOgHK8N
         UIS9tl+u++15uA8TmCqtlMOhorp40jCDjZmoDTJ1wJW7+pSZSOm1V1Rl2SYg8ykaP312
         0I4I4WHmmTYI+LMJ67SwHzAqVjhzLT1HVu3Gjfd4bfUA4Blfc1lum2oJmeqO/7Y7Q9X/
         NfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fAvDAwGpb762D3N/F1VLQfiE3umHXccn2rzhXlp0Ls=;
        b=12Lyolz5traS6Dy879Azf6sbDENK8D+R+nJLkz8UmSJrnzOd0RwlPmHKgKpc+ZPQDQ
         APzwqLtYNHyoXBtigrx2iM6rBEH9YLkwEJUMpmNCgu6CNQjWYUuA7DfI9cp+UiHEhR/j
         Xelg37Mzwdh4DY7MXNupJ87mD7FuBvJhCY1XuhmPmV0cYtV0j8f7BzZZx7tNlsF2EMI8
         GZct8Yd+MIcdgfnqiTdO/eh27GCTt8x5EzZnb7FpwHweEOltZVMH665Z6IwZCln9SL/c
         yUVRIi5YpesRcCT2yEFKkqKXmbOV3Z/Km462KMOnad+syjHY50X1/wwt7uGD/m7NwXpQ
         VK6A==
X-Gm-Message-State: AOAM532ayCz50W3VgJKH8MzMiiIL1/gZXE59GgtV5a0W27g3nGJhqnpV
        aKVuY2pVZ+9Yuou07fsDomSJBw==
X-Google-Smtp-Source: ABdhPJz90quyj/viO/1nla9+Xqqxnquzwkzrm4WXkfrltwO+V5B8UZQX6LgsE8CxCZB5o+hD7puIAQ==
X-Received: by 2002:a05:6808:228c:: with SMTP id bo12mr379407oib.93.1638980857561;
        Wed, 08 Dec 2021 08:27:37 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bk41sm770522oib.31.2021.12.08.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 08:27:37 -0800 (PST)
Date:   Wed, 8 Dec 2021 08:29:01 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel <kernel@vivo.com>
Subject: Re: [PATCH] phy: qcom: fix bug: application of sizeof to pointer
Message-ID: <YbDdTYny9VXtmzb7@ripper>
References: <20211207131642.5313-1-guozhengkui@vivo.com>
 <AO6AKgBME5Y4PNQLIg0Wlap9.9.1638889943341.Hmail.guozhengkui@vivo.com.@PFlhOTZLT3luc080NzhjVnhAcmlwcGVyPg==>
 <f0a6ae0e-4a6c-7db5-7924-a957f1a0b70b@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a6ae0e-4a6c-7db5-7924-a957f1a0b70b@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Dec 22:56 PST 2021, Guo Zhengkui wrote:

> On 2021/12/7 23:13, Bjorn Andersson wrote:
> > On Tue 07 Dec 05:16 PST 2021, Guo Zhengkui wrote:
> > 
> > > Fix following coccicheck error:
> > > ./drivers/phy/qualcomm/phy-qcom-edp.c:574:31-37:
> > > ERROR: application of sizeof to pointer.
> > > 
> > > Use sizeof(*data) instead.
> > > 
> > > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-edp.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> > > index 17d5653b661d..5fe4eab9cac1 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> > > @@ -571,7 +571,7 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
> > >   	struct clk_init_data init = { };
> > >   	int ret;
> > > -	data = devm_kzalloc(edp->dev, sizeof(data), GFP_KERNEL);
> > > +	data = devm_kzalloc(edp->dev, sizeof(*data), GFP_KERNEL);
> > 
> > Ouch, thanks for catching that!
> > 
> > But the clk_hw_onecell_data actually has a variable size array at the
> > end and as you can see further down I store 2 items in that array.
> > 
> > So that sizeof should be struct_size(data, hws, 2)
> > 
> > Would you be willing to update your patch with that?
> > 
> 
> OK, I will commit another patch. Do you mind I add a "Suggested-by" tag of
> your name in the new patch?
> 

I don't mind.

Regards,
Bjorn

> Zhengkui
> 
> > And please add:
> > Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
> > 
> > Regards,
> > Bjorn
> > 
> > >   	if (!data)
> > >   		return -ENOMEM;
> > > -- 
> > > 2.20.1
> > > 
