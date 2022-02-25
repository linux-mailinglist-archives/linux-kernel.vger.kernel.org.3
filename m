Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9334C4630
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbiBYNZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiBYNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:25:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A32E1A6F81;
        Fri, 25 Feb 2022 05:24:35 -0800 (PST)
X-UUID: 5796af6c76604c259a0218e8e4b11534-20220225
X-UUID: 5796af6c76604c259a0218e8e4b11534-20220225
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 698999412; Fri, 25 Feb 2022 21:24:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Feb 2022 21:24:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Feb 2022 21:24:28 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>, <tzungbi@google.com>,
        <cujomalainey@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Kevin Hilman <khilman@baylibre.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <sound-open-firmware@alsa-project.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v18 0/2] mtk: add ADSP mailbox controller for MT8195
Date:   Fri, 25 Feb 2022 21:24:25 +0800
Message-ID: <20220225132427.29152-1-allen-kh.cheng@mediatek.com>
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

Mediatek ADSP IPC is used to send notification or short message 
between processors with dsp.
It will place the message to the share buffer and will access the
ADSP mailbox registers to kick dsp. Two mailboxes used to send
notification or short message between processors with dsp.

This patchset was tested and confirmed on MT8195 cherry board.
Based on tag: next-20220223, linux-next/master

changes since v17:
- remove description and add maxItems for reg and interrupts in
  mtk,adsp-mbox.yaml

changes since v16:
- fix WARNING: modpost: missing MODULE_LICENSE() in drivers/mailbox
  /mtk-adsp-mailbox.o. Add MODULE_LICENSE in the last line.
- Due to WARNING: Missing or malformed SPDX-License-Identifier tag
  in line 1 in checkpatch, we don't remove SPDX-License in line 1.

changes since v15:
- add paragraphs to describe the config symbols fully

changes since v14:
- add inline for get_mtk_adsp_mbox_priv

changes since v13:
- rebase on v5.16-rc8
- add back ptr check from of_device_get_match_data

changes since v12:
- remove of_device_get_match_data ptr check:
  of_device_get_match_data(dev) will never going to return NULL.
  driver probe with compatible mediatek,mt8195-adsp-mbox.

changes since v11:
- remove useless MODULE_LICENSE

changes since v10:
- split up v9 into two separate submissions

changes since v9:
- rename adsp_mbox_chan_ops to mtk_adsp_mbox_chan_ops

changes since v8:
- remove struct adsp_mbox_ch_info
- add get_mtk_adsp_mbox_priv
- use mtk_adsp_mbox_priv va_mboxreg address in adsp mbox driver
- add struct mtk_adsp_mbox_cfg for DSP mbox register offset
- remove adsp mbox register offset hard code define
- remove mtk-adsp-ipc.h reference in adsp mbox driver

changes since v7:
- add mtk prefix for adsp ipc functions
- rename adsp_mbox_ch_info to mtk_adsp_mbox_ch_info
- remove incorrect reviewers in commit message

changes since v6:
- dt-bindings: change example dtsi node.
- rename config MTK_ADSP_IPC_MBOX to MTK_ADSP_MBOX
- remove unused variable
- add reviewers

changes since v5:
- remove some redundant code

changes since v4:
- use switch ... case in adsp_ipc_recv
- add error handling path for chan_name pointer
- refine some code to be concise

changes since v3:
- reorder MTK_ADSP_IPC_MBOX config
- remove some redundant code
- remove lock in mtk-adsp-mailbox

changes since v2:
- separate adsp_mailbox into two instances

changes since v1:
- fix dt_binding_check error

Allen-KH Cheng (2):
  dt-bindings: mailbox: mtk,adsp-mbox: add mtk adsp-mbox document
  mailbox: mediatek: add support for adsp mailbox controller

 .../bindings/mailbox/mtk,adsp-mbox.yaml       |  50 +++++
 drivers/mailbox/Kconfig                       |   9 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mtk-adsp-mailbox.c            | 176 ++++++++++++++++++
 4 files changed, 237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
 create mode 100644 drivers/mailbox/mtk-adsp-mailbox.c

-- 
2.18.0

