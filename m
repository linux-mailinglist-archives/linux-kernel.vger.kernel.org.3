Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BFC56D6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiGKHdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGKHdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:33:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7021A048;
        Mon, 11 Jul 2022 00:33:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso3122336wms.5;
        Mon, 11 Jul 2022 00:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bWprOYf0otpaMCejRz21ihN86ilpeml7m0pSz/Cp7s8=;
        b=WlrrXGdzetMV5cQUjRQVZ4UUfZQuQEO0sVoH7Q1R2TstiH36jAhOwMrf6uh2s2T6nF
         ucbLPY3b4i9YL2lTe3FxnG4xA/vlfJDR1dkrpazDIWh0MzwEF06iwtwFY2wft7s+0we/
         hy3BapglXypxj/npsD0NcYf3ANWtqpb+qFIdp8F9azihcwfvGltC3r5RHlbCpmk0F54I
         mXMO7VBs80IM+xZp5RnfCQiFKzfkIh7Tm9FzWRJxNDLNMiB0s2cEjHBpGRXzAsvuBBdS
         HTISodY7APmoHFViHkyEk6J8XAv36C4SjnwhWURfgkuB/PydfhDsL/Og4cWUr2FiUB2U
         xBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bWprOYf0otpaMCejRz21ihN86ilpeml7m0pSz/Cp7s8=;
        b=rTD/571bXqLUimTrh7dZZSHUYQo+nOSqKhjsrJZqc5msl6izecuWPb2BB5sQGQnsaX
         0kiKim/luX01H24ivfctzFDmP/pxI9q14zMvqRpXIL2NP1d5WGiJZ/7nA6HnffmrPJXD
         u4K1IR7ZMTpWtCHlRfkvWpW6ht5J0EsbwjizCZuXfV8Ee5Ad46NmwzC2+/jifyGjuQ5l
         icQLKZzzD1/dLqt48cWh8aYJo2H4sxOb/WZiHBx/L1heqo6SP26bEG8mLxzdmXWAGi/o
         H8MpfttHeUQfIwz6JkRD+qBJs5wtnLf/DqhGPquZmVHXdcUTeIrmSNvC/Pl5HbqpamG0
         q1yQ==
X-Gm-Message-State: AJIora/PJqkMfUjSdE/2rXM+KXWfnUoTyC7iixwngZYsm4hT/ripzq+F
        Z+6lfva7FmzB9LwoVVlP6ko=
X-Google-Smtp-Source: AGRyM1v6Vkcrf5r9GxjvaD2Yue1HGnL/WF2bLEdRhzZ2P3QzVd94oZ1AIp9iVlCBaqmq5hpo3bkD4Q==
X-Received: by 2002:a05:600c:4f05:b0:3a1:67df:a116 with SMTP id l5-20020a05600c4f0500b003a167dfa116mr14653844wmq.103.1657524828807;
        Mon, 11 Jul 2022 00:33:48 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id j16-20020adfff90000000b0021d76a1b0e3sm5155671wrr.6.2022.07.11.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:33:48 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] HID: uclogic: Fix warning in uclogic_rdesc_template_apply
Date:   Mon, 11 Jul 2022 09:33:37 +0200
Message-Id: <20220711073337.337708-1-jose.exposito89@gmail.com>
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

Fixes: 08177f40bd00 ("HID: uclogic: merge hid-huion driver in hid-uclogic")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-rdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 13f9ce73f1b1..9fe048729e51 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -1009,7 +1009,7 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 		if (memcmp(p, head, sizeof(head)) == 0 &&
 		    p[sizeof(head)] < param_num) {
 			v = param_list[p[sizeof(head)]];
-			put_unaligned(cpu_to_le32(v), (s32 *)p);
+			put_unaligned((__force u32)cpu_to_le32(v), (s32 *)p);
 			p += sizeof(head) + 1;
 		} else {
 			p++;
-- 
2.25.1

