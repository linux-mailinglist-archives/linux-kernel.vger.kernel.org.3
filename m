Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC259FADD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiHXNHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiHXNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:07:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A637B7EFC5;
        Wed, 24 Aug 2022 06:07:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m15so8944672pjj.3;
        Wed, 24 Aug 2022 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8hQNlaNRXsTFWu3o2bv0H8H3dQ4+lM+vaoEV4x76qg4=;
        b=ZWuwggVwhgl+RWG5blvg8JohOdTrZXEfEQHhPT7ykLYdSBw/1aLDHoYVLHGFiGkkjz
         p4Rk12s5pYr0JGSUAhScvCc61YcODUrF3eozBk4JbL+YH+Zvk2owIBU3+ty9xaiTlE2P
         E3V35PYtht2oeMuxZCKnkXsyp5m4+xzjlge81oBWyJzYdiOtAoGiB2uN/92dLDm0csFM
         lj8rAsX/sLisHMZitoHUJHc7vqP9ovFPD/dDHGon5T8X+xadUggDAoykuifJpEotRwCJ
         u8LnB8vLFhunyGzu8NYxW42E2K2rrptrsfGkyN5hIiu0UZnjYZB3M3shydY/CHZdHlpl
         ICuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8hQNlaNRXsTFWu3o2bv0H8H3dQ4+lM+vaoEV4x76qg4=;
        b=E+tta91d7LNGt/+fTEIXoG1NeX/Pq0oCEV683QlrAUFQ6rCRIgMVN9TYFrJ6SCVypg
         3tcelJKzHn9HP7cGAlEAihBaf2wWzx9Qk57+wS346p2bcZPi12TNKDhoaiwnmqQzbDVg
         o+BK28ds2NSP8ojC7T+pX1WJ1qLieErF9h8JZDUA6l7WGSxBRmoptVgVOwCHpES9gApb
         5Bnxu8zG0v5ctKQjS86G5QTx5TWugFFheX3P30UD0/dpYMFMK8jWPhu4Dqj8ycF+66hK
         +txFGEPzTds00BV0RjOtw52zKLf3NMPfAbjI+7T6nkccJXKZ1kx1qmT75Hsp1hpMF4J8
         Zlng==
X-Gm-Message-State: ACgBeo0f0ATK9Y5fI+qxCGU9h33EQna+DpW7Pbel2lB7NIzkQGNK0L9T
        9lTPlxNcBA4aQNlfAlHO7M+UIGQmtPM2/Q==
X-Google-Smtp-Source: AA6agR6xn/Z0E7zOROHt6LLIPRv549HHXNyJ8KBcJsXZt4wQkIka7KikRb0a2eGY22Bl3jJJ5qc98g==
X-Received: by 2002:a17:903:2049:b0:172:eb95:c61e with SMTP id q9-20020a170903204900b00172eb95c61emr13467280pla.74.1661346445857;
        Wed, 24 Aug 2022 06:07:25 -0700 (PDT)
Received: from fedora.. ([103.159.189.138])
        by smtp.gmail.com with ESMTPSA id m12-20020a633f0c000000b0041c49af8156sm11096323pga.6.2022.08.24.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 06:07:25 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH] usb: host: Use helper function to get endpoint
Date:   Wed, 24 Aug 2022 19:07:02 +0600
Message-Id: <20220824130702.10912-1-khalid.masum.92@gmail.com>
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

Current implementation to convert urb pipe number to struct 
usb_host_endpoint in rquest_single_step_set_feature_urb is a little
messy. 

Use usb_pipe_endpoint helper function to get the endpoint instead.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 drivers/usb/core/hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 94b305bbd621..107e29d5d3ae 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2165,8 +2165,7 @@ static struct urb *request_single_step_set_feature_urb(
 		return NULL;
 
 	urb->pipe = usb_rcvctrlpipe(udev, 0);
-	ep = (usb_pipein(urb->pipe) ? udev->ep_in : udev->ep_out)
-				[usb_pipeendpoint(urb->pipe)];
+	ep = usb_pipe_endpoint(udev, urb->pipe);
 	if (!ep) {
 		usb_free_urb(urb);
 		return NULL;
-- 
2.37.1

