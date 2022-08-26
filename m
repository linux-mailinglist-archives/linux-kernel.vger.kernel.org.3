Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772FC5A2D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbiHZRct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiHZRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:32:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B827DB06E;
        Fri, 26 Aug 2022 10:32:45 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QFRlGU003072;
        Fri, 26 Aug 2022 17:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ecRmlNQsuaYmhxcydyYYt1QTJ13LiRhIIAvbEV3Gjis=;
 b=YHK3vvq6Lh+xuq6OAG6Lfth7Y7QXGrtYi3wQxKJ+cR4xuLznqq0a6Z9OQshnEKHghyVR
 9AQpBwqjOBsAtDRD9WP3JfdgiQcZrh4se4gjeQS9FcWjVHe6qtZH9MjjS2uO48LgKPCX
 I8/wEj+uCVK3koGZVUKTg7AHyJv2Pm2cCnYRw/ejxiuAmKZNclq0k1lVrB0APFXqH7Y/
 zdUj8vsX9qXtEHm8QIosundBYJtuqZVHcpsf6y4rKccvyhghtPiRQ3d8rKwk7696DXVt
 1ubFbawk8TnNvLVNylYUXqS4c/zgC7CtJsTB9NnKVVcVpihmQnNT0b+bZPqQfffi0+CN FQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j6j4mk1bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 17:32:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27QHWX2c009617
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 17:32:33 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 26 Aug 2022 10:32:30 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Maxim Devaev <mdevaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] usb: gadget: mass_storage: Fix cdrom data transfers on MAC-OS
Date:   Fri, 26 Aug 2022 23:02:22 +0530
Message-ID: <1661535142-5204-1-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 06b6ufFt0kq0JvjKySi3Kg_FNqHHzp0L
X-Proofpoint-ORIG-GUID: 06b6ufFt0kq0JvjKySi3Kg_FNqHHzp0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=258
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During cdrom emulation, the response to read_toc command must contain
the cdrom address as the number of sectors (2048 byte sized blocks)
represented either as an absolute value (when MSF bit is '0') or in
terms of PMin/PSec/PFrame (when MSF bit is set to '1'). Incase of
cdrom, the fsg_lun_open call sets the number of sectors to 2048 byte
sized blocks.

When MAC OS sends a read_toc request with MSF set to '1', the
store_cdrom_address assumes that the address being provided is the
LUN size represented in 512 byte sized blocks instead of 2048. It
tries to modify the address further to convert it to 2048 byte sized
blocks and store it in MSF format. This results in data transfer
failures as the cdrom address being provided in the read_toc response
is incorrect.

Fixes: 3f565a363cee ("usb: gadget: storage: adapt logic block size to bound block devices")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/gadget/function/storage_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index 03035db..db40392 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -295,7 +295,6 @@ void store_cdrom_address(u8 *dest, int msf, u32 addr)
 {
 	if (msf) {
 		/* Convert to Minutes-Seconds-Frames */
-		addr >>= 2;		/* Convert to 2048-byte frames */
 		addr += 2*75;		/* Lead-in occupies 2 seconds */
 		dest[3] = addr % 75;	/* Frames */
 		addr /= 75;
-- 
2.7.4

