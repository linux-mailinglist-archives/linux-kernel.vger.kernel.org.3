Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0994F502693
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351352AbiDOIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349082AbiDOIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:17:03 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31CF6317;
        Fri, 15 Apr 2022 01:14:31 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 61C37240005;
        Fri, 15 Apr 2022 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650010469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pKzyHpH5Bjb8iRoLHJukJctM0gcYG5sge5R4tzijau0=;
        b=gGZxFfuwsslvH4NphybsIpHaqITUT0Q9HkNGcVr+cb12cyRUcoYsz1UQTOk+H8DNHIARCm
        fxl1cg8HE7VG+Ok2pKSsFt6C8uY0FT7+4cKhR9S8Iar0wvP98Sve1oAHK0V0c8dsURyunV
        V0A/JVMxlp6ZmsG/RIfY+ASsWkNe5IYCM1oZ7bElD23VR9T/lnzyAoBo5RT31+TgDdPvR9
        SqGSnO476l9EqRPxYwVVyPsVrXydhrnIqcHR6G/1rUyDUuD40V7mfIa/iLCIi4uGvdicJb
        UfAtW2d64HTNXSFcyBPqxfOfTYIKBln0lZoLCNUp5LkGdgnjXXj7o63ukeExwA==
Date:   Fri, 15 Apr 2022 10:14:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] rtc: Introduce ti-k3-rtc
Message-ID: <YlkpY4jzQVa8GokG@mail.local>
References: <20220412073138.25027-1-nm@ti.com>
 <20220412073138.25027-3-nm@ti.com>
 <b0ae635f-461f-be80-ebff-a548c9dd66af@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ae635f-461f-be80-ebff-a548c9dd66af@ti.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2022 13:33:14+0530, Vignesh Raghavendra wrote:
> Hi,
> 
> On 12/04/22 1:01 pm, Nishanth Menon wrote:
> > +/**
> > + * k3rtc_fence  - Ensure a register sync took place between the two domains
> > + * @priv:      pointer to priv data
> > + *
> > + * Return: 0 if the sync took place, else returns -ETIMEDOUT
> > + */
> > +static int k3rtc_fence(struct ti_k3_rtc *priv)
> > +{
> > +	u32 timeout = priv->sync_timeout_us;
> > +	u32 mask = K3RTC_RD_PEND_BIT | K3RTC_WR_PEND_BIT;
> > +	u32 val = 0;
> > +
> > +	while (timeout--) {
> > +		val = k3rtc_readl(priv, REG_K3RTC_SYNCPEND);
> > +		if (!(val & mask))
> > +			return 0;
> > +		usleep_range(1, 2);
> > +	}
> 
> readl_poll_timeout() ?
> 
> > +
> > +	pr_err("RTC Fence timeout: 0x%08x\n", val);
> 
> Can we use dev_err()?  Provides better indication of the driver throwing
> error.
> 

What would the user do with this information in the kernel logs? Please
do not add error strings that will never be used. Returning -ETIMEDOUT
is probably enough.

> > +	return -ETIMEDOUT;
> > +}
> > +

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
