Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46155C6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiF0Myu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiF0Myr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:54:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E0B866
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:54:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso10189338pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=o3xBP+E3kmKQgb+KNGWuqjsb+ry6d1Jr12qAFBaZCTY=;
        b=Pah6BB+spmfitgU1poq8uRHpycpH9Js/8JqrDPw5KbdyifTiJanR8zJY9apSoHxsKk
         Vqzan3Ji/cnQUduaI1esis4oTtmM2s+CcDyz2XqEFHrFB8BMzgIpXZGO87TQdH29iIfW
         CsoU2KPZlLvBWhaGnctIjHAXOEym9A6C54pnw9X6alTJBVCYVPHVsPK/NResGIvCFkz/
         AZVo0XdMrj8V+Xm3whc5oPDcaGYez39fsdGGGTaCity3AJf9X4Wkh+AQw6zAI0BO390w
         BBqGtUah7eklrb/OxHWnUYWQ/Dl+CU0QsZrbixDfaPW875vM1yxBdryXxYZbthHBB7qE
         OQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o3xBP+E3kmKQgb+KNGWuqjsb+ry6d1Jr12qAFBaZCTY=;
        b=tou3RNAXWGpHtcvt3DJo+reVs+czJBnD61TeeWQJcq3L7x0zOCv+DW5AVnG1G4Hwl4
         h7PwQkIY5Cblr50Wlick9qzu3REn9MmTmgWK6UFMGdO6V0ixaxzqon+zrCBrqaZpYDiw
         u93ndtXJUK+Ltw+bC6xmFlRR/zcqn8gaD62eLGa+Ct7b5klKnluSPWKPTDVU8vDJYGaW
         XJqg6ejD4Upih2qgTLnk3YDHX+6gYv/0mCUbDdsgxLF5WLB6/jxEwKvCIrDtZqLvajDR
         nhznLTiDpiGPEFYuSMIJJqGsId2wMA43jXsl54WE6TKa53p5V/eVifcaWce3D0QFuaFL
         +SxQ==
X-Gm-Message-State: AJIora+0B/ahBWkTett6gD9to+K4zRH9bR8Wd/gS12xuceeh+nc+kPE4
        0IFS3PcvsNaP0tcbK9+U8o+J5/W3ORvB5X69cQY=
X-Google-Smtp-Source: AGRyM1tAOTpUJw8keP8h8CQCVuPUmiTgi5MxuuCPylTYpVooG+YJifC2N6tiUdiZ3iQwjapIBQkzKQ==
X-Received: by 2002:a17:902:ebcb:b0:168:e3ba:4b5a with SMTP id p11-20020a170902ebcb00b00168e3ba4b5amr14362593plg.11.1656334486307;
        Mon, 27 Jun 2022 05:54:46 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id a27-20020aa794bb000000b005252a06750esm7244686pfl.182.2022.06.27.05.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:54:44 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>,
        Yangxi Xiang <xyangxi5@gmail.com>
Subject: [PATCH v2] vt: fix memory overlapping when deleting chars in the buffer
Date:   Mon, 27 Jun 2022 20:54:28 +0800
Message-Id: <20220627125428.19885-1-xyangxi5@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory overlapping copy occurs when deleting a long line. This memory
overlapping copy can cause data corruption when scr_memcpyw is optimized
to memcpy because memcpy does not ensure its behavior if the destination
buffer overlaps with the source buffer. The line buffer is not always
broken, because the memcpy utilizes the hardware acceleration, whose
result is not deterministic.

Fix this problem by using replacing the scr_memcpyw with scr_memmovew, and
preserving the memcpy optimization when the buffers are not overlapping.

Fixes: 81732c3b2fed ("Fix line garbage in virtual console").
Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
---
 drivers/tty/vt/vt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..d87bff9d8ed5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -853,9 +853,13 @@ static void insert_char(struct vc_data *vc, unsigned int nr)
 static void delete_char(struct vc_data *vc, unsigned int nr)
 {
 	unsigned short *p = (unsigned short *) vc->vc_pos;
+	unsigned short cp = (vc->vc_cols - vc->state.x - nr) * 2;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
+	if (cp > nr)
+		scr_memmovew(p, p + nr, cp);
+	else
+		scr_memcpyw(p, p + nr, cp);
 	scr_memsetw(p + vc->vc_cols - vc->state.x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
-- 
2.17.1

