Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2824E579077
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiGSCHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiGSCG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:06:58 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD9A3C8F0;
        Mon, 18 Jul 2022 19:06:57 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26INawPX011668;
        Mon, 18 Jul 2022 19:06:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 from : subject : to : cc; s=pfptdkimsnps;
 bh=pgyyw7qloBP+2PnQ9zZFbJUixZQLm17L1ypgw4nxJk4=;
 b=XmenRxfX26WaeBIuybtPrtfF13mZBjRgoC35ez2rm+idAOwAwC03DTbUX4tCJmA97ILb
 W5BWVHSHzAiNt0ywlgOx30AQEKsE6CNEzZOTDmV+8I/zL+ZVLYxIk7ISh0j3h7kdzDbE
 GR1H+PEyYeX6n0OOsN69Yf0AU0JYAL3j1YRZ8+e6nYmuscKdn3NMh76o5EW0oozSJdr3
 OlKgfoKa55VVmr1sbR3O3VmRBjxKPsZTeKC76oYCFxmR1G/s3PN5JXkRGZAoR8ReuZDo
 myGhOV5ASunZt1U6F7/6uTdSUez3VD5YlRead9hnjQDca8WPoCP1m4ro4G5B0lEYRMUd zA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5wnu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 19:06:55 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 87369C0649;
        Tue, 19 Jul 2022 02:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658196415; bh=XWjDZFd15XO417ldxwYTtRi6BFQvhWBskNoQ9usEtvY=;
        h=Date:From:Subject:To:Cc:From;
        b=WxRzYjZKuS1ucvKSwWsj0CQIIxBQvDW6mw7m5PBE180/76V6F5Akq72z+vHM6vRFQ
         96C1aJINU50bHuhivtJib3FSIFr1DNRwGxTJp2enus+yxr7udQyK8bolI3mjqvFC9x
         arHyvzshU8T3Dew/2NMeKOTMQIUFJvtpSyVaDfa/1YUX9pbHscex/oYnUaXd5PMrYQ
         I4FrkH/xJEA49kgFqgOzsCgrW5AOcU4xmOD0X11WyBCYUN+Aoy5iw2NBs2IJElJyNG
         QsU5yBQOjU9y78r8YY0Rrgvhp9NuqaGuHKt82pbyClc4qD8BbOTJXQQIz2cdU+8E2I
         b5g+aShdRm91Q==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 44AE1A0096;
        Tue, 19 Jul 2022 02:06:54 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 19:06:54 -0700
Date:   Mon, 18 Jul 2022 19:06:54 -0700
Message-Id: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 0/4] target: Updates related to UASP
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org
X-Proofpoint-GUID: tiUmZkrYdzIjS_3tKp_zeVtixkv1zJUG
X-Proofpoint-ORIG-GUID: tiUmZkrYdzIjS_3tKp_zeVtixkv1zJUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=825 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some changes splitted from the series below [*]:
"[PATCH 00/36] usb: gadget: f_tcm: Enhance UASP driver"

Cc: linux-usb@vger.kernel.org

Changes in v2:
 - From review, remove the following patches either because they are incorrect
   or not needed:
     target: Don't drain empty list
     target: Does tmr notify on aborted command
     target: Don't remove command too early
     target: Return Function Complete
     target: Don't do tmr_notify on empty aborted list
     target: Refactor core_tmr_abort_task
     target: Don't respond TMR_LUN_DOES_NOT_EXIST for all TMR failure
     target: Introduce target_submit_tmr_fail_response
     target: Include INQUIRY length
 - Minor fixes to the remaining patches


[*] https://lore.kernel.org/linux-usb/cover.1657149962.git.Thinh.Nguyen@synopsys.com/





Thinh Nguyen (4):
  target: Handle MI_REPORT_SUPPORTED_OPERATION_CODES
  target: Implement TMR_ABORT_TASK_SET
  target: Properly set Sense Data Length of CHECK CONDITION
  target: Properly set Sense data length when copy sense

 drivers/target/target_core_alua.c      | 70 ++++++++++++++++++++++++++
 drivers/target/target_core_alua.h      |  2 +
 drivers/target/target_core_spc.c       | 14 +++++-
 drivers/target/target_core_tmr.c       | 16 ++++--
 drivers/target/target_core_transport.c | 21 ++++++--
 5 files changed, 111 insertions(+), 12 deletions(-)


base-commit: 88a15fbb47db483d06b12b1ae69f114b96361a96
-- 
2.28.0

