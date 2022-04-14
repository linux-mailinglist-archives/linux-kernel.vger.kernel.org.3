Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F1500324
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 02:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiDNAsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 20:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiDNAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:48:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D8F2C136;
        Wed, 13 Apr 2022 17:46:09 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23E0jj9X126972;
        Wed, 13 Apr 2022 19:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649897145;
        bh=N8S3hB1hCn8/K02MahOO1epFSN2nfiFflu8uHePcno8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=CHL/WiDaZ/L0oWNt/qg86iPS7GSUE2h5JhZCBoxnXss4NXQH7PeJD3iCxFLoYiT1w
         gZQ6g8X99QBfkb5AEYrdun5u/2WeT5QVjvb16AAjy27k/Q2K4LYdH2fkLwzvh5RPEg
         O33u/Vo8DSPKKop8DtrisXOqTckTDBFh1ob9JFIo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23E0jj0A066199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Apr 2022 19:45:45 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 13
 Apr 2022 19:45:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 13 Apr 2022 19:45:45 -0500
Received: from [10.250.34.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23E0jiqe020241;
        Wed, 13 Apr 2022 19:45:44 -0500
Message-ID: <8c824a2c-383c-ba0e-b924-d7cdaf68ff0c@ti.com>
Date:   Wed, 13 Apr 2022 19:45:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] rtc: Introduce ti-k3-rtc
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220412073138.25027-1-nm@ti.com>
 <20220412073138.25027-3-nm@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220412073138.25027-3-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 2:31 AM, Nishanth Menon wrote:
[...]

> +
> +static inline u32 k3rtc_readl(struct ti_k3_rtc *priv, u32 offset)
> +{
> +	return readl(priv->rtc_base + offset);


Could we use regmap in this driver?

[...]


> +
> +	reg = k3rtc_readl(priv, REG_K3RTC_IRQENABLE_SET_SYS);
> +	reg &= K3RTC_EVENT_ON_OFF_BIT;


regmap fields to get rid of all the bitmasking

[...]



> +		return 0;
> +
> +	k3rtc_writel(priv, offset, K3RTC_EVENT_ON_OFF_BIT);
> +
> +	for (i = 0; i < bytes / 4; i++) {
> +		val[i] = k3rtc_readl(priv,
> +				     REG_K3RTC_SCRATCH0 + offset + (i * 4));
> +	}
> +


regmap_bulk_read()

[...]


> +
> +	priv->rtc_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->rtc_base))
> +		return PTR_ERR(priv->rtc_base);
> +


devm_regmap_init_mmio(dev, priv->rtc_base, ...)

[...]


> +static struct platform_driver ti_k3_rtc_driver = {
> +	.probe = ti_k3_rtc_probe,
> +	.driver = {
> +		   .name = "rtc-ti-k3",
> +		   .of_match_table = ti_k3_rtc_of_match_table,
> +		   .pm = &ti_k3_rtc_pm_ops,
> +		   },
> +};
> +module_platform_driver(ti_k3_rtc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TI K3 RTC driver");
> +MODULE_AUTHOR("Nishanth Menon");
> +MODULE_ALIAS("platform:rtc-ti-k3");


Is MODULE_ALIAS needed here? The MODULE_DEVICE_TABLE above will
build the MOD ALIAS table needed for OF loading.

Andrew

