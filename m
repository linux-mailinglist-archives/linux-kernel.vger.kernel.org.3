Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FCE4BEB4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiBUTiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:38:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiBUTiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:38:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A423BCF;
        Mon, 21 Feb 2022 11:37:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id B16341F43D58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645472259;
        bh=ppkjAqsyefNanhA6ebbN+nOWgkrenoU3SYfcyrnCW9U=;
        h=From:To:Cc:Subject:Date:From;
        b=UXVJl8OQpjuFzsctC70VXjMowE4u/MClizz+0R07tdlyi4D/ePgvcJ17qe6xyx5L7
         RST1wUjyIIezhSv3Wc102bupCZ9AU+lKxqhQHPukmAzg9zNlHOANUsJAztS6siaHE/
         mJ42kjp2lpjDzgQOyJEWcszvlY2U8OnPIEVnJPF4PxRinzgM/wR8xH5jxE/0rJOIn3
         TDrffNLQBlK3Y+ZxFG4t5lLnIYXoTuuXKGm18ZjCoI/obHr5LCj4o7Q+smY7pYdoGH
         RczE0mFJffSNF+ixZY2HnnxWzXry75dTH7VRWQtjVA0GuI/cQNEcPwmuCO6OmQ2tkz
         OqxmFoDJjFNOg==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] doc: media: Document VP9 reference_mode miss-placement
Date:   Mon, 21 Feb 2022 14:37:27 -0500
Message-Id: <20220221193728.808414-1-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference_mode derived syntax is part of the compressed headers and
should have been moved into the corresponding control structure. Document
this mistake. The value can be set to 0 if the driver does not require
compressed headers information.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../userspace-api/media/v4l/ext-ctrls-codec-stateless.rst  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
index cc080c4257d01..ec48e4acb5ece 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -1692,7 +1692,12 @@ See section '7.3.1 Tx mode semantics' of the :ref:`vp9` specification for more d
     * - __u8
       - ``reference_mode``
       - Specifies the type of inter prediction to be used. See
-        :ref:`Reference Mode<vp9_reference_mode>` for more details.
+        :ref:`Reference Mode<vp9_reference_mode>` for more details. Note that
+	this is derived as part of the compressed header parsing process and
+	for this reason should have bee part of
+	:c:type: `v4l2_ctrl_vp9_compressed_hdr` optional control. It is safe to
+	set this value to zero if the driver does not require compressed
+	headers.
     * - __u8
       - ``reserved[7]``
       - Applications and drivers must set this to zero.
-- 
2.35.1

