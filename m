Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BEA509E33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388665AbiDULEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388654AbiDULEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:04:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69251572F;
        Thu, 21 Apr 2022 04:01:52 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:01:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650538911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIdUP69Ss3+lGzLEDkpFFhJmP12NS0Ifi5BLyomcpUw=;
        b=WmLbB7TUQdgm4+epJHLJHLGuFdsFk6xG79VygbfAOO3dBJQfnpu9SGFHbn0Sv+j9r8bzt7
        ect5jlG7ADypcl2N0+ByDIG/VCMPNccjBRX3bruS73xti7rFgurGOUx+Qk2i9JpdDBwEEf
        5QRD1OovhKZrDjGtDqz9qHDhVkSRkWPj7EpotG8Q0wz3C46FYkte0DY6Qr9RyVJ6VR1qyb
        ZC7KEbxCqZuco41GSP6sel3K5xglFt2Wo/26Zafy5boEaV3INhs+ni14WqYFPyQQuI432y
        NnkzenBMnzKej6SoGrXBONg0FXbgEozQs+D/x6DiXli+EOe/aMahDPdpq2n8pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650538911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIdUP69Ss3+lGzLEDkpFFhJmP12NS0Ifi5BLyomcpUw=;
        b=OgABmhje13IvZ/peG01FpQ4L8jJnTh4zNQMF/oVVZC7Q5Z8WDxv6Zrnk8OuHDsWwRQ7YN2
        IyLbkkWnoSQx0XCA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Annotate a noreturn function
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220420115025.5448-1-bp@alien8.de>
References: <20220420115025.5448-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <165053891043.4207.15313691719977442074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     5af14c29f7a0e6d1fcee44c4ed4a2d12a49c4a43
Gitweb:        https://git.kernel.org/tip/5af14c29f7a0e6d1fcee44c4ed4a2d12a49c4a43
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 20 Apr 2022 13:45:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Apr 2022 12:54:08 +02:00

x86/tdx: Annotate a noreturn function

objdump complains:

  vmlinux.o: warning: objtool: __tdx_hypercall()+0x74: unreachable instruction

because __tdx_hypercall_failed() won't return but panic the guest.
Annotate that that is ok and desired.

Fixes: eb94f1b6a70a ("x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions")
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220420115025.5448-1-bp@alien8.de
---
 arch/x86/coco/tdx/tdcall.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 2458882..eeb4511 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -200,5 +200,6 @@ SYM_FUNC_START(__tdx_hypercall)
 .Lpanic:
 	call __tdx_hypercall_failed
 	/* __tdx_hypercall_failed never returns */
+	REACHABLE
 	jmp .Lpanic
 SYM_FUNC_END(__tdx_hypercall)
