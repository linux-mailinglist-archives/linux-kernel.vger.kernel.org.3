Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2046537814
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiE3JAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiE3JAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:00:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4704E77F36;
        Mon, 30 May 2022 02:00:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BA4C11F4263D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653901229;
        bh=oVWZjJhb7qhA9swQsNjKyIH4iNxQFAuTs6yfX8nGbjY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BNLFSACyyunH5pzqLMctQd1Xk+suq1vnZWHFxZZmI/Im55ZJyLLoZa5/nJQPNth8z
         kPxqSsHZx7TobCa+Rl3/7oOdCynLTJhFqMztuXuqvA9Pt5eyYsdejdB0U3mN9MXIvv
         Y6IExcTX+/biME3rmT/0cVJmSoNn7MnM8kDZXzPCUifSA+obi6IiTidcUP5rH2rLmx
         80VSRYqItBDC1baJ46hR0Pp4R0Ltq1edOOEo95nXr8AvciH9vfVVkX99nH4wiBEHdC
         X7ohDHPmCDn4yx7P047gZHKqEGVyybixkFCdPnw3WSTbjhOg/3zVEs/+Uc2cbNUx3Z
         TWFIjzCUUbtag==
Message-ID: <524f15ad-07d1-37e1-eebb-ae86d4ee1763@collabora.com>
Date:   Mon, 30 May 2022 11:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/3] Input: mtk-pmic-keys - Transfer per-key bit in
 mtk_pmic_keys_regs
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
 <20220524093505.85438-2-angelogioacchino.delregno@collabora.com>
 <YpBiz7fGCgHaKqGs@google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YpBiz7fGCgHaKqGs@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/05/22 07:34, Dmitry Torokhov ha scritto:
> On Tue, May 24, 2022 at 11:35:03AM +0200, AngeloGioacchino Del Regno wrote:
>> Place the key bit in struct mtk_pmic_keys_regs to enhance this
>> driver's flexibility, in preparation for adding support for more
>> PMICs.
>>
>> While at it, remove the definition of MTK_PMIC_RST_KEY_MASK as
>> we are now dynamically setting the keymask relatively to the keys
>> that are defined in the newly added rst_en_mask variable, on a
>> per-key basis.
>>
>> This commit brings no functional changes.
> 
> AngeloGioacchino,
> 
> Could you please tell me if these devices (currently supported by the
> driver) have 2 fully independent reset settings for HOME and PWR keys,
> or is there are actually 2 separate bits, one to enable/disable key
> reset, and another controlling what keys will cause the reset - only PWR
> or either PWR or HOME?
> 
> Thanks.
> 


Hello Dmitry,

there are two separate bits for the "Long Press Reset", you can achieve
reset with either holding the power button, volume up button (register
name is HOMEKEY because on very old devices this was a "home" button),
or both - for a certain amount of time.
If both {HOME,PWR}KEY_RST_EN bits are *not set*, the long press reset
PMIC trigger will be disabled.
Long-press time is controlled with the RST_DU register.

Regards,
Angelo
