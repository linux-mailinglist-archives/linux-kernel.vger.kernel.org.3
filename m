Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1707557D1E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiGUQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGUQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:48:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B08812D;
        Thu, 21 Jul 2022 09:48:26 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LCXeC8021465;
        Thu, 21 Jul 2022 16:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=CjpWaSkMjpushvLWWB+MZ+mEPHbX6DOXx0M+VrxWs6Q=;
 b=PUwhepW/eqMzzMUf3pgdU4jM2GZCb1eezFoZtWuVdu3u1hWUn0Qtfqa43kJb2kg01VCb
 S43+8ipTPxrIlcdDezj1aNuKvAwGnHVZx/uXzVk1aWH78ooM4RpCFh6CZzlsPOCa8es8
 z7C8zhYasX7lRYwEm0RlxHPUb/lMh0WzdG9o9RVPdJymT52JU5rz4iHnq23wksP+z0kD
 pPxAxTtwllBoa8dKzomGkbIk3ARhe8sWoaQWWp6uimbns+TTTw7Q/Em0ogMdITRBriV4
 stPVY6jcqIGdQlqRekgy9CfyI8Re2FBemc7Ej5OrBGRR/bDeqwx6CbZOgm5whPM9252P 7Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3heb3x4kae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 16:48:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26LGm9W9011413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 16:48:09 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Jul
 2022 09:48:09 -0700
Date:   Thu, 21 Jul 2022 09:48:07 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David Heidelberg" <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH 5/5] firmware: qcom: scm: Add wait-queue handling logic
Message-ID: <20220721164807.GA14440@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
 <1656359076-13018-6-git-send-email-quic_gurus@quicinc.com>
 <ec04538b-93e2-fa93-4043-c489a0f228e8@quicinc.com>
 <ad5e875d-e5d7-3b6f-4915-98ba08df8c5d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad5e875d-e5d7-3b6f-4915-98ba08df8c5d@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d8FmaQ9dRYTCRwB3ffjiYAACf2Q1IPQV
X-Proofpoint-ORIG-GUID: d8FmaQ9dRYTCRwB3ffjiYAACf2Q1IPQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_23,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=864 impostorscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 01 2022 16:51, Rajendra Nayak wrote:
> >>+
> >>+            if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
> >>+                wait_for_completion(wq);
> >>+                fill_wq_resume_args(smc, smc_call_ctx);
> >>+                wq = NULL;
> >>+                continue;
> >>+            } else {
> >>+                fill_wq_wake_ack_args(smc, smc_call_ctx);
> >>+                continue;
> >>+            }
> >>+        } else if ((long)res->a0 < 0) {
> >>+            /* Error, simply return to caller */
> >>+            break;
> 
> if my understanding above is correct, shouldn't we do a
> >>+            if (wq)
> >>+                scm_waitq_flag_handler(wq, flags);
> in the error case also?

Yes, you're right, since both error or success means that a request is
complete. We should act the same way for error as for success. Thanks for
catching this.

> Also why no just scm_waitq_flag_handler(wq, flags); before fill_wq_wake_ack_args(smc, smc_call_ctx);?

Because that is not part of the protocol - calling scm_waitq_flag_handler(wq, flags)
would result in a completion being freed, meaning a sleeping call would be
woken up, which is not what we want. When a WAITQ_WAKE is received, the
action to be taken is to immediately respond with a wq_wake_ack() and nothing
else.
