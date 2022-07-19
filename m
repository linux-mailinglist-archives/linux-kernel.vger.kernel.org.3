Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1921579052
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiGSCAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGSCAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:00:47 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975513D05;
        Mon, 18 Jul 2022 19:00:47 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26INpod4011657;
        Mon, 18 Jul 2022 18:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=8F0gXGID+CdTS5g4PPBSgqjJKTPYm0EbKjo/WZ2Oz88=;
 b=pWfs1r1880u1SQJw3lWyQfFzqssST4lRbiEawUnYa+sW/4s/ZFiaTnpCbWIkgEd0faA2
 g2OkvOJNH2HHgTBRezQlGS0qs5OWEDn3ncDHJuKSsxbEhuZjvuDWH1l8LBLnVMJ3EKVF
 9KeDNV7CpaXjK/ReNjaxbVVJuwTZ/+OsyuRubnYd1PGTwuR3d3/B5WziF4ZMk0aUJm92
 ZLE/bfXmgwib6sieyQLbP2ubGNQqilFN44UlXw42vG9gzL6hfonyC7ZYkudNlw2Dt2s9
 1q16w3xpFr/W9y6zH0skOl4+1fYF1FcKBX819LEBNepHPqvsiLjz6SANxM93HthP1LSM Lw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:41 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C571D40097;
        Tue, 19 Jul 2022 01:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194060; bh=vvRdsPn/wHMKfHQ1z7oX1vkbtug+pziFFH4VyhYW+TU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Mx8ICcsxW9R/NUVSVB+sYJuYqSyHUg7/0qVBG5RO/336vYjbxtXZkV1wg+58ZltR5
         dFzdVkgpEWDTQOOL1rX391Llc2Itf3Rq7Jfby6y3cXfgpx/aB/R3vXDXBWW03S3OoY
         iTMjc1icksqF8ByZipKs1ytmc4XncLFnVtR+hdDyD/j8JcKeTMIPNTaJNjte0f3AOe
         F+nwP0GQpgX8oUFw56ivQ+sb2b60Yk3u7wlCRfhGVgTg+r2sEVqz2s8u8xqPu5pr34
         7JBA0H5OA9bUBD1O44K9NgaF68to3PQYIugcv86V+T9OXurfSBTKBP73VqKw0B7+St
         DEGQBKKNqsS/A==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 96028A0096;
        Tue, 19 Jul 2022 01:27:39 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:39 -0700
Date:   Mon, 18 Jul 2022 18:27:39 -0700
Message-Id: <420c91967948fb8e7c758ed0857c708b3b070d72.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 15/25] usb: gadget: f_tcm: Cleanup unused variable
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: -gN4YhreYozy-RVPCVjCdSYfJBeV-8dt
X-Proofpoint-ORIG-GUID: -gN4YhreYozy-RVPCVjCdSYfJBeV-8dt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=564 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

se_cmd is not used anywhere. Remove it.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 28b560ab44fd..1e7d29f8aecb 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -675,7 +675,6 @@ static int uasp_send_read_response(struct usbg_cmd *cmd)
 static int uasp_send_write_request(struct usbg_cmd *cmd)
 {
 	struct f_uas *fu = cmd->fu;
-	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct uas_stream *stream = cmd->stream;
 	struct sense_iu *iu = &cmd->sense_iu;
 	int ret;
-- 
2.28.0

