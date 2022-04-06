Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F54F5D42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiDFMJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiDFMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:08:29 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [203.148.12.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A11A3949;
        Tue,  5 Apr 2022 19:38:34 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 6 Apr
 2022 10:38:30 +0800
Received: from [10.29.8.49] (10.29.8.49) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 6 Apr
 2022 10:38:29 +0800
Message-ID: <bbd9148d-5970-2233-6ee9-625e961cd2f5@zhaoxin.com>
Date:   Wed, 6 Apr 2022 10:38:28 +0800
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
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <YkxoHY2SVomGwGdh@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.49]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/6 00:02, Alan Stern wrote:
> On Wed, Mar 16, 2022 at 10:18:39AM +0800, WeitaoWang-oc@zhaoxin.com wrote:
>> On 2022/3/15 11:18, Alan Stern wrote:
>>> On Tue, Mar 15, 2022 at 08:39:09PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
>>>> I have encountered the following situation if EHCI runtime suspend is
>>>> enabled by default.
> 
> Some things about this still confuse me...
> 
>>>> 1.Wake from system to disk and boot OS.
>>>
>>> You're talking about resuming after hibernation, right?
>>
>> You're right.
>>>> 2.EHCI will entry runtime suspend after enumerated by driver during boot
>>>> phase of suspend to disk
>>>
>>> I'm not sure what you mean by "boot phase of suspend to disk".  This is
>>> while the restore kernel is starting up at the beginning of resume from
>>> hibernation, right?
>>>
>> You understood exactly what I was saying.
> 
> Okay, so we're waking up from hibernation.
> 
>>>> 3.EHCI will be placed to freeze state and ehci_resume is called after image
>>>> is loaded.
>>>
>>> ehci_resume is called to leave runtime suspend.  Going into the freeze
>>> state doesn't require any changes.
> 
> In fact, the resume kernel doesn't call ehci_resume at all.  Here's what
> it does:
> 
> 	The resume kernel boots;
> 
> 	If your patch causes STS_PCD to be set at this point, the flag
> 	should get cleared shortly afterward by ehci_irq;
> 
> 	ehci-hcd goes into runtime suspend;
> 
> 	The kernel reads the system image that was stored earlier when
> 	hibernation began;
> 
> 	After the image is loaded, the system goes into the freeze
> 	state (this does not call any routines in ehci-hcd);
On this phase, pci_pm_freeze will be called for pci device. In this
function, pm_runtime_resume will be called to resume already
runtime-suspend devices. which will cause ehci_resume to be called.
Thus STS_PCD flag will be set in ehci_resume function.

Thanks
Weitao Wang
> 
> 	The resume kernel transfers control to the image kernel;
> 
> Now the image kernel is running.  It goes into the restore state, which
> involves calling ehci_resume.  Presumably your patch cases the STS_PCD
> flag to get set at this point.
> o
> But that's all!  The system is now back up, out of hibernation, and
> running normally.  There are no more calls to check_root_hub_suspended
> 
>>>> 4.If PCD flag is set(caused by patch), then HCD_FLAG_RH_RUNNING will be set.
>>>>
>>>> 5.Pci_pm_freeze_noirq is called to check ehci root hub state and return
>>>> value is -EBUSY. which will cause
>>>>    quiesce phase of suspend to disk fail.
>>>
>>> You're talking about check_root_hub_suspended() in hcd-pci.c, right?
>>>
>> It's right.
> 
> So how can this happen, given that the image kernel doesn't call
> pci_pm_freeze_noirq?
> 
> Alan Stern
> .
