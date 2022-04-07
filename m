Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0FA4F75D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbiDGGRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiDGGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:17:36 -0400
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [203.148.12.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D71F047C;
        Wed,  6 Apr 2022 23:15:35 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 7 Apr
 2022 14:15:31 +0800
Received: from [10.29.8.49] (10.29.8.49) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 7 Apr
 2022 14:15:30 +0800
Message-ID: <bd43807d-a2d7-5742-4253-c443cdf5c2f0@zhaoxin.com>
Date:   Thu, 7 Apr 2022 14:15:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] USB:Fix ehci infinite suspend-resume loop issue in
 zhaoxin
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>
References: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
 <Yi9QIk+6VIWW6V/W@rowland.harvard.edu>
 <320584eb-ef89-3759-509c-e7e9cb10f983@zhaoxin.com>
 <YjCuOXRFZ8CjK9SD@rowland.harvard.edu>
 <ac40c227-ea26-bccd-d254-5a2034103184@zhaoxin.com>
 <YkxoHY2SVomGwGdh@rowland.harvard.edu>
 <bbd9148d-5970-2233-6ee9-625e961cd2f5@zhaoxin.com>
 <Yk29tZpy9pLDlPj2@rowland.harvard.edu>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <Yk29tZpy9pLDlPj2@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.49]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/7 00:20, Alan Stern wrote:
> On Wed, Apr 06, 2022 at 10:38:28AM +0800, WeitaoWang-oc@zhaoxin.com wrote:
>> On 2022/4/6 00:02, Alan Stern wrote:
>>> In fact, the resume kernel doesn't call ehci_resume at all.  Here's what
>>> it does:
>>>
>>> 	The resume kernel boots;
>>>
>>> 	If your patch causes STS_PCD to be set at this point, the flag
>>> 	should get cleared shortly afterward by ehci_irq;
>>>
>>> 	ehci-hcd goes into runtime suspend;
>>>
>>> 	The kernel reads the system image that was stored earlier when
>>> 	hibernation began;
>>>
>>> 	After the image is loaded, the system goes into the freeze
>>> 	state (this does not call any routines in ehci-hcd);
>> On this phase, pci_pm_freeze will be called for pci device. In this
>> function, pm_runtime_resume will be called to resume already
>> runtime-suspend devices. which will cause ehci_resume to be called.
>> Thus STS_PCD flag will be set in ehci_resume function.
> 
> Aha!  I was missing that piece of information, thanks.
> 
> But this still doesn't explain why check_root_hub_suspended is failing.
> That routine checks the HCD_RH_RUNNING bit, which gets set in
> hcd_bus_resume.  hcd_bus_resume gets called as part of resuming the root
> hub, and in ehci-hcd this happens when ehci_irq sees that STS_PCD is set
> and calls usb_hcd_resume_root_hub.  That routine queues a wakeup request
> on the pm_wq work queue, which is then supposed to run hcd_resume_work
> to actually restart the root hub.
> 
> But pm_wq is a freezable work queue!  While the system is in the freeze
> state, the work queue isn't running.  This means that the root hub
> should remain suspended until the end of the freeze phase, and so the
> call to check_root_hub_suspended should succeed.
> 
> Can you check to see what's really happening on your system?  Something
> must be wrong with my analysis, but I can't tell what it is.  I'm still
> puzzled.
> 
> Alan Stern
Your analysis is right, my test platform's kernel version is not the
latest, this kernel not call freeze_kernel_threads on software_resume
function.
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/power/hibernate.c?h=v5.18-rc1&id=2351f8d295ed63393190e39c2f7c1fee1a80578f)
So pm_wq is active and can handle root hub power events.
Update my kernel to fix the issue in the url above, system hibernation
test was successful with our patch(not clear STS_PCD bit).
Thanks for your clarification.

Weitao Wang
