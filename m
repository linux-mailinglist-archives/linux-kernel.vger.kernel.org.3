Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29A14DB975
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358034AbiCPUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358015AbiCPUhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640036E37D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CD08B81D48
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90745C340EE;
        Wed, 16 Mar 2022 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462953;
        bh=AAAhWEJi/anFNCmxfNhIiBbA6Y0GIdzJjvQH3bJNz/k=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=J1gz/E1CchAXd+lS5jkyTs1XeC9RQX/mBXckYjl3klNfDO/r3soyjfzUEVuoLAAe5
         lC54LRj0+gFBhgxEVGCiiEVKy1CkQHi6qdqB4jgkaJAU2O6zQK+SUggzSRyhr+OeYb
         D1tZT1dpw/XvUm3GMidGdyt2pt8HbPPMw3AeEEufiGmBeZCo26/Geap712HYLSODbi
         kn4cqxQteP+75j+hEOmJUotLedQCYzfET+jXMhIH2VIE7vsiYLI/9P3OmeUFqR2dvm
         /oIyYQQ0iphi3q8Srp4PjtkkFot5tRl0X2NJ9++zaGOHansIttRB0McVx10mQiBtk4
         HfLkkDHibg0wQ==
From:   Mark Brown <broonie@kernel.org>
To:     Shunli Wang <shunli.wang@mediatek.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Miaoqian Lin <linmq006@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220316014059.19292-1-linmq006@gmail.com>
References: <Yia5XgkGyLbIRc1f@google.com> <20220316014059.19292-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] ASoC: mediatek: Fix error handling in mt8183_da7219_max98357_dev_probe
Message-Id: <164746295130.1220201.16478310954172024054.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:35:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 01:40:57 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> Fix this by calling of_node_put() in error handling too.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Fix error handling in mt8183_da7219_max98357_dev_probe
      commit: 28a265a1ee11febeec5ea73a804f30dcec3181ca

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
