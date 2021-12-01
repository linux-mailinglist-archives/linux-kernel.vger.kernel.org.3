Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC246458C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbhLADo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:44:27 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52664 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241585AbhLADoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:44:25 -0500
X-UUID: 2cea26f00c0247e48aa70e0c992bb24b-20211201
X-UUID: 2cea26f00c0247e48aa70e0c992bb24b-20211201
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 201628152; Wed, 01 Dec 2021 11:41:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 1 Dec 2021 11:40:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Dec 2021 11:40:59 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <chinwen.chang@mediatek.com>, <nicholas.tang@mediatek.com>,
        <james.hsu@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] arm64: update PAC description for kernel
Date:   Wed, 1 Dec 2021 11:40:10 +0800
Message-ID: <20211201034014.20048-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the paragraph which has nothing to do with the kernel and
add PAC description related to kernel.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
v1 -> v2:
  - Remove compiler option description
  - Add PAC description for kernel

 Documentation/arm64/pointer-authentication.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm64/pointer-authentication.rst b/Documentation/arm64/pointer-authentication.rst
index f127666ea3a8..e5dad2e40aa8 100644
--- a/Documentation/arm64/pointer-authentication.rst
+++ b/Documentation/arm64/pointer-authentication.rst
@@ -53,11 +53,10 @@ The number of bits that the PAC occupies in a pointer is 55 minus the
 virtual address size configured by the kernel. For example, with a
 virtual address size of 48, the PAC is 7 bits wide.
 
-Recent versions of GCC can compile code with APIAKey-based return
-address protection when passed the -msign-return-address option. This
-uses instructions in the HINT space (unless -march=armv8.3-a or higher
-is also passed), and such code can run on systems without the pointer
-authentication extension.
+When ARM64_PTR_AUTH_KERNEL is selected, the kernel will be compiled
+with HINT space pointer authentication instructions protecting
+function returns. Kernels built with this option will work on hardware
+with or without pointer authentication support.
 
 In addition to exec(), keys can also be reinitialized to random values
 using the PR_PAC_RESET_KEYS prctl. A bitmask of PR_PAC_APIAKEY,
-- 
2.18.0

