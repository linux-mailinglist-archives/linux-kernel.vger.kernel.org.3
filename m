Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CC550C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiFSRUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 13:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiFSRUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 13:20:02 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDD2638A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 10:20:01 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 2yabog1Yxk3IC2yaboxGxL; Sun, 19 Jun 2022 19:19:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 19 Jun 2022 19:19:59 +0200
X-ME-IP: 90.11.190.129
Message-ID: <19bcf5cb-e291-2c18-b006-f4e9e7adac92@wanadoo.fr>
Date:   Sun, 19 Jun 2022 19:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC 3/6] clk: microchip: mpfs: add reset controller
Content-Language: fr
To:     Conor Dooley <mail@conchuod.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220619164935.1492823-1-mail@conchuod.ie>
 <20220619164935.1492823-4-mail@conchuod.ie>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220619164935.1492823-4-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/06/2022 à 18:49, Conor Dooley a écrit :
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add a reset controller to PolarFire SoC's clock driver. This reset
> controller is registered as an aux device and read/write functions
> exported to the drivers namespace so that the reset controller can
> access the peripheral device reset register.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[...]

> +static void mpfs_reset_adev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	auxiliary_device_uninit(adev);
> +
> +	kfree(adev->name);

?

Below we have:
	adev->name = "reset-mpfs";


> +	kfree(adev);
> +}
> +
> +static struct auxiliary_device *mpfs_reset_adev_alloc(struct mpfs_clock_data *clk_data)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	adev->name = "reset-mpfs";
> +	adev->dev.parent = clk_data->dev;
> +	adev->dev.release = mpfs_reset_adev_release;
> +	adev->id = 666u;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		kfree(adev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return adev;
> +}

[...]
