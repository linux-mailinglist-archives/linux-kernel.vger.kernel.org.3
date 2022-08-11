Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4158F63D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiHKDCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiHKDC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:02:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94D8B9B6;
        Wed, 10 Aug 2022 20:00:40 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B0kaAr019987;
        Thu, 11 Aug 2022 03:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=hhoND+9R0x+PcnI5xccp7yL4SYBWJAzVC2AcIZgMUJg=;
 b=ip9w46wopb9i0v/A1NlTatAwcMbWTfXmXhpIzNE0oRutzllhbvCIyF4NYkReG+81iUDl
 VoSDPH3S/PyjtWl9JsDEmQqynHSDAmbaIHcbC3dhxGKemU3le0Arid0YiL4OEVTegiVM
 mIABWQWixAbIQiymTsIviRmUKrTXB249JN8COJ5YZWD0V7ZJrHgYOCWu8RMQCDmaraZV
 AXTMwzTedomVM/rG1Y6QMmuXtF0mHVA6TscUo3YCv1n5TIME98RQrpinEce8KzhfANCf
 O67k2AencsnptiKZpJSsiuc7K/jERKsUWicSk5ZoirKk1C+qlRSZebS8MPXdzL+Xplv/ Gg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hvntg8d6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 03:00:26 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27B30PV5018381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 03:00:25 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 10 Aug
 2022 20:00:25 -0700
Date:   Wed, 10 Aug 2022 20:00:24 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David Heidelberg" <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v2 4/5] firmware: qcom: scm: Add wait-queue helper
 functions
Message-ID: <20220811030022.GA18104@quicinc.com>
References: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
 <1658529438-9234-5-git-send-email-quic_gurus@quicinc.com>
 <1f284b9c-257b-a127-55c0-e6cc8c07a9eb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1f284b9c-257b-a127-55c0-e6cc8c07a9eb@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zXmswYpxUFgDmh9vnRerRmWZqsVX44Rq
X-Proofpoint-ORIG-GUID: zXmswYpxUFgDmh9vnRerRmWZqsVX44Rq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_02,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=402 suspectscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110006
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Rajendra,

Sorry for the delay in response. Needed to clarify with internal team members
on these questions before responding.

On Aug 02 2022 17:07, Rajendra Nayak wrote:
> 
> On 7/23/2022 4:07 AM, Guru Das Srinagesh wrote:
> >When the firmware (FW) supports multiple requests per VM, and the VM
> >also supports it via the `allow-multi-call` device tree flag, the
> >floodgates are thrown open for them to all reach the firmware at the
> >same time.

[...]

> >   2) SCM_WAITQ_WAKE:
> >
> >   	When an SCM call receives this return value instead of success
> >   	or error, FW wishes to signal HLOS to wake up a (different)
> >   	previously sleeping call.
> >
> >   	FW tells HLOS which call to wake up via the additional return
> >   	values `wq_ctx`, `smc_call_ctx` and `flags`. The first two have
> >   	already been explained above.
> >
> >   	`flags` can be either WAKE_ONE or WAKE_ALL. Meaning, wake either
> >   	one, or all, of the SCM calls that HLOS is associating with the
> >   	given `wq_ctx`.
> >
> >A sleeping SCM call can be woken up by either an interrupt that FW
> >raises, or via a SCM_WAITQ_WAKE return value for a new SCM call.
> 
> Do you know why the FW was not designed to always use an interrupt?
> That would have made the handling of this in kernel a lot less complicated.

Because:

1. Our firmware in TrustZone cannot raise interrupts on its own - it needs the
hypervisor to do that.

2. Thus, in platforms where there is no hypervisor, there is no interrupt
possible - only SMC_WAITQ_WAKE.

Therefore, relying only on an interrupt would render the driver unable to
support platforms without a hypervisor, which we didn't want to do.

> >The handshake mechanism that HLOS uses to talk to FW about wait-queue
> >operations involves three new SMC calls. These are:
> >

[...]

> >+static void scm_irq_work(struct work_struct *work)
> >+{
> >+	int ret;
> >+	u32 wq_ctx, flags, more_pending = 0;
> >+	struct completion *wq_to_wake;
> >+	struct qcom_scm_waitq *w = container_of(work, struct qcom_scm_waitq, scm_irq_work);
> >+	struct qcom_scm *scm = container_of(w, struct qcom_scm, waitq);
> >+
> >+	do {
> >+		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
> >+		if (ret) {
> >+			pr_err("GET_WQ_CTX SMC call failed: %d\n", ret);
> >+			return;
> >+		}
> >+
> >+		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
> >+		if (IS_ERR_OR_NULL(wq_to_wake)) {
> >+			pr_err("No waitqueue found for wq_ctx %d: %ld\n",
> >+					wq_ctx, PTR_ERR(wq_to_wake));
> >+			return;
> 
> What happens if at this point 'more_pending' was true? will the FW raise
> another interrupt?

Hmm. At this point, the interrupt handler is early-exiting without waking up a
sleeping call via the flag_handler() because firmware has goofed up and given
it an invalid wq_ctx. We have bigger problems than `more_pending` being true.

> 
> >+		}
> >+
> >+		scm_waitq_flag_handler(wq_to_wake, flags);
> >+	} while (more_pending);
> >+}

Thank you.

Guru Das.
