Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF158CD8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiHHSXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiHHSX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:23:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6D313DEF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:23:27 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j5so5567385oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qumghsVwVyc/1cec+TpMNR9E2GdUtY0tpWdgXYmrSkA=;
        b=u0P7hxg16bYMDaZ5QkebYN5ijyP8/FMa/XFXqAm+TxX3l9JF7y5KK0WFzt0HzbOTfe
         7LUStqW85N9LtJ4NpvIW2CnZMbaNoeh7pztQ9njApqJ5VFz12ubHawJhQcS1E9BjhEIc
         qzpDlF43VuNDIvaea330NAV0mbx9Dpgp+tW73naziwT1/WoWIGek0u94Db0kh/kEI8zr
         xfdXxkni86+OoGJnoeJb+ah/msuN4qCqXbbUAO9BDK9HSEpeTHx8/MpTYqDEYzUVBd2p
         jsweogkTG6ulKlAcHGMOJ9hBhGDdOOGAk9IGcWhmN42fCuWZadkSLXq6Kr75LoJTl7Ka
         3U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qumghsVwVyc/1cec+TpMNR9E2GdUtY0tpWdgXYmrSkA=;
        b=uHlMFbpJ+36gqZslOAZsOhRskth+a5ua6Srrj8NDmNNaArZGYSctaKLgvl3GI3ZhA5
         Tan04sRgYVz+/4pMS4+u/qNxrYfI3MS/y/5f2Zg4rXP1sbGsYb8P/XyNK4KYqxa996/j
         iB1ugyW8OnOw3W8Y+DaM1NH8Ru/Aq90/VmB2ABIgipv1hhFH8ENlqR2n+BodtwIBfKqb
         9cLivY4BIXd7QvJhHpKbCOBcaodWsddj9jLH2add5kayClpmD8aCzGab2jyU6v3psuo/
         vrbIftwGlFl9Uh8joJCD9QfMRHo+00lgDaauDtRlZrjwkRpJnFhWVcdF2vbCHxnbigjJ
         hmtw==
X-Gm-Message-State: ACgBeo1hoG6oZkuo0WTnmv7HIzD1i6BUjZpBZgcQp6XR04JSIga7UpJl
        cNLp9RT9gxIP4Oc2p657atw/iw==
X-Google-Smtp-Source: AA6agR7/cBx5jUBwldJoWxB/aaZEgF7DlbKue6OZiCSUGgzdM9a2Weu8+Wy+8wgk9W76fm9tir0YHA==
X-Received: by 2002:a05:6808:302c:b0:339:ee90:94df with SMTP id ay44-20020a056808302c00b00339ee9094dfmr11521637oib.193.1659983006909;
        Mon, 08 Aug 2022 11:23:26 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v2-20020a056808004200b00342fedaf7d9sm461695oic.43.2022.08.08.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:23:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Hangyu Hua <hbh25y@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Saud Farooqui <farooqui_saud@hotmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [GIT PULL] rpmsg updates for v5.20
Date:   Mon,  8 Aug 2022 13:23:25 -0500
Message-Id: <20220808182325.2104359-1-bjorn.andersson@linaro.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.20

for you to fetch changes up to 7113ac825371c17c15e2d0be79d850e5e16d3328:

  rpmsg: convert sysfs snprintf to sysfs_emit (2022-07-16 23:08:47 -0500)

----------------------------------------------------------------
rpmsg updates for v5.20

This contains fixes and cleanups in the rpmsg core, Qualcomm SMD and
GLINK drivers, a circular lock dependency in the Mediatek driver and the
a possible race condition in the rpmsg_char driver is resolved.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      rpmsg: mtk_rpmsg: Fix circular locking dependency

Arnaud Pouliquen (1):
      rpmsg: Fix parameter naming for announce_create/destroy ops

Hangyu Hua (1):
      rpmsg: Fix possible refcount leak in rpmsg_register_device_override()

Krzysztof Kozlowski (3):
      rpmsg: qcom: glink: replace strncpy() with strscpy_pad()
      rpmsg: qcom: glink: remove unused name
      rpmsg: qcom: correct kerneldoc

Miaoqian Lin (1):
      rpmsg: qcom_smd: Fix refcount leak in qcom_smd_parse_edge

Saud Farooqui (1):
      rpmsg: Strcpy is not safe, use strscpy_pad() instead

Shengjiu Wang (1):
      rpmsg: char: Add mutex protection for rpmsg_eptdev_open()

Xuezhi Zhang (1):
      rpmsg: convert sysfs snprintf to sysfs_emit

 drivers/rpmsg/mtk_rpmsg.c         |  2 ++
 drivers/rpmsg/qcom_glink_native.c | 10 ++--------
 drivers/rpmsg/qcom_glink_ssr.c    |  2 +-
 drivers/rpmsg/qcom_smd.c          |  9 +++++----
 drivers/rpmsg/rpmsg_char.c        |  7 ++++++-
 drivers/rpmsg/rpmsg_core.c        |  3 ++-
 drivers/rpmsg/rpmsg_internal.h    |  4 ++--
 7 files changed, 20 insertions(+), 17 deletions(-)
