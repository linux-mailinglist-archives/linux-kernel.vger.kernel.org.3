Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3395825F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiG0Ly2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiG0LyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:54:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78EC4B0C9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7393EB8202D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF75C433D6;
        Wed, 27 Jul 2022 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658922854;
        bh=d0AJsAf6s/ajEoQ5jnWKRwQwPDO7HECfPRk8bwk0Uxg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f1RY2jxVDGcCuME1czjssBw80GspJQSTJ25SOd95VnJ82jtmaKVmtR+oNHd90teaR
         Ys4NeMzyLHoWL+e2juhJMCGB8/3qqCdiZM8LPbZ6NvIZsDizvq7YuphEx/FIxVswu2
         I2PKFUFwsxFvmi1etwvOiJVvjQDp1VRw/kNY8p8dIQGDZPx9LbBxXYONwx6qMfbXEx
         eg58M9jQr5toj7z70JYTL6Eo/JA/VTu2kDXJbbJcwLonzz0xRPbXh9zhE0cEBi7D2M
         K0H5ilrQ+fxfSJ0nsUQA1t6EqHIiLmogghGqJOEQOYG+Lf1NWU1OQXNWbiSP8ghc28
         Q87kfL58uWluA==
Message-ID: <86e1eb1f-7d12-7ffb-da5b-e6ab3ce85184@kernel.org>
Date:   Wed, 27 Jul 2022 13:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/9] trinity: Add base driver
Content-Language: en-US
To:     Jiho Chu <jiho.chu@samsung.com>, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
 <CGME20220725065309epcas1p4565e7bb0fea1aaf3e5e300de00774c2a@epcas1p4.samsung.com>
 <20220725065308.2457024-2-jiho.chu@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220725065308.2457024-2-jiho.chu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 08:53, Jiho Chu wrote:
> It contains the base codes for trinity driver. Minimal codes to load and
> probe device is provided. The Trinity Family is controlled by the
> Memory-Mapped Registers, the register addresses and offsets are
> described. And user api interfaces are presented to control device under
> ioctl manner.
> 

> +	dev = &pdev->dev;
> +	dev->id = ((desc->ver & TRINITY_MASK_DEV) >> TRINITY_SHIFT_DEV);
> +
> +	/* set private data */
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +	if (drv == NULL)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, drv);
> +	dev_set_drvdata(dev, drv);
> +
> +	drv->dev = dev;
> +	drv->desc = desc;
> +
> +	np = dev->of_node;
> +	if (of_property_match_string(np, "samsung,trinity-type", desc->type))

Let me be more specific.

You need to document your bindings.

Patch cannot be accepted without them.

Best regards,
Krzysztof
