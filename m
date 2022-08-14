Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA655925D8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiHNRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHNRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:44:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D994DEA3;
        Sun, 14 Aug 2022 10:44:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n133so6620501oib.0;
        Sun, 14 Aug 2022 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=MgVIXnrzamGi1CDQWdojbS7ElaBT1I5kwnpNyLD1mjk=;
        b=IvWKNwADAH+C6wMh9Gyr3A56r/geDdikybNfApEEZUCKFUWBOPS0LlYfZx2FTwUIZq
         91ELAo/g6Qu9rmC9lws9pZwccmo+lBuCWb1zwMi/QJUh+KukgvQHaOqZGMHMJwGSkmz+
         /v6iaamRFJxslyOw9uvqLS04YOceQtK+eA3gCAsR9SCnJ+lczpVb0DlElt+GZHNA/L8w
         t1rcazCJkMea0s5pZkeJgjtZJ9dwseetgxNIe27o2Hae6lFdAFOqBxGvNAz+TnSrZ3TW
         3N3ZAbcVY5RUt5zBzpS1W873Bm7R2cURyB+30BYIu/QRJngiwciLWq9ef482vIu8sVW+
         hseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=MgVIXnrzamGi1CDQWdojbS7ElaBT1I5kwnpNyLD1mjk=;
        b=x8pzUOFuyq701xvc34Gt2RtujL/7hxepfDHvzqu70/SnssVq/oR4WS/eDIFCPrhsco
         sQV5K3dOJnkp0wW84nvu+l/B/tJmTssx6A+HlwSCvxUYYeHjIul4H6NSZIx6q2gyXNJc
         MK1qhE2iJUuRr3RuPaRG49mvNqoYDPDw+9uMN3rhpOUChdoTD9KRG52urB5Z7SFoIr80
         V5wTQI263bSVWW3jH5q12fFKRMQcvwa2Hj5Kcx45ccUraLSJ+OLiJVoHldVh5AJUlbw4
         ffWP15efwkzTZRLVHKqEhuqyC9x4JZ02LW6gF2ruoAmBE6GBGlYA4J7l0aiQynE+Jmgw
         QoAA==
X-Gm-Message-State: ACgBeo0va/n5KZSuigTr4LNsv5oqMH7hcxYKBsbC/W0r37Vkb4m8atef
        vkXpRSOaPwAR6VmvE5A0DPtE3Oj0LMM=
X-Google-Smtp-Source: AA6agR5jp0xp8Meg2NdVpgLJezQotEmGKedXqcXOXpzOgAfaKtGuK29QDcKqKL5ZWNTAUCHc/15lJg==
X-Received: by 2002:a05:6808:f13:b0:344:81ce:7f7b with SMTP id m19-20020a0568080f1300b0034481ce7f7bmr2681432oiw.248.1660499048910;
        Sun, 14 Aug 2022 10:44:08 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id v37-20020a056830092500b00636a8dafdc9sm1654484ott.2.2022.08.14.10.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 10:44:08 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] staging: r8188eu: Prevent infinite loop
Date:   Sun, 14 Aug 2022 12:44:04 -0500
Message-Id: <20220814174404.25923-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index bc8543ea2e66..0a5f08427385 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -531,6 +531,7 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 	uint cnt;
 	u8 *wpsie_ptr = NULL;
 	u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
+	int loop_max = 0;
 
 	if (wps_ielen)
 		*wps_ielen = 0;
@@ -557,6 +558,8 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 			break;
 		}
 		cnt += in_ie[cnt + 1] + 2; /* goto next */
+		if (++loop > 1000)
+			return NULL;
 	}
 	return wpsie_ptr;
 }
-- 
2.37.1

