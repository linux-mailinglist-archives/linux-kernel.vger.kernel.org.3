Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2135247CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351416AbiELIWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351404AbiELIWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:22:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01F861617
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:22:33 -0700 (PDT)
X-UUID: 90d3dfc74d1842c08b15073111d62dcb-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e1679bf6-5a71-4ce3-9ffd-b4a20cda3f19,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:4b200aa7-eab7-4b74-a74d-5359964535a9,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 90d3dfc74d1842c08b15073111d62dcb-20220512
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 567945416; Thu, 12 May 2022 16:22:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 16:22:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 12 May 2022 16:22:26 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        TingHan Shen <tinghan.shen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        YC Hung <yc.hung@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v9 0/3] firmware: mtk: add adsp ipc protocol for SOF
Date:   Thu, 12 May 2022 16:22:12 +0800
Message-ID: <20220512082215.3018-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides mediatek adsp ipc support for SOF.
ADSP IPC protocol offers (send/recv) interfaces using
mediatek-mailbox APIs.

This patch was tested and confirmed to work with SOF fw on 
MT8195 cherry board and MT8186 krabby board.

changes since v8:
- fix patchset 2 and 3.
  move "depends on MTK_ADSP_IPC" from SND_SOC_SOF_MTK_COMMON
  to SND_SOC_SOF_MT8195/MT8186 to prevent generating wrong
  config.

changes since v7:
- rebase to linux-next/next-22020504
- use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL in mtk-adsp-ipc.c 
- move mtk-adsp-ipc.c out from driver/firmware/mediatek
- add user of mtk-adsp-ipc.h in patchset 2 and 3.

changes since v6:
- rebase to matthias.bgg/linux.git, v5.18-next/soc
- Prefer "GPL" over "GPL v2" for MODULE_LICENSE

changes since v5:
- fix WARNING: modpost: missing MODULE_LICENSE() in drivers/mailbox
  /mtk-adsp-mailbox.o. Add MODULE_LICENSE in the last line.
- Due to WARNING: Missing or malformed SPDX-License-Identifier tag
  in line 1 in checkpatch, we don't remove SPDX-License in line 1.

changes since v4:
- add error message for wrong mbox chan

changes since v3:
- rebase on v5.16-rc8
- update reviewers

changes since v2:
- add out tag for two memory free phases

changes since v1:
- add comments for mtk_adsp_ipc_send and mtk_adsp_ipc_recv
- remove useless MODULE_LICENSE
- change label name to out_free


Allen-KH Cheng (1):
  ASoC: SOF: mediatek: Add ipc support for mt8195

TingHan Shen (1):
  firmware: mediatek: add adsp ipc protocol interface

Tinghan Shen (1):
  ASoC: SOF: mediatek: Add mt8186 ipc support

 drivers/firmware/Kconfig                      |   9 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/mtk-adsp-ipc.c               | 157 ++++++++++++++++++
 .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 ++++++++
 sound/soc/sof/mediatek/Kconfig                |   2 +
 sound/soc/sof/mediatek/adsp_helper.h          |  12 +-
 sound/soc/sof/mediatek/mt8186/mt8186-loader.c |   5 +
 sound/soc/sof/mediatek/mt8186/mt8186.c        | 141 ++++++++++++++++
 sound/soc/sof/mediatek/mt8195/mt8195.c        | 138 ++++++++++++++-
 9 files changed, 519 insertions(+), 11 deletions(-)
 create mode 100644 drivers/firmware/mtk-adsp-ipc.c
 create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h

-- 
2.18.0

