Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47FE57D1F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiGUQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiGUQuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:50:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34968AEE8;
        Thu, 21 Jul 2022 09:50:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LCob61012583;
        Thu, 21 Jul 2022 16:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=uSOngsMlx/P519OlD2T4SviaTBg41aXPtvK39CIWeI8=;
 b=DlTpbIhpAMpVTcTtQ7w/O/vNios1k2/2a6j4lW8X/M7iHzVBQV+PYyRImm22EWk0sggQ
 98qQGZWi3x+qeRjIBOtyBK9tSFK7xiLcwcjDdA+SQRq/mhdWiRsQ030Cqta15ACupgOD
 5kwcUTjyr1V80alJWhWCY4U0Ivzj7SAlOTDw5FKYfv9hVP3pCzcnaGvL1eyIT58BkAO0
 Xuj5M1si5gFo3UQbj+d0sWXXiAWSzUzNe7FjIJVIlPQo2EeGLjMSlZLbTFnR+JlLcP7y
 N8rLZmutX/xjC67iedVdPM58llkodvgKOCIU8Iv1RV/p9+B4uinqUHxKNC1BihY9K/yl GQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hf12qsfvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 16:50:27 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26LGoQKK015553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 16:50:26 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Jul
 2022 09:50:26 -0700
Date:   Thu, 21 Jul 2022 09:50:25 -0700
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
Message-ID: <20220721165024.GB14440@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
 <1656359076-13018-6-git-send-email-quic_gurus@quicinc.com>
 <ec04538b-93e2-fa93-4043-c489a0f228e8@quicinc.com>
 <ad5e875d-e5d7-3b6f-4915-98ba08df8c5d@quicinc.com>
 <20220714005735.GA22183@quicinc.com>
 <7d1106b0-178c-7167-34d5-330bb2763c3e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d1106b0-178c-7167-34d5-330bb2763c3e@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GzupB7l2S9FqQCcju0WLu8gqF6z4i4P_
X-Proofpoint-ORIG-GUID: GzupB7l2S9FqQCcju0WLu8gqF6z4i4P_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_23,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 mlxlogscore=924 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207210067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 19 2022 16:03, Rajendra Nayak wrote:
> Ok thanks for the explanation, I actually had a few more comments down in that
> patch which you did not answer, can you clarify them too?

Just replied. Sorry, missed them amidst the wall of lines of context. Could you
please remove all lines of context that are not relevant while replying? That
will help draw attention to the comments that are being made.

Thank you.

Guru Das.
