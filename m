Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72144CA4F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbiCBMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiCBMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:39:06 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80F6F4A3;
        Wed,  2 Mar 2022 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646224704; x=1677760704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UgICb5ciFEnI1dKFbScEEs2FF9Max9eXOAfOpAvRCQw=;
  b=iQmQBhrTsr8VXw0DOFJbfFMPROqZ661YwZGVD+zbc9Q4UQaCCHytuwn+
   dM/Pgju1ZH9x/nOooqi16E40Pk+fA24NVjBmp8guKzVl9Y9b+ZtDZ2InQ
   v5RvZhXXlrw6WCzEfitWqd0FxTGehmnXD2axFZnWzJeJJ/anLRLTipYTY
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 04:38:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 04:38:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 04:38:02 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 2 Mar 2022
 04:38:01 -0800
Date:   Wed, 2 Mar 2022 07:37:59 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [tip: sched/core] sched/numa: Avoid migrating task to CPU-less
 node
Message-ID: <Yh9lJ8FqX67C0zj6@qian>
References: <20220214121553.582248-2-ying.huang@intel.com>
 <164512421264.16921.689831789198253265.tip-bot2@tip-bot2>
 <Yh6H8SPSqpjv1dl7@qian>
 <87v8wx1850.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v8wx1850.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 08:59:55AM +0800, Huang, Ying wrote:
> Thanks for reporting!  Can you try whether the following debug patch can fix the issue?

Yes, it prevents the crash.
