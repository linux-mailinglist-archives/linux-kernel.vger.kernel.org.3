Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4570C5693C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiGFVAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiGFVA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:00:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928F220F4;
        Wed,  6 Jul 2022 14:00:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B95B966019AA;
        Wed,  6 Jul 2022 22:00:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657141225;
        bh=1yqivW3OfQW/R38VjkAOcosydDNZlcJT15iHFWhhmwM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jOaBnOZwwv2lh36dnbUiozFSWdoPw3+RZGxBPiVOQ1MhQgbTOcp4JEYPxJsdg1R70
         a58km2bWnVL0Yvgc4i6sTJim7mSqxkPEVEPgLWeToXVWLGUsXHkLP7ICfMGg0FrP7h
         RVpf3u52olYo4k/PyU4yJx2tAGn5y0GNYh2Exo6N3sooiy8oa7u5KgNKlXLAqeOCLP
         cwmNALFwRjq0UQTeVOJMPhEwmYh2Lx1boWzpoIUHwYCes9T1y+1CUEeeUsP5IhEy99
         taZfyiZ2SlmkuPIG5eOoAqWdCpYDIP5PutzOHLs7U5mZC8opNZisAWTIISXCd17gLh
         GzVRjg+LTa17w==
Message-ID: <37527ba7-ae54-86a0-b0af-fe20d3a1e484@collabora.com>
Date:   Thu, 7 Jul 2022 00:00:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 2/2] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, kernel test robot <lkp@intel.com>
References: <20220615135130.227236-1-shreeya.patel@collabora.com>
 <20220615135130.227236-3-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220615135130.227236-3-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 16:51, Shreeya Patel wrote:
> +static int ltrf216a_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	ltrf216a_disable(indio_dev);
> +
> +	return 0;
> +}

As Jonathan said, there is no need to disable sensor in the remove()
since you're using devm_add_action_or_reset().

If you're going to use devm_pm_runtime_enable(), then let's also use
devm_iio_device_register() and in this case the ltrf216a_remove() is not
needed anymore at all since the removal will be handled by the driver
core entirely, i.e. you'll need to drop ltrf216a_remove().

-- 
Best regards,
Dmitry
