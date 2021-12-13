Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593CB4737B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbhLMWjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243647AbhLMWjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:39:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9F4C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:39:04 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q16so15763832pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MT/vHE1ydzFe9PN6Wp2UZVjSoHcS4dYEtLHlHKEEAM=;
        b=YGvnvAuqro151EfwgJKAALvz+kJyqgCsgO5oXMZXTc4McLwsP+2Tt2nK/DxNVgXIAe
         88rUvAL023ldcNApa6EZUZZQCMnNDs8r5Ga8v5HlbnaHudKIDV+KjxVwtgN7uOXFaIbQ
         a7dRHSLnBFZJQxNZRAjXvCiVr8o65n5n0D94g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MT/vHE1ydzFe9PN6Wp2UZVjSoHcS4dYEtLHlHKEEAM=;
        b=1NYOdzuYRBxtCqCBp3aAcX64wpgMomlAs9ah3f5LbQgriN842iTZUMSzVH/Jc7Fv5g
         9ZmeRlIbl+uUWejhx82lICGjtbbLMHQZh2p9XkwpiUhMKvFpDDEJgClVdpN8jHIQymX1
         NGuNjt2lW8Qkb4wbjhwiVF3gNu3amWtqammJWL+0YySDAtd6tRMVmZn6Tu8pzn0zgtqd
         S7/DxQGaDqdKibASA1+TAsVPotw2RHopUYLdWNEZeY0avBg+UecR7E++cKhXhfsUNFwm
         22sunUT14g50bXSgu1XDEohtrmDEl6vNPmEouFFcFOwsk80n8B6xA6rwMd3+11oIDsgu
         +hKg==
X-Gm-Message-State: AOAM530czYLMdwD4kmEuI+VbnQfbmy83clRsM6960+gTqNwbrzli96ws
        6VoG3EuyFj25b3gaIEgzcLoG6A==
X-Google-Smtp-Source: ABdhPJyA0kifmlmp09ULzUkVNS3B5zsL46YKdL6X5gUXjzYwPTvQUN8jwmFIq+nNLfPBsfjYFryetQ==
X-Received: by 2002:aa7:9a04:0:b0:4a2:ebcd:89a with SMTP id w4-20020aa79a04000000b004a2ebcd089amr981317pfj.60.1639435144258;
        Mon, 13 Dec 2021 14:39:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t13sm13181529pfl.98.2021.12.13.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:39:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] scsi: lpfc: Use struct_group() to initialize struct lpfc_cgn_info
Date:   Mon, 13 Dec 2021 14:33:29 -0800
Message-Id: <20211213223331.135412-16-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4872; h=from:subject; bh=b7Gop8YkIsZSGaBsGHz+xW8brMLq6H3enGBmwNbBTro=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o6LbqKmAkUNnfmlrw0b7QUEamBgQovX0V9gsVd 8MY1kVOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOgAKCRCJcvTf3G3AJtVLD/ 4k62/NuNCnXqabCvHr68q+AQ5zUtY0Xz+S6EU7HgUfTO6Qj6pdWIgl8Mai8sy4Taa+YO0pHT6Gq+hl HTnevazuz76atJOM+gpoVzm0wMuthUzVGIGM9nEv+tB97wdj60ofuJDubae4PNalUR/ttfanHLDefZ JX8TPos1tsLQhPIaKPabzrILLazhZfO0ZagZXPvF45qVuRzLBzjZG0jR+LIvNEw0kuSGcgrFgNnYND 9Lb6hWwrfE8wqnKpcO/JliZ7eXMe8tfVaeZ7KgKwqgCuOMVvSuQJ+bygomAZCCT2jluKGyBpy41bf5 4AhWN1xssa9laAbpaK2Ma/5cMhcWSmHrDZ4gkqHrtpufJjetO1nTDTQRjNMPHlZWx7PUZZd+Gzyb6n lh6bZpRFit8dBAutA2Mi76C0o/qMZxe4L2BumDDP/ycfl5DIzRYgKreOS7iYuatlSM2EqbT3K8+j0f QqxtlMHGeq/MKQ0jCUTP/cztyBExbc5PMJBJnx/K9voPhhTuTT71YXFG4wIpBFTJRoVTgANamLxDAk rA7jLMZV+mzP5jLjaZn5SCyhXb5h3/IHo3wTpYMHM6YmQXK1tj8aLJwk0doq88iT5pdE1r7bfbNNj2 IvJvSrVVaBmMQAg1qmmgy47/ukFQ3EgACgaCJvChAxaaCJpvq8brRmRGhUNQ==
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

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
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

