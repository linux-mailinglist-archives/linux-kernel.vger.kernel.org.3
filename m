Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B64EC96D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348680AbiC3QQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiC3QQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:16:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E01128;
        Wed, 30 Mar 2022 09:15:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 16E381F45D79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648656899;
        bh=b0AyqVB1oKTLJHMRCRnyV2JQz3E+jsXsvdxPFkQuRVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkXp7YLLbwEGMTNIGKu1Wmcyn3FrmqCJymAolDdizOH0Qi3JJeAiLJVh30Xbqrx0O
         CCWbxYSfWhivoN2A/vo91tfKEKTi5hb/q0rQlfsjVEINng46NNfyM494yLZgFp+T6q
         ymuAwSZiWjhDFZL1WmgedlIsNpBRl3Xz9WMKM/IGmzY+zbh32fqAO7I7oBskvbdNcY
         kt8d/YcpEDu8aQUM8Nm+mULHgyKhiiKyW+5nlZWI8rQwHXIeOcnUUloQ595W+RCwg+
         sjpK5RZGKg9/71NcL40P5FBueF6GX6anecvM+GcMPpTCk8eiDGb8GiygmOy/nqjPut
         KfUPnV2Y0wb1A==
Date:   Wed, 30 Mar 2022 12:14:50 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        tzungbi@google.com, angelogioacchino.delregno@collabora.com,
        aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        linmq006@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [v7 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
Message-ID: <20220330161450.xxak64el6g6lzcem@notapiano>
References: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
 <20220324064511.10665-3-jiaxin.yu@mediatek.com>
 <20220329223002.uo7kiemopkh7ak4x@notapiano>
 <dee3fbb7c9f0c3e1f11143db1d6fc4381cab827f.camel@mediatek.com>
 <YkRNSoBKFvYYyZLu@sirena.org.uk>
 <61e9fb59448837cfc8e3ec862b711294bcb68872.camel@mediatek.com>
 <YkRoC30JLDMeVi1B@sirena.org.uk>
 <734fbf254c64668856e987aafe9d7dfd3ec86941.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <734fbf254c64668856e987aafe9d7dfd3ec86941.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:48:01PM +0800, Jiaxin Yu wrote:
> On Wed, 2022-03-30 at 15:24 +0100, Mark Brown wrote:
> > On Wed, Mar 30, 2022 at 10:06:24PM +0800, Jiaxin Yu wrote:
> > > On Wed, 2022-03-30 at 13:30 +0100, Mark Brown wrote:
> > > > Making a previously optional property required means that systems
> > > > that
> > > > previously worked may stop working unless they update their DT,
> > > > DTs
> > > > may
> > > > be distributed separately to the kernel and perhaps even baked
> > > > into
> > > > firmware or similar.
> > > Thank you for your detailed answer. I should keep the driver's
> > > behavior
> > > consistent with the description of dt-bindings. The "mediatek,hdmi-
> > > codec" needs to be set as the required property. Is my
> > > understanding
> > > right?
> > 
> > The binding document and code should match so if one is changed the
> > other needs to be changed too.
> > 
> > In theory we should never change a previously optional property to
> > required which would mean that the code should be updated to reflect
> > the
> > binding document, however sometimes the DT isn't actually used as a
> > stable intereface by anything for a given property or device type so
> > we
> > can get away with changing things.
> 
> "however sometimes the DT isn't actually used as a stable intereface by
> anything for a given property or device type so we can get away with
> changing things."
> 
> Sorry, I don't understand the real idea of this description. Does it
> mean that dt-bindings in this series don't need to be updated, but the
> driver?

He means that usually the DT (and dt-binding) shouldn't be changed to avoid
incompatibilities, but sometimes it's OK to change them. For example if there
are no users of the DT yet.

But in any case, like I mentioned in my latest reply [1], I don't think changing
the dt-binding is the proper solution in this case. The driver should be changed
instead.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220330152026.6nuigsldx46lue44@notapiano
