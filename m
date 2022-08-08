Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAB58CE34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbiHHTBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbiHHTAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:00:44 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91A10D2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:00:42 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u9so11348250oiv.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=78BKn7qeyMuZq/nBbXsEZdC7K4WoTnDR72eCBOZ4cQk=;
        b=fNn0xQPJl7I54FDMVw9g5Fy2pyB9k3cwiFukA25DO4KT8JONQJQYUe1zasFBsYeoM8
         P6IqioLYdzkFC7S+QHrtZwxvtsOHGuo0hMyft2tznZb3xg5UQ1PkZBD3sJplzjiXo2R+
         XOcE+IVlr7NiRECFDjwWYPYtOc0fw6x9KaNteWde8NLg72aNFIJqdZSdmizvXvOvXd1S
         8H244Qw5em9GAdPiQIDWm6gN+ZRFjyTtNMfYE8D3e4FkFfTQfKcZs/8IZ008Gv+OtE5S
         ULm28/ZWGX65qf3dcbj4cBh8MxV6jZgOzdH/Xqni3YJcH5DfcBawtjpmMy8vrMzqJo2p
         gqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=78BKn7qeyMuZq/nBbXsEZdC7K4WoTnDR72eCBOZ4cQk=;
        b=36LmZeZC9xfOsmugFRlSBhv94cu5lrTK6sqypuOmCJgqSqUJqxmjgvlj02R4sKfTAk
         bFyHSb9pC9Wwd1/Qa/DGIrFgzkJUZZzqoaW0g4zVyJstFBezsPh6q7tMOQzeh5JVKFO7
         A3GtOwlnuT4JYWN8HWR7jr/nZNMrUs0oAh107hfXuajmIxh4rHTk1kqffziAlvPfqSWO
         zZHAXgvY+mHl1Rav08C6YGyr8suqFPiWY/7YT9H9riEUS/vsaYD2mtay0GWXFPT5l09n
         6k1/1OLN6UkEOSvhBqQSZG9WFkDN1SgilwpS9DCIrRAgsojWkFJG6fCYjfGQmM/1gTp+
         S2pQ==
X-Gm-Message-State: ACgBeo2ZGeja5nxO9kpqvzLVLX5G5DjmoaiKsoaA9XYXf+OWb4MKXNY8
        6eDMbKmi2rH6kla+fMGoQgahqg==
X-Google-Smtp-Source: AA6agR46jRFxbOvzGFQgMIxpT2BXX6H0lmqqi8zZ/KAqa4h3RFAiy7tbW+1mFf/773QFgDRyPoeWhg==
X-Received: by 2002:aca:905:0:b0:342:e38a:7314 with SMTP id 5-20020aca0905000000b00342e38a7314mr3694184oij.23.1659985241555;
        Mon, 08 Aug 2022 12:00:41 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l5-20020acabb05000000b00342d18cc2fdsm1323898oif.53.2022.08.08.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:00:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Xiang wangx <wangxiang@cdjrlc.com>, keliu <liuke94@huawei.com>,
        ran jianping <ran.jianping@zte.com.cn>,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [GIT PULL] remoteproc updates for v5.20
Date:   Mon,  8 Aug 2022 14:00:39 -0500
Message-Id: <20220808190039.2106786-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.20

for you to fetch changes up to 8447d0e75099eb54eea9306c2d43ecfc956d09ed:

  remoteproc: qcom_q6v5_pas: Do not fail if regulators are not found (2022-08-08 10:32:17 -0500)

----------------------------------------------------------------
remoteproc updates for v5.20

This introduces support for the remoteproc on Mediatek MT8188, and
enables caches for MT8186 SCP. It adds support for PRU cores found on
the TI K3 AM62x SoCs.

It moves the recovery work after a firmware crash to an unbound
workqueue, to allow recovery to happen in parallel.

A new DMA API is introduced to release dma_mem for a device.

It adds support a panic handler for the Qualcomm modem remoteproc, with
the goal of having caches flushed in memory dumps for post-mortem
debugging and it introduces a mechanism to wait for the modem firmware
on SM8450 to decrypt part of its memory for post-mortem debugging.

Qualcomm sysmon is restricted to only inform remote processors about
peers that are actually running, to avoid a race where Linux tries to
notify a recovering remote processor about its peers new state. A
mechanism for waiting for the sysmon connection to be established is also
introduced, to avoid out-of-sync updates for rapidly restarting remote
processors.

A number of Devicetree binding cleanups and conversions to YAML are
introduced, to facilitate Devicetree validation. Lastly it introduces a
number of smaller fixes and cleanups in the core and a few different
drivers.

----------------------------------------------------------------
Abel Vesa (1):
      remoteproc: qcom_q6v5_pas: Deal silently with optional px and cx regulators

Allen-KH Cheng (1):
      remoteproc: mediatek: Enable cache for mt8186 SCP

Dmitry Baryshkov (1):
      remoteproc: qcom: q6v5-mss: add powerdomains to MSM8996 config

