Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516FB46F491
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhLIUJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhLIUJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:09:17 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430FCC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:05:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k2so10700442lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vdi+ngDYZ8frSITjIEVRzjOKqqv9jxuC3qoXZDRzY3E=;
        b=POI/206AdEE7Y8xM46ArhvWFzWMc2DNrU+UafFP+UOclIvQYLxk1wmsBw/yyS/2aJq
         S5CpimmLVPKLGv1qeaK8y9ZSZWPbUrwWz0U9F23hBFzZMNnqPiSgGl6i4yrjddpeoM+4
         pCbv8bG+8PORW01axAIL0xFxcCuYd/SxoZ6D83LMnf0JeYB3FzzmLDoqQYGTBLtxMEcP
         AqUoKYkz+sQ323/QBMVXkSS+NhUo2aqU24AfJZE57ACd8ve3kXXj62V6znNiezs+Qw1u
         72Nkmrzzg3J90EBkRxkscukCm+D95/mVkCa9cL3RnL2xd6tVyz3BvuskJvsUpaKNUpzK
         u5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vdi+ngDYZ8frSITjIEVRzjOKqqv9jxuC3qoXZDRzY3E=;
        b=GHS9hYJM/NL85mboFFm6l7CPI/mPyV7rO4xRPIrM/i60cwEeiGaf5LclrF1YnSQSMy
         DzCfXoPvU/yls2tvFuj83yfAgV0zzgJCwpp2VGcFt9lyO6ztTmDGRLA+V+LVARe+71y3
         L1tOxNgf+dj8SShizl5dMKO8X/qHnmghmAGieRXj1ytto+PJfgwwwfhnzgmK/oiP2CIj
         FU+Lv2iyNqYI2hVXz1E8Qnlr3Gnp643jZe91iGolwcafDMBZQb/6i84u1qLhUqwg6NT6
         koHq/yLnukW/HaXrtPvIixBtTOk/Q76EE1el/kMU935OHiSAvZMnyrdfay4g4nWvVONP
         mYTQ==
X-Gm-Message-State: AOAM532jz3NcH/4NsOHOU63Ks3RCoTXg5KTZ87GOLJ+/jxkKBOGozZPr
        3e7RRHc/4B/9jj/xIMe/CFg=
X-Google-Smtp-Source: ABdhPJxucGuWwfKQW2OEY9Dp9Wft8deEcKtIdgf1+XzoXquMxrrE4dy0sBiatCkpQLtPu/fTSAEpFw==
X-Received: by 2002:a2e:530d:: with SMTP id h13mr8398300ljb.95.1639080341326;
        Thu, 09 Dec 2021 12:05:41 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id o12sm87371lft.134.2021.12.09.12.05.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 12:05:40 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>
Subject: [PATCH V4 0/6] xen: Add support of extended regions (safe ranges) on Arm
Date:   Thu,  9 Dec 2021 22:05:30 +0200
Message-Id: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Hello all.

You can find the RFC-V3 patch series at [1],[2] and [3].

The corresponding Xen support (for both Dom0 and DomU) is already committed and
is available in mainline Xen since the following commit:
57f87857dc2de452a796d6bad4f476510efd2aba libxl/arm: Add handling of extended regions for DomU

The extended region (safe range) is a region of guest physical address space
which is unused and could be safely used to create grant/foreign mappings instead
of ballooning out real RAM pages to obtain a physical address space for creating
these mappings (which simply results in wasting domain memory and shattering super
pages in P2M table).

The problem is that we cannot follow Linux advise which memory ranges are unused
on Arm as there might be some identity mappings in P2M table (stage 2) the guest is not
aware of or not all device I/O regions might be known (registered) by the time the guest
starts creating grant/foreign mappings. This is why we need some hints from the hypervisor
which knows all details in advance to be able to choose extended regions (which won't
clash with other resources).

The extended regions are chosen at the domain creation time and advertised to it via
"reg" property under hypervisor node in the guest device-tree [4]. As region 0 is reserved
for grant table space (always present), the indexes for extended regions are 1...N.
No device tree bindings update is needed, guest infers the presence of extended regions
from the number of regions in "reg" property.

Please note the following:
- The ACPI case is not covered for now
- patch series was created in a way to retain existing behavior on x86

The patch series is based on v5.16-rc3 and also available at [5], it was fully
tested on Arm64 and only compile tested on x86.

[1] https://lore.kernel.org/all/1627490656-1267-1-git-send-email-olekstysh@gmail.com/
    https://lore.kernel.org/all/1627490656-1267-2-git-send-email-olekstysh@gmail.com/
[2] https://lore.kernel.org/all/1635264312-3796-1-git-send-email-olekstysh@gmail.com/
[3] https://lore.kernel.org/all/1637787223-21129-1-git-send-email-olekstysh@gmail.com/
[4] https://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/arm/device-tree/guest.txt;hb=refs/heads/master
[5] https://github.com/otyshchenko1/linux/commits/map_opt_ml7

Oleksandr Tyshchenko (6):
  xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
  arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
  xen/balloon: Bring alloc(free)_xenballooned_pages helpers back
  xen/unpopulated-alloc: Add mechanism to use Xen resource
  arm/xen: Read extended regions from DT and init Xen resource
  dt-bindings: xen: Clarify "reg" purpose

 Documentation/devicetree/bindings/arm/xen.txt |  14 +--
 arch/arm/xen/enlighten.c                      | 132 ++++++++++++++++++++++++--
 drivers/xen/Kconfig                           |   2 +-
 drivers/xen/balloon.c                         |  20 ++--
 drivers/xen/unpopulated-alloc.c               |  87 ++++++++++++++++-
 include/xen/balloon.h                         |   3 +
 include/xen/xen.h                             |  16 ++++
 7 files changed, 245 insertions(+), 29 deletions(-)

-- 
2.7.4

