Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C15A02C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbiHXUbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:31:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5656B67F;
        Wed, 24 Aug 2022 13:31:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p185so3132139pfb.13;
        Wed, 24 Aug 2022 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JS396VO3RjIxv2EdN1gwXH0IVteoC89fKy018NJlSI4=;
        b=DJ726nuBhrKxCRN9Vl4h7nD8MJ9khauabketOtwG96ztSRmma9M2LL737/A973Xm9/
         A1HkXBFymyUePR2E65G300Nu0vcvXoSh7vP9CmNxstGOJjC3LuPq5bjRN/MqD29p11Cu
         e9+zoPU/vd+hzx4fofmm420f8lNB6OU4ddogOkU/FYfvo2ylDNeAVULRKnHLtkMRpFkE
         BI+OsrRnTz/MLZo4RhPEXOPRggF7kJYn0o3TKB5iNo33Zs+z5dlAuY4/T2YOD40VRtW8
         bBBEFN+hg0pj3Q1FhcWVDQLA0ObqaGwnvNRgA6BDYen8z7S6f7Na6J5aB5BX8lgRU3M+
         7vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JS396VO3RjIxv2EdN1gwXH0IVteoC89fKy018NJlSI4=;
        b=kGS+zsN5cvu1Mt8i5qHFz6E/IEpZWo3I+TNPb/UcHK1eQrBrov4kIe6G4NiNlH6Oz3
         K2MC52I1l7SGkvYh14qG1+PFSsMQiNqstW/fV/xiu3IOy97SjeOIW+aSuNZ/OHx2MJrx
         6khZ2VXycJst+ReDjxSlKDy55Pbg2tqMjEm7AmMymi97IGXXSoGSzh8NhzRV+DjSOKo7
         tc1THTk5PCmc8QejhvXVXGb05GXxYPTreaOrcWF+RfkVDC4MEHgNChh1CzKzcCQSR4Rm
         KJRIhSgxtzX8Qwby9U6cCBjvUf98Fw0gy/p2yPZ7fH0DT2VgaPUyDrUShLdq6C3c1Vx4
         XdIg==
X-Gm-Message-State: ACgBeo2XOHG0wdroYRmbtNx1GDdU+jLf1MmfoZV2aKn2SCzfY1+mQXHC
        h3E1aaHx63oGBBwwbc2lIzAHAFOCAkowXw==
X-Google-Smtp-Source: AA6agR7J3xx58TIIiBDRjMFIdMcuBK4hAzDg9M0xKet4Ornl9P/KbcddihwBWRKszlRF1Uk8iDebDw==
X-Received: by 2002:aa7:88d0:0:b0:536:e993:730d with SMTP id k16-20020aa788d0000000b00536e993730dmr813054pff.81.1661373077014;
        Wed, 24 Aug 2022 13:31:17 -0700 (PDT)
Received: from fedora.. ([103.159.189.138])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b0017269cc60d7sm13065714plx.214.2022.08.24.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:31:16 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Matthias Kaehlcke <mka@chromium.org>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: host: Initiate urb ep with udev ep0
Date:   Thu, 25 Aug 2022 02:31:07 +0600
Message-Id: <20220824203107.14908-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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

Currently we look up for endpoint in a table and initate urb endpoint
with it. This is unnecessary because the lookup will always result in
endpoint 0.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
Changes since v1:
 - Remove endpoint lookup and NULL check
 - Remove unnecessary variable *ep
 - Initiate urb ep with udev ep0
 - Update commit message
 - v1 Link: https://lore.kernel.org/lkml/20220824130702.10912-1-khalid.masum.92@gmail.com/ 

 drivers/usb/core/hcd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 94b305bbd621..05f30ae5570b 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2158,21 +2158,14 @@ static struct urb *request_single_step_set_feature_urb(
 {
 	struct urb *urb;
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
-	struct usb_host_endpoint *ep;
 
 	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!urb)
 		return NULL;
 
 	urb->pipe = usb_rcvctrlpipe(udev, 0);
-	ep = (usb_pipein(urb->pipe) ? udev->ep_in : udev->ep_out)
-				[usb_pipeendpoint(urb->pipe)];
-	if (!ep) {
-		usb_free_urb(urb);
-		return NULL;
-	}
 
-	urb->ep = ep;
+	urb->ep = &udev->ep0;
 	urb->dev = udev;
 	urb->setup_packet = (void *)dr;
 	urb->transfer_buffer = buf;
-- 
2.37.1