Kishon Vijay Abraham I (3):
      dt-bindings: remoteproc: pru: Re-arrange "compatible" in alphabetic order
      dt-bindings: remoteproc: pru: Update bindings for K3 AM62x SoCs
      remoteproc: pru: Add support for various PRU cores on K3 AM62x SoCs

Krzysztof Kozlowski (8):
      dt-bindings: remoteproc: remove unneeded ref for names
      dt-bindings: remoteproc: qcom,adsp: add interconnects
      dt-bindings: remoteproc: qcom,adsp: simplify interrupts
      dt-bindings: remoteproc: qcom,adsp: simplify SM8150 power domains
      dt-bindings: remoteproc: qcom,adsp: use GIC_SPI defines in example
      dt-bindings: remoteproc: qcom,glink-edge: define re-usable schema for glink-edge
      dt-bindings: remoteproc: qcom,smd-edge: define re-usable schema for smd-edge
      remoteproc: qcom: correct kerneldoc

Luca Weiss (1):
      dt-bindings: remoteproc: qcom: q6v5: fix example

Manivannan Sadhasivam (1):
      remoteproc: qcom_q6v5_pas: Do not fail if regulators are not found

Mark-PK Tsai (2):
      dma-mapping: Add dma_release_coherent_memory to DMA API
      remoteproc: Fix dma_mem leak after rproc_shutdown

Miaoqian Lin (2):
      remoteproc: k3-r5: Fix refcount leak in k3_r5_cluster_of_init
      remoteproc: imx_rproc: Fix refcount leak in imx_rproc_addr_init

Minghao Chi (1):
      remoteproc: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Mukesh Ojha (1):
      remoteproc: Use unbounded workqueue for recovery work

Ren Zhijie (1):
      dma-mapping: Fix build error unused-value

Sibi Sankar (7):
      dt-bindings: remoteproc: qcom: Convert SC7280 MSS bindings to YAML
      dt-bindings: remoteproc: qcom: Convert SC7180 MSS bindings to YAML
      remoteproc: qcom_q6v5_mss: map/unmap metadata region before/after use
      remoteproc: qcom_q6v5_mss: Update MBA log info
      remoteproc: qcom_q6v5: Introduce panic handler for MSS
      remoteproc: qcom: pas: Add decrypt shutdown support for modem
      remoteproc: sysmon: Wait for SSCTL service to come up

Siddharth Gupta (5):
      remoteproc: qcom: pas: Mark va as io memory
      remoteproc: qcom: pas: Mark devices as wakeup capable
      remoteproc: qcom: pas: Check if coredump is enabled
      remoteproc: qcom: q6v5: Set q6 state to offline on receiving wdog irq
      remoteproc: sysmon: Send sysmon state only for running rprocs

Sireesh Kodali (1):
      remoteproc: qcom: wcnss: Fix handling of IRQs

Tinghan Shen (2):
      dt-bindings: remoteproc: mediatek: Add binding for mt8188 scp
      remoteproc: mediatek: Support MT8188 SCP

Xiang wangx (1):
      remoteproc: omap_remoteproc: Fix typo in comment

keliu (1):
      remoteproc: Directly use ida_alloc()/free()

ran jianping (1):
      remoteproc: qcom: using pm_runtime_resume_and_get to simplify the code

wangjianli (1):
      drivers/remoteproc: fix repeated words in comments

 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   2 +
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |  74 +++---
 .../bindings/remoteproc/qcom,glink-edge.yaml       |  72 ++++++
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  88 ++-----
 .../bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml  |   1 -
 .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml   | 245 +++++++++++++++++++
 .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 266 +++++++++++++++++++++
 .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  |  21 +-
 .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  |   1 -
 .../bindings/remoteproc/qcom,smd-edge.yaml         |  85 +++++++
 .../bindings/remoteproc/ti,pru-rproc.yaml          |   5 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |  50 +---
 drivers/remoteproc/imx_rproc.c                     |   7 +-
 drivers/remoteproc/keystone_remoteproc.c           |   3 +-
 drivers/remoteproc/mtk_scp.c                       |  23 +-
 drivers/remoteproc/omap_remoteproc.c               |   6 +-
 drivers/remoteproc/pru_rproc.c                     |   1 +
 drivers/remoteproc/qcom_common.c                   |   4 +-
 drivers/remoteproc/qcom_q6v5.c                     |   4 +
 drivers/remoteproc/qcom_q6v5_adsp.c                |   3 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |  54 ++++-
 drivers/remoteproc/qcom_q6v5_pas.c                 | 105 ++++++--
 drivers/remoteproc/qcom_sysmon.c                   |  16 +-
 drivers/remoteproc/qcom_wcnss.c                    |  10 +-
 drivers/remoteproc/remoteproc_core.c               |  24 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c           |   2 +
 include/linux/dma-map-ops.h                        |   3 +
 kernel/dma/coherent.c                              |  10 +-
 28 files changed, 958 insertions(+), 227 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
