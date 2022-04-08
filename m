Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADC4F9BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbiDHRgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbiDHRgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:36:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE86AACAA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649439260; x=1680975260;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=hsHvmXkAO7Z/X+ZfPmp4tfAodc4efwkezWwR3R+tMlI=;
  b=tI2mxe4QtT1P7i9ZD7n9p+YCzCFnZuQ9OZ1z8uJeZMhcQqPjrbK9qXG6
   bbK/WDmMoZ5OCm0gTTtTz1b9Mzz96011itJrsHzdUAnSDvPe0iCLbfVSX
   kkOTlMcNINM2We4XvtbApgK0JzGiVBVSZvoyF4cNP3E84uRltp8U4Xn+H
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Apr 2022 10:34:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:34:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Apr 2022 10:34:18 -0700
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 8 Apr 2022
 10:34:18 -0700
Message-ID: <6410d0d5-bd88-64d5-6ae7-cca33746b302@quicinc.com>
Date:   Fri, 8 Apr 2022 11:34:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: x86 multi-msi w/o iommu
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I'd like to get multi-MSI without IOMMU working on x86.  I'm hoping you 
could help me understand the current state of things, and if there is a 
path toward enabling this.

This is an overly simplistic assessment, but this reportedly works in 
other OSes, so it looks like Linux is broken in comparison.

In my investigation so far, the failure stems from 
x86_vector_alloc_irqs() in arch/x86/kernel/apic/vector.c [1].  If we 
need a contiguous allocation of more than one irq, the allocation 
immediately fails:

	/* Currently vector allocator can't guarantee contiguous allocations */
	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
		return -ENOSYS;


As I'm sure you are aware, this only impacts MSI without IOMMU as both 
MSI-X and MSI with IOMMU can handle a discontinuous allocation (the flag 
is not set for either of those cases).

That check was added back in 2015 with [2].  In 2017, it looks like you 
refactored the allocator to the irq_matrix component [3].  However, the 
limitation remains to today.

Digging a bit further, it looks like the internal function 
matrix_alloc_area() [4] is capable of doing a contiguous allocation, but 
all the callers of that via the public api hardcode num to 1.  I 
wouldn't say it would be trivial to refactor the irq_matrix public api 
to do a contigious range allocation, and refactor 
x86_vector_alloc_irqs() to do that based on 
X86_IRQ_ALLOC_CONTIGUOUS_VECTORS, but since it seems like that hasn't 
been tackled in 5-7 years (depending on how you look at the history), I 
suspect I'm missing something.

Since I'm poking my nose in an area of the kernel that I haven't gone 
poking into before, I'm guessing there is a lot I don't know.  Would you 
kindly educate me on what the concerns might be?

I look forward to your expertise and opinions.

Thanks

-Jeff



[1]: 
https://elixir.bootlin.com/linux/v5.18-rc1/source/arch/x86/kernel/apic/vector.c#L542
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/apic/vector.c?h=v5.18-rc1&id=b5dc8e6c21e7ffba0246bf39cea97805c142bf85
[3]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/apic/vector.c?h=v5.18-rc1&id=69cde0004a4b5cfc7d1cec4ef9ce4cf4e26142f0
[4]: 
https://elixir.bootlin.com/linux/v5.18-rc1/source/kernel/irq/matrix.c#L110
