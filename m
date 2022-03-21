Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1674E1F67
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiCUEBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiCUEBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95844AE5E;
        Sun, 20 Mar 2022 20:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 305FD60C89;
        Mon, 21 Mar 2022 03:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D741C340E8;
        Mon, 21 Mar 2022 03:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647835183;
        bh=6C2Rn2TiO19qVcy2kVX3WO5CMQAaiGC6EBfvsJ7KrWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNHA/biyCxRt6ihYlKG7yYtUAnAIa+4/rTM34JAZ2oVG1nMbaacKi1UA9fTlQpFiX
         HOakm6JDehmbET4ORvCXeWqk+LRKNUp2qdOTkiNxWShg8MmwTJo2I5KCC+8a5MGDCr
         nFFfpnBt60HU0/xklNUDWGFpY/+uXNOSMfrNLSHQSFlQa4rTwdaOjImDOjOsa6drMm
         0YRlgrl0nGbcbNmf6XWoZMGtyWvNuO+ta1WYKbwIzzLs6wa1iBpUIPjQdMRhZoO0vg
         L7qoSX+Y3TlUZ2m0FgqNs90Xvh74ElQ2tvFccRo2N7af7vUHho2tYfHulF50oBgSQG
         7DBUnpf1aBamQ==
Date:   Mon, 21 Mar 2022 11:59:38 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linmq006@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
        matthias.bgg@gmail.com, aaronyu@google.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: Re: [v5 3/4] ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI
 links of headset
Message-ID: <Yjf4KjXpVJaNnvb8@google.com>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
 <20220319114111.11496-4-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319114111.11496-4-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 07:41:10PM +0800, Jiaxin Yu wrote:
> @@ -1145,6 +1140,13 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
>  		goto err_speaker_codec;
>  	}
>  
> +	headset_codec = of_get_child_by_name(pdev->dev.of_node, "mediatek,headset-codec");
> +	if (!headset_codec) {
> +		ret = -EINVAL;
> +		dev_err_probe(&pdev->dev, ret, "Property 'headset_codec' missing or invalid\n");
> +		goto err_headset_codec;
> +	}

(to be neat) Does it have any reason to prevent from using of_parse_phandle()
but of_get_child_by_name()?
