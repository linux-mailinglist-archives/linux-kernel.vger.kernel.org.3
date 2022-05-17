Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBB152A77C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350709AbiEQP7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiEQP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45885496A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D01A461222
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF9AC385B8;
        Tue, 17 May 2022 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803165;
        bh=qB+Y2b64SyCD76/3XYAEBdye3lfRy7RB0EKRB7eIy44=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ic77VlduGWC/bBx4kKkKWri6PpIr+WNQkfPakgMeHzOYKy/3leM0YedDNBvNKlxCD
         otWAQX0IiJfU+Wv52iV+tqz/8Scfzy+wn90H09iQ6aHMq/5xfRkAQdjTWu/3FQ60OA
         NE1TeWbfVRjKp6Clclo+taeyj9mzoHZ/mYJ+ygbLq/hPhiddlJftI8a6/tK2uJhSMH
         ICMD1PCKO4WuSEPs+2muB6YeZlDylFHoqHFPQKpeghUGK+KCmqcbAr8f3LFkwyRRnV
         kOk0b550GvXmG3KUmVgwz0ngaIjb6xnj8l1DGqMUt4bBIKBRlqQPKGFCRVROvSEtEy
         //2+hgNIPKTFg==
From:   Mark Brown <broonie@kernel.org>
To:     cujomalainey@chromium.org, tinghan.shen@mediatek.com,
        john.stultz@linaro.org, javierm@redhat.com,
        cristian.marussi@arm.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, geert+renesas@glider.be,
        yc.hung@mediatek.com, tzimmermann@suse.de, lgirdwood@gmail.com,
        perex@perex.cz, kai.vehmanen@linux.intel.com, tzungbi@google.com,
        bp@suse.de, ranjani.sridharan@linux.intel.com,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        tiwai@suse.com, Arnd Bergmann <arnd@arndb.de>,
        simont@opensource.cirrus.com, daniel.baluta@nxp.com,
        xueshuai@linux.alibaba.com, msuchanek@suse.de,
        yangyingliang@huawei.com, sudeep.holla@arm.com,
        allen-kh.cheng@mediatek.com, matthias.bgg@gmail.com,
        daniel.vetter@ffwll.ch, angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        sound-open-firmware@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20220512082215.3018-1-tinghan.shen@mediatek.com>
References: <20220512082215.3018-1-tinghan.shen@mediatek.com>
Subject: Re: [PATCH v9 0/3] firmware: mtk: add adsp ipc protocol for SOF
Message-Id: <165280315828.1635268.5394864574806411839.b4-ty@kernel.org>
Date:   Tue, 17 May 2022 16:59:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 16:22:12 +0800, Tinghan Shen wrote:
> This patch provides mediatek adsp ipc support for SOF.
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> This patch was tested and confirmed to work with SOF fw on
> MT8195 cherry board and MT8186 krabby board.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] firmware: mediatek: Add adsp ipc protocol interface
      commit: 9db69df4bdd37eb1f65b6931ee067fb15b9a4d5c
[2/3] ASoC: SOF: mediatek: Add ipc support for mt8195
      commit: aea9350108ed1627f8610c93de44578162b3ee91
[3/3] ASoC: SOF: mediatek: Add mt8186 ipc support
      commit: e0100bfd383c7d994d2e957e85ca56a5fe5a3f43

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
