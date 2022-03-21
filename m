Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00104E233A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbiCUJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiCUJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:23:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827811628A;
        Mon, 21 Mar 2022 02:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81E79B81177;
        Mon, 21 Mar 2022 09:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE151C340E8;
        Mon, 21 Mar 2022 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647854509;
        bh=js3Rr+dGBwxPT5O2sAogbnMjmIOd+kG1mAzBVLLRx5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njg8O/W4Vv3IECCZJM2JewVvH2vhm/jUaAYsDEQCWqJEgtkAsUVGs4K/8FcdpyR71
         YjV1ksexpq42ejRKGzipRXOojPfkM/Q7xSNrXdq6JsKQWhkzJ7rOAC15x1NcxNerTU
         un6vKgzW5+68tp0PAizpMFw8QEXn9ec5oKQs4+546vK0dWR7HZ2kyk4ldf40i/Qe8r
         k1QnGilipJlO+hW0rVt0F1Aur7Wk9ZqXUiX5E9LZuEJ7i5vVUU3CQxVF3QT1LutpPz
         sIoozG+4fpjWdnp8YvNE/yHISY8DpgnYVsWpiG9oBKBUE/2Mw+q2mm/sQo6p12Go8A
         epZkZzxjmBvdA==
Date:   Mon, 21 Mar 2022 17:21:44 +0800
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
Message-ID: <YjhDqKhtYastPhf0@google.com>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
 <20220319114111.11496-4-jiaxin.yu@mediatek.com>
 <Yjf4KjXpVJaNnvb8@google.com>
 <17e6e8895ebc1113911481c7e097b394005db123.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e6e8895ebc1113911481c7e097b394005db123.camel@mediatek.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 05:14:08PM +0800, Jiaxin Yu wrote:
> On Mon, 2022-03-21 at 11:59 +0800, Tzung-Bi Shih wrote:
> > On Sat, Mar 19, 2022 at 07:41:10PM +0800, Jiaxin Yu wrote:
> > > @@ -1145,6 +1140,13 @@ static int mt8192_mt6359_dev_probe(struct
> > > platform_device *pdev)
> > >  		goto err_speaker_codec;
> > >  	}
> > >  
> > > +	headset_codec = of_get_child_by_name(pdev->dev.of_node,
> > > "mediatek,headset-codec");
> > > +	if (!headset_codec) {
> > > +		ret = -EINVAL;
> > > +		dev_err_probe(&pdev->dev, ret, "Property
> > > 'headset_codec' missing or invalid\n");
> > > +		goto err_headset_codec;
> > > +	}
> > 
> > (to be neat) Does it have any reason to prevent from using
> > of_parse_phandle()
> > but of_get_child_by_name()?
> 
> "mediatek,headset-codec" is a child node of pdev->dev.of_node, so I use
> of_get_child_by_name() to get and   pass it to
> snd_soc_of_get_dai_link_codecs().

"mediatek,platform" and "mediatek,hdmi-codec" are also children of
pdev->dev.of_node.  I guess my question is: why doesn't it also use
of_parse_phandle() for "mediatek,headset-codec"?  Did I misunderstand?
