Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2477446DC96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbhLHUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbhLHUDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:03:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0221EC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:00:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h24so2720994pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryG9F0cNdfUlgVrF/NxUIt+Pz0m+Oe9K2Svfx8D1tX0=;
        b=cDUnluAwhgjxqTXxu1GCbqv9CC0ZQ5kLYOOY+cn9oMhL1vM0WWfP/ZxBG6WVLXmXrX
         odZlg/eOsFeiLHPsF1ZruSdyDu6bjyyX2ZoMcBCO5qDLG/CKOLAb+FZOA8sGEqXUDKky
         SRqYDI21j9C72i6pn/ZSKtO6UKbhSy5P2sCwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryG9F0cNdfUlgVrF/NxUIt+Pz0m+Oe9K2Svfx8D1tX0=;
        b=6k+MoEsylEEOi8AY3lyv8+QQpnZbNixTPYXR6us0PV9IDAWWZA189KslnkQtG2LfjY
         K8GQcvnVgko/lgyEhsv4yFSL/Dt18CfqJ9teFYJrc5ynR7MudXk6nSE78ORzERfqZT6U
         SlLV7OWXZnkj9bJehOZ7I4k8cS4YGOfzP+x4HlmP/U5mPx95wILLqEYXom9ZJ5T8XPbY
         8tbalW7UyKnXeq78gHYNFIKxx4Mrj7TDrN5uiVzsXsMfFrizxBgXaynYCjNvJ3KcFF4h
         7Dyh+8/yVc+vEyJUNlc9Clzy38qn0SXhRJMEcSC6UxzOuUtW0HMFq7IfcwgBLIAIY/zr
         RLDA==
X-Gm-Message-State: AOAM532Ha6dJ/nLkOMrdxV4Amgwp0LCGFqPkRgM7+RAYs2HSFZnNsQ6S
        VTLnLdAPNCm6kZ/3/xkc6PAjBw==
X-Google-Smtp-Source: ABdhPJzeUr1CLAgmwx46mEtMKfG5fRMmsYrQUKjNklA67PYofq5cYsVuaX/QUYGHSWwHr/4NlPqJTw==
X-Received: by 2002:a17:90a:7004:: with SMTP id f4mr9649105pjk.156.1638993599536;
        Wed, 08 Dec 2021 11:59:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w17sm4486734pfu.58.2021.12.08.11.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:59:59 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     James Smart <james.smart@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Use struct_group() to initialize struct lpfc_cgn_info
