Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3154CBEFF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiCCNkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiCCNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:40:38 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DFA188A2E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:39:53 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2235lqoE030833;
        Thu, 3 Mar 2022 07:39:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Wil96UH11D63VQZT9D+yQu3zLFJpjvNbnxG2lAUNVzY=;
 b=d0nOHZQIdPfdrj82Bq6f2ecHOSRjadeUwWvQXDGsM/GOrxLT1rx17goUDbRcYJIa5cz1
 ozmhirG4mdlw6MylVNiMXwsyIEee50fZAJE4OkZAKYAB4+DTH/3vxIQP3GuMI2JHGI+r
 vNzkDgqQBbcXGa0QOuLhVeVViRY9wWsfp70vW9q2SfpiKuh6q634cwmTETLadU4R85If
 FfHiPUeiN8Nf3HmBQZEGIwC4OpzQFsV3ZcSezI/MH00qD9n33ADcCkq0DLh6WqanRqBD
 S0ln6YtHPWmlc2oW2BUoA1wv8M+H9NmQTyMgmY1V3D5Joki89yMzkZmtL/eTH6/chUN6 iw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8mbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 07:39:40 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 13:39:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 13:39:38 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8E3217C;
        Thu,  3 Mar 2022 13:39:38 +0000 (UTC)
Date:   Thu, 3 Mar 2022 13:39:38 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
CC:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <patches@opensource.cirrus.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: rtc-wm8350: Handle error for wm8350_register_irq
Message-ID: <20220303133938.GP38351@ediswmail.ad.cirrus.com>
References: <20220303085030.291793-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220303085030.291793-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: q-McmAQFGKQjxFEtF2jzsa19I2Ed8unW
X-Proofpoint-GUID: q-McmAQFGKQjxFEtF2jzsa19I2Ed8unW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:50:30PM +0800, Jiasheng Jiang wrote:
> As the potential failure of the wm8350_register_irq(),
> it should be better to check it and return error if fails.
> Also, it need not free 'wm_rtc->rtc' since it will be freed
> automatically.
> 
> Fixes: 077eaf5b40ec ("rtc: rtc-wm8350: add support for WM8350 RTC")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
