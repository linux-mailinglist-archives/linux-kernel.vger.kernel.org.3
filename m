Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605505AC72E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiIDVpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiIDVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:22 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D031303F0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r7so3867457ile.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FwCkCkIuXLu91UbfHdZYDrwIlB+NdbMmm6xvFEQjyUU=;
        b=RYCkLD0FCIpFqOKsWlElNLu5l8dGxBEngWLZ18ylxy41NG+Qaj5BZrfDLn5uvMF2xo
         VwhlrGgEcVvma9ILcXWr/GE6ZBBnf6OlwUb6biRCydxCUq3oKWxUcQ2J/MNFVAYtgIqI
         Xb9AS9cv7UVTnWGcrEevePRMFxuCn/ulpHIE9HVRP/TdyoUsfjS6AF5uOoRVUuWr8vqg
         4VPmeMzC0eaHliSJUHUrAHWH8r+EM3TH96DE9T2refzCG1P0lmBG3updh9CAqjc0qY/W
         hrGlSxiGyrArtn+T2krt991mxFZxt+CbQR1NKOfrS5F4tEvIbplkb8gHJGHTFjrzcpA+
         KgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FwCkCkIuXLu91UbfHdZYDrwIlB+NdbMmm6xvFEQjyUU=;
        b=mLTr09jo2o29n3WoWBOKFv/zXTUmEFVsFunqIcPl/c3hsqstT/xFJpqDYFEZNhjypP
         suHidORsPxnV0COU6yNtgTTxODdtOTLEfjPJSbIC8euAobnmMorizEIQHGQDq6UGjPbc
         4xB4p2DsVQl6bzPMWnAR+bhGoMF2GunsQIjl3zxFVZJhnEBDnwb8dDebYCuDGssojZ92
         X2frJjL9eRX+kVjAcoDvRL5fp1hrLb9wI1IWYQuXz8oTMPqQJP34zzujowYPmq5ph0Yj
         IYBKNrX3Dv6UL7L1JfqNEveunOwO+IGHeaQAlDYTXTFagR+ejnhRJmQq5u11EdXbduak
         2Piw==
X-Gm-Message-State: ACgBeo0g6+qc8BHhtRNd/LblDt4b9Gy4CRVJjy86EVL1CHmvUdt4UYdG
        TmLPBGGyXw97gG6GoeDcAyQEZQcRw14=
X-Google-Smtp-Source: AA6agR6xgn/MlYOoGIi2AaB+WdvqdQ5gYdviqjuZlblXZSMV6/iv7FJf6NsVsV/Y3NPrVDl1/Xe7dA==
X-Received: by 2002:a05:6e02:1909:b0:2f0:a558:7113 with SMTP id w9-20020a056e02190900b002f0a5587113mr4717553ilu.55.1662327770538;
        Sun, 04 Sep 2022 14:42:50 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:50 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 42/57] dyndbg: shrink lineno field by 2 bits
Date:   Sun,  4 Sep 2022 15:41:19 -0600
Message-Id: <20220904214134.408619-43-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

struct _ddebug.lineno int:18 is bigger than we need:

  git ls-files | grep -P '\.c$' | xargs wc -l | sort -n | tail -n20
  ...
   22553 drivers/scsi/lpfc/lpfc_sli.c
   28593 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
   46300 drivers/net/wireless/realtek/rtw88/rtw8822c_table.c
   48725 drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
 1386670 total
 ...

All but one of the biggest of these are just .data tables, and have no
code, so would never need a pr_debug().  drivers/scsi/lpfc/lpfc_sli.c,
at ~22k lines, would be encodable with 15 bits, but lets just shrink
to 16 bits for now.

RFC: Is this tantamout to a "don't write files with >64kloc" policy ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dcc0e8cc2ef0..c05148dab367 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -30,7 +30,7 @@ struct _ddebug {
 	struct _ddebug_site *site;
 	/* format is always needed, lineno shares word with flags */
 	const char *format;
-	const unsigned lineno:18;
+	const unsigned lineno:16;
 #define CLS_BITS 6
 	unsigned int class_id:CLS_BITS;
 #define _DPRINTK_CLASS_DFLT		((1 << CLS_BITS) - 1)
-- 
2.37.2

