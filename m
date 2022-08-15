Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9725E592C41
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiHOKtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiHOKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:49:44 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A76622B14
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RWy0N+7/yckvgkArgj6CdthLLzk89M9POcSFkfkYnRA=; b=N5ZGfjRF8WeW92jxf8spYDSDvP
        DmLr5GBnEfOozxMT2zbuHCOgstG6jXgxZ5wxkwGyfP5vzzlblBxN/TDlA+3/FoqB5WAtqQ29QDt4k
        I7R+Ju7eo+dLue5R0eYfsrHl5npb6Pxxb4CRofJP5D9q25kbkPFyx8hY+QxR1zhunkRzFHwm8zoir
        LhKFemOrzlDNk+7snRjUXnE4mwC80sJmm5ktcxiX5A0zOWNq1IhB2Xk5twOaOYewddU6jji0Is8H0
        HisNyFSnBSOpFy8ZsN1IcItt2e+7a+wB/EpsZuyNqDnTVkM33Ktn6GxGRjy19Z46YrPPIn04H4OvH
        vIXWhpWg==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=52575)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oNXf9-0001wP-Ry; Mon, 15 Aug 2022 12:49:39 +0200
Message-ID: <d56c3ff4-8a14-0467-2b61-d559dc936dda@tronnes.org>
Date:   Mon, 15 Aug 2022 12:49:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 06/35] drm/connector: Only register TV mode property if
 present
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
 <20220728-rpi-analog-tv-properties-v1-6-3d53ae722097@cerno.tech>
 <d96df677-a1a7-ae49-bda6-abad025dc974@tronnes.org>
 <20220815104041.6ymspbhpjdxg2aoe@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220815104041.6ymspbhpjdxg2aoe@houat>
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



Den 15.08.2022 12.40, skrev Maxime Ripard:
> Hi,
> 
> On Mon, Aug 08, 2022 at 02:49:08PM +0200, Noralf Trønnes wrote:
>> Den 29.07.2022 18.34, skrev Maxime Ripard:
>>> The drm_create_tv_properties() will create the TV mode property
>>> unconditionally.
>>>
>>> However, since we'll gradually phase it out, let's register it only if we
>>> have a list passed as an argument. This will make the transition easier.
>>>
>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>>
>>
>> I don't understand why this makes the transition easier, but if you
>> think so:
> 
> So the basic idea behind this series was to introduce the new property,
> gradually convert the old drivers to the new one, and finally remove the
> old one.
> 
> In order to keep the backward compatibility, we need to add to the
> drivers some custom get/set_property hook to expose the old property and
> fill the new one if needed.
> 
> That means that each driver would have to create the old property, which
> will conflict with that code
> 

Got it.

Noralf.