Date:   Wed,  8 Dec 2021 11:59:57 -0800
Message-Id: <20211208195957.1603092-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4744; h=from:subject; bh=ifCLUxbQxASo1tR1Zxws2L+owBAIVDqaIZyrnGtvuy0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhsQ693IFoh1y1lBK3oIqiJvkk0IV5I8DRUAJFiKYR SxqH3kiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbEOvQAKCRCJcvTf3G3AJnnkD/ 0botSCPgrvcWjq7Dpou8O9qkYgwJRZU6M208ALcvF9jQPOIOe/RxvCUDjCpl8PFtp3R8RxwmiT1UPD 2AyrUApSHxbq7g+W6fNU3W+G2WkSPXNVxTvkdc2d+YQ6Lve+yDXNMbIHlRrcbvXzJWYgvURgSVexmV PsEAYn7DAB1zNr9Z8Dq3QqjFSkl/3C1L+0wtYtK+UFK+vAEmR2kKk408yJ+5KLBFmbolS/AkTym86N CuXhzko6b7WQd9HaAz+dKMvw5+9/nOT6AoMDt0/hIwjUUs6+uESBYgQUcSXXEJXduxdVg9fPj+9LW6 FyODub+v7dyp0n+zKyi8j+vbsgkjYryoP/Rue9lMHrdoLJoC5tYtc9aXG3nXrwe4lLZr9FOHoaHC7n /KMoFKPBRSbI6j/F+YZtRqZsGQZeGNTSiTznUs6I5weo23FMOwpl/1gmTnGImO4MfejOAxVcV9bYxh s0geN6I1DZoC8Cs4OKoahy+QbJXtMn6aFFT7eA5BNiR797oUXn5RQvb6veJxRGHqnSCLoBa5UNQAOn tXfJ1DjkxGiC38Vw6AzHmh2CjrUqaPtkI8+YfdTIjN1tIh+vmriksJgafUtO+V/MFaF9ihhUBWhs4n S11aybSO9yNCu1zHSeo73ZYe5I5Tmmohff8odqqRPp0VhjUTDRVA4tCBkr6A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark "stat" region of struct lpfc_cgn_info that
should be initialized to zero, and refactor the "data" region memset()
to wipe everything up to the cgn_stats region.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Also, ping, Re: https://lore.kernel.org/lkml/20211203223351.107323-1-keescook@chromium.org/
---
 drivers/scsi/lpfc/lpfc.h      | 90 +++++++++++++++++------------------
 drivers/scsi/lpfc/lpfc_init.c |  4 +-
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 3faadcfcdcbb..4878c94761f9 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -496,52 +496,50 @@ struct lpfc_cgn_info {
 	__le32   cgn_alarm_hr[24];
 	__le32   cgn_alarm_day[LPFC_MAX_CGN_DAYS];
 
-	/* Start of congestion statistics */
-	uint8_t  cgn_stat_npm;		/* Notifications per minute */
-
-	/* Start Time */
-	uint8_t  cgn_stat_month;
-	uint8_t  cgn_stat_day;
-	uint8_t  cgn_stat_year;
-	uint8_t  cgn_stat_hour;
-	uint8_t  cgn_stat_minute;
-	uint8_t  cgn_pad2[2];
-
-	__le32   cgn_notification;
-	__le32   cgn_peer_notification;
-	__le32   link_integ_notification;
-	__le32   delivery_notification;
-
-	uint8_t  cgn_stat_cgn_month; /* Last congestion notification FPIN */
-	uint8_t  cgn_stat_cgn_day;
-	uint8_t  cgn_stat_cgn_year;
-	uint8_t  cgn_stat_cgn_hour;
-	uint8_t  cgn_stat_cgn_min;
-	uint8_t  cgn_stat_cgn_sec;
-
-	uint8_t  cgn_stat_peer_month; /* Last peer congestion FPIN */
-	uint8_t  cgn_stat_peer_day;
-	uint8_t  cgn_stat_peer_year;
-	uint8_t  cgn_stat_peer_hour;
-	uint8_t  cgn_stat_peer_min;
-	uint8_t  cgn_stat_peer_sec;
-
-	uint8_t  cgn_stat_lnk_month; /* Last link integrity FPIN */
-	uint8_t  cgn_stat_lnk_day;
-	uint8_t  cgn_stat_lnk_year;
-	uint8_t  cgn_stat_lnk_hour;
-	uint8_t  cgn_stat_lnk_min;
-	uint8_t  cgn_stat_lnk_sec;
-
-	uint8_t  cgn_stat_del_month; /* Last delivery notification FPIN */
-	uint8_t  cgn_stat_del_day;
-	uint8_t  cgn_stat_del_year;
-	uint8_t  cgn_stat_del_hour;
-	uint8_t  cgn_stat_del_min;
-	uint8_t  cgn_stat_del_sec;
-#define LPFC_CGN_STAT_SIZE	48
-#define LPFC_CGN_DATA_SIZE	(sizeof(struct lpfc_cgn_info) -  \
-				LPFC_CGN_STAT_SIZE - sizeof(uint32_t))
+	struct_group(cgn_stat,
+		uint8_t  cgn_stat_npm;		/* Notifications per minute */
+
+		/* Start Time */
+		uint8_t  cgn_stat_month;
+		uint8_t  cgn_stat_day;
+		uint8_t  cgn_stat_year;
+		uint8_t  cgn_stat_hour;
+		uint8_t  cgn_stat_minute;
+		uint8_t  cgn_pad2[2];
+
+		__le32   cgn_notification;
+		__le32   cgn_peer_notification;
+		__le32   link_integ_notification;
+		__le32   delivery_notification;
+
+		uint8_t  cgn_stat_cgn_month; /* Last congestion notification FPIN */
+		uint8_t  cgn_stat_cgn_day;
+		uint8_t  cgn_stat_cgn_year;
+		uint8_t  cgn_stat_cgn_hour;
+		uint8_t  cgn_stat_cgn_min;
+		uint8_t  cgn_stat_cgn_sec;
+
+		uint8_t  cgn_stat_peer_month; /* Last peer congestion FPIN */
+		uint8_t  cgn_stat_peer_day;
+		uint8_t  cgn_stat_peer_year;
+		uint8_t  cgn_stat_peer_hour;
+		uint8_t  cgn_stat_peer_min;
+		uint8_t  cgn_stat_peer_sec;
+
+		uint8_t  cgn_stat_lnk_month; /* Last link integrity FPIN */
+		uint8_t  cgn_stat_lnk_day;
+		uint8_t  cgn_stat_lnk_year;
+		uint8_t  cgn_stat_lnk_hour;
+		uint8_t  cgn_stat_lnk_min;
+		uint8_t  cgn_stat_lnk_sec;
+
+		uint8_t  cgn_stat_del_month; /* Last delivery notification FPIN */
+		uint8_t  cgn_stat_del_day;
+		uint8_t  cgn_stat_del_year;
+		uint8_t  cgn_stat_del_hour;
+		uint8_t  cgn_stat_del_min;
+		uint8_t  cgn_stat_del_sec;
+	);
 
 	__le32   cgn_info_crc;
 #define LPFC_CGN_CRC32_MAGIC_NUMBER	0x1EDC6F41
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 2fe7d9d885d9..c18000d05379 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13483,7 +13483,7 @@ lpfc_init_congestion_buf(struct lpfc_hba *phba)
 	phba->cgn_evt_minute = 0;
 	phba->hba_flag &= ~HBA_CGN_DAY_WRAP;
 
-	memset(cp, 0xff, LPFC_CGN_DATA_SIZE);
+	memset(cp, 0xff, offsetof(struct lpfc_cgn_info, cgn_stat));
 	cp->cgn_info_size = cpu_to_le16(LPFC_CGN_INFO_SZ);
 	cp->cgn_info_version = LPFC_CGN_INFO_V3;
 
@@ -13542,7 +13542,7 @@ lpfc_init_congestion_stat(struct lpfc_hba *phba)
 		return;
 
 	cp = (struct lpfc_cgn_info *)phba->cgn_i->virt;
-	memset(&cp->cgn_stat_npm, 0, LPFC_CGN_STAT_SIZE);
+	memset(&cp->cgn_stat, 0, sizeof(cp->cgn_stat));
 
 	ktime_get_real_ts64(&cmpl_time);
 	time64_to_tm(cmpl_time.tv_sec, 0, &broken);
-- 
2.30.2

