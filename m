Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353D25A21CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbiHZH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245343AbiHZH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:26:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E3B647D0;
        Fri, 26 Aug 2022 00:26:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso7274516pjb.0;
        Fri, 26 Aug 2022 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CVd4gipKEyJsCvgUp2zsVtIKTk/IiJZuB69XLQsZ+E4=;
        b=B4WCc8PPDJZ8v1fAg4UuAOZVblhilW1F14VxOUw6kiDA9CQm8Q63oIBVttIe9UMYN6
         mpzNMkl3ybGxhgZsUSF+0puLNe3XKsX/fwMHV7uwR/GVeCeOVORyTY6BaIApxngdvbAI
         B/TcAZgICis+xeWCQiorvZxWCU//KLXWRnxBTKAkAfZxXhyiOHwdKgwULDIfgHMKLC9U
         8bWWfrYaHeog+9zMcbovgRWqB5yBad+j6u4pzShGDcvgL2Tf1EfK7NRCoDRHwyi75Dxx
         58yrGcnbCbJDjRz62KjaSLH2NvXicvWZt4iASAcrb3DP/SNKYYQ2NWxCvP7cWMXD4qeT
         f6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CVd4gipKEyJsCvgUp2zsVtIKTk/IiJZuB69XLQsZ+E4=;
        b=77KWyjv2cq9eBHV1t6AXUIXe2TuamSrX/157p/02VPu3kHh2Fk0YsbttcRrI7jI6ET
         2KmaxhCUZw7LpEnpNYaI5fQCAfbfUckw5ENpud3TijUji5SUfexZkiZvTWJKjrdGiPmV
         ARkL5Pm1ngo/LrQn4CRq96Vjvzu6yICammjq0VR+wDFlr44HE2QZWfkXiBfBQF8fxTQZ
         fJnuyJP05X+SEtSkskCDsaO59EpIQU8RQrrslLcZxFEuAYJzZsGTnEJkXUpJv9CZVKlx
         HNEzDsccDe2uiIhmNopCfNLERU+FnbRyQ301kmfgl9Ig4ZOSnabNc+Oua7hWPSbYjsIU
         bWQg==
X-Gm-Message-State: ACgBeo0RM/wX0TiB62f+ABLwyPluVku95TzRiKl5ksbkZOHHi8gaRTbZ
        PIdbm/ogI/WHi6JM37eAeDU=
X-Google-Smtp-Source: AA6agR4GAH1B37Rvc50hoOeSsUAcTY6UdQY23/xmD+dy/fwuOyPhXYytRjFtW/DDIzBUfVuhCODbDw==
X-Received: by 2002:a17:90a:1d0e:b0:1fa:bf2e:a56e with SMTP id c14-20020a17090a1d0e00b001fabf2ea56emr2978765pjd.23.1661498811909;
        Fri, 26 Aug 2022 00:26:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b0016d5626af4fsm823576pla.21.2022.08.26.00.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:26:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     martin.petersen@oracle.com
Cc:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: snic: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 07:26:48 +0000
Message-Id: <20220826072648.252972-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value 0 and -ENOMEM  directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/scsi/snic/snic_trc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
index c2e5ab7e976c..9796bf280775 100644
--- a/drivers/scsi/snic/snic_trc.c
+++ b/drivers/scsi/snic/snic_trc.c
@@ -109,16 +109,15 @@ snic_trc_init(void)
 {
 	struct snic_trc *trc = &snic_glob->trc;
 	void *tbuf = NULL;
-	int tbuf_sz = 0, ret;
+	int tbuf_sz = 0;
 
 	tbuf_sz = (snic_trace_max_pages * PAGE_SIZE);
 	tbuf = vzalloc(tbuf_sz);
 	if (!tbuf) {
 		SNIC_ERR("Failed to Allocate Trace Buffer Size. %d\n", tbuf_sz);
 		SNIC_ERR("Trace Facility not enabled.\n");
-		ret = -ENOMEM;
 
-		return ret;
+		return -ENOMEM;
 	}
 
 	trc->buf = (struct snic_trc_data *) tbuf;
@@ -131,9 +130,8 @@ snic_trc_init(void)
 	trc->enable = true;
 	SNIC_INFO("Trace Facility Enabled.\n Trace Buffer SZ %lu Pages.\n",
 		  tbuf_sz / PAGE_SIZE);
-	ret = 0;
 
-	return ret;
+	return 0;
 } /* end of snic_trc_init */
 
 /*
-- 
2.25.1
