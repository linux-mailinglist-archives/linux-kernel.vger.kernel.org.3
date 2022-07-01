Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4C56328C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiGAL1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiGAL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:27:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DAD81484;
        Fri,  1 Jul 2022 04:27:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ej4so2547250edb.7;
        Fri, 01 Jul 2022 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kPJJjylIpBkQ8W7Ml6hHpSSjjYliXppQHMQmyiUop9Q=;
        b=L1IPD8ninOruMAbXZlKHku59T3sS5xXk+D9sBBiOg/rk1J6jDylYkWEK/coJsiGpB9
         /4sjWjEaryt0I3Is97qYC5cqLSxIonGDXwChh47Mz5LKZbjz+Iw4moJxMCQhbxjGW+pX
         ihNGXvBG6j0giHRLnYrOm9/QxgDrUvTbOU2Dsier3V+MuxvZqXbCXFOxA3YjKyRxATYm
         yT8RhhHKAOiRXpvyWAvjZlkTBoXsHftq4IqpedCo9dIQN1QWzivBcIjkuIm8jkEi3k+A
         F6k7xaRNMKW0QS9vNOI9Ye6/c9i8j1udo8US4ftQqAX+KBEMz/0wNEnxFIuVAEDLGh1V
         DXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kPJJjylIpBkQ8W7Ml6hHpSSjjYliXppQHMQmyiUop9Q=;
        b=7rhOS1eFqY2W+b3+9JW5ssTA42oNJvU0htNYO5eVbAOacH0pyJLstCHshp5lcS39Py
         VFRaWDMtL2CFJnkJEK1vsMhc9u14fETfady1riffaSi3/LHXBLkIPLEPOTXi6NZINOv5
         SCIS5guHEJnDTvHuQCT5iC09sItlvEJhaO1icBP3VkoslUvkF470xLnoblg28QtUuShv
         v62Wrfl8cqKCpLvstJTpPfBpovufCGE7XwzujEJOgWf3MYwmH2CuULFjy73yHGU4BuCc
         ZJX4FkuPG8PZi3N04UbANj2fVlLClV/onvKRm18V4Vhf5SKMB89tDhxt7AGOzSB+F7kl
         mdjQ==
X-Gm-Message-State: AJIora9m9iUaEkuyVazpMYeVwOrq4uxB4ndxyjgo32AC6/44ZycI4IrN
        xDUGi7v9/BxBZtGFpX6cqgSx+g6XOfM=
X-Google-Smtp-Source: AGRyM1susy/qfIZI1T1yxmxSf7281014snIkVQO+0mLyOdyCK9p25FB2sMMTP+WEOQ99BhQIt+uCNw==
X-Received: by 2002:a50:fc15:0:b0:435:7897:e8ab with SMTP id i21-20020a50fc15000000b004357897e8abmr18287719edr.17.1656674846155;
        Fri, 01 Jul 2022 04:27:26 -0700 (PDT)
Received: from felia.fritz.box (200116b826fa4e0041b3c167ba41e809.dip.versatel-1u1.de. [2001:16b8:26fa:4e00:41b3:c167:ba41:e809])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00437d3e6c4c7sm4764548edb.53.2022.07.01.04.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 04:27:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] HID: core: remove unneeded assignment in hid_process_report()
Date:   Fri,  1 Jul 2022 13:27:20 +0200
Message-Id: <20220701112720.13452-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bebcc522fbee ("HID: core: for input reports, process the usages by
priority list") split the iteration into two distinct loops in
hid_process_report().

After this change, the variable field is only used while iterating in the
second loop and the assignment of values to this variable in the first loop
is simply not needed.

Remove the unneeded assignment during retrieval. No functional change and
no change in the resulting object code.

This was discovered as a dead store with clang-analyzer.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Benjamin, Jiri, please pick this minor non-urgent clean-up patch.

 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 00154a1cd2d8..b7f5566e338d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1662,7 +1662,7 @@ static void hid_process_report(struct hid_device *hid,
 
 	/* first retrieve all incoming values in data */
 	for (a = 0; a < report->maxfield; a++)
-		hid_input_fetch_field(hid, field = report->field[a], data);
+		hid_input_fetch_field(hid, report->field[a], data);
 
 	if (!list_empty(&report->field_entry_list)) {
 		/* INPUT_REPORT, we have a priority list of fields */
-- 
2.17.1

