Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEEE4D0DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbiCHCEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiCHCEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:04:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DCE21837
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:03:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC504614D9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9CBC340E9;
        Tue,  8 Mar 2022 02:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646704995;
        bh=+5Cyq8EnO4Z7dInU7QtRiRgZkFYM1vfMImCrh3hisB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifIYXJSuREhd5QQVQga5BeJFLiCsR1g1uDKO0QrsvhcDiPk+KayzNVPr3R5uFxXtU
         0R6eiP6w+170ffXBRqJGHRvNYLoJzSG4/kYczFZ3cpe9K1Wz4yzz67smC/s7/7PJ1L
         Jdb9s7Al3sCILD4PNdpilQ46XSiBxZ9kMd1gRhnNmdeU6IBDiWraCMDiNWjFCHkJrV
         5I1IQ53j4itSWaaYX9T+ZfFY4xwY9ucEY5fRcFkw9F6ZHPS84yRaM+rFL/nN2Bm8Rp
         dYbSBVspq1f8xJ5h4ZkV9ElhpanKR2BFOllKBWJhmFmG49fTj0jBzfSr4LcA1ll8RD
         wp+cvIJn0ZKXg==
Date:   Tue, 8 Mar 2022 10:03:10 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: Fix error handling in
 mt8183_da7219_max98357_dev_probe
Message-ID: <Yia5XgkGyLbIRc1f@google.com>
References: <20220307131924.9905-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307131924.9905-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 01:19:21PM +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> Fix this by calling of_node_put() in error handling too.
> 
> Fixes: ebbddc75bbe8 ("ASoC: Mediatek: MT8183: Add machine driver with DA7219")

I am not sure if the Fixes tag makes sense.  ebbddc75bbe8 is the first commit
for the file; however, we have some more commits in between tip and
ebbddc75bbe8.

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

With the minor comment,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
