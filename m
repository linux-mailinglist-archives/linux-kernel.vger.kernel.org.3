Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7155930B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbiHOO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiHOO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:27:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4CD167FD;
        Mon, 15 Aug 2022 07:27:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso7874823wmc.1;
        Mon, 15 Aug 2022 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=q0GaKXFW4qnlMQyjrEAQuIo5YkYY0s64UrfVh5G5KJE=;
        b=B861ql2nIB1Ktu1eZjOhTOhfdHByY7SSzDn+GsC1t8xpOWRM79XIoYM64851KW16Es
         xqpDwBWkT1qXDUmvy0QUZdNnX4+oWMnaXCNwW+CgIjhFBfYWPghOLGJxIpqMcY2rvsQm
         EVoVcuzIkvazS3lo/MhxqZi12/OhGooVnex7e+kIjIyigbPvocfGpBS7ycwWC9vBmAXR
         4D9aTZkixsFNFNBN5ayrm3o9M8WBOSWH2Fpv1HJm7N3+i6xeGt3Y0fSApZHfYUz4YK3F
         VYLrRcpkC4NFAQtxYis6jAK5g7AKq3mbBJiG4Xb8qWXNfuRBa8bCMwEL3JAawOJdmXC0
         zY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=q0GaKXFW4qnlMQyjrEAQuIo5YkYY0s64UrfVh5G5KJE=;
        b=e1AN9l4g2NGqlmLFfeK5Gs3iTUaS6mAeR54DBW009iaq23vabj4ToKpG3mYK915CCW
         b3z8DJk2IejHihNxFOiaRay5AuyAMtR46aKtaZmeQKESyxVSV8qXIizN7A6QTRNQwrjh
         UQhan37pNWzz59uJcPnY2lw+rrpCh1j5PeHx72piru1Q1mRTUdX3Wk+mTR4MgLmcVgp6
         Yzxi2MkUNMLSs9QZlQ2i0JrmstXX56AQmAnUMqLhaaTCmQh540e9k61m7MW1f9JC0FFv
         u1to7BHdsgn9S/79Cb3SwbRGOkjzE11CZCY3Y5kHBCIZ5XXUCoq+91pukWpy+Oq9C8jY
         JqFQ==
X-Gm-Message-State: ACgBeo2g9KcATBxtUFNLkIQa5XxWJK5u/R4aKKwPm+myBCMFsuAkKQ92
        GJdoA7VP8N3OjzagwLuEcIY=
X-Google-Smtp-Source: AA6agR40AK9Vta9OU0laf9gv29XY4LEW/xJK8peuH0r7jXXco0CVzXxlIhZtrx8oAEod+UrZEwORxA==
X-Received: by 2002:a05:600c:1f0f:b0:3a5:c132:66e9 with SMTP id bd15-20020a05600c1f0f00b003a5c13266e9mr10460868wmb.205.1660573632774;
        Mon, 15 Aug 2022 07:27:12 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id v12-20020adfe28c000000b0021e5adb92desm7437824wri.60.2022.08.15.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:27:12 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RESEND] HID: uclogic: Fix warning in uclogic_rdesc_template_apply
Date:   Mon, 15 Aug 2022 16:27:06 +0200
Message-Id: <20220815142706.18369-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with Sparse enabled prints this warning:

    warning: incorrect type in assignment (different base types)
        expected signed int x
        got restricted __le32 [usertype]

Cast the return value of cpu_to_le32() to fix the warning.

Fixes: 08177f4 ("HID: uclogic: merge hid-huion driver in hid-uclogic")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

Kindly resending this patch so it doesn't get lost after the merge
window.
---
 drivers/hid/hid-uclogic-rdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 3d68e8b0784d..81ca22398ed5 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -1113,7 +1113,7 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 		    memcmp(p, pen_head, sizeof(pen_head)) == 0 &&
 		    p[sizeof(pen_head)] < param_num) {
 			v = param_list[p[sizeof(pen_head)]];
-			put_unaligned(cpu_to_le32(v), (s32 *)p);
+			put_unaligned((__force u32)cpu_to_le32(v), (s32 *)p);
 			p += sizeof(pen_head) + 1;
 		} else if (memcmp(p, btn_head, sizeof(btn_head)) == 0 &&
 			   p[sizeof(btn_head)] < param_num) {
-- 
2.25.1

