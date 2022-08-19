Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8F59A6BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350313AbiHSTof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHSTod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A2D5737
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660938270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oS4vWcSrX9RKmYKtz13NoOmSpAITGLSkakwv0uqVwzc=;
        b=M8Ywc5NBr5hYlHe+fKl1g6rcX5+Q1P00hENOGLIrG59B6XtCCnXVou9JMJe9xrINiMOtZ1
        RlSZvnEXjXcZtDwgSAtHH1lF8Qb82ADVyowupan6gfMDRKim17NyC8452LaL+OQ1YkNsRf
        q0wvxYcZg6w2RZmy3Sob6JX4NyEMVSc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359-qWQHlnIrPj-H9xsiohTPwA-1; Fri, 19 Aug 2022 15:44:29 -0400
X-MC-Unique: qWQHlnIrPj-H9xsiohTPwA-1
Received: by mail-pf1-f197.google.com with SMTP id x38-20020a056a0018a600b0052e48f9b194so2716844pfh.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=oS4vWcSrX9RKmYKtz13NoOmSpAITGLSkakwv0uqVwzc=;
        b=Numic5we2YrDqIh98RFGg3qT0FLrSGfVzd+Tli3XlsNm09/05qpe+nCHBCXFKg10uI
         PAIWFsmrRf7pvvU4fIcibaXJ3QJkf1J22XgwgkEx0RiM0eidpH03DOTTlbt8hgH1v4YM
         X2Qguo6aNq5r3Nv7MKh2eXi/AAOLrtDTPPbAUkkfSf0XOIM7vaIKfnD0ESxcYVpHNOOq
         t9jpt59bcmQZlP4p+NVZSV5PyOoD4FSQf9exJo8kJd7yi1V/sKxl3hrL4gchl/YdN2w9
         UqPCSUTVca9wzyPauAxqB7cFJK/OiyyMHUIiEDS9VcN0cHClzy8OnQaQOexa4zJcVCif
         E6Sg==
X-Gm-Message-State: ACgBeo2a1lxKQ1W1/ZXXWrDscA/9tCqkVyzmcT08TeNi+/UrKZA9EZ4q
        k6oM94Y7aJZ5gfi2zQCX3VCcyc9/GOTZpqtwsu/klDGXrqyA/g8pbZJpMR3OvFOBGW8RTg1PR6W
        7IzsIbd0MX8pWVYa3zxWAalv+
X-Received: by 2002:a17:90a:9486:b0:1fa:ad51:4a78 with SMTP id s6-20020a17090a948600b001faad514a78mr9845250pjo.176.1660938268272;
        Fri, 19 Aug 2022 12:44:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ORnlFrdlb9nPKMmSW5pBN2tVp5SyYkWyq1/upBd7WHx+o/hbPXRwQ1X9MP1VaW28sAZF3Yg==
X-Received: by 2002:a17:90a:9486:b0:1fa:ad51:4a78 with SMTP id s6-20020a17090a948600b001faad514a78mr9845234pjo.176.1660938267998;
        Fri, 19 Aug 2022 12:44:27 -0700 (PDT)
Received: from halaneylaptop.redhat.com ([2600:1700:1ff0:d0e0::1e])
        by smtp.gmail.com with ESMTPSA id nh14-20020a17090b364e00b001fa867105a3sm5677196pjb.4.2022.08.19.12.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:44:27 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, bmasney@redhat.com,
        dianders@chromium.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] regulator: core: Clean up on enable failure
Date:   Fri, 19 Aug 2022 14:43:36 -0500
Message-Id: <20220819194336.382740-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If regulator_enable() fails, enable_count is incremented still.
A consumer, assuming no matching regulator_disable() is necessary on
failure, will then get this error message upon regulator_put()
since enable_count is non-zero:

    [    1.277418] WARNING: CPU: 3 PID: 1 at drivers/regulator/core.c:2304 _regulator_put.part.0+0x168/0x170

The consumer could try to fix this in their driver by cleaning up on
error from regulator_enable() (i.e. call regulator_disable()), but that
results in the following since regulator_enable() failed and didn't
increment user_count:

    [    1.258112] unbalanced disables for vreg_l17c
    [    1.262606] WARNING: CPU: 4 PID: 1 at drivers/regulator/core.c:2899 _regulator_disable+0xd4/0x190

Fix this by decrementing enable_count upon failure to enable.

With this in place, just the reason for failure to enable is printed
as expected and developers can focus on the root cause of their issue
instead of thinking their usage of the regulator consumer api is
incorrect. For example, in my case:

    [    1.240426] vreg_l17c: invalid input voltage found

Fixes: 5451781dadf8 ("regulator: core: Only count load for enabled consumers")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

I'm new to using the regulator framework, but I _believe_ this is a
cosmetic bug that's fixed by this patch. I went down a bit of a rabbit
hole because of the original WARN() message, so I'm trying to prevent
others from doing the same :)

Please let me know what you think, I tested on the misconfigured system
and on a working system and things seemed to work as expected.

Thanks,
Andrew

 drivers/regulator/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8373cb04f90..d3e8dc32832d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2733,13 +2733,18 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
  */
 static int _regulator_handle_consumer_enable(struct regulator *regulator)
 {
+	int ret;
 	struct regulator_dev *rdev = regulator->rdev;
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
 	regulator->enable_count++;
-	if (regulator->uA_load && regulator->enable_count == 1)
-		return drms_uA_update(rdev);
+	if (regulator->uA_load && regulator->enable_count == 1) {
+		ret = drms_uA_update(rdev);
+		if (ret)
+			regulator->enable_count--;
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.37.1

