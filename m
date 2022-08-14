Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89BC591EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiHNGo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbiHNGoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:44:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D05FAD3;
        Sat, 13 Aug 2022 23:44:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x10so4012741plb.3;
        Sat, 13 Aug 2022 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=x/Q3fU1bn9QVuiMbQk5jZ1nohKUqZAypaJSN80aFDfo=;
        b=dWtAh9sTXz7dnaowHMm+DKSlsj8xHf8nzxEpMOcNScraGbeBvUtFtDTALT4v/qjJYc
         9cc8AcefpDpf5jJYSTcLksRNWc2Bb8Wi7i0rObufF661pv2o0IY0X/ks07LG/rBZWUdV
         VW0HGWZfb/uDeL6hAAnxnNIoExNXZpup9k35D6Xl5vbdsS+TBLr6pasPEraty2xtln3g
         JF2Z5IZcQ6zGgPDPsPGkl4m0rXSpLWZAhh2Wa6iLpuKFXVK9y0frPRoZ5LJnaLX2LRks
         ElrdV6wZo13dUcN9yS0O8VTMqq0rPApNIyXjYqH9HxpFpqRrcpvQo/SgCSCsxSk9v+Cp
         fLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=x/Q3fU1bn9QVuiMbQk5jZ1nohKUqZAypaJSN80aFDfo=;
        b=qRwkso1hvijQyDTRERXQQWiIRYAHyX4wm/QfGjRnz9ARG9t+vIlyJl7wlmFlMrz8NE
         DUEG/IxxSYIL+vBQmHpRVoDTTE7efFROG8K5mJ9CAgufajGUWjuh7jsWCKbjwPmxk2NU
         0zxooUI4rEUTLSf5UrD93xYI+Bna2uIKK9cLX14Y6zaKgU6DrAUjeTqXH+rUK+1gu1UW
         MHVWOt6R+BcMSGCHz3A5kS96J39wOYkhr0h4R8KywJ94nX97nWDTeB6w0A2+TeKTKAFu
         jYuRKuypD7voR5zn4OBAehalh3jkr6yA2gCQRyo4Fr4uHCRjkWUcSCzvsfUEhbB6OKOY
         7b0A==
X-Gm-Message-State: ACgBeo2jwuoE9nVEr8NdqiFH8bjkl+STTQOspOPIvAa3eUwgtG9oLimJ
        MoebAOsXRoH8Vq9uBvbw1Eo=
X-Google-Smtp-Source: AA6agR78JNbrhxuHuDr9egylanK64uXcsgBpSqTwjbQjVWA6ISa+41l0KdO+bsjFayZDws49rOaQSQ==
X-Received: by 2002:a17:90b:b13:b0:1f3:7ab:35b2 with SMTP id bf19-20020a17090b0b1300b001f307ab35b2mr22071610pjb.118.1660459463983;
        Sat, 13 Aug 2022 23:44:23 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:23 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 1/9] scsi: 53c700: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:29 +0800
Message-Id: <20220814064337.32621-2-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220814064337.32621-1-91tuocao@gmail.com>
References: <20220814064337.32621-1-91tuocao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is unnecessary to call spin_lock_irqsave in a interrupt handler.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 drivers/scsi/53c700.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index e1e4f9d10887..55dc0fb7943e 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1490,7 +1490,6 @@ NCR_700_intr(int irq, void *dev_id)
 	__u8 istat;
 	__u32 resume_offset = 0;
 	__u8 pun = 0xff, lun = 0xff;
-	unsigned long flags;
 	int handled = 0;
 
 	/* Use the host lock to serialise access to the 53c700
@@ -1498,7 +1497,7 @@ NCR_700_intr(int irq, void *dev_id)
 	 * lock to enter the done routines.  When that happens, we
 	 * need to ensure that for this driver, the host lock and the
 	 * queue lock point to the same thing. */
-	spin_lock_irqsave(host->host_lock, flags);
+	spin_lock(host->host_lock);
 	if((istat = NCR_700_readb(host, ISTAT_REG))
 	      & (SCSI_INT_PENDING | DMA_INT_PENDING)) {
 		__u32 dsps;
@@ -1746,7 +1745,7 @@ NCR_700_intr(int irq, void *dev_id)
 		}
 	}
  out_unlock:
-	spin_unlock_irqrestore(host->host_lock, flags);
+	spin_unlock(host->host_lock);
 	return IRQ_RETVAL(handled);
 }
 
-- 
2.17.1

