Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6324F4DB729
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355861AbiCPRa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiCPRax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:30:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300E5B3D6;
        Wed, 16 Mar 2022 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647451778; x=1678987778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+xhifC9vlTQFwQ9YWjiKID87ju32ttb6F0adLroaUZg=;
  b=RKmx8NujgM879ah6J/q1hnrnKlFH0373kwAVaMDo/KfGNLzk0i0m2v5Q
   k2OUHJk4CicN2XZEaYSp4FgtdYzob8tfOZQQa9vC8zmfnPwn/7UNnGvTi
   tbpyn3jhty3ANWM3J/x4fOKfLkgyaIbPXdk+0/xBf/msU1/v8tbtjlICe
   NsfPFyCsseifYKJBB/RxTut02XJ7iNBbvJWAN6avfp0EehUIoD26db2Mv
   RFLm5YUxWTW1t+IHcI4XKAU4Qu5GkbnyOzM4TSBKKtcmqayVWoYiLAGpA
   4lvKWHTLSQnMVXnJ4kHCVu8guPCRtGyAmHF3R9FEdZaWs9fOYzp0YHHQ/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244124761"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244124761"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:29:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="513120436"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:29:35 -0700
Date:   Wed, 16 Mar 2022 10:29:33 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        graeme.gregory@linaro.org, will.deacon@arm.com,
        myron.stowe@redhat.com, len.brown@intel.com, ying.huang@intel.com
Subject: Re: [BUG] kernel side can NOT trigger memory error with einj
Message-ID: <YjIeff7ESJB/amYA@agluck-desk3.sc.intel.com>
References: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:19:12PM +0800, Shuai Xue wrote:
> Hi folks,
> 
> If we inject an memory error at physical memory address, e.g. 0x92f033038,
> used by a user space process:
> 
> 	echo 0x92f033038 > /sys/kernel/debug/apei/einj/param1
> 	echo 0xfffffffffffff000 > /sys/kernel/debug/apei/einj/param2
> 	echo 0x1 > /sys/kernel/debug/apei/einj/flags
> 	echo 0x8 > /sys/kernel/debug/apei/einj/error_type
> 	echo 1 > /sys/kernel/debug/apei/einj/error_inject
> 
> Then the following error will be reported in dmesg:
> 
>     ACPI: [Firmware Bug]: requested region covers kernel memory @ 0x000000092f033038
> 
> After digging into einj trigger interface, I think it's a kernel bug.

I think you are right. This isn't the first bug where Linux tries
to validate addresses supplied by EINJ for Linux to read/write.

I hadn't come across it because I almost always set:

# echo 1 > notrigger

so that I can have some application, or function in the kernel
trigger the error. Instead of running the EINJ trigger action
to make it happen right away.

> I am wondering that should we use kmap to map RAM in acpi_map or add a
> another path to address this issue? Any comment is welcomed.

Perhaps just drop the sanity checks? Just trusting the BIOS? Sounds
radical, but this is validation code where the user is deliberately
injecting errors. If there are BIOS bugs, then people doing validation
may be well positioned to find the BIOS people to make them fix
things.

Problem with this approach is that EINJ calls into the APEI code
that is used for other things besides error injection for validation.
So a blanket removal of sanity checks wouldn't be a good idea.

-Tony
