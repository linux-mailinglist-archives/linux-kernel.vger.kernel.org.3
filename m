Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19F4871FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiAGFKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:10:14 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:39380 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbiAGFKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641532213; x=1673068213;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KgL8VrGMs8Bx+NMrwfWdtzpBiKkTEKV1Et/z9iC0lbU=;
  b=f11UbLrb5YebEtbdTOmC9Z8OkQxvqjL2++x6NJxf3B6jksbIxnUm6ue2
   7zx7Vu61uoQL0lXaKwbwxJZeFVI5h3/D0iQDwOFpHieYaWKZgHqlRhS2v
   V6gkzWbMauv8ptad6GnRzVkvuzV54B+IJMXNTrOSMfwoi+k22vtgUB09G
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jan 2022 21:10:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 21:10:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 6 Jan 2022 21:10:12 -0800
Received: from [10.50.8.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 6 Jan 2022
 21:10:08 -0800
Message-ID: <df9b5a82-5f00-f3ec-14cf-0b212be2a7a7@quicinc.com>
Date:   Fri, 7 Jan 2022 10:40:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv6 4/5] tracing: Add register read/write tracing support
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
References: <cover.1638858746.git.quic_saipraka@quicinc.com>
 <76983c26d889df7252a17017a48754163fb6b0d5.1638858747.git.quic_saipraka@quicinc.com>
 <20220106131824.073fbe5c@gandalf.local.home>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220106131824.073fbe5c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 1/6/2022 11:48 PM, Steven Rostedt wrote:
> This should not be in the kernel/trace directory. It should be in the

Hmm these are called from low level generic io header file 
(include/asm-generic/) where
we wouldn't have any Kconfig to control this feature flexibly and as we 
can have this as
a generic feature selectable by other architectures, wouldn't this be 
suited in kernel/trace?
I thought you were ok with the folder structure in the initial versions 
of the series?

Thanks,
Sai
