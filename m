Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AFD4DD7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiCRKXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiCRKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:23:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7A1ED07F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:21:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 967871F45DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647598905;
        bh=R2Fab+/4Q7++fifqmPDXKzsJYJZyn9f33fmTuUB0D4I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dod9l0meUNiRYcJN4FDqfmbnda3tnKjwdpK3zx/jLmDpE1cs+kukPITKnv4Xo4ZQW
         OxatywIqPs/f7uywjxvQOONMVvJuEsba2n1AxDugu50DHmFp60tebAgLauQPyDafcb
         6FoVy7FoYgmgZ0rZVYmSpsZ1OmgPSB9kzjW7EqAbYabqrdZcmU9LB5BC9OpkEhcMpj
         f1GaMJtUiUeb9c3kgLwBjsxHLZ1cb/3Pg7gtXR3em+ETEfvBs0KTbLbVB30UVJT+Ul
         J6eOsJ++nZ3HSHtqOVkBHRADiiSqlXbjkhUZiWB1q2of0qoxBkVSb+rhwQsJQAbdkz
         7NVSBTzY+VH7A==
Message-ID: <399aa873-4285-cc48-8c58-89673c505cb0@collabora.com>
Date:   Fri, 18 Mar 2022 11:21:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2 RESEND] drm/bridge: Add extra checks in pre_enable and
 post_enable
Content-Language: en-US
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
References: <20220311093406.4068019-1-ricardo.canuelo@collabora.com>
 <20220311093406.4068019-3-ricardo.canuelo@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220311093406.4068019-3-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/03/22 10:34, Ricardo Cañuelo ha scritto:
> Depending on the bridge code, certain userspace events during a driver
> teardown (such as a DRM ioctl call) might cause a race condition where
> the drm_bridge_chain_pre_enable() and drm_bridge_chain_post_enable()
> functions could be called for a bridge that has just been detached and
> removed from the bridge chain of an encoder.
> 
> This change makes these functions a bit more robust by bailing out if
> the bridge has already been detached.
> 
> Tested on an Acer Chromebook R13 (Elm, MT8173) with Debian Sid.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>

On various chromebooks with different MediaTek SoC models, and on
Qualcomm SC7180 Trogdor,

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

