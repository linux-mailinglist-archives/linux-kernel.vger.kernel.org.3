Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF17148AEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbiAKNmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240839AbiAKNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:42:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7860C06173F;
        Tue, 11 Jan 2022 05:42:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3BD3F1F43CF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641908572;
        bh=uaxzh4zsAhZ1ewzMCAUwEtPans4AmfRV9oSlzLefnlk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WmIB87G52wOngWT2q5aJGiFEWOTw4ESogbQhD2rSDu1s+BV5vsV9KWIl8kHT9nEvC
         VOeORansLXJq9bVeXwDUKG2fpo6CB3L4fVNYKpD5Lp3aSqrWvonklbtBPk+DyfQ0L1
         n59JxjUqvyOlnUnUcrExjPMBIrqHfKUXRATk+dM/VW3oEC39A4/jdA3l2dsDkj8og4
         lYdoMkJujjNr/YWdb/UFHlWn3FY6djNyjETl++sP9Iu6xt/Zaaga4TTYhmDUUIy64J
         y6IGTjoC8UIcOHgjzJgr7f8TkyHAS/tVWkfL59JPwZr4b/K5eCwU70FFW9ZTtbEwEu
         lgPOLrwkwhp6A==
Subject: Re: [PATCH 7/7] pinctrl: mediatek: paris: Support generic
 PIN_CONFIG_DRIVE_STRENGTH_UA
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
 <20220111112244.1483783-8-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <8a5aba82-d9e3-25d8-f34e-7182586d8ce4@collabora.com>
Date:   Tue, 11 Jan 2022 14:42:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111112244.1483783-8-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
> Some of the MediaTek chips that utilize the Paris pinctrl driver library
> support a lower drive strength (<= 1mA) than the standard drive strength
> settings (2~16 mA) on certain pins. This was previously supported by the
> custom MTK_PIN_CONFIG_DRV_ADV parameter along with the
> "mediatek,drive-strength-adv" device tree property.
> 
> The drive strength values for this hardware are 125, 250, 500, and 1000 mA,
> and can be readily described by the existing "drive-strength-microamp",
> which then gets parsed by the generic pinconf library into the parameter
> PIN_CONFIG_DRIVE_STRENGTH_UA.
> 
> Add support for PIN_CONFIG_DRIVE_STRENGTH_UA while keeping the old
> custom parameter around for backward compatibility.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> 
> The indentation in the switch/case blocks is getting somewhat out of
> control. I also have some cleanup changes to reverse the logic of the
> if/break statements. Not sure if it should be done before or after this
> patch though.

Hello Chen-Yu,



this commit is so nice that:

- My heart says that it's fine as it is, but

- My brain says that it makes a lot more sense if you push the cleanup

changes to reverse that logic before pushing this commit, as to reduce the

count of changed lines (hence, to reduce some noise)...



...so please, can you rebase this commit over the cleanups?



Thanks,

- Angelo

