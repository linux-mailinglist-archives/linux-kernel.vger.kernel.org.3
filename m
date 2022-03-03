Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B64CB621
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 06:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiCCFQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 00:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCCFQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 00:16:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D31637DD;
        Wed,  2 Mar 2022 21:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17BCBB82232;
        Thu,  3 Mar 2022 05:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91609C004E1;
        Thu,  3 Mar 2022 05:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646284567;
        bh=0bq/jJdABYiYg74A+Fe0/noQNqV2iAgsmxYRoawwrlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZ5A5oQoJlaOFyFdgdRfHHGQkn4BIGzNHMx23tTiXbv2PzRoXTrI3YduuTBp0Mm77
         sYpOvkvXxTGeq8Xoefo30WCa2/LtCfTmCyYCStH5idHLLDLzF65JuJtbOEfeZEHNBx
         jEvxXX0p65qRHDwTJMhskS5RzBe4xTGqUDrwnGYqkthjApxEajeKwPy7DKwlP1GKTz
         60UhG2uZkUnnr+fsd1LvZZLbkzvfyDzY40t85sEXZRUdLIDdfyiESu2lpIKBAwKLjb
         dcE3UcqlzLEdrtOM6IkYdAhPattuq7VKn19JFr4w0+KP5gRIcHF424ulBCBY1lE4Sd
         lAzWmgqDd0PVg==
Date:   Thu, 3 Mar 2022 13:16:03 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        trevor.wu@mediatek.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Message-ID: <YiBPE9z+iHU7unn7@google.com>
References: <20220301072924.24814-1-jiaxin.yu@mediatek.com>
 <20220301072924.24814-3-jiaxin.yu@mediatek.com>
 <Yh3hcQpLngg8Pnd4@google.com>
 <0b8a5c22acb87b49de0380c7cb4e49030f93d715.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8a5c22acb87b49de0380c7cb4e49030f93d715.camel@mediatek.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 12:07:39PM +0800, Jiaxin Yu wrote:
> On Tue, 2022-03-01 at 17:03 +0800, Tzung-Bi Shih wrote:
> > After seeing the code, I am starting to wonder if the reuse is
> > overkill.  If
> > they (RT5682 vs. RT5682S) only have some minor differences, probably
> > it could
> > reuse more by:
> > 
> > SND_SOC_DAILINK_DEFS(i2s8, ...
> > SND_SOC_DAILINK_DEFS(i2s9, ...
> > 
> > ...
> > 
> > if (card == &mt8192_mt6359_rt1015p_rt5682s_card) {
> >         i2s8_codecs.name = RT5682S_DEV0_NAME;
> >         i2s8_codecs.dai_name = RT5682S_CODEC_DAI;
> >         ...
> > }
> > 
> > Or even uses of_device_is_compatible() if it would like to reuse the
> > struct
> > snd_soc_card.
> If we reuse the struct snd_soc_card, the card .name will be same.
> Should I change the card .name through of_device_is_compatible()?

Exactly yes.
