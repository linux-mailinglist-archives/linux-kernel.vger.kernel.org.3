Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0730148E479
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiANGw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiANGwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:52:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F87C061756
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:52:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q8so13904847wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aCUMeN/pwTcI/jyjtGOazClrsdePBfCZ+NCC3aiwEs=;
        b=aUKBmK/6hNZ2b+ctMk82PTZdXNBuzhcJZQReqNLHaSdJsdLJ2NGTwLMC2Wk+d3NNNR
         clvqKdXxFA8IfvDv0yNh+ng/RUFL8rtFENQVe/VsHkEXo+BQDrQBqsMfMxOJPEU/op5N
         koDJuv5TGWxT30DxXrRc9FEPdCiHPakienRqWKbqfNxTKG5o+a4A8ZuRWz5CSE6Jr8u1
         tidDwMvOkZADGChPdI5d95nxtyHSaxu+961rz2oovYTeEiYtmywkoF2ZoKGrlH2RDbrb
         dDEjEsxHPjnhfMCI7etCUQLB3ehiSXuLPtMgXUUVoZ2zLpuGZbm57QJG0KJyDbg1YppP
         AwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aCUMeN/pwTcI/jyjtGOazClrsdePBfCZ+NCC3aiwEs=;
        b=sZ6llyevzKB5uExBsOd05fM9O0QgaRDwp8odFiTFb0sjYpBWojPQJPunvrc/VZNQ3a
         yJVaOZ26Euk3YuER7dupTOTTSC3jaOWvgLdnP4n+KyteuwD3ezMr4Xe9oSHIgFhmMcI9
         6d+NF0AGvzbpD1RDnUdRiLtteA5V2njnqFuGr6s9TJabq2dtTFwr1XZ923d4cRTF7bfO
         oIzmQWc4D6OEEDDvFYdGTTvE7edEtwX1bUcKiVG7E8imHFbQnaw9zIPxLoX2bzXChchz
         5y8tnxLSxrTWhOfoGa0Lha9e1Q4UcAuwuWTZsyFTfY2W8exGv+ZkDnhdAurfcZMFeFle
         /kZw==
X-Gm-Message-State: AOAM533QxRfnmf+lD+wGyMyanHAebucFusK7qdgtTGvakaRpZh2m4kCg
        Elfs3SlwAjyS2kwzEMZzUc8=
X-Google-Smtp-Source: ABdhPJxfoWycRSPJTt9RbgHaKC2zlzA1CwchyupHnqyvPMjwVA1z+jBZI5L/jsmjtYSdazMaPF5WTA==
X-Received: by 2002:a5d:4343:: with SMTP id u3mr6705543wrr.504.1642143138969;
        Thu, 13 Jan 2022 22:52:18 -0800 (PST)
Received: from lukas-pc.fritz.box (p200300f6671a9600e06cd1ebd7837a58.dip0.t-ipconnect.de. [2003:f6:671a:9600:e06c:d1eb:d783:7a58])
        by smtp.gmail.com with ESMTPSA id e12sm897903wrg.33.2022.01.13.22.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:52:18 -0800 (PST)
From:   Lukas Fink <lukas.fink1@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lukas Fink <lukas.fink1@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix rejecting Tahiti GPUs
Date:   Fri, 14 Jan 2022 07:51:41 +0100
Message-Id: <20220114065141.14506-1-lukas.fink1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device") added
generic bindings to amdgpu so that that it binds to all display class devices
with VID 0x1002 and then rejects those in amdgpu_pci_probe.

Unfortunately it reuses a driver_data value of 0 to detect those new bindings,
which is already used to denote CHIP_TAHITI ASICs.

The driver_data value given to those new bindings was changed in
dd0761fd24ea1 ("drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by default")
to CHIP_IP_DISCOVERY (=36), but it seems that the check in amdgpu_pci_probe
was forgotten to be changed. Therefore, it still rejects Tahiti GPUs.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1860
Fixes: eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device")

Signed-off-by: Lukas Fink <lukas.fink1@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9ec58bf74012..224d073022ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1903,7 +1903,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
 
-	if (flags == 0) {
+	if (flags == CHIP_IP_DISCOVERY) {
 		DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
 		return -ENODEV;
 	}
-- 
2.34.1

