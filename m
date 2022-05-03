Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ADD51807E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiECJGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiECJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:05:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209819C2E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:02:28 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2437MqXG008610;
        Tue, 3 May 2022 09:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/LR+vf6VZNibn/8kISPTCOW5eJs7P2he0lXQXNAGkhs=;
 b=lNrx0EqFTLOV+2SR6g09MFHx7ZM/5GR/WQUhZfyPyAEUIh9lRseHtrDCIdDiVHmYf70C
 dCwH27unAWYKzbNbgDN8F2KXADDrw4+qVmBc0Y3UHsTIfd2/4klV+EqXhdPdTczaTpoc
 kyqPOXkanbWljktrSB9GRCLRun3s1EpfmjBEjn3clDAtdEGF/Vig9ddSuE8PBFPJLIJ6
 wDyMRiKRNC3W+w2SwflVQM55oOIlGySUWzBaf0xpyXIO+LZy32U6F1t7p42J1OYwxoJZ
 zJU2AN/kbrdjd47Oyhb1+kuTj/ojAcV0qTq6mAzFP56cvpv8Y8BQGPuJqmZRD7y/sNIr fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftyxysdy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 09:02:27 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2438vxsp006356;
        Tue, 3 May 2022 09:02:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftyxysdxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 09:02:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2438vcgZ000437;
        Tue, 3 May 2022 09:02:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3frvr8ux3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 09:02:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24392MoS24642028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 May 2022 09:02:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A034C4C046;
        Tue,  3 May 2022 09:02:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F8324C044;
        Tue,  3 May 2022 09:02:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 May 2022 09:02:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 51C67E0287; Tue,  3 May 2022 11:02:22 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] audit: add filterkey to special audit messages
Date:   Tue,  3 May 2022 11:02:12 +0200
Message-Id: <20220503090212.1322050-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503090212.1322050-1-svens@linux.ibm.com>
References: <20220503090212.1322050-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: esBDZ7MBcLIVTdRqjYA4PUviXbbSTSZd
X-Proofpoint-GUID: bZz3s_MXUjfapxPqW-8XlFH7KlvTziDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_02,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For automated filtering/testing it is useful to have the
filter key logged in the message.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/auditsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c856893041c9..2e349660a56f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1508,6 +1508,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 		audit_log_time(context, &ab);
 		break;
 	}
+	audit_log_key(ab, context->filterkey);
 	audit_log_end(ab);
 }
 
-- 
2.32.0

