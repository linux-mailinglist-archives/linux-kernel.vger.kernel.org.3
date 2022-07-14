Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E95740BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGNBEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiGNBEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:04:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CC31758E;
        Wed, 13 Jul 2022 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657760647; x=1689296647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlc/D0oD3bwnMh5O2RFhSO7vCAqJUs807PtajVeEH9A=;
  b=xTkVvvoxVT8ow2WTfjpxgAFv4JLJzZlrDC5A3Q5mGf7Q2GK9n8ySUOAD
   STycw9jF/4jpNH97Td65FNsj/FKmLQXE9L8Ke+z8ztGdJuKY8oAuGAL/o
   5CRnlsVFRKCeJpEvpl+HjxQU+Cp8sC/jHMXmKCJX2GDSEpUFt4JZE8VnV
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jul 2022 18:04:07 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:04:07 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 18:04:06 -0700
Date:   Wed, 13 Jul 2022 18:04:05 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David Heidelberg" <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH 4/5] firmware: qcom: scm: Add wait-queue helper functions
Message-ID: <20220714010405.GB22183@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
 <1656359076-13018-5-git-send-email-quic_gurus@quicinc.com>
 <aa754d43-ec58-97c7-e50b-0459a850e302@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aa754d43-ec58-97c7-e50b-0459a850e302@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 01 2022 16:29, Rajendra Nayak wrote:
> 
> On 6/28/2022 1:14 AM, Guru Das Srinagesh wrote:
> >When the firmware (FW) supports multiple requests per VM, and the VM also
> >supports it via the `enable-multi-call` device tree flag, the floodgates
> >are thrown open for them to all reach the firmware at the same time.
> >
> >Since the firmware currently being used has limited resources, it guards
> >them with a resource lock and puts requests on a wait-queue internally
> >and signals to HLOS that it is doing so. It does this by returning two
> >new return values in addition to success or error: SCM_WAITQ_SLEEP and
> >SCM_WAITQ_WAKE.
> >
> >   1) SCM_WAITQ_SLEEP:
> >
> >   	When an SCM call receives this return value instead of success
> >   	or error, FW has placed this call on a wait-queue and
> >   	has signalled HLOS to put it to non-interruptible sleep. (The
> >	mechanism to wake it back up will be described in detail in the
> >	next patch for the sake of simplicity.)
> >
> >	Along with this return value, FW also passes to HLOS `wq_ctx` -
> >	a unique number (UID) identifying the wait-queue that it has put
> >	the call on, internally. This is to help HLOS with its own
> >	bookkeeping to wake this sleeping call later.
> >
> >	Additionally, FW also passes to HLOS `smc_call_ctx` - a UID
> >	identifying the SCM call thus being put to sleep. This is also
> >	for HLOS' bookkeeping to wake this call up later.
> >
> >	These two additional values are passed via the a1 and a2
> >	registers.
> >
> >	N.B.: The "ctx" in the above UID names = "context".
> >
> >   2) SCM_WAITQ_WAKE:
> >
> >   	When an SCM call receives this return value instead of success
> >   	or error, FW wishes to signal HLOS to wake up a (different)
> >   	previously sleeping call.
> 
> What happens to this SCM call itself (The one which gets an SCM_WAITQ_WAKE returned
> instead of a success or failure)?
> is it processed? how does the firmware in that case return a success or error?

Hopefully, with the clarificatory note posted in response to your query on the
other patch, this is clear. To answer your question:

Let's refer to the SCM call that received an SCM_WAITQ_WAKE as the parent call.
The parent call's success or failure depends on the result of the wq_wake_ack()
call defined below.

> 
...

> >   3) wq_wake_ack(smc_call_ctx):
> >
> >   	Arguments:	smc_call_ctx
> >
> >   	HLOS needs to issue this in response to receiving an
> >   	SCM_WAITQ_WAKE, passing to FW the same smc_call_ctx that FW
> >   	passed to HLOS via the SMC_WAITQ_WAKE call.

...

> >+
> >  static int qcom_scm_probe(struct platform_device *pdev)
> >  {
> >  	struct qcom_scm *scm;
> >  	unsigned long clks;
> >-	int ret;
> >+	int irq, ret;
> >  	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
> >  	if (!scm)
> >@@ -1333,12 +1432,28 @@ static int qcom_scm_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >+	platform_set_drvdata(pdev, scm);
> >+
> >  	__scm = scm;
> >  	__scm->dev = &pdev->dev;
> >+	spin_lock_init(&__scm->waitq.idr_lock);
> >+	idr_init(&__scm->waitq.idr);
> >  	qcom_scm_allow_multicall = of_property_read_bool(__scm->dev->of_node,
> >  							"allow-multi-call");
> >+	INIT_WORK(&__scm->waitq.scm_irq_work, scm_irq_work);
> >+
> >+	irq = platform_get_irq(pdev, 0);
> >+	if (irq) {
> >+		ret = devm_request_threaded_irq(__scm->dev, irq, NULL,
> >+			qcom_scm_irq_handler, IRQF_ONESHOT, "qcom-scm", __scm);
> >+		if (ret < 0) {
> >+			pr_err("Failed to request qcom-scm irq: %d\n", ret);
> 
> idr_destroy()?

Yes, will add in next patchset.
