Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A074A49CB78
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241699AbiAZNy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiAZNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:54:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E019C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h21so8379869wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8ZmsjYApuSKFdTLmkU7aSaEGaEf3DeSxo6fmL1z97I=;
        b=owEAHyrdHX91H7nPN4ig7gWV2Pym+Ykf/GtdDHYnWoIJGOghqCM1OT9/Rp/rkfPsze
         utt2fUiG20EUJQ1gqJEBQURSBbnE9bczBSamHGAJa36SCw6YMjVQZpNgxX1PfJ9nCCt/
         hPPmzocXa2tk3UilFoftgXroLUkRn1QkW5Cb+ZidhIdNqG7tyHbP9NkIUuLOLunfB5X2
         qIb7/pvLpA0/e2NldsDOg7gXYaoLvGSHYVVMxZAAbjIww7sAVZHurRdErmcspaPS+RsA
         R6UX0WN8bpWKZ2phyJDFsn2gfPlNCrDSvp95b4XWxID5N91f73Z0wZIajDkytrBhUg2O
         Z+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8ZmsjYApuSKFdTLmkU7aSaEGaEf3DeSxo6fmL1z97I=;
        b=2uu35puOfirtR46zKpjM1PcNqVR+DbUgwM/C2Pj3nf1hep02x92lXebnGc8kmMAr/N
         2MHAxZm3ymLcxyqODKkU4XyA/sLIVhCBqjrF9CmNQ1N2uK0aPTd/VU2IVICfcHVDRPMl
         idt8fFS0q5RUipEgr4IMoht+roNgAb45peusod8AfQhhCB3zq/ofu0LJExn4A/zwfSkp
         d5Zv2UEfPNvpfl+ZBoLwgfW6ogOQA5VtscUmoHwiMaU+HWOA9UAupT1A/msZrOk0DPej
         RUoiT8zNweeyJjNa53zxhgdDMpsyJy5Dirj2+aNpf5a8b3LmZdOu1MIPsYtMZU3IK3nu
         CoCg==
X-Gm-Message-State: AOAM533Z/drpvjxwmJXUhGkRf4+ATXSDw2NY7GeYoJSQ8jV/3tbpzGO1
        YJj9TXCYPN/kvq9u85Mek6m+xA==
X-Google-Smtp-Source: ABdhPJwKbgzXJDYRaAjYdbk+40Tkyl2cUzPjXkjpJbspisPadqP0ZfG2Phn0bdiMbk+gg5yq960HRA==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr14505979wrd.407.1643205265050;
        Wed, 26 Jan 2022 05:54:25 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n15sm3356593wmr.26.2022.01.26.05.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:54:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 00/12] misc: fastrpc: Add missing DSP FastRPC features
Date:   Wed, 26 Jan 2022 13:52:52 +0000
Message-Id: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds below DSP FastRPC features that have been missing in
upstream fastrpc driver and also cleans up channel context structure with kref.

- Add ablity to reflect if the DSP domain is secure/unsecure by creating
 seperate device nodes for secured domain, this would used by SE policy
 to restrict applications loading process on the DSP.
- Add new IOCTL to get DSP capabilites
- Add IOCTL to support mapping memory on the DSP.
- Add support for allocating secure memory for DSP
- Handle fdlist in put args
- Handle dma fds in invoke request.

Tested this series on DragonBoard 845c with TensoFlowLite.

Changes since v2:
- Add support for Secure Memory allocations.
- added handling fdlist and dmalist in and after invoke.
- removed unnecessary debug log
- removed dependency on yaml bindings and added new bindings to .txt


Jeya R (5):
  misc: fastrpc: add support for FASTRPC_IOCTL_MEM_MAP/UNMAP
  misc: fastrpc: Add support to get DSP capabilities
  dt-bindings: misc: add property to support non-secure DSP
  misc: fastrpc: check before loading process to the DSP
  arm64: dts: qcom: add non-secure domain property to fastrpc nodes

Srinivas Kandagatla (2):
  misc: fastrpc: separate fastrpc device from channel context
  misc: fastrpc: add secure domain support

Vamsi Krishna Gattupalli (5):
  dt-bindings: misc: add fastrpc domain vmid property
  misc: fastrpc: Add support to secure memory map
  misc: fastrpc: Add helper function to get list and page
  misc: fastrpc: Add fdlist implementation
  misc: fastrpc: Add dma handle implementation

 .../devicetree/bindings/misc/qcom,fastrpc.txt |  10 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   3 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   3 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |   3 +
 drivers/misc/fastrpc.c                        | 552 ++++++++++++++++--
 include/uapi/misc/fastrpc.h                   |  81 ++-
 8 files changed, 607 insertions(+), 48 deletions(-)

-- 
2.21.0

