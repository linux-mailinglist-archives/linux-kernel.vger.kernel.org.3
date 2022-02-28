Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78194C7088
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiB1P1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbiB1P1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:27:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154AC8093F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:27:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA29DB811D2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0D7C340E7;
        Mon, 28 Feb 2022 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646062024;
        bh=kFhWjGGPF0HOMSD41o5huv2osoCwgvTkZ3Q334nGLzY=;
        h=From:To:Cc:Subject:Date:From;
        b=gn3F5ZL+dou8lTgfyLNm181boVHfFi+CTyIt/fDJtEMsk00674yLi6uEWrBRqz2EC
         rWdAi7n5FTg5oOA/k3VIZ/FlW7A9FsC0Hf99O+46B82BI5g4xxsoSl6nSB3UL+Q7ia
         TkoyE+Ne4nSdi+OzagxH6CAJ3cSXWx9Ug3cX5aZJhEjH1ygv6VyHlWzW/msM5wEkAt
         sn8nU/Qo2ndeTO79tMwOXgX0+xOfNWSK0B+Arpx15XZEebqLlXuVVekSt4AmbqipmY
         4kSMGfpqhTyXW/rrhhsI4eJ02lyEfBPwO+k1gty5GZx8XHK3aCBpwaRhrAIkJLu5Qv
         386CwB06NKMfQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lewis Hanly <lewis.hanly@microchip.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] SoC: polarfire: fix build warning
Date:   Mon, 28 Feb 2022 16:26:52 +0100
Message-Id: <20220228152658.3367506-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver causes a build warning because of a missing
prototype:

drivers/soc/microchip/mpfs-sys-controller.c:76:6: warning: no previous prototype for function 'mpfs_sys_controller_put' [-Wmissing-prototypes]

Link: https://lore.kernel.org/llvm/202202260947.F5T1YNao-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Fixes: d0054a470c33 ("soc: add microchip polarfire soc system controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've applied this to the arm/drivers branch as a fixup

 include/soc/microchip/mpfs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
index 6466515262bd..969b5239521e 100644
--- a/include/soc/microchip/mpfs.h
+++ b/include/soc/microchip/mpfs.h
@@ -38,6 +38,8 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *mpfs_client, struct mp
 
 struct mpfs_sys_controller *mpfs_sys_controller_get(struct device *dev);
 
+void mpfs_sys_controller_put(void *data);
+
 #endif /* if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL) */
 
 #endif /* __SOC_MPFS_H__ */
-- 
2.29.2

