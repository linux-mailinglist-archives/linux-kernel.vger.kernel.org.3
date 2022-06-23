Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9BD558920
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiFWTiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFWThm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:37:42 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3608DA182;
        Thu, 23 Jun 2022 12:26:05 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id bo5so518653pfb.4;
        Thu, 23 Jun 2022 12:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+Po9Dm3vumEX9STq43cTmihX9SdOY+/mYJ+qc0yciOo=;
        b=sGAUs3OuNq/HpG0mGrjUfw8EV5ojeDk4MKCkeFJczsQMdL0CrRHfWEhCfsifSn7omK
         3ToVGm8qKf5pNK5LovA7aB6DtNDXGvLU2smcPWpeWE0YmdeI5Wn8z1xHlrdPY7cnqeIz
         VdVmRgNGcaed8Sd7j9dwkvwzNhT9JrMomEHP2hSfhCsRNQ9w4ccLuDgCxXucxjCm6XfN
         Sgn4lbTdslKNzALsB8y/4oP+Fd1vAx3sfGjTcSDZyhP9V0XmXkbLVx9QUNUuCr25g263
         s3EUJKP9ZWOFGyVdCBz0vB20wCvseQnqgJrJn0vxC0FxnTulBXaWhkv9hiHIitLtXCJK
         z0Pg==
X-Gm-Message-State: AJIora9oQxk20zjVrqRX85GjIRrBg1IPjcZGpANLetSc0Yft06NzRCuo
        RmOkdOlEhlWOH87Tm3hEKzY=
X-Google-Smtp-Source: AGRyM1uTX4ESJ0tw80Aa81RBvBg4Pcvvf5BGyKGi9W8AIdbExQbAaHbhTGHrArxaF0w8Iu1c5l0S6Q==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr42316787pfv.36.1656012364666;
        Thu, 23 Jun 2022 12:26:04 -0700 (PDT)
Received: from karthik-strix-linux.karthek.com ([117.208.185.194])
        by smtp.gmail.com with ESMTPSA id h11-20020a63b00b000000b0040c99f8bcb7sm10095771pgf.58.2022.06.23.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 12:26:04 -0700 (PDT)
Date:   Fri, 24 Jun 2022 00:55:58 +0530
From:   Karthik Alapati <mail@karthek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tsuchiya Yuto <kitakar@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media/atomisp: don't use index pointer for debug
 messages
Message-ID: <YrS+RmnyusG6JOTU@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there are some debug messages which use index pointer of
list which may not always point to the right entry as in
the case where the required entry is not found and the
list traversal completes with index pointer pointing
to the last entry

Signed-off-by: Karthik Alapati <mail@karthek.com>
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 97d5a528969b..ec030e3aeae5 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -956,7 +956,7 @@ void atomisp_buf_done(struct atomisp_sub_device *asd, int error,
 		asd->s3a_bufs_in_css[css_pipe_id]--;
 		atomisp_3a_stats_ready_event(asd, buffer.css_buffer.exp_id);
 		dev_dbg(isp->dev, "%s: s3a stat with exp_id %d is ready\n",
-			__func__, s3a_buf->s3a_data->exp_id);
+			__func__, buffer.css_buffer.exp_id);
 		break;
 	case IA_CSS_BUFFER_TYPE_METADATA:
 		if (error)
@@ -976,7 +976,7 @@ void atomisp_buf_done(struct atomisp_sub_device *asd, int error,
 		asd->metadata_bufs_in_css[stream_id][css_pipe_id]--;
 		atomisp_metadata_ready_event(asd, md_type);
 		dev_dbg(isp->dev, "%s: metadata with exp_id %d is ready\n",
-			__func__, md_buf->metadata->exp_id);
+			__func__, buffer.css_buffer.exp_id);
 		break;
 	case IA_CSS_BUFFER_TYPE_DIS_STATISTICS:
 		list_for_each_entry_safe(dis_buf, _dis_buf_tmp,
@@ -995,7 +995,7 @@ void atomisp_buf_done(struct atomisp_sub_device *asd, int error,
 		}
 		asd->dis_bufs_in_css--;
 		dev_dbg(isp->dev, "%s: dis stat with exp_id %d is ready\n",
-			__func__, dis_buf->dis_data->exp_id);
+			__func__, buffer.css_buffer.exp_id);
 		break;
 	case IA_CSS_BUFFER_TYPE_VF_OUTPUT_FRAME:
 	case IA_CSS_BUFFER_TYPE_SEC_VF_OUTPUT_FRAME:
-- 
2.36.1

