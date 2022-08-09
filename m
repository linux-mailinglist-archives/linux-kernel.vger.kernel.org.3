Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8B58D56B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbiHIIdN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Aug 2022 04:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbiHIIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:33:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC5201B2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:33:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oLKfR-0006K1-7S; Tue, 09 Aug 2022 10:32:49 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oLKfM-002fas-63; Tue, 09 Aug 2022 10:32:46 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oLKfN-0001Qi-La; Tue, 09 Aug 2022 10:32:45 +0200
Message-ID: <b18ef07670c09d4a58b70dc3671549a9b7d5b4e2.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] ASoC: apple: mca: Start new platform driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Martin =?UTF-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Aug 2022 10:32:45 +0200
In-Reply-To: <20220808224153.3634-3-povik+lin@cutebit.org>
References: <20220808224153.3634-1-povik+lin@cutebit.org>
         <20220808224153.3634-3-povik+lin@cutebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Di, 2022-08-09 at 00:41 +0200, Martin Povišer wrote:
> +	mca->rstc = devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(mca->rstc)) {
> +		dev_dbg(&pdev->dev, "couldn't obtain reset control: %pe\n", mca->rstc);
> +		mca->rstc = NULL;
> +	}

Please don't ignore errors, this could be -ENOMEM.

For optional resets, use devm_reset_control_get_optional_shared(),
which returns NULL if there is no resets property in the device tree.

regards
Philipp
