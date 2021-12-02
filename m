Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A050466A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376707AbhLBTUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348386AbhLBTT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:19:59 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A9C06174A;
        Thu,  2 Dec 2021 11:16:36 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id j11so732336pgs.2;
        Thu, 02 Dec 2021 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIvVc9UzAzdCz9AdkWnea+gAbAiNOR5uDHyDKu3WgbY=;
        b=Dd6ZI4tPy87vBsH9gdjNVI/4AKh8RYj2BBGqNyxi/IpzlJWUC8ZBgslwGGSnr74Xpa
         tTugp2dHQUBdQO3JDOE8ggG2QjBhC1T/7folmDMnnQ1UcB5VJuYVURTSjFiZsw4AGDzW
         LLjDDic6KjNe6TpfLUpCuzmI2vERRC5LKuqlCQbH0Zocu/kEdcNNlzb49AzLlkZ+JlCf
         QOqA/XhgyXNTNYvOMUe+b4zryLaUuVjPh9ObaybleteEl8ESRWgXoXsk11sH0iNG+NQz
         zvrOMZmPtf7xQ7FkdekLysPRlyk4c/FbVhXBfVlij8ccSkKAE7VZlLpGR7rw4YTPl1pj
         z3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIvVc9UzAzdCz9AdkWnea+gAbAiNOR5uDHyDKu3WgbY=;
        b=zT2720d2zbjMiyixfMkXi0zEjuZsCgGDKxYIj784Cd6ECrCyQYkY/E0cWPv1Fc3gXy
         qw2aFzNtAqZ9zkTIj1H738Qax6DMsETyBjXn+hIcj7+mCgcxIP5wg7XA5aGbgLs7It0C
         H3Zd17HrIB/LrTxGoM9H+RGgw66dqFcveOEEzMXgHBoVbOtGiusDuGAJjm9L8G3VIral
         gzfwTDIYeO2dmtZ78oxxsNnlE07+uYr80Dv4gfsOzu4ym+E5o35hy5GfWJj+75rp4wVh
         RksMF5Phi4puET7wpBrKbmhTaZAriXkFINzs0NPUMFowJkYdgHd+k39cu4Nq8zW7Sout
         zlXA==
X-Gm-Message-State: AOAM532vF5FLZWSPmfitcUngWz3QHRrQ/TZQoDwr5RW71xgWgilehLPV
        tX0dyOC69C53VHs3lw0pwTU=
X-Google-Smtp-Source: ABdhPJzSF9McZwh7hSAJ32DTE3jgq5yPSGbCRWaxmbEij3y927XaXHA+ul8uQkNPpmVoJTflN2IQqQ==
X-Received: by 2002:a05:6a00:2283:b0:49f:dea0:b9ba with SMTP id f3-20020a056a00228300b0049fdea0b9bamr14444920pfe.56.1638472595586;
        Thu, 02 Dec 2021 11:16:35 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:517f:74c7:9fe9:b5e8])
        by smtp.gmail.com with ESMTPSA id x14sm289897pjl.27.2021.12.02.11.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:16:35 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v2 0/5] platform: surface: Introduce Surface XBL Driver
Date:   Thu,  2 Dec 2021 11:16:25 -0800
Message-Id: <20211202191630.12450-1-jaschultz@microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the Surface Extensible Boot Loader driver for the Surface Duo.
Exposes information about the driver to user space via sysfs.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>

---

Changes in v3:
 - For the yaml documentation:
    * Updated description
    * Fixed examples
    * Updated 'required' field
 - Further propogated ACPI dependency in Kconfigs
 - Updated sysfs several binding descriptions
 - Renamed files to conform to naming conventions

---

Changes in v2:
 - Per Maximilian, added patch 2: propagated ACPI dependency from the
   directory as a whole to each individual driver
 - For the yaml documentation:
    * Removed json-schema dependence
    * Elaborated on description of driver
    * Updated example
 - Changed target KernelVersion in sysfs documentation
 - Updated MAINTAINER changes to be properly applied across patches
 - For the driver itself,
    * Added types.h inclusion and removed unused inclusions
    * Minor updates to code and acronym style
    * Remove __packed attribute on driver struct
    * Use .dev_groups for sysfs
 - Added more in-depth description of driver in Kconfig
 - Modified dts to reference a newly added section in sm8150.dtsi

---
Jarrett Schultz (5):
  dt-bindings: platform: microsoft: Document surface xbl
  platform: surface: Propagate ACPI Dependency
  platform: surface: Add surface xbl
  arm64: dts: qcom: sm8150: Add imem section
  arm64: dts: qcom: surface-duo: Add surface xbl

 .../ABI/testing/sysfs-platform-surface-xbl    |  79 ++++++++
 .../platform/microsoft/surface-xbl.yaml       |  69 +++++++
 MAINTAINERS                                   |   9 +
 .../dts/qcom/sm8150-microsoft-surface-duo.dts |  10 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   8 +
 drivers/platform/surface/Kconfig              |  19 +-
 drivers/platform/surface/Makefile             |   1 +
 drivers/platform/surface/aggregator/Kconfig   |   1 +
 drivers/platform/surface/surface_xbl.c        | 186 ++++++++++++++++++
 9 files changed, 381 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-surface-xbl
 create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
 create mode 100644 drivers/platform/surface/surface_xbl.c

-- 
2.25.1

