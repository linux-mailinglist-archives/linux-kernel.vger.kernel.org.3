Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF71D4F51B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846964AbiDFCLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455499AbiDEQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A385DA15;
        Tue,  5 Apr 2022 08:16:02 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 093DF1EC053B;
        Tue,  5 Apr 2022 17:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649171757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDL2dhmJrCNToj/HGsyDQ7DuZlLclp5wFLMD60mJIDk=;
        b=S/B6B6pYfurNbBNbI4KbkkR3uHedbbjg7UNT2jV1Q4qeYZQwaEBUHwRMr+grYfQGCMjRML
        YS/NXOyWYq3sbQxeJQczSgnmOErjoLD349KtuAenIDbryMtxYVeOHUmj4ivD68y7y/gmlb
        KVZ7pAR54/PR/seX/1pPg+SYhJXY0Hs=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 07/11] usb: typec: tcpm: Fix undefined behavior due to shift overflowing the constant
Date:   Tue,  5 Apr 2022 17:15:13 +0200
Message-Id: <20220405151517.29753-8-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405151517.29753-1-bp@alien8.de>
References: <20220405151517.29753-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fix:

  drivers/usb/typec/tcpm/tcpm.c: In function ‘run_state_machine’:
  drivers/usb/typec/tcpm/tcpm.c:4724:3: error: case label does not reduce to an integer constant
     case BDO_MODE_TESTDATA:
     ^~~~

See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
details as to why it triggers with older gccs only.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb/pd_bdo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/pd_bdo.h b/include/linux/usb/pd_bdo.h
index 033fe3e17141..7c25b88d79f9 100644
--- a/include/linux/usb/pd_bdo.h
+++ b/include/linux/usb/pd_bdo.h
@@ -15,7 +15,7 @@
 #define BDO_MODE_CARRIER2	(5 << 28)
 #define BDO_MODE_CARRIER3	(6 << 28)
 #define BDO_MODE_EYE		(7 << 28)
-#define BDO_MODE_TESTDATA	(8 << 28)
+#define BDO_MODE_TESTDATA	(8U << 28)
 
 #define BDO_MODE_MASK(mode)	((mode) & 0xf0000000)
 
-- 
2.35.1

