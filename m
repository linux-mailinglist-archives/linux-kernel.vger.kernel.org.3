Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C34B4F39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352251AbiBNLrD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:47:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352300AbiBNLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:46 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD4C1DA46;
        Mon, 14 Feb 2022 03:31:12 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:30:54 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v15 2/7] drm/ingenic: Add dw-hdmi driver specialization
 for jz4780
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Harry Wentland <harry.wentland@amd.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Message-Id: <IBLA7R.1NQX4KVACXPK3@crapouillou.net>
In-Reply-To: <AD978522-8321-476D-955C-3CDD747EFCAC@goldelico.com>
References: <cover.1644681054.git.hns@goldelico.com>
        <e6e1f3f44e6979a998ec9c372e329b6facaded15.1644681054.git.hns@goldelico.com>
        <58IA7R.PZ9FQXN7FVAK@crapouillou.net>
        <AD978522-8321-476D-955C-3CDD747EFCAC@goldelico.com>
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



Le lun., févr. 14 2022 at 12:02:53 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> Hi Paul,
> 
>>  Am 14.02.2022 um 11:24 schrieb Paul Cercueil <paul@crapouillou.net>:
>> 
>>  Hi,
>> 
>>  Le sam., févr. 12 2022 at 16:50:50 +0100, H. Nikolaus Schaller 
>> <hns@goldelico.com> a écrit :
> 
>>>  +static void ingenic_dw_hdmi_cleanup(void *data)
>>>  +{
>>>  +	struct dw_hdmi *hdmi = (struct dw_hdmi *)data;
>>>  +
>>>  +	dw_hdmi_remove(hdmi);
>>>  +}
>>>  +
>>>  +static int ingenic_dw_hdmi_probe(struct platform_device *pdev)
>>>  +{
>>>  +	struct dw_hdmi *hdmi;
>>>  +
>>>  +	hdmi = dw_hdmi_probe(pdev, &ingenic_dw_hdmi_plat_data);
>>>  +	if (IS_ERR(hdmi))
>>>  +		return PTR_ERR(hdmi);
>>>  +
>>>  +	return devm_add_action_or_reset(&pdev->dev, 
>>> ingenic_dw_hdmi_cleanup, hdmi);
>> 
>>  I think I said it already, but in this driver you could use a 
>> .remove callback, there's not much point in using devm cleanups in 
>> such a simple setup.
> 
> Well it was your suggestion after v8:
> 
> https://lore.kernel.org/all/DIA33R.QE29K7RKLI2C1@crapouillou.net/

It made sense for your v8, not so much for your v15...

> So we now almost go back to RFC v1 almost 2 years ago:
> 
> https://patchwork.kernel.org/project/linux-mips/patch/2c131e1fb19e19f958a612f7186bc83f4afb0b0a.1582744379.git.hns@goldelico.com/
> 
> Of course there was a good reason to better handle the regulator
> AND the dw_hdmi_remove() by a single mechanism.
> 
> Now the regulator has gone and been replaced by the hdmi connector
> and we can go back.
> 
>> 
>>  In your probe you could just:
>>  return PTR_ERR_OR_ZERO(hdmi);
> 
> No, this does not work since we need to platform_set_drvdata().
> to be able to access the private struct in the remove callback.
> And checking errors after platform_set_drvdata() can be done but
> looks strange to me.

Yeah, I guess it would look strange. Fine then.

Then I guess just merge your current [6/7] with this one (and make sure 
it comes after your current [5/7]) and it looks mergeable to me.

Cheers,
-Paul

> It is up to you what you prefer.
> 
>> 
>>>  +}
>>>  +
>>>  +static struct platform_driver ingenic_dw_hdmi_driver = {
>>>  +	.probe  = ingenic_dw_hdmi_probe,
>>>  +	.driver = {
>>>  +		.name = "dw-hdmi-ingenic",
>>>  +		.of_match_table = ingenic_dw_hdmi_dt_ids,
>>>  +	},
>>>  +};
>>>  +module_platform_driver(ingenic_dw_hdmi_driver);
>>>  +
>>>  +MODULE_DESCRIPTION("JZ4780 Specific DW-HDMI Driver Extension");
>>>  +MODULE_LICENSE("GPL v2");
>>>  +MODULE_ALIAS("platform:dwhdmi-ingenic");
>> 
>>  Should probably be "platform:dw-hdmi-ingenic"?
> 
> Yes, indeed. Thanks for spotting!
> 
> Was also good in v1. Probably someone deleted the hyphen unnoticed 
> during editing of "jz4780" to "ingenic"...




