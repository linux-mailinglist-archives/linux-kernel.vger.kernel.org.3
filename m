Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA00535149
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbiEZPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbiEZPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBD350468;
        Thu, 26 May 2022 08:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3786261C37;
        Thu, 26 May 2022 15:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3731BC34114;
        Thu, 26 May 2022 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653578245;
        bh=JwoKQrS2WF+qGe4jyKO4eVRc1+Zjzv9x2ADz53UC8us=;
        h=From:To:Cc:Subject:Date:From;
        b=RxyX9SVIJ164cZ4daW3ZHBaYR1kQnuIuqJAsWnq5G59phgrRcPRO8XZQ9CJvnjLNe
         rdermwDVjGg/2c+gdKOTjnQksY3rIozXvFXpVMhuRbbUbJItJHdqIqqoP5GSfUpRn7
         xLXhwCR9wPykfvZ+a4hogBw4wc05FqsiTtFWXHflGOBO3GDDMkR/q5kNrFfuZ+pQvz
         B+9/8JAupjyXHpSPif+pRpKdgBz/Lb0VzCWQxcA77PgpsT1xvtvU5jxL/v1vJtBqOT
         igX9DarTfib6XVsTo7/p5+MXfQnQJJpMoW6MrEbRuTmmSDCkeIlKQxUKHHexFFD7d+
         picr0fWsefOBQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] linux/types.h: Restore __bitwise__ definition
Date:   Thu, 26 May 2022 10:17:06 -0500
Message-Id: <20220526151706.331557-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts part of commit c724c866bb70cb8c607081a26823a1f0ebde4387.

Jiri Slaby reported that c724c866bb70 ("linux/types.h: remove unnecessary
__bitwise__") broke userspace, including open-iscsi, because it uses
__bitwise__.

Restore the __bitwise__ definition.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/b5c0a68d-8387-4909-beea-f70ab9e6e3d5@kernel.org
Link: https://lore.kernel.org/r/CAHk-=whk=ygWsxt=1HhndCwjtXdga9sPmkxFGby5PJWRk5yx9Q@mail.gmail.com
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index c4dc597f3dcf..308433be33c2 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -26,6 +26,9 @@
 #define __bitwise
 #endif
 
+/* The kernel doesn't use this legacy form, but user space does */
+#define __bitwise__ __bitwise
+
 typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
 typedef __u32 __bitwise __le32;
-- 
2.25.1

