Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED59C544D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiFINH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiFINHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:07:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07A85EE4;
        Thu,  9 Jun 2022 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654780062; x=1686316062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PTrfA4+QXjPYtg7WES29RLAhtkp56K5doQjbZoUFJhE=;
  b=jNsOoN3zr0VsoaCsDIUIirWSxEpEmyil8DZK4060SeD1KHnHYlZQgRkW
   01GRR4LJq9QBdRHDxtSzfT4AxAs3CuLKQRuJyYbpH6Lg2qzT0tMxMCGa0
   HQJzKPLN6mTymJSM95TQqGXW7jW0Vn/mERVG5cSYm04oJ7xKaHL1UTTiF
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jun 2022 06:07:41 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 06:07:41 -0700
Received: from [10.242.59.11] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 06:07:37 -0700
Message-ID: <58c87a74-52e3-1133-f5cc-56c098f0273e@quicinc.com>
Date:   Thu, 9 Jun 2022 18:37:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V5] arm64: perf: Make exporting of pmu events configurable
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
 <20220609100247.GA2187@willie-the-truck>
 <4f5dbc00-e25b-f6ff-8585-31fc50f48a21@quicinc.com>
 <20220609113225.GA2326@willie-the-truck>
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
In-Reply-To: <20220609113225.GA2326@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/2022 5:02 PM, Will Deacon wrote:
> [Please don't top-post]
>
> On Thu, Jun 09, 2022 at 04:05:20PM +0530, Srinivasarao Pathipati wrote:
>> On 6/9/2022 3:32 PM, Will Deacon wrote:
>>> On Mon, May 23, 2022 at 05:19:34PM +0530, Srinivasarao Pathipati wrote:
>>>> The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
>>>> Make is configurable using sysctls to enable/disable at runtime.
>>>> It can also be enabled at early bootup with kernel arguments.
>>>>
>>>> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
>>>> ---
>>>> Changes since V4:
>>>> 	- Registering sysctls dynamically for only arm64 as suggested by Will
>>>> 	- Not removed the code to configure with kernel parameters
>>>> 	  as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
>>>> 	  is not working at early bootup. pmu_reset() getting called before
>>>> 	  sysctl's kernel parameter is set.
>>> Why do you need this during early bootup? Perf won't program any events
>>> until much later and if somebody else is configuring the PMU before
>>> entering Linux then they can also set that X bit in the PMCR.
>> On our Qualcomm platforms, The X bit is getting set by firmware at early
>> bootup for Qualcomm use cases
>> and non-secure world is resetting it, that causing issue.
> What "Qualcomm use cases" and why should we care about them upstream?

Thanks Will & Robin for your inputs .

Understood your point ,  pushed next version [V6] after removing kernel 
parameters code.

>
> Will
