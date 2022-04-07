Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5774F7937
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbiDGIQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiDGIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:16:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5971D253C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:14:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g20so5477518edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uuPCrvHDkvmkaWKFBJeZIWghlVm/xXawdQ6pGCSJBsY=;
        b=X76cHWHH+dKO15k7nRs696qFHOComkQcq5VyssHr/p36pNENkVdOithAKx3GTruA4l
         u8wb0yE8g7u/vEm4BZ+ublqst3AvzTGVsyPmFehSAAm+aG5VLzh460t0e5CSLcI2GxNh
         NgHj5lWAjA2kuV9/sY1lhGnzw8B0p/mFK7ddFasN9xIJuLaxhj1XPVMwb0aKLWP7AnyS
         cZLDWhiPZ+3mW7ie8f2UeMtZjCTuj8hDcPdG9RW+aLE5/QRmjyWVx57t6M53EqQ1jJAJ
         zcqqCy8Sqdid/tnG0Qfr/ORHTNN8/H+BBdW+K6TISwmSyPJqLrI8Bl/drRUqMZf0H0iS
         BifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uuPCrvHDkvmkaWKFBJeZIWghlVm/xXawdQ6pGCSJBsY=;
        b=tHJkvAIzXbIhTUPsIGfZ3qK/8u3phjA991ithheM3pcL6hOk1ohK4Wz5/UduGZtHdK
         Tv/MDCN7cb7okXEEeYgGLvbqj1hvxvPWN5pjath2ZVxXtvb0/PqJWJqJsMCDjU2ny8T3
         aLmqxC1QUU6rgUg7f2kYqYbvLhezCMtKWheqcET4+ew4bcEJXPJoahZKmLThP7xwaPtA
         vLsTF4JmedDMPqlhVjvf9/f5oFbpr30mBvbBTIWRNqYCaxhUcdGmcfaeKDOZLv7p/5j0
         7fBmums+4ZU6U3e7SBcXw4CTDwCOJCPvAwXMWicP7HUGqHtCsGon4d9vow8EQ82N6piK
         lKIA==
X-Gm-Message-State: AOAM531Nymj/W7ur9mlQ+eataHbLyXYSbsEncD3j/gmDQKwQc7CRRDLG
        dUSOtpFd/fy2/VV6t6qCqms/BA==
X-Google-Smtp-Source: ABdhPJwaxJSzvu7XogoiRn/oibfelC9c2fpnLOfco3bPP29ZKDL2pqIOiV7f5CgICkKrJMwAzRa8Qg==
X-Received: by 2002:aa7:db18:0:b0:41c:e010:a07f with SMTP id t24-20020aa7db18000000b0041ce010a07fmr12822787eds.281.1649319292623;
        Thu, 07 Apr 2022 01:14:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090626da00b006e7cb663277sm4956566ejc.90.2022.04.07.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:14:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: Fixes for v5.18 (current cycle)
Date:   Thu,  7 Apr 2022 10:14:48 +0200
Message-Id: <20220407081448.113208-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fixes for v5.18, please. One is recently introduced, others were already
existing.

Best regards,
Krzysztof


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-fixes-5.18

for you to fetch changes up to dd8adc713b1656ce469702eba8fc1adc4db91dc4:

  memory: fsl_ifc: populate child nodes of buses and mfd devices (2022-04-06 09:39:16 +0200)

----------------------------------------------------------------
Memory controller drivers - fixes for v5.18

Issues in v5.18:
1. Freescale/NXP: fix populating children of Integrated Flash Controller
   DT nodes.

Issues existing before:
1. Renesas: fix platform-device leak in probe's error path.
2. Atmel: fix of_node reference leak in probe's error path.
3. Synopsys: correct the bindings for snps,ddrc-3.80a (interrupts are
   required).

----------------------------------------------------------------
Johan Hovold (1):
      memory: renesas-rpc-if: fix platform-device leak in error path

Li Yang (1):
      memory: fsl_ifc: populate child nodes of buses and mfd devices

Miaoqian Lin (1):
      memory: atmel-ebi: Fix missing of_node_put in atmel_ebi_probe

Sherry Sun (1):
      dt-bindings: memory: snps,ddrc-3.80a compatible also need interrupts

 .../memory-controllers/synopsys,ddrc-ecc.yaml      |  6 ++++--
 drivers/memory/atmel-ebi.c                         | 23 ++++++++++++++++------
 drivers/memory/fsl_ifc.c                           |  3 +--
 drivers/memory/renesas-rpc-if.c                    | 10 +++++++++-
 4 files changed, 31 insertions(+), 11 deletions(-)
