Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9488A4CC342
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiCCQwe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Mar 2022 11:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbiCCQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:52:31 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205119D766;
        Thu,  3 Mar 2022 08:51:45 -0800 (PST)
Date:   Thu, 03 Mar 2022 16:51:28 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [Letux-kernel] [PATCH v16 1/4] drm/bridge: dw-hdmi: introduce
 dw_hdmi_enable_poll()
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Paul Boddie <paul@boddie.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Message-Id: <SHH68R.Z3J9KSY0GQVA2@crapouillou.net>
In-Reply-To: <3E620AF4-402E-45EA-9D92-92EAEA9647F5@goldelico.com>
References: <cover.1645895582.git.hns@goldelico.com>
        <e54838849f80454b863f9f5634dd10f79ef7bb8f.1645895582.git.hns@goldelico.com>
        <983e9064-17ad-e646-f37d-ca9173ba0967@baylibre.com>
        <C8AE9A7A-E288-4637-ACAD-40CD33CD5F8C@goldelico.com>
        <3E620AF4-402E-45EA-9D92-92EAEA9647F5@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le jeu., mars 3 2022 at 17:43:05 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> Hi Neil,
> 
>>  Am 03.03.2022 um 17:30 schrieb H. Nikolaus Schaller 
>> <hns@goldelico.com>:
>> 
>>  Hi Neil,
>> 
>>>  Am 03.03.2022 um 17:23 schrieb Neil Armstrong 
>>> <narmstrong@baylibre.com>:
>>> 
>>>  Hi,
>>> 
>>>  On 26/02/2022 18:12, H. Nikolaus Schaller wrote:
>>>>  so that specialization drivers like ingenic-dw-hdmi can enable 
>>>> polling.
>>>>  Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>>  ---
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++++
>>>>  include/drm/bridge/dw_hdmi.h              | 1 +
>>>>  2 files changed, 10 insertions(+)
>>>>  diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c 
>>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>>  index 4befc104d2200..43e375da131e8 100644
>>>>  --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>>  +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>>  @@ -3217,6 +3217,15 @@ static int dw_hdmi_parse_dt(struct dw_hdmi 
>>>> *hdmi)
>>>>  	return 0;
>>>>  }
>>>>  +void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable)
>>>>  +{
>>>>  +	if (hdmi->bridge.dev)
>>>>  +		hdmi->bridge.dev->mode_config.poll_enabled = enable;
>>>>  +	else
>>>>  +		dev_warn(hdmi->dev, "no hdmi->bridge.dev");
>>>>  +}
>>>>  +EXPORT_SYMBOL_GPL(dw_hdmi_enable_poll);
>>>>  +
>>>>  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>>>>  			      const struct dw_hdmi_plat_data *plat_data)
>>>>  {
>>>>  diff --git a/include/drm/bridge/dw_hdmi.h 
>>>> b/include/drm/bridge/dw_hdmi.h
>>>>  index 2a1f85f9a8a3f..963960794b40e 100644
>>>>  --- a/include/drm/bridge/dw_hdmi.h
>>>>  +++ b/include/drm/bridge/dw_hdmi.h
>>>>  @@ -196,5 +196,6 @@ enum drm_connector_status 
>>>> dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
>>>>  void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
>>>>  			    bool force, bool disabled, bool rxsense);
>>>>  void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
>>>>  +void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable);
>>>>    #endif /* __IMX_HDMI_H__ */
>>> 
>>>  As I understand, this is because the IRQ line of the dw-hdmi IP 
>>> isn't connected right ? and you use the display-connector ddc gpio 
>>> instead ?
>> 
>>  Yes. The IRQ line is not connected on all boards as far as I can 
>> see.
>> 
>>> 
>>>  In this case I think the Ingenic DRM core should call 
>>> drm_kms_helper_poll_init(drm) instead.
>> 
>>  Ah, that is good. it seems to do "dw_hdmi_enable_poll()" in a more 
>> generic way.
> 
> Well, I looked through source code and it is defined as
> 
> 	void drm_kms_helper_poll_init(struct drm_device *dev)
> 
> But there is no direct pointer to some drm_device available.
> Neither in dw-hdmi nor ingenic-dw-hdmi.

Well he said "the Ingenic DRM core" aka ingenic-drm-drv.c. You do have 
access to the main drm_device in the ingenic_drm_bind() function, so 
you can add it there (with a cleanup function calling 
drm_kms_helper_poll_fini() registered with drmm_add_action_or_reset()).

Cheers,
-Paul

> What should the parameter to drm_kms_helper_poll_init(drm) be?
> 
> From comparing code to be able to set mode_config.poll_enabled = 
> enable it should be
> 
> 	&hdmi->bridge.dev
> 
> but the struct dw_hdmi *hdmi is an opaque type for the 
> ingenic-dw-hdmi driver.
> So it can't access the hdmi-bridge directly.
> 
> What we can do is to make dw_hdmi_enable_poll() call 
> drm_kms_helper_poll_init()
> or drm_kms_helper_poll_fini().
> 
> BR and thanks,
> Nikolaus
> 
> 


