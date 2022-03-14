Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47634D8AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbiCNRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiCNRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:16:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5B39694;
        Mon, 14 Mar 2022 10:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2CCB60F4B;
        Mon, 14 Mar 2022 17:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150B1C340E9;
        Mon, 14 Mar 2022 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647278135;
        bh=EQd6QSNnIgzu3N+XI4qSRIf3ZpnZgC2hfNyP7yHWeBE=;
        h=From:To:Cc:Subject:Date:From;
        b=Y6CAX+qOJXC95w4Way/8WtBS1h2fPcGylcautxIBOI+BwC9RVxzqTY8X8lhA8uMLy
         L1AMLZqASaO1VE/YPMgC4SCZM4P4ZFkVoJKnBFm5sIrO+7WpODruCkO27obRRajcPj
         +aN6AB+KKiM7HnHe9lzn0Cx79eMZPhgTFLDVJnwtkQGVYpBALFM9YNIYedpSqqOyWM
         m6z46nqw/ga5QmvGFIM+bvvP7dfd7aFLJnMQzX/voQeFDidnejFZSUqB41sLKsyyOt
         YoSlvtI23iEkzOwbMMB1HqmD1MsTYosJ2D+5czzgRBXTLeoJUFGAm2yxKXjEznECX7
         +M2IFMZGeb/DQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nToI8-001zIU-Fa; Mon, 14 Mar 2022 18:15:32 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Aline Santana Cordeiro <alinesantanacordeiro@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] media: atomisp: fix bad usage at error handling logic
Date:   Mon, 14 Mar 2022 18:15:31 +0100
Message-Id: <7c6071ba016b58206fc1f731f02c67ea0ae3c758.1647278119.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by sparse:
	atomisp: drivers/staging/media/atomisp/pci/atomisp_acc.c:508 atomisp_acc_load_extensions() warn: iterator used outside loop: 'acc_fw'

The acc_fw interactor is used outside the loop, at the error handling
logic. On most cases, this is actually safe there, but, if
atomisp_css_set_acc_parameters() has an error, an attempt to use it
will pick an invalid value for acc_fw.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 .../staging/media/atomisp/pci/atomisp_acc.c   | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_acc.c b/drivers/staging/media/atomisp/pci/atomisp_acc.c
index 9a1751895ab0..28cb271663c4 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_acc.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_acc.c
@@ -439,6 +439,18 @@ int atomisp_acc_s_mapped_arg(struct atomisp_sub_device *asd,
 	return 0;
 }
 
+static void atomisp_acc_unload_some_extensions(struct atomisp_sub_device *asd,
+					      int i,
+					      struct atomisp_acc_fw *acc_fw)
+{
+	while (--i >= 0) {
+		if (acc_fw->flags & acc_flag_to_pipe[i].flag) {
+			atomisp_css_unload_acc_extension(asd, acc_fw->fw,
+							 acc_flag_to_pipe[i].pipe_id);
+		}
+	}
+}
+
 /*
  * Appends the loaded acceleration binary extensions to the
  * current ISP mode. Must be called just before sh_css_start().
@@ -479,16 +491,20 @@ int atomisp_acc_load_extensions(struct atomisp_sub_device *asd)
 								     acc_fw->fw,
 								     acc_flag_to_pipe[i].pipe_id,
 								     acc_fw->type);
-				if (ret)
+				if (ret) {
+					atomisp_acc_unload_some_extensions(asd, i, acc_fw);
 					goto error;
+				}
 
 				ext_loaded = true;
 			}
 		}
 
 		ret = atomisp_css_set_acc_parameters(acc_fw);
-		if (ret < 0)
+		if (ret < 0) {
+			atomisp_acc_unload_some_extensions(asd, i, acc_fw);
 			goto error;
+		}
 	}
 
 	if (!ext_loaded)
@@ -497,6 +513,7 @@ int atomisp_acc_load_extensions(struct atomisp_sub_device *asd)
 	ret = atomisp_css_update_stream(asd);
 	if (ret) {
 		dev_err(isp->dev, "%s: update stream failed.\n", __func__);
+		atomisp_acc_unload_extensions(asd);
 		goto error;
 	}
 
@@ -504,13 +521,6 @@ int atomisp_acc_load_extensions(struct atomisp_sub_device *asd)
 	return 0;
 
 error:
-	while (--i >= 0) {
-		if (acc_fw->flags & acc_flag_to_pipe[i].flag) {
-			atomisp_css_unload_acc_extension(asd, acc_fw->fw,
-							 acc_flag_to_pipe[i].pipe_id);
-		}
-	}
-
 	list_for_each_entry_continue_reverse(acc_fw, &asd->acc.fw, list) {
 		if (acc_fw->type != ATOMISP_ACC_FW_LOAD_TYPE_OUTPUT &&
 		    acc_fw->type != ATOMISP_ACC_FW_LOAD_TYPE_VIEWFINDER)
-- 
2.35.1

