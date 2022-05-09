Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6651FE39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiEIN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiEIN0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:26:00 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E714FC92;
        Mon,  9 May 2022 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652102511; x=1683638511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8BssW2vt86Or5YZamPV4O++D2jwvrX19Ct/ALbFqDOg=;
  b=HGsa3uF+nJn5Vnnygjq/10LW12qzJbUIjs85Mxbobliupe5wGsgstLfr
   ZtJQZPawbkEV23ikQB5nfMni+5wry3zAmzo71PXWlLpPMtVhdqPP2GJL8
   QzvAKghpgiCmIN9KEw8zh3Ms9qAEsh6hx/pJ9O7w4mkO0VeaF7/2azbjW
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 May 2022 06:21:50 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:21:49 -0700
Received: from [10.242.59.11] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 06:21:46 -0700
Message-ID: <a4e3a53a-ba66-835d-41ab-4ef5a3e1496e@quicinc.com>
Date:   Mon, 9 May 2022 18:51:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V2] arm64: perf: Retain PMCR.X of PMCR_EL0 during reset
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1651231749-19565-1-git-send-email-quic_c_spathi@quicinc.com>
 <20220506141213.GA23485@willie-the-truck>
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
In-Reply-To: <20220506141213.GA23485@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Will for reviewing patch

We are seeing issue at early boot up , so we will make this configurable 
with kernel arguments and push

On 5/6/2022 7:42 PM, Will Deacon wrote:
> Changes since V1:
> 	- Preserving only PMCR_X bit as per Robin Murphy's comment
