Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078235790AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiGSCPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiGSCPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:15:35 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA74140E9;
        Mon, 18 Jul 2022 19:15:35 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILhi6f002271;
        Mon, 18 Jul 2022 18:27:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=8tolDFm89/8zK78M9TjG6dQ+ZoazYBzcHvBv82IAklM=;
 b=qE/f54D5BRB1UvyObVCwR9scIL+q/rOC2+8LpRsd+ygIn/zaWpdRfW9F5tY01k3nY36c
 tz/ufnI3Vvoar3A/5KOQ1OGA4nVVodmVC1KpQANxNJr5m2QrpZS3LfTL6FFu90drEEkk
 xgrhKyUVOk1GdfVCGiSxKWuWFOkGiExDuB38PG4sdoEGtZIG3CwPwX4b0ajkVBgeM7Dt
 35W0kxpftVFClI00blkgHJfSXdLuQIGPYWd3PKckMtGPI4jVGqhPjvyFfKvkr1KzrUTu
 7SzpvDaotFKghraP8/F0TbkVTjSbO9Els7PC/z/7kywOt3QwPcYZwoLez7bdPM8MgIHR JA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvbmwhsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:35 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B5A6DC0765;
        Tue, 19 Jul 2022 01:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194054; bh=pP7gQU+q6Jbs9kRO4wHEn4LGNIaHXAzO28B7lxUiCKg=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=hDCgspOlKFCTMC60DQOHxwY8hgV1tyZcl//LB5xgDZ1m3Ln4fUEQWGlk0Qi7TDM28
         7W+HPEXDJqSUTHxkvl3guARjlaDxfa4ME1D07IXKHLgUZ0PaSDAw2V43BtRXWNZrUp
         2x7vTSSdjp/zYAOvzBLOvA+Ye2ARJQb4OLqN/vxKtdqohypR62yluzoWo4bq9XCMVW
         PAKNyu2w4o/uLBjYaz/f7piTDYE62MBctMGaQ+7g5ved/BOqEMC5hCpf45OitQA1zw
         rOv2ZaJIodwKl3b9mTmJiTGubQAW1QTLVtsmb68lG05ND6O2LTwXhQvfJF7kGHxFTC
         lX6JE1bvvUuHQ==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id B9B77A006D;
        Tue, 19 Jul 2022 01:27:32 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:32 -0700
Date:   Mon, 18 Jul 2022 18:27:32 -0700
Message-Id: <443175c77873b6b86d01b8df8fc5d5aeba6748f0.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 14/25] usb: gadget: f_tcm: Translate error to sense
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>
X-Proofpoint-GUID: BkB21a4mBxOUK3O8ASrTfNw3O9-Fglq7
X-Proofpoint-ORIG-GUID: BkB21a4mBxOUK3O8ASrTfNw3O9-Fglq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=725 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When respond with check_condition error status, clear from_transport
input so the target layer can translate the sense reason reported by
f_tcm.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index cace5746c0f9..28b560ab44fd 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1044,7 +1044,7 @@ static void usbg_cmd_work(struct work_struct *work)
 
 out:
 	transport_send_check_condition_and_sense(se_cmd,
-			TCM_UNSUPPORTED_SCSI_OPCODE, 1);
+			TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 }
 
 static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
@@ -1160,7 +1160,7 @@ static void bot_cmd_work(struct work_struct *work)
 
 out:
 	transport_send_check_condition_and_sense(se_cmd,
-				TCM_UNSUPPORTED_SCSI_OPCODE, 1);
+				TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
-- 
2.28.0

