Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3050D591
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiDXWKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbiDXWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:10:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8335E77B;
        Sun, 24 Apr 2022 15:07:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bv19so26275648ejb.6;
        Sun, 24 Apr 2022 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgJcAl0zdpAYB0IRw4jP+ujI4F2jFIRqxBwg3WITVhs=;
        b=cZ77NACJh5VixU+h1pcfeiY6y7ekGoKIuy5NDHqSRXwlc2y3ZEwCkTQz72ojbxVxOT
         dmwZW/wDSUDuH9DvwVV80Hg6CjvR/RZZRVd9GKMKHwFvAo0mY1YjHQvE5w+J4fnh6I3q
         JPX1XeMlGHgiunbzi57c41Rchut1u+PCVOnO2rU/MOrz2GqSnjMUDDo45v8Ska0tiaAh
         vADZTf0Jy9iFejyonxz2Desz2g6vNtgfX81Z4CRz024yNvanNPqLwka8wCz1y9PdodVZ
         z/ujNjvU6JRDuQWMcpb8KSOdSYG4eNi1NMjiBbs3GP3Wsn8vje59UNlcyNYnWuI8F2J4
         WdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgJcAl0zdpAYB0IRw4jP+ujI4F2jFIRqxBwg3WITVhs=;
        b=sM3KwdkOrwoLOB/+3rGfadZniG3Enm9HNGOR1XGMMefS23Zl9BnpJqSf3ysbU2326x
         BqTzPLW4ihoDxrAdtu4CwYFo1u8gq48sbEdLYZ1Y/YQipLZ7CSnbe+p+JsQVfDZqqSr4
         mCAzX+zqQ/SmSfQ4Z1y7wlohpUZOlxzhS4Z9t22J9iJQArU2bOX3sEwnv1IZgTEj46QY
         aPMMVOQZyqR6lU2HhtbGbGOhASoEzCLwBTPpT81BextRVLzUpQ8obz9X/GyasPeF0rDX
         Y0l6rva4yweRjZ9OA6oCEm0vXgBEPTiLwrcjpUAnowcFKBbLq0jVA9NkvznDk4Y/dxuG
         DwRg==
X-Gm-Message-State: AOAM533OcX9YGEYyvNgS6liDaH+55hecG8US3Dpzhuhaxhcbyxg7sE+V
        0lKc9MlmrybPywj+rhFaYqk=
X-Google-Smtp-Source: ABdhPJxQxA5FsP+gIegcaQbl4IeReGJ6lg1tXoNsu/iMf2ULGyR2U0DaQ2wvxFILc5eu2iInj+wOSg==
X-Received: by 2002:a17:907:d8c:b0:6f0:1091:de34 with SMTP id go12-20020a1709070d8c00b006f01091de34mr13540330ejc.376.1650838043241;
        Sun, 24 Apr 2022 15:07:23 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm3672948edt.92.2022.04.24.15.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 15:07:23 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, keosung.park@samsung.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] scsi: ufshpb: Remove 0 assignment for enum value
Date:   Mon, 25 Apr 2022 00:07:09 +0200
Message-Id: <20220424220713.1253049-3-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220424220713.1253049-1-huobean@gmail.com>
References: <20220424220713.1253049-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

If the first enumerator has no initializer, the value of the corresponding
constant is zero.

Reviewed-by: Keoseong Park <keosung.park@samsung.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshpb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
index 7aa0dc58ee9f..b83b9ec9044a 100644
--- a/drivers/scsi/ufs/ufshpb.h
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -59,8 +59,8 @@ enum UFSHPB_MODE {
 };
 
 enum UFSHPB_STATE {
-	HPB_INIT = 0,
-	HPB_PRESENT = 1,
+	HPB_INIT,
+	HPB_PRESENT,
 	HPB_SUSPEND,
 	HPB_FAILED,
 	HPB_RESET,
-- 
2.34.1

