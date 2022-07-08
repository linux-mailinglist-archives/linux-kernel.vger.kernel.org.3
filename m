Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B556B317
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiGHHHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiGHHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:07:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334B774DD0;
        Fri,  8 Jul 2022 00:07:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id c14so311870eja.10;
        Fri, 08 Jul 2022 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckqRD8Bf1uj6HRKyDkXcFSZCa+eTCm85tstNY0XnYFg=;
        b=OHhPGlX6omnG2OOntDzx3XAi6TSrdXu6IpqTc6JPdJ6s2gHPHbBxoLhte/tlP8BhO1
         m9f9CScpgH5GhrwlkkFm4CH0NWm2FVDN/b4iVEImhMND7M/TFkj8qoPDrxmZVNZQ1aI1
         y2DG/ly8bKfmoNmGtnVpNwXHGNj0Cckzp0hlCH1m+PbG1CvNoOcn7Pa916xDpazpDd6e
         GW96W9EVOjL14yEBcFkf/AOZUiGURlzK7pUfJjlvHK9QrERWhr8Dmkd/D+9DdymVwVJa
         8Iqi2unsD1q4j9LSJ/bCv4vbFfgBDoQ37JvKBHpjE0Jm+/vOaw4OLAGYd6YM1OiuUpZh
         OvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckqRD8Bf1uj6HRKyDkXcFSZCa+eTCm85tstNY0XnYFg=;
        b=h+NKUyMYqQMVkqTotuoFmu62qk++WjEyv1Q773ebaWSmsK58SibkApxaVTqAEQsJts
         CvdIcFzb//89VNTFXgsCa3YUX5qLjgaSxUMepJcC1q4RZ+gu+hCFHMWNOkxXqHkDGNQ5
         5m7DrBwgFTGiBxs5+p5jzt53ZVF3zeY9uNU74PT/Mtq6B4dIEGU93tYAuM20neeeesPK
         6wVekBik4oj9XfQUH6EOUcXHXPcyCY0SyzRjXbDRZiY5texBRVIC++jUR13T8cv5x56x
         Z+SGHpui4j4ySeUfjT0sO8hGLnX/5vh/W4EX7qat71zHuP4naQVEk0oN48Ku7+GfW8xQ
         7j5A==
X-Gm-Message-State: AJIora+08SAgin0B55X384eJTsSUOmamybDGP5LoUu3pGcAVOzgqo6j9
        fyT7DXGXORvpfCOjIYZ6YdU=
X-Google-Smtp-Source: AGRyM1sxYLnkkn6JxYnULG9I07qoV5AiTVqa3VFU4kfnYtU1JhzoQbH466ZMHRh8hHA4DpCARBhMSA==
X-Received: by 2002:a17:907:7fa5:b0:726:935b:2faa with SMTP id qk37-20020a1709077fa500b00726935b2faamr2164718ejc.17.1657264027631;
        Fri, 08 Jul 2022 00:07:07 -0700 (PDT)
Received: from localhost.localdomain (188-167-110-14.dynamic.chello.sk. [188.167.110.14])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b0072b131815e2sm1713640ejh.113.2022.07.08.00.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 00:07:07 -0700 (PDT)
From:   Jozef Martiniak <jomajm@gmail.com>
To:     jomajm@gmail.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>, Hangyu Hua <hbh25y@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gadgetfs: ep_io - wait until IRQ finishes
Date:   Fri,  8 Jul 2022 09:06:44 +0200
Message-Id: <20220708070645.6130-1-jomajm@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after usb_ep_queue() if wait_for_completion_interruptible() is
interrupted we need to wait until IRQ gets finished.

Otherwise complete() from epio_complete() can corrupt stack.

Signed-off-by: Jozef Martiniak <jomajm@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 79990597c39f..01c3ead7d1b4 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -362,6 +362,7 @@ ep_io (struct ep_data *epdata, void *buf, unsigned len)
 				spin_unlock_irq (&epdata->dev->lock);
 
 				DBG (epdata->dev, "endpoint gone\n");
+				wait_for_completion(&done);
 				epdata->status = -ENODEV;
 			}
 		}
-- 
2.25.1

