Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0356C88B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGIJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGIJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D020D59
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657360231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXpBOrPualzly/errIyf41e70bGGUmHJrc3A4C7tf2Y=;
        b=Qj4TcIkFQT2qRAXaaDS0yVrj94Mq8hkdS8vb/hGLYHvNAniRdxszh+/WpQo0+3k+x6G9QS
        HNlH/V0fQ8vLiU1ui9+pXh0FMoNH19t1Guytisu1brHCjVm8OfSgBs50uqymyGeIg7eWKd
        k4G2Ct4ZRqLdmMaIdlI9XTXtLDy0laM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-lmyeXe-LOm2DZIfaBfaIvw-1; Sat, 09 Jul 2022 05:50:30 -0400
X-MC-Unique: lmyeXe-LOm2DZIfaBfaIvw-1
Received: by mail-ed1-f69.google.com with SMTP id b7-20020a056402350700b00435bd1c4523so833531edd.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HXpBOrPualzly/errIyf41e70bGGUmHJrc3A4C7tf2Y=;
        b=WAWwekmjh5KiGZmQUop50APsgvi8pYH4KZkurogn3rU2+JiVWK1VzGVpLYAqRVKdJw
         qU5upwzswiQaWWkdEBDAEY77+9xlGCmwW7QD9D+aZSX8QLtHIjJlB27ShxR+Y6sC29Bp
         p4SKcjqCPlLr15cTZU4luXYA0r4Yi4asGPEO2j6UohnddXXY7UHALDJFO1Dn8pwLaZfc
         RE5rz856mst4k+nZzMeqNlSTRf3BMD3dJdZMhmHw5yNrVGJiJ9Y9m2rli4BhvmXr0div
         pk4hDwneMgLh7frQsRMh41r/E9QPPHlsgQl8F03dqnAKX7RLjD+TduQRKAt1PGxG66ac
         uuLQ==
X-Gm-Message-State: AJIora/t/ZSej6kieeQ5gjfb7kxXDn54dMpMHJHLrBcE0K/0Tu7U0JfL
        jkilRPyCeJYmZoSD867rArVD2jdHqHl5w70PMu1fjORok5BxhuVg9Wt22zOh03mpAnoe8juWUjE
        sPyetMIp867GrvpM5yEx9W0xc
X-Received: by 2002:a17:907:2d2a:b0:726:3527:60ac with SMTP id gs42-20020a1709072d2a00b00726352760acmr8000539ejc.661.1657360228905;
        Sat, 09 Jul 2022 02:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tEFpH2vnic0Fc6RdRYIbIZ/TZMtdDY8sTd39md0JXp3PM2XBgC6lMqu1cioRnO486ih2Mnew==
X-Received: by 2002:a17:907:2d2a:b0:726:3527:60ac with SMTP id gs42-20020a1709072d2a00b00726352760acmr8000521ejc.661.1657360228736;
        Sat, 09 Jul 2022 02:50:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b00705cdfec71esm444085eja.7.2022.07.09.02.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 02:50:28 -0700 (PDT)
Message-ID: <632929cd-c239-b239-ecbe-99de98dad894@redhat.com>
Date:   Sat, 9 Jul 2022 11:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 3/7] platform/x86: serial-multi-instantiate: Drop
 duplicate check
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
 <20220709000636.35550-3-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220709000636.35550-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/9/22 02:06, Andy Shevchenko wrote:
> The device_get_match_data() checks for firmware node to be present,
> there is no need to check for ACPI companion.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patches 3-7 look good to me, you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

after rebasing to drop patches 1 + 2.

Regards,

Hans

> ---
>  .../platform/x86/serial-multi-instantiate.c   | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index e599058196bb..ceb0e414b9f5 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -81,16 +81,16 @@ static void smi_devs_unregister(struct smi *smi)
>  /**
>   * smi_spi_probe - Instantiate multiple SPI devices from inst array
>   * @pdev:	Platform device
> - * @adev:	ACPI device
>   * @smi:	Internal struct for Serial multi instantiate driver
>   * @inst_array:	Array of instances to probe
>   *
>   * Returns the number of SPI devices instantiate, Zero if none is found or a negative error code.
>   */
> -static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev, struct smi *smi,
> +static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
>  			 const struct smi_instance *inst_array)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	struct spi_controller *ctlr;
>  	struct spi_device *spi_dev;
>  	char name[50];
> @@ -166,17 +166,17 @@ static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev,
>  /**
>   * smi_i2c_probe - Instantiate multiple I2C devices from inst array
>   * @pdev:	Platform device
> - * @adev:	ACPI device
>   * @smi:	Internal struct for Serial multi instantiate driver
>   * @inst_array:	Array of instances to probe
>   *
>   * Returns the number of I2C devices instantiate, Zero if none is found or a negative error code.
>   */
> -static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev, struct smi *smi,
> +static int smi_i2c_probe(struct platform_device *pdev, struct smi *smi,
>  			 const struct smi_instance *inst_array)
>  {
>  	struct i2c_board_info board_info = {};
>  	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	char name[32];
>  	int i, ret, count;
>  
> @@ -230,14 +230,9 @@ static int smi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	const struct smi_node *node;
> -	struct acpi_device *adev;
>  	struct smi *smi;
>  	int ret;
>  
> -	adev = ACPI_COMPANION(dev);
> -	if (!adev)
> -		return -ENODEV;
> -
>  	node = device_get_match_data(dev);
>  	if (!node) {
>  		dev_dbg(dev, "Error ACPI match data is missing\n");
> @@ -252,14 +247,14 @@ static int smi_probe(struct platform_device *pdev)
>  
>  	switch (node->bus_type) {
>  	case SMI_I2C:
> -		return smi_i2c_probe(pdev, adev, smi, node->instances);
> +		return smi_i2c_probe(pdev, smi, node->instances);
>  	case SMI_SPI:
> -		return smi_spi_probe(pdev, adev, smi, node->instances);
> +		return smi_spi_probe(pdev, smi, node->instances);
>  	case SMI_AUTO_DETECT:
> -		ret = smi_i2c_probe(pdev, adev, smi, node->instances);
> +		ret = smi_i2c_probe(pdev, smi, node->instances);
>  		if (ret && ret != -ENOENT)
>  			return ret;
> -		ret = smi_spi_probe(pdev, adev, smi, node->instances);
> +		ret = smi_spi_probe(pdev, smi, node->instances);
>  		if (ret && ret != -ENOENT)
>  			return ret;
>  		if (ret)

