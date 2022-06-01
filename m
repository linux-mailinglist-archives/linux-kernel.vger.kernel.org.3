Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD35853A4B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352089AbiFAMSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348212AbiFAMSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:18:12 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8945D5CC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:18:11 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-f2a4c51c45so2426389fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYSb8FA9Ykns49985bGrz8nq1DrPHUc7tJMRYFIXey8=;
        b=hYbEA6ZSL7pLmVip4Fp9+C1YueJqiza/AFlE1vKomNckQklu67pK1AuCTVhysaltO/
         H4FHn+ddGhP68EK/VTSAgQ220f6INzgV+p5JtWl/Ip/fNs6Gpohq7k3U1sX2L4nq8sX5
         T5uQc4RbGKjZR6v3RObwFoYYlLutcY6AjKxAnqcm6XtFMOsiQ8T0brYxpxu7uP/dNSLt
         YPzjiEZ0aU46ZXQ9f8lJScJ2xr4cm+NxR74CGU+aQ1cSbxFENLUqy/bwV0W4XY1HRrhD
         r8DWcsM4T/8wFqv+JJOwYrWoaixGbjjFL0HSPuZfSaYCtaJng27rzUoh7QA+VqQUnJPI
         vC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYSb8FA9Ykns49985bGrz8nq1DrPHUc7tJMRYFIXey8=;
        b=50LJ4uGAYBIv+Jdlf2MwVkbYk0EP8ADLnzGhNH5gnflQ7KBAf17GCHET8UIMnq1iWL
         PALdX5b89f+XrHs6+CMT/UMDXZzi3nT1QuvMLcZyne6jm7gWUHZ/OyVcXOkzpLyxIqHv
         9LH7B3u0zTAQKqpgyC6Mz1U+1RiBUIcht3UpGZ05EMxw55VL7KR4yaaYMxTDQBZlyT/d
         jt0F5Yq11F5Ic/ryYWw2ayVa/T44qI+M0MNP9L+epn32qDknoXARnMbxAtb7ijxhNPPJ
         wdB2Q/YivkDCM4kYsU3wusKUXTJWnF1aQE/eX/nm1Fe6FMdJWVA11NK1jRTdbkz3DWkD
         kcXg==
X-Gm-Message-State: AOAM533KpGMEQqCA420feGc5h9tXg7NkWhel332HR3neH2Y3CK38M1Wq
        NZZ8I36K0PV5pl3pZh+Qa1kJ5g==
X-Google-Smtp-Source: ABdhPJziuOEo0HMHzqpjpdzaJSxid8KEX0AtyrINYNPwpMziuIkIvpE6iNSDsnfDVgnkfEZ+A9x1OA==
X-Received: by 2002:a05:6870:d6aa:b0:f1:8277:3026 with SMTP id z42-20020a056870d6aa00b000f182773026mr16699231oap.200.1654085890917;
        Wed, 01 Jun 2022 05:18:10 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 12-20020aca120c000000b00325cda1ffa5sm779377ois.36.2022.06.01.05.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:18:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [GIT PULL] remoteproc updates for v5.19
Date:   Wed,  1 Jun 2022 07:18:09 -0500
Message-Id: <20220601121809.536000-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.19

for you to fetch changes up to bb489b96406104070c1fbe364c441cffae8a2ae4:

  dt-bindings: remoteproc: mediatek: Add optional memory-region to mtk,scp (2022-05-17 03:19:08 +0100)

----------------------------------------------------------------
remoteproc updates for v5.19

This fixes a race condition in the user space interface for starting and
stopping remote processors, it makes the ELF loader properly skip zero
memsz segments and it cleans up the debugfs tracefile code a bit by not
checking for errors.

It introduces support for controlling the audio DSP on Qualcomm MSM8226,
as well as audio and compute DSPs on Qualcomm SC8280XP.

It makes it possible to specify the firmware path for Mediatek's remote
processors, fixes a double free in the SCP driver and addresses an issue
with the SRAM initialization on MT8195.

Lastly it deprecates the custom ELF loader in the iMX remoteproc driver,
in favor of using the shared one.

----------------------------------------------------------------
Allen-KH Cheng (2):
      dt-bindings: remoteproc: mediatek: Add firmware-name property
      remoteproc: mediatek: Allow reading firmware-name from DT

Arnaud Pouliquen (1):
      dt-bindings: remoteproc: st,stm32-rproc: Fix phandle-array parameters description

Bjorn Andersson (2):
      dt-bindings: remoteproc: qcom: pas: Add sc8280xp adsp and nsp pair
      remoteproc: qcom: pas: Add sc8280xp remoteprocs

Christophe JAILLET (1):
      remoteproc: mtk_scp: Fix a potential double free

Daniel Baluta (1):
      remoteproc: imx_dsp_rproc: Make rsc_table optional

Luca Weiss (2):
      dt-bindings: remoteproc: qcom: pas: Add MSM8226 adsp
      remoteproc: qcom: pas: Add MSM8226 ADSP support

Manivannan Sadhasivam (1):
      remoteproc: Don't bother checking the return value of debugfs_create*

Mathieu Poirier (2):
      Merge branch 'rproc-fixes' into rproc-next
      Merge branch 'rproc-fixes' into rproc-next

Nícolas F. R. A. Prado (3):
      dt-bindings: remoteproc: mediatek: Add interrupts property to mtk,scp
      dt-bindings: remoteproc: mediatek: Make l1tcm reg exclusive to mt819x
      dt-bindings: remoteproc: mediatek: Add optional memory-region to mtk,scp

Peng Fan (5):
      remoteproc: elf_loader: skip segment with memsz as zero
      remoteproc: imx_dsp_rproc: use common rproc_elf_load_segments
      remoteproc: imx_rproc: Ignore create mem entry for resource table
      dt-bindings: remoteproc: imx_rproc: Support i.MX93
      remoteproc: imx_rproc: Support i.MX93

Shengjiu Wang (2):
      remoteproc: core: Remove state checking before calling rproc_boot()
      remoteproc: core: Move state checking to remoteproc_core

Tinghan Shen (1):
      remoteproc: mediatek: Fix side effect of mt8195 sram power on

 .../bindings/remoteproc/fsl,imx-rproc.yaml         |   9 +-
 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |  57 ++++++++---
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |  31 ++++++
 .../bindings/remoteproc/st,stm32-rproc.yaml        |  16 ++--
 drivers/remoteproc/imx_dsp_rproc.c                 | 105 ++-------------------
 drivers/remoteproc/imx_rproc.c                     |  36 +++++++
 drivers/remoteproc/mtk_common.h                    |   2 +
 drivers/remoteproc/mtk_scp.c                       |  76 +++++++++++----
 drivers/remoteproc/qcom_q6v5_pas.c                 |  34 +++++++
 drivers/remoteproc/remoteproc_cdev.c               |  11 ---
 drivers/remoteproc/remoteproc_core.c               |  15 ++-
 drivers/remoteproc/remoteproc_debugfs.c            |  17 +---
 drivers/remoteproc/remoteproc_elf_loader.c         |   2 +-
 drivers/remoteproc/remoteproc_sysfs.c              |  11 ---
 14 files changed, 240 insertions(+), 182 deletions(-)
