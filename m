Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598C249F405
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiA1HFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346648AbiA1HFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:05:34 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F28AC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:05:34 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id w8so4788455qkw.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHLbWiRVBsn87OEDSHKBtxozoDmuxOvqHTO93YKujuA=;
        b=p9e+0lOdrmQSmOrNtBwzqY6EvkM1VH+bwVG+H6TUuKh+3mXIrOjbJd7ov/IJdrSqj1
         +3O/AcA6nqBvee18S1J4NwyhPhALJCGw179DiC+tWJ4TRn6nOIOiNL7t2qe4K2HYpfK3
         FPt7gWutc/KcadXm9IFeYn1nUQovcPnvE+N9vGdZZD/KRj1RUYL9EpCjM7c/4HIT/k0Z
         UBFvQM47+XB23emUyIdnerqwwXo/VNHUJNTlj4Jcd7FH39WGVR4Kd9VBByDD+ekxlr9l
         ygPqD8buMH2c/W9XMSFWDJHUBoMxdj9bOdpsx9riTJSImvnP9AS46EO+yXPOmNE2hwDB
         vh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHLbWiRVBsn87OEDSHKBtxozoDmuxOvqHTO93YKujuA=;
        b=rK6ulZ1xOT8+23YkG13J0XqGgZx0/e4zKqNRXCfFoQF5VxZeWInrT10cCVtWQ4Gtiq
         vew7Q8g4EXJTR00XoW1CgE/eAiHGe8ITMfeH+KOyk/UuQrxPXAFb7Ad6BuF0bctG8s2N
         bRSRbGSTzImf3+B0KN+J7iLc6bvuot5wbN4fwPtRyEcgYF9WoF/6BazExYPemIgUXvW9
         ZRK+y6WkibGFskqeuC3M1H4QXZJBKT7RLbD7Mn6OlXYw3PEsE2HE3qvfNMlw0BrhiN5r
         KcdbH+KcVfTuHv2QRN0dpHR0lAskTodFvZyQJntjv5o125cFA+3xgXaHoHgcFLN2z9Xw
         GcXg==
X-Gm-Message-State: AOAM5321DgKgWDob3Q0T3EEy93YhaSjkmGxxkuMV/mDotsV9cH4YZHmH
        NABQ4X2hOfboG+kb10kUG0s=
X-Google-Smtp-Source: ABdhPJzKObe7p854Wgn8CoPIHd6YoM8+sHDl/QXDiiCv7vlv+XyNBuBuMfU9W8OXx/c2yrBx8rts9g==
X-Received: by 2002:a05:620a:3cf:: with SMTP id r15mr4978842qkm.158.1643353533836;
        Thu, 27 Jan 2022 23:05:33 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s11sm2577422qtw.2.2022.01.27.23.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 23:05:33 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, evan.quan@amd.com, Hawking.Zhang@amd.com,
        andrey.grodzovsky@amd.com, shaoyun.liu@amd.com,
        Jack.Zhang1@amd.com, lijo.lazar@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdgpu: remove duplicate include in 'amdgpu_device.c'
Date:   Fri, 28 Jan 2022 07:05:19 +0000
Message-Id: <20220128070519.1210105-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

'linux/pci.h' included in 'amdgpu_device.c' is duplicated.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dd5979098e63..289c5c626324 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -56,7 +56,6 @@
 #include "soc15.h"
 #include "nv.h"
 #include "bif/bif_4_1_d.h"
-#include <linux/pci.h>
 #include <linux/firmware.h>
 #include "amdgpu_vf_error.h"

--
2.25.1

