Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120654C28B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiBXJ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiBXJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:56:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDE2285A9F;
        Thu, 24 Feb 2022 01:56:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B33E1F39D;
        Thu, 24 Feb 2022 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645696559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18KgPXChIZvCcv99HC0TP296dhKANDC4RaJpwfonCJE=;
        b=f4GEZ7vaJCsHlvFY0stXGs5sVAY0sUNSRQ9l8Pvda0dk9EmNiebRTDeRbyhSXSoMsJb/mP
        r1u18mJsaPTvSSOH3QkPfhe6VbkXvVCl60M44cLWtlQ2GpuGEHfgLL+zk5ovvAwH4QvN7h
        1JLjqKHD5Z0FtNS0xvvel/V1jdP2Ty0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645696559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18KgPXChIZvCcv99HC0TP296dhKANDC4RaJpwfonCJE=;
        b=7OPEjogzUBrx+5Ue/w4Rq1859w782fuoFUEqYQSgQ590PcotXEExyJNUEPYSFFrGvE5hkk
        ZpnbWX+uA4JZpNBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62675A3B93;
        Thu, 24 Feb 2022 09:55:59 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/5] tty: serial: define UART_LCR_WLEN() macro
Date:   Thu, 24 Feb 2022 10:55:54 +0100
Message-Id: <20220224095558.30929-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224095517.30872-1-jslaby@suse.cz>
References: <20220224095517.30872-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a generic UART_LCR_WLEN() macro with a size argument. It can be
used to encode byte size into an LCR value. Therefore we can use it to
simplify the drivers using tty_get_char_size() in the next patches.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/uapi/linux/serial_reg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index f51bc8f36813..c9d5ff6dd4c6 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -111,6 +111,7 @@
 #define UART_LCR_WLEN6		0x01 /* Wordlength: 6 bits */
 #define UART_LCR_WLEN7		0x02 /* Wordlength: 7 bits */
 #define UART_LCR_WLEN8		0x03 /* Wordlength: 8 bits */
+#define UART_LCR_WLEN(x)	((x) - 5)
 
 /*
  * Access to some registers depends on register access / configuration
-- 
2.35.1

