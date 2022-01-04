Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F374843AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiADOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:48:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiADOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:48:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 648FD1F43790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641307691;
        bh=G+jVGmECfNW9PLCn0NHGgzigCEJfRk6KgWTuVOWIb3k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AgD77RERBYtR6rmleLLBnFWdCy/RukQMSW58ckAyF6LbE7yTBG/EMsyPXT1oarx7s
         IBU/TRZrtwKkAwqaEi6sbrZ/14jpWO4YBcyWTX0CMEQxBJDO0NKWcRYyYFoPoZu7rs
         fGPbYjKaqVwek5g7gYV37tjlWwEz9zMShKNzL9o+aU1PoLfGHd8jFt0jTYEmfdaACt
         do4IRx/CrIJ9Ga4s3Dd2gTc2GWJWSf2Paz5kgo0fpGAl6sQd5i/by60lMA/5S9oaUG
         igNQVaq6LDME37rC0D1aLWijwfIQCGRGZbJF+kHDL26Y5XfWT0OZZqIYbvjVcUduMz
         zGG6dMx30eu3Q==
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Link device to ensure
 suspend/resume order
To:     Robert Foss <robert.foss@linaro.org>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
References: <20211102130428.444795-1-angelogioacchino.delregno@collabora.com>
 <CAG3jFys2Js0urfL9q3nk_KDweLcX+cOZeURCk8=gyps9h6TPcA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <3b0af96e-f833-5cd1-7725-5ec37faab9fb@collabora.com>
Date:   Tue, 4 Jan 2022 15:48:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAG3jFys2Js0urfL9q3nk_KDweLcX+cOZeURCk8=gyps9h6TPcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/01/22 15:22, Robert Foss ha scritto:
> Hey AngeloGioacchino,
> 
> On Tue, 2 Nov 2021 at 14:08, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Entering suspend while the display attached to this bridge is still on
>> makes the resume sequence to resume the bridge first, display last:
>> when this happens, we get a timeout while resuming the bridge, as its
>> MCU will get stuck due to the display being unpowered.
>>
>> On the other hand, on mt8173-elm, closing the lid makes the display to
>> get powered off first, bridge last, so at resume time the sequence is
>> swapped (compared to the first example) and everything just works
>> as expected.
>>
>> Add a stateless device link to the DRM device that this bridge belongs
>> to, ensuring a correct resume sequence and solving the unability to
>> correctly resume bridge operation in the first mentioned example.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/bridge/parade-ps8640.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
>> index 45100edd745b..191cc196c9d1 100644
>> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
>> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
>> @@ -100,6 +100,7 @@ struct ps8640 {
>>          struct regulator_bulk_data supplies[2];
>>          struct gpio_desc *gpio_reset;
>>          struct gpio_desc *gpio_powerdown;
>> +       struct device_link *link;
>>          bool powered;
>>   };
>>
>> @@ -460,10 +461,23 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
>>                  goto err_aux_register;
>>          }
>>
>> +       ps_bridge->link = device_link_add(bridge->dev->dev, dev, DL_FLAG_STATELESS);
>> +       if (!ps_bridge->link) {
>> +               dev_err(dev, "failed to create device link");
>> +               ret = -EINVAL;
>> +               goto err_devlink;
>> +       }
>> +
>>          /* Attach the panel-bridge to the dsi bridge */
>> -       return drm_bridge_attach(bridge->encoder, ps_bridge->panel_bridge,
>> +       ret = drm_bridge_attach(bridge->encoder, ps_bridge->panel_bridge,
>>                                   &ps_bridge->bridge, flags);
>> +       if (ret)
>> +               goto err_bridge_attach;
>>
>> +err_bridge_attach:
>> +       device_link_del(ps_bridge->link);
>> +err_devlink:
>> +       drm_dp_aux_unregister(&ps_bridge->aux);
>>   err_aux_register:
>>          mipi_dsi_detach(dsi);
>>   err_dsi_attach:
>> @@ -473,7 +487,11 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
>>
>>   static void ps8640_bridge_detach(struct drm_bridge *bridge)
>>   {
>> -       drm_dp_aux_unregister(&bridge_to_ps8640(bridge)->aux);
>> +       struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>> +
>> +       drm_dp_aux_unregister(&ps_bridge->aux);
>> +       if (ps_bridge->link)
>> +               device_link_del(ps_bridge->link);
>>   }
>>
>>   static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
>> --
>> 2.33.1
>>
> 
> This patch does not apply on drm-misc-next, could you rebase it on the
> current branch?
> 

Sure, I'll rebase it asap.
