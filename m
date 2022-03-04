Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2C4CD7BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiCDP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCDP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:29:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CAD4C414;
        Fri,  4 Mar 2022 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cgN9vxorelzw3VwEgeGHzYx+hnysDRumjVLx3wSP6i8=; b=rZxOdMBSL1Xys44bhf5Ycuem0S
        etxCLDoJNG1TlZ/tbAQqDxnoOdhsDxVjykInoy6gENQJ8YoV7Du6FiXcZwVmDbrZ7OF7M6Uc66Msk
        5nNDIHSeY7ApwIkoIA4jFPMRy0p4SQGFKJ6e40iw5i9h6NEdoXWUXGDnlnb1R7pW/RcTO8IcKnmFA
        //csRV+FgPnq/seEPai/yiLKqRA55QmwVlkQnjx0TOQc8WITUEjn0XsAwT172s6+YuebUtWC4Wb1p
        inhbruf+nTeZZQIPx6CA5C/VggbbfvlDhhg7TGm0ImQ5neyxOcvG3gQVW9aerrHrkDX1kEuoqft8T
        AZIQ8q0A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQ9qd-00Ck1M-0Z; Fri, 04 Mar 2022 15:28:03 +0000
Message-ID: <851f1804-4156-0b37-0bbd-598bdbb2abfa@infradead.org>
Date:   Fri, 4 Mar 2022 07:27:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 0/4] support USB offload feature
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
References: <CGME20220304062609epcas2p1b9e2720d2d7d66438e1eab92546f46cc@epcas2p1.samsung.com>
 <1027007693.21646375403236.JavaMail.epsvc@epcpadp3>
 <YiHCTgg5Ibv9YQvi@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YiHCTgg5Ibv9YQvi@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/22 23:39, Greg Kroah-Hartman wrote:
> On Fri, Mar 04, 2022 at 03:23:54PM +0900, Daehwan Jung wrote:
>> This patchset is for USB offload feature, which makes Co-processor to use
>> some memories of xhci. Especially it's useful for USB Audio scenario.
>> Audio stream would get shortcut because Co-processor directly write/read
>> data in xhci memories. It could get speed-up using faster memory like SRAM.
>> That's why this also gives vendors flexibilty of memory management.
>> Below pathches have been merged in AOSP kernel(android12-5.10) and I put
>> together and split into 3 patches. Plus let me add user(xhci-exynos) module 
>> to see how user could use it. 
>>
>> To sum up, it's for providing xhci memories to Co-Processor.
>> It would cover DCBAA, Device Context, Tranfer Ring, Event Ring, ERST.
>> It needs xhci hooks and to export some xhci symbols.
>>
>> ANDROID: usb: host: fix slab-out-of-bounds in xhci_vendor_get_ops
>> ANDROID: usb: export built-in tracepoint functions
>> ANDROID: usb: host: Use old init scheme when hook unavailable
>> ANDROID: usb: host: free the offload TR by vendor hook
>> ANDROID: usb: host: xhci: provide function prototype for xhci_address_device
>> ANDROID: usb: host: add bus_suspend/bus_resume to xhci overrides
>> ANDROID: usb: host: add address_device to xhci overrides
>> ANDROID: usb: host: add max packet parameter on alloc_transfer_ring hook
>> ANDROID: usb: host: add xhci hooks for vendor specific container context
>> ANDROID: usb: host: export xhci symbols for ring management
>> ANDROID: usb: host: export additional xhci symbols for ring management
>> FROMLIST: usb: xhci-plat: add xhci_plat_priv_overwrite
>> FROMLIST: usb: host: export symbols for xhci hooks usage
>> FROMLIST: usb: host: add xhci hooks for USB offload
> 
> What does that list of text mean?  You are only submitting 4 patches
> here, not that many.
> 
>>
>> Below are owners of patches.
>>
>> Howard Yen <howardyen@google.com>
>> Jack Pham <jackp@codeaurora.org>
>> Puma Hsu <pumahsu@google.com>
>> J. Avila <elavila@google.com>
>> chihhao.chen <chihhao.chen@mediatek.com>
> 
> What do you mean by this?  Did you loose authorship of the code you just
> submitted?  That's not ok.  You always have to properly credit the
> creators of the changes you submit to us for obvious legal reasons.
> 
> Please fix up and resend this series properly.

Also: Greg might have received the full patch series, but I didn't, so I
checked lore.kernel.org/linux-usb/, and it did not either, so it appears
that there is a problem with sending the full series.

-- 
~Randy
