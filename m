Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325D55A1975
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbiHYTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbiHYTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:22:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CDEBD131;
        Thu, 25 Aug 2022 12:22:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PHK5ZQ022330;
        Thu, 25 Aug 2022 19:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=4OExE7/j1GF9DglWOSxq+7pg6RSVkS6FfZdQPfvxlJc=;
 b=kE/eEyMQYfb/ger5GqaTkpcF9UThEhUVT964mU0pxKxmZdFnXOgKyxx8jbwN150QSYpI
 Mzz3GIYSPc0e1W7I3O2IcMDhCL4Cg6z8JmCpekACWFwepWiG42kJRxB2z1gU6YkOL+sc
 1rSOqlP346ST4LrzqbLWY3s/XJ2iNwRd9dyHcuwhuVZIGsVGjAu5UM4e/ilplJPgSEpf
 GYrURPf0Av1Yx59uP+prasamTsqREhFXRx35MTUm1Ke8vzIeGMswF9gi7bKCI07b/Frx
 BG75rqj8MidBKodkwmN4rdbtTT7ihdeKAXeufmDvHS/U/ayuUL+xaYAj6foHYMF/S7FR 2w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j63v0jxt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 19:22:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PJM3Hn027595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 19:22:03 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 12:22:03 -0700
Date:   Thu, 25 Aug 2022 12:22:01 -0700
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
Message-ID: <20220825192201.GA9699@quicinc.com>
References: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
 <1658529438-9234-5-git-send-email-quic_gurus@quicinc.com>
 <1f284b9c-257b-a127-55c0-e6cc8c07a9eb@quicinc.com>
 <20220811030022.GA18104@quicinc.com>
 <456915bf-b7ff-efaa-72aa-62fd05344270@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <456915bf-b7ff-efaa-72aa-62fd05344270@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UJT53_FmyfyTz6mG95JP9R66bjyHXtKp
X-Proofpoint-ORIG-GUID: UJT53_FmyfyTz6mG95JP9R66bjyHXtKp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 mlxlogscore=550 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 11 2022 11:13, Rajendra Nayak wrote:
> 
> On 8/11/2022 8:30 AM, Guru Das Srinagesh wrote:
> >On Aug 02 2022 17:07, Rajendra Nayak wrote:
> >>
> >>On 7/23/2022 4:07 AM, Guru Das Srinagesh wrote:
> >>>When the firmware (FW) supports multiple requests per VM, and the VM
> >>>also supports it via the `allow-multi-call` device tree flag, the
> >>>floodgates are thrown open for them to all reach the firmware at the
> >>>same time.
> >
> >[...]
> >
> >>>   2) SCM_WAITQ_WAKE:
> >>>
> >>>   	When an SCM call receives this return value instead of success
> >>>   	or error, FW wishes to signal HLOS to wake up a (different)
> >>>   	previously sleeping call.
> >>>
> >>>   	FW tells HLOS which call to wake up via the additional return
> >>>   	values `wq_ctx`, `smc_call_ctx` and `flags`. The first two have
> >>>   	already been explained above.
> >>>
> >>>   	`flags` can be either WAKE_ONE or WAKE_ALL. Meaning, wake either
> >>>   	one, or all, of the SCM calls that HLOS is associating with the
> >>>   	given `wq_ctx`.
> >>>
> >>>A sleeping SCM call can be woken up by either an interrupt that FW
> >>>raises, or via a SCM_WAITQ_WAKE return value for a new SCM call.
> >>
> >>Do you know why the FW was not designed to always use an interrupt?
> >>That would have made the handling of this in kernel a lot less complicated.
> >
> >Because:
> >
> >1. Our firmware in TrustZone cannot raise interrupts on its own - it needs the
> >hypervisor to do that.
> >
> >2. Thus, in platforms where there is no hypervisor, there is no interrupt
> >possible - only SMC_WAITQ_WAKE.
> >
> >Therefore, relying only on an interrupt would render the driver unable to
> >support platforms without a hypervisor, which we didn't want to do.
> 
> Thanks Guru for the clarification, however what problem are we really solving
> with this on platforms _without_ a hypervisor?
> 
> Your cover letter said
> 'The problem this feature is fixing is as follows. In a scenario where there is
> a VM in addition to HLOS (and an underlying hypervisor):'
> 
> So I assumed this was primarily for platforms _with_ a VM/Hypervisor?
> 
> I understand that even with just the HLOS and no VM, if we can get these requests
> processed concurrently it still adds value, but eventually Trustzone will
> still process these requests sequentially right?

The Trustzone (TZ) firmware doesn't process all requests sequentially - there are a
few that require a "callback" back to HLOS. In such cases, the original SCM
call releases the TZ serialization lock, thereby allowing a new call to enter
TZ. It is better to have requests sleep and wake via WAITQ_SLEEP and WAITQ_WAKE
rather than the alternative - retrying an arbitrary amount of times via -EBUSY.
