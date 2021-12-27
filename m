Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58A54801B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhL0Qn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:43:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45760 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhL0QnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:43:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AA5FB81022;
        Mon, 27 Dec 2021 16:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E46C36AE7;
        Mon, 27 Dec 2021 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640623403;
        bh=WFk47Lhwi5z+idtPDIQjy1p/P02mO2Zj/3w53lMufQs=;
        h=From:To:Cc:Subject:Date:From;
        b=shptdpzrcG2hbM0C0cvPyOTd97auugmZ+iWuE1BiKyIsTQqX388ntmD2pyXTmFmnK
         xjLEDJeYM4YEwx5qdqmzDM0cAiuOpC6l4jH4BYb2Eo15IYjSzVHV5WKaAE+JKp/rJ4
         rg4kmlpLMHTLONECBfOBO5TtihUW/0/nJpRXNAQ3cFEVhDjMGwly5roq/+9HhUEVhL
         jsBUGJG5w5GDuQx80OJbI40uACq3Z28wtBQMWFT+jZKLTLQwSiQ3VT9hrY26GaCdWz
         e32tXWeG4nBz2ZLuGAX8E/q/vLsm/vgAiS3hOGKf64d8jpbwdqBtjJps5T7TM8TNUR
         BnLAm7ssmj+SA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] media: atomisp: Do not define input_system_cfg2400_t twice
Date:   Mon, 27 Dec 2021 09:42:43 -0700
Message-Id: <20211227164243.2329724-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_VIDEO_ATOMISP_ISP2401 is disabled, clang warns:

./drivers/staging/media/atomisp//pci/isp2400_input_system_local.h:32:40:
error: redefinition of typedef 'input_system_cfg2400_t' is a C11 feature
[-Werror,-Wtypedef-redefinition]
typedef struct input_system_cfg2400_s           input_system_cfg2400_t;
                                                ^
./drivers/staging/media/atomisp//pci/input_system_local.h:22:40: note:
previous definition is here
typedef struct input_system_cfg2400_s           input_system_cfg2400_t;
                                                ^
1 error generated.

input_system_cfg2400_t's typedef was copied from
isp2400_input_system_local.h to input_system_local.h, rather than moved.
Remove the one in isp2400_input_system_local.h so that there is no more
warning, which can break the build under -Werror.

Fixes: 4005ecee616a ("media: atomisp: shift some structs from input_system_local")
Link: https://github.com/ClangBuiltLinux/linux/issues/1557
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/media/atomisp/pci/isp2400_input_system_local.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/isp2400_input_system_local.h b/drivers/staging/media/atomisp/pci/isp2400_input_system_local.h
index 6880c9b6aa65..c3ae5014a039 100644
--- a/drivers/staging/media/atomisp/pci/isp2400_input_system_local.h
+++ b/drivers/staging/media/atomisp/pci/isp2400_input_system_local.h
@@ -29,8 +29,6 @@
 #include "isp_acquisition_defs.h"
 #include "input_system_ctrl_defs.h"
 
-typedef struct input_system_cfg2400_s		input_system_cfg2400_t;
-
 struct target_cfg2400_s {
 	input_switch_cfg_channel_t		input_switch_channel_cfg;
 	target_isp_cfg_t	target_isp_cfg;

base-commit: 68b9bcc8a534cd11fe55f8bc82f948aae7d81b3c
-- 
2.34.1

