Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54E3592D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiHOKsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242514AbiHOKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:48:40 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B122B14
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vh4WP5c9FJ0MbLK61vY6yRT/SQaaMEr8RbbREz+rZ1g=; b=b1TJYcymPjKnvyimmR5TjK81Mu
        VqbuVBHbCfn54WGnqn0VB7piwq8YS9MKHNpYBPPOvVgVgp2zlJtU9MFGi7NrC9Be70mYyrw+TW1EW
        cNVYeWCOkfSvyulTlCiQT9jnM28OmqhwKChxRrhWHa812xj2Du4i5eaMDXWJDocyjv1ikGAs+wYcB
        XQ4Z6Yh28waRpNDKXpQZisudD5+cFUqFL8m9SLmx+AKeDFVXUCU0neZoELSCxtN5DM7H077grQe+s
        zywFm7UJLVQ7ZJpq4rQVY2XG4QCDYe/PczZS6fBvKKfGIJWQ+oB40qpMJNvxKx2PZqV93BUmiJ1d+
        2i/+GCAA==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=52543)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oNXe0-00013Y-A2; Mon, 15 Aug 2022 12:48:28 +0200
Message-ID: <53216533-d0d6-90d5-b9d1-c7d935867a54@tronnes.org>
Date:   Mon, 15 Aug 2022 12:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 03/35] drm/atomic: Add TV subconnector property to
 get/set_property
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-3-3d53ae722097@cerno.tech>
 <6e47ce2d-25c7-7254-703d-2a1d3bb64373@tronnes.org>
 <20220815073546.4isrl7o3bt5g23pk@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220815073546.4isrl7o3bt5g23pk@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 15.08.2022 09.35, skrev Maxime Ripard:
> Hi Noralf,
> 
> Thanks for your review
> 
> On Mon, Aug 08, 2022 at 02:30:42PM +0200, Noralf Trønnes wrote:
>> Den 29.07.2022 18.34, skrev Maxime Ripard:
>>> The subconnector property was created by drm_mode_create_tv_properties(),
>>> but wasn't exposed to the userspace through the generic
>>> atomic_get/set_property implementation, and wasn't stored in any generic
>>> state structure.
>>>
>>> Let's solve this.
>>>
>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>
>> I just realised that this and the select_subconnector property isn't
>> used by any drivers. Do you plan to use them? Maybe they don't need to
>> be wired up at all.
> 
> I'm not sure really
> 
> It's true that the subconnector and select_subconnector fields in the TV
> connector state aren't used by any driver, but the ch7006 and nouveau
> will update the property content through a call to
> drm_object_property_set_value
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/i2c/ch7006_drv.c#L217
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c#L185
> 
> I think it could still be useful to report it in the connector state, if
> only for consistency?
> 

Yeah maybe.

I just realised that I have support in the GUD protocol for these
properties so any future devices that rely on them them will need this
patch, so I'm now suddenly in favor of this :)

Noralf.
