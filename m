Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A014F59E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiDFJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580512AbiDFJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:20:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755332816AF;
        Tue,  5 Apr 2022 19:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C4EAB81FB5;
        Wed,  6 Apr 2022 02:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F4FC385A0;
        Wed,  6 Apr 2022 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649212204;
        bh=xmoV1wDYDm25L/wEd+wgpbgIUhjzDoq0K9phYwvAZFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pmkqz/0noFRk7vacJLi7o3vg9unVDqrCyTAAmO94kuNLcZpRGMnELojxzt4z7WhJZ
         MQ3qDz1FiqDLxIYJRTjAk/M2pFxqYYRTQpr0Y0O4tL9+KgYbHjW6ayRs/K2ptMZvEz
         cVAANQyp3Ln6sbQO15qdCyNHeO0mFkgWRd5ASXpkkXbHXZC8mPQNGEhFa5PliOaizn
         MfIndUw2XCE0Bkvjc7W+0DeHOGuAeJOWnFaKxKnvQ7E8M75ru8vz9y8kLhvlLuBg3Z
         GPemXN5w4EG5VauaqfsPEk+rcXHHZZJUP4iyzD8sgcV+bf8lwW3RxwojcilIGweC0s
         Q8huiUdIzv4gQ==
Date:   Wed, 6 Apr 2022 02:30:00 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v8 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
Message-ID: <Ykz7KB221jyfwKzQ@google.com>
References: <20220402051754.17513-1-jiaxin.yu@mediatek.com>
 <20220402051754.17513-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402051754.17513-3-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 01:17:52PM +0800, Jiaxin Yu wrote:
> MT8192 platform will use rt1015 or rt105p codec, so through the

s/rt105p/rt1015p/.

>  static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
[...]
> +	hdmi_codec = of_parse_phandle(pdev->dev.of_node, "mediatek,hdmi-codec", 0);
> +	if (!hdmi_codec)
> +		dev_info(&pdev->dev, "The machine don't have hdmi-codec\n");

s/don't have/has no/.
