Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA04DD7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiCRKX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiCRKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:23:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DB01ED07F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:22:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 362351F45DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647598921;
        bh=W1u39IUbe6otztE9r97TmBCaSkIJMT4WAPdgwQbuLz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iyNSFjkU8INvl3lzVLbYVltGn9Ljcetd9s8dl/V8f5DVEU00xl0ZDrqbXRsL65QYc
         UoeyDwjqn2KUdwJYnh2luQ44Ht+3XAgexrigTM7hX0WFQwVZFoY6kyhOAHAj7xn1UN
         uwcXJkRlIm/z0mP82WxrdoYQeCNZ4pjawzoLTPZpRC9vBB4NUFLXMJJIUcJwAp1Rrw
         45qYx9I4aN+L8o8FrQ6sR70thPKtHdlYwfCY89nbYDEJMtJkminYYjuULIgIuK6Gsk
         5iQbJZfsZDXGcjQckZrH245rhABMCJAiZ+VD9Xae84TfHqV13qmye6VmojaJWYAE8Q
         m6U05UKxQXLTw==
Message-ID: <bb78f340-4a37-33ad-55d6-805f64e1389c@collabora.com>
Date:   Fri, 18 Mar 2022 11:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2 RESEND] drm/bridge: parade-ps8640: avoid race
 condition on driver unbinding
Content-Language: en-US
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
References: <20220311093406.4068019-1-ricardo.canuelo@collabora.com>
 <20220311093406.4068019-2-ricardo.canuelo@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220311093406.4068019-2-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/03/22 10:34, Ricardo Cañuelo ha scritto:
> When unbinding a DRM master driver there's a race condition that
> sometimes results in an invalid vm access when userspace (gnome-shell)
> issues a DRM_IOCTL_MODE_GETCONNECTOR ioctl right after a bridge has been
> removed from an encoder's bridge chain.
> 
> This means that once a bridge has been disabled and gone through
> ps8640_post_disable(), if ps8640_bridge_get_edid() runs afterwards as a
> result of that ioctl call it will call drm_bridge_chain_pre_enable()
> and drm_bridge_chain_post_disable() again in a bridge that has been
> already detached.
> 
> Setting `ps_bridge->pre_enabled = false` at a later stage of the
> bringdown path and calling drm_bridge_chain_pre_enable() inside
> ps8640_bridge_get_edid() only if needed avoid this, although a proper
> subsystem-wide fix would be the proper solution, since the same type of
> race conditions might happen somewhere else.
> 
> Tested on an Acer Chromebook R13 (Elm, MT8173) with Debian Sid.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/bridge/parade-ps8640.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

