Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C022F5A7E30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiHaNCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiHaNCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:02:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DC6C2775
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:02:29 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A0E1651E;
        Wed, 31 Aug 2022 15:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661950947;
        bh=OvMM1K/1lN614CtAJ2Sclv17YZSGjK2rbDos4DLOIOo=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=sr9UEnB1NOIZJZrvZ05ZJFZlXOtw22+ynMoKGKcbKstPM7aB/ES4IVLCD/LuhZnkR
         +6Kzp5EFzDD3rN4q5qlTkEXrWPpLcEGb1u8hGV4qkpx5SCjnzuEo2heF4TwuDxZUuq
         ke6OEb8QVHIfbtsThsZIKkiyCAI650AuMQ7IpHIg=
Message-ID: <7163f30b-6496-5762-0d9d-96834fb7452d@ideasonboard.com>
Date:   Wed, 31 Aug 2022 16:02:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211225063151.2110878-1-nikita.yoush@cogentembedded.com>
 <Yczy3UYpU2UMFQ6N@pendragon.ideasonboard.com>
 <164563304251.4066078.10022034509552549983@Monstersaurus>
 <YhZf+Fs2AP+btuJj@pendragon.ideasonboard.com>
 <164563575394.4066078.17104997030535169083@Monstersaurus>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH] drm/bridge_connector: enable HPD by default if supported
In-Reply-To: <164563575394.4066078.17104997030535169083@Monstersaurus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/02/2022 19:02, Kieran Bingham wrote:
> Quoting Laurent Pinchart (2022-02-23 16:25:28)
>> Hello,
>>
>> On Wed, Feb 23, 2022 at 04:17:22PM +0000, Kieran Bingham wrote:
>>> Quoting Laurent Pinchart (2021-12-29 23:44:29)
>>>> On Sat, Dec 25, 2021 at 09:31:51AM +0300, Nikita Yushchenko wrote:
>>>>> Hotplug events reported by bridge drivers over drm_bridge_hpd_notify()
>>>>> get ignored unless somebody calls drm_bridge_hpd_enable(). When the
>>>>> connector for the bridge is bridge_connector, such a call is done from
>>>>> drm_bridge_connector_enable_hpd().
>>>>>
>>>>> However drm_bridge_connector_enable_hpd() is never called on init paths,
>>>>> documentation suggests that it is intended for suspend/resume paths.
>>>>
>>>> Hmmmm... I'm in two minds about this. The problem description is
>>>> correct, but I wonder if HPD should be enabled unconditionally here, or
>>>> if this should be left to display drivers to control.
>>>> drivers/gpu/drm/imx/dcss/dcss-kms.c enables HPD manually at init time,
>>>> other drivers don't.
>>>>
>>>> It feels like this should be under control of the display controller
>>>> driver, but I can't think of a use case for not enabling HPD at init
>>>> time. Any second opinion from anyone ?
>>>
>>> This patch solves an issue I have where I have recently enabled HPD on
>>> the SN65DSI86, but without this, I do not get calls to my .hpd_enable or
>>> .hpd_disable hooks that I have added to the ti_sn_bridge_funcs.
>>>
>>> So it needs to be enabled somewhere, and this seems reasonable to me?
>>> It's not directly related to the display controller - as it's a factor
>>> of the bridge?
>>>
>>> On Falcon-V3U with HPD additions to SN65DSI86:
>>> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> If you think this is right, then
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I do, and at the very least it works for me, and fixes Nikita's issue so
> to me that's enough for:

So who disables the HPD now?

Is the drm_bridge_connector_enable_hpd & 
drm_bridge_connector_disable_hpd documentation now wrong as they talk 
about suspend/resume handlers?

  Tomi
