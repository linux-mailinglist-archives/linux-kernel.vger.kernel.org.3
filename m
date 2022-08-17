Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8D597CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbiHRERW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiHRERN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:17:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCC80513;
        Wed, 17 Aug 2022 21:17:12 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I1uh3l008456;
        Thu, 18 Aug 2022 04:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=noabOEHneJxCBrb7N/ft+t1do/5udp+DULkSI6s3pC4=;
 b=oi8/iXF7oj9nuMvzpHxsgOzueMej0yTyFProoqlPXNN7A/X6pUHvVcBBtWMeaFIipsdY
 VIz91VE0XY8T4187eQ7X8HeEV//8hjHlstjyY2jLqkrczr3kqTJlk7wO32AaJ+egtbO3
 gpuFwvm7Ejei7kEO9SMLqwOlhxqoQ8iibMVTPglb1Si/p7QUzctlcEkY6Ll1XFLRCKy0
 TakX+fYfqNj8rgYv3ERB79TEM8K7OMc0HeJiWWuQg8wiicrdFMMsS9cCTByNIy5gUrMY
 /8gqBtScY8HAet+nrq5JWBhpNH5TK/LLrFKTVkotCxum66pgGP3tfFR+XBZ25BT4mHPb Yw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j0w7hm3pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4GxVQ017882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:01 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 19:24:09 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 11:24:10 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v4 0/9] Fix controller halt and endxfer timeout issues
Date:   Wed, 17 Aug 2022 11:23:50 -0700
Message-ID: <20220817182359.13550-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RGYTwiUgEyk_fZI-ikbjtKxPk0ULRQC4
X-Proofpoint-GUID: RGYTwiUgEyk_fZI-ikbjtKxPk0ULRQC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=483 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
- Split the increase timeout patch into separate patches. #1 for the
gadget suspend/resume locking changes #2 for the increased timeout
- Modified msleep to usleep_range w/ an interval of 1-2ms and a max
timeout of 4s.

Changes in v3:
- Modified the msleep() duration to ~2s versus ~10s due to the minimum
mdelay() value.
- Removed patch to modify DEP flags during dwc3_stop_active_transfer().
This was not required after fixing the logic to allow EP xfercomplete
events to be handled on EP0.
- Added some changes to account for a cable disconnect scenario, where
dwc3_gadget_pullup() would not be executed to stop active transfers.
Needed to add some logic to the disconnect interrupt to ensure that we
cleanup/restart any pending SETUP transaction, so that we can clear the
EP0 delayed stop status. (if pending)
- Added patch to ensure that we don't proceed with umapping buffers
until the endxfer was actually sent.

Changes in v2:
- Moved msleep() to before reading status register for halted state
- Fixed kernel bot errors
- Clearing DEP flags in __dwc3_stop_active_transfers()
- Added Suggested-by tags and link references to previous discussions

This patch series addresses some issues seen while testing with the latest
soft disconnect implementation where EP events are allowed to process while
the controller halt is occurring.

#1
Since routines can now interweave, we can see that the soft disconnect can
occur while conndone is being serviced.  This leads to a controller halt
timeout, as the soft disconnect clears the DEP flags, for which conndone
interrupt handler will issue a __dwc3_ep_enable(ep0), that leads to
re-issuing the set ep config command for every endpoint.

#2
Function drivers can ask for a delayed_status phase, while it processes the
received SETUP packet.  This can lead to large delays when handling the
soft disconnect routine.  To improve the timing, forcefully send the status
phase, as we are going to disconnect from the host.

#3
Ensure that local interrupts are left enabled, so that EP0 events can be
processed while the soft disconnect/dequeue is happening.

#4
Since EP0 events can occur during controller halt, it may increase the time
needed for the controller to fully stop.

#5
Account for cable disconnect scenarios where nothing may cause the endxfer
retry if DWC3_EP_DELAY_STOP is set.

#6
Avoid unmapping pending USB requests that were never stopped.  This would
lead to a potential SMMU fault.


Wesley Cheng (9):
  usb: dwc3: Do not service EP0 and conndone events if soft disconnected
  usb: dwc3: gadget: Force sending delayed status during soft disconnect
  usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
  usb: dwc3: gadget: Continue handling EP0 xfercomplete events
  usb: dwc3: Avoid unmapping USB requests if endxfer is not complete
  usb: dwc3: Remove DWC3 locking during gadget suspend/resume
  usb: dwc3: Increase DWC3 controller halt timeout
  usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer
  usb: dwc3: gadget: Submit endxfer command if delayed during disconnect

 drivers/usb/dwc3/core.c   |  4 ----
 drivers/usb/dwc3/core.h   |  3 +++
 drivers/usb/dwc3/ep0.c    | 11 ++++++---
 drivers/usb/dwc3/gadget.c | 48 +++++++++++++++++++++++++++++++++------
 4 files changed, 52 insertions(+), 14 deletions(-)

