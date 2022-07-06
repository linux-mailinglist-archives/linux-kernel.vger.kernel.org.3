Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C185693A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiGFUwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiGFUwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:52:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E791C11A;
        Wed,  6 Jul 2022 13:52:13 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D36CB66019A9;
        Wed,  6 Jul 2022 21:52:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657140731;
        bh=bQmOutdpedPd4x2iFqvLhglIfkXUpkZt7X2WOKbpo5A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DIInQm27rRPdokpOAdOjN7RYhNv/ztIHjCv9MWulfZ0bMSaIbrTAuBZAxzqhEAxKn
         0lzKg1EAvo61htGqUK0m+M7ScnD7RxmjEtzHTjCz/D70kCKrAFXOo3+rGrm6w8O9MX
         9TO4vRidFgEq/1YV4mkXSF+xt2sWsRC/FHX+AqTqUwhiViirE+mjm+LRxFWxugFxfk
         K2aTIN5/0SRKS5ZyxJzpuvHHV7LUUCrErohzb/F6lr8FWsZ2Doudsh7ZZgwhtVyCEy
         R5ZgXxkqm8e3YAWoyO7YzElBtBG4KaTJ6v4xolppmud2960ByvHVFwvzRXX5/MNgen
         H0tpEPWkRShng==
Message-ID: <2bc94bec-3565-f334-285e-d37f00f98d13@collabora.com>
Date:   Wed, 6 Jul 2022 23:52:07 +0300
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

Hello Shreeya,

On 6/15/22 16:51, Shreeya Patel wrote:
> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret, suspended;
> +
> +	if (on) {
> +		suspended = pm_runtime_suspended(dev);
> +		ret = pm_runtime_get_sync(dev);

The pm_runtime_get_sync() returns 1 if device was already resumed and as
Andy said there is no reason not to handle the RPM error. Hence we can
rewrite it like this:

if (on) {
	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0) {
		dev_err(&data->client->dev, "failed to resume runtime PM: %d\n", ret);
		return ret;
	}

	/* Allow one integration cycle before allowing a reading */
	if (!ret)
		msleep(ltrf216a_int_time_reg[0][0]);
} else {
	pm_runtime_mark_last_busy(dev);
	ret = pm_runtime_put_autosuspend(dev);
}

-- 
Best regards,
Dmitry
