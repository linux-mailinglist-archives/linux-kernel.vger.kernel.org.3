Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F01A57909C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiGSCLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiGSCLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:11:42 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358472A97F;
        Mon, 18 Jul 2022 19:11:42 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ILhi6e002271;
        Mon, 18 Jul 2022 18:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=0YDOTLFLGfQtmls8fcXazGD6uzhGVaDdgiSn1jTpAOw=;
 b=tey3YVUMnh3/Tq/HyydHuK9lwcufUEHrC126u2Sk1ietLycxYRQL2pW8meOeXTkjufbq
 sOQUnGRbQl72QoTAqoSxzxxyb1/E9TxgHtq4deElnsabMczvxEAlIHaROeQwVz9VlGoP
 bs4vt/VQ/k8d+qylmDNMqVBfNdBqR/ugq1PVPFJ8lBKlwYDCfxsyE4GIzwa/eDy/q4Ap
 Y1lDOWmHqAUnKOGAcoWn4U44Dy7rHrPlh//P5KyAncI3EyIainANMPfEcIGOYpYBvIFR
 sB5Hw7VNA8d8o1WcWTRB7U0Fwlicyor+IFS1tNxz0ETL04D6IAxVLHkPe8iq7VP520xP hQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvbmwhsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:29 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C34824008A;
        Tue, 19 Jul 2022 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194048; bh=9C/C9peMaFH4yIQhG0ciT8FsvOej0rEdfJ3PBquPxfM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=E9ufCstSdSRtG73L/Len2FUUsTDv7JCwmpkbiMb4/27qm4rfUTzxXgGgG92xwD892
         ovHZbSFDZmm8rWKnsFlISkY/CHYW4g1N2pVF+zLtl/UTmiet1sLX+vp7ZSPDO3Ewc6
         SEssvx5KM6CtFxddK5LT8F3pziS0AiZNqgImDKS95UENkK5+tHiXgj8T74tydLyyIE
         Dx64YWYk5moyClsX2dpqyqdT1URd5WttKfyxpuiatBVBnB6iOt66aE1PucxDUxPUQq
         4P26E1aZ7pUUM3R136oDjNPBhlfA2TqLPNDvNG8E+fqXeGsz+f+qc290lIK0pRvynv
         7MUiY4sh6iWZQ==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 98FD1A006D;
        Tue, 19 Jul 2022 01:27:25 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:25 -0700
Date:   Mon, 18 Jul 2022 18:27:25 -0700
Message-Id: <ffabf2f13d58a229ad23bb1f5b79364c7ee73ce0.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 13/25] usb: gadget: f_tcm: Don't free command immediately
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Proofpoint-GUID: JB4qvKEf7fG-WmXvAIZ3On8z9ukdRAV_
X-Proofpoint-ORIG-GUID: JB4qvKEf7fG-WmXvAIZ3On8z9ukdRAV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=685 phishscore=0 lowpriorityscore=0 adultscore=0
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

Don't prematurely free the command. Wait for the status completion of
the sense status. It can be freed then. Otherwise we will double-free
the command.

Fixes: cff834c16d23 ("usb-gadget/tcm: Convert to TARGET_SCF_ACK_KREF I/O krefs")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 53b178ad4f90..cace5746c0f9 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1045,7 +1045,6 @@ static void usbg_cmd_work(struct work_struct *work)
 out:
 	transport_send_check_condition_and_sense(se_cmd,
 			TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
 
 static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
-- 
2.28.0

