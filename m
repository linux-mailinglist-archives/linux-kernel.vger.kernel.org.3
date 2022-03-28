Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BD64E9323
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiC1LUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbiC1LUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:20:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D0D6D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:18:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m3so24065057lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=Mr3I0zTOmgfpQLSBDag6X3RkoBkoQu16gRVM9S+AEJk=;
        b=jbV6LejVShCi1T0VntAgmPDw0vvedWvv41xd7eUPffr8XAgeNM0WFffn+YkFYGyBnT
         IjZQOH8dAm+wYbyX7H2e3MtEPMbSQEr/B1L3kFtt0k2QXD0NpTBSg4PkNm0lSj8vdTtv
         43bgjUPTnFjYYPW9wpNJSkHhkoJeZ3hkNuInHXjULLXvBLe8uaSIHiA86Vmhhk38qZ9J
         j9qMbQULcVlnFdfIR9l5soJEeaI9BIX9G8CHHJPqkViyE7LIRxMaErBnaXOAsrbYd+dz
         pULh2gHBCEz8TktcZbKH4MPF4n/Vd56PMOvizrs+cImHZCMHYkFob1/GGiy1A+g6ALi/
         HA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Mr3I0zTOmgfpQLSBDag6X3RkoBkoQu16gRVM9S+AEJk=;
        b=WTFXOBtlYwBkH+FCLTyRlbmJ7oVwCcOgrD3HDHjFyv6bnKF620aHz7KRChD2IeQ/BQ
         MO0CsYcSp/EiA9wbPxAY30ZntuhBVd1wFqn36TrErHAQY0nKYulNaqiYkrbqDR+XtOfj
         rfVBwkxLlBr09hZ+wEGT7hrWdtPCvOBm3kBGSeyo4SZpaofTSobS2ALm+GxetdG/p1fd
         cYGDNgc1fUiAazFjbNtImjfxlNj1uyJgBV//9/Uwr/YZOwWtQCoZKDCgRe6ep5nHvWKu
         wpqRF7YgIbqeiO+SB/SQy//wFbOUrtDGGMqjys1M9aQBSaGFiwlAnWWTFNktR7AZE2S0
         mGfg==
X-Gm-Message-State: AOAM532pdUdI9euze3H2Nasln5EFBv5+JxzDc2wEtTXWYoS1tMSsm7XR
        fBQ2QZFRG8sA+waiEyTvCIHcyw==
X-Google-Smtp-Source: ABdhPJyEoLfTVx81uIbeqr52bd0IdNg687n+trzkDyCfYVD8GcWwCIe94C+hoM3YaYIuscSMh9fFmA==
X-Received: by 2002:a19:654c:0:b0:448:2649:1169 with SMTP id c12-20020a19654c000000b0044826491169mr19369641lfj.555.1648466303868;
        Mon, 28 Mar 2022 04:18:23 -0700 (PDT)
Received: from [127.0.1.1] ([2.92.192.17])
        by smtp.gmail.com with ESMTPSA id j15-20020a056512108f00b0044a3cc8769dsm1603648lfg.123.2022.03.28.04.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:18:23 -0700 (PDT)
Subject: [PATCH 1/4] dm: Export dm_complete_request()
From:   Kirill Tkhai <kirill.tkhai@openvz.org>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com, kirill.tkhai@openvz.org
Date:   Mon, 28 Mar 2022 14:18:22 +0300
Message-ID: <164846630280.251310.15762330533681496392.stgit@pro>
In-Reply-To: <164846619932.251310.3668540533992131988.stgit@pro>
References: <164846619932.251310.3668540533992131988.stgit@pro>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is required for dm-qcow2 driver going in next patches.
The driver transforms block requests into file operations on underlining
file in QCOW2 format (like loop but over QCOW2 instead of RAW file).
We need to have a possibility to complete a request after corresponding
file operations are finished.

Signed-off-by: Kirill Tkhai <kirill.tkhai@openvz.org>
---
 drivers/md/dm-rq.c |    3 ++-
 drivers/md/dm-rq.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 579ab6183d4d..1b9a633efe37 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -275,7 +275,7 @@ static void dm_softirq_done(struct request *rq)
  * Complete the clone and the original request with the error status
  * through softirq context.
  */
-static void dm_complete_request(struct request *rq, blk_status_t error)
+void dm_complete_request(struct request *rq, blk_status_t error)
 {
 	struct dm_rq_target_io *tio = tio_from_request(rq);
 
@@ -283,6 +283,7 @@ static void dm_complete_request(struct request *rq, blk_status_t error)
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
 }
+EXPORT_SYMBOL(dm_complete_request);
 
 /*
  * Complete the not-mapped clone and the original request with the error status
diff --git a/drivers/md/dm-rq.h b/drivers/md/dm-rq.h
index 1eea0da641db..56156738d1b4 100644
--- a/drivers/md/dm-rq.h
+++ b/drivers/md/dm-rq.h
@@ -44,4 +44,6 @@ ssize_t dm_attr_rq_based_seq_io_merge_deadline_show(struct mapped_device *md, ch
 ssize_t dm_attr_rq_based_seq_io_merge_deadline_store(struct mapped_device *md,
 						     const char *buf, size_t count);
 
+void dm_complete_request(struct request *rq, blk_status_t error);
+
 #endif


