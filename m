Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB14B09F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiBJJtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:49:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbiBJJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:49:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB666BEF;
        Thu, 10 Feb 2022 01:49:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so8398993wrc.13;
        Thu, 10 Feb 2022 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBJtKcMcmZW3d1ZPmF8edX1mvxTQJq2besnPp14ia5M=;
        b=cpBWfnfF0O/nqwqnGqlQCLy7oQbPyZxV9HvKc2RhN6EwvGtr9rBI2EQ8Gl49d6AK8I
         ngS87oN23MIu3/nt5aFJrlKXZARfn47qyRow4o535W1LlhbwhLHTBpjk9Lcf/pxViWYJ
         Mu8YlJCUyyaYLBGV2tGUyZQ27dUOAYxDaDom8nDbbVYrI0ck1r5kdA39rjMy3KBbddBV
         F1Q9iVY2dPRie2dExOOE2KNUjb1994G6XHv+pmFSqBemiLYv/SbYdooBEnikyC9swxhk
         ZDfyp7Ze+h5zKxUHw7ZY8fztcHDwEbuV1Xs2uxVhNgahNrGm6wcksRFYdISOk+Rll04R
         EEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBJtKcMcmZW3d1ZPmF8edX1mvxTQJq2besnPp14ia5M=;
        b=5iORSsUmUQ2WgCQzETrTLFJxd/S5zRUxHDd6Yw0BgGCWR2/GIcaHsl1umt/nMUmAMA
         3pmdEZvi1Wd74oZMTFxhR1Qulr4qBZgQy3jUHhYnH+3seisfZ9k2PwWmm7n+jBHRxFTF
         zvGq6c3v4ZjOHs/TSaTlYO6UppYRCD7AJWpvNKZBnGrz8oiC7YoSxzXLSNGATyhKBCYa
         rlGn6jBoQl+jF66JxHqQdAppl26xJRWO+ZdkAfawPG0r6uIxMTYTi7R2FO3UnKXLphSf
         Im9u6p+RWTdWiGJZ9klBndRyOH5iY98xggqnCaHdZdpY0fMVYwDDlcXqLabTshW+Q6g0
         KVvw==
X-Gm-Message-State: AOAM531J6a0doG/RnzbA/qbN5+65lEDBQ8MuTtEYfB3Vb7Jht8eGbu+Z
        QGKm2VZDSHIowftLUbh2dhi9C02eJO8=
X-Google-Smtp-Source: ABdhPJz1VCYhQsQTa9UPD5KfY24dvxGmN1T/pbCtpTvCDc2zMutDOos22+B22MoRRgabZn0jY2Zyrw==
X-Received: by 2002:adf:f981:: with SMTP id f1mr5622867wrr.651.1644486541117;
        Thu, 10 Feb 2022 01:49:01 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id j6sm6636601wrt.70.2022.02.10.01.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:49:00 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: [PATCH v9 0/2] clk: ralink: make system controller a reset provider
Date:   Thu, 10 Feb 2022 10:48:57 +0100
Message-Id: <20220210094859.927868-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series add minimal change to provide mt7621 resets properly
defining them in the 'mediatek,mt7621-sysc' node which is the system
controller of the SoC and is already providing clocks to the rest of
the world.

There is shared architecture code for all ralink platforms in 'reset.c'
file located in 'arch/mips/ralink' but the correct thing to do to align
hardware with software seems to define and add related reset code to the
already mainlined clock driver.

After this changes, we can get rid of the useless reset controller node
in the device tree and use system controller node instead where the property
'#reset-cells' has been added. Binding documentation for this nodeq has
been updated with the new property accordly.

This series also provide a bindings include header where all related
reset bits for the MT7621 SoC are defined.

Also, please take a look to this review [0] to understand better motivation
for this series.

These remaining two are expected to go through the staging tree since there
was a dts file conflict and dependencies with driver code.

Changes in v9:
 - Drop already applied patchs in staging-tree 1, 4 of previous version of the series.
 - Collect Stephen Boys Acked-by for remaining patches.
 - Collect Philipp Zabel Reviewed-by for reset changes in driver code.

Changes in v8:
 - PATCH 3/4: with .of_xlate set, the driver needs to check whether id < nr_resets
   on its own.

Changes in v7:
 - PATCH 3/4: make use of '.of_xlate' callback as per Philipp v6 review.

Changes in v6:
 - Rebased on the top of last changes of staging-testing to properly
   update dtsi file (PATCH 4/4).
 - Send a copy of this to reset provider maintainer Philipp as per Stephen's sugestion
   to get changes added through the clk tree (Philipp, thanks in advance for reviewing
   this).

Changes in v5:
 - Move platform driver init process into 'arch_initcall' to be sure the
   rest of the world can get the resets available when needed (since PCIe
   controller driver has been moved from staging into 'drivers/pci/controller'
   is probed earlier and reset was not available so it was returning 
   -EPROBE_DEFER on firt try. Moving into 'arch_initcall' avoids the 'a bit
   anoying' PCI first failed log trace.

Changes in v4:
 - I sent wrong patch 3 accidentaly so now include the good version, sorry.

Changes in v3:
 - Collect Rob's Acked-by for patches 1 and 2. 
 - Rebase on the top of staging-next since there were already many
   changes there and PATCH 4 of the series didn't apply cleanly.

Changes in v2:
 - Address review comments of Dan Carpenter [1]:
 - Avoid 'inline' in function definition.
 - Return proper error codes (-EINVAL) instead of '-1'.
 - Make use of 'devm_kzalloc' instead of 'kzalloc'.

[0]: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210926145931.14603-3-sergio.paracuellos@gmail.com/

Best regards,
   Sergio Paracuellos

Sergio Paracuellos (2):
  dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
  clk: ralink: make system controller node a reset provider

 .../bindings/clock/mediatek,mt7621-sysc.yaml  | 12 +++
 drivers/clk/ralink/clk-mt7621.c               | 92 ++++++++++++++++++-
 2 files changed, 103 insertions(+), 1 deletion(-)

-- 
2.25.1

