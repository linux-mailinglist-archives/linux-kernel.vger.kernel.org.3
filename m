Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9794B96CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiBQDpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:45:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiBQDpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:45:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116829C137;
        Wed, 16 Feb 2022 19:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=QKExgNQWp3Zssh/nqG6fZnwPbmQE7iVXyRjvlEzqCoM=; b=F55Xyk13rPLqv1D0CWn92CH/go
        LF2wtY8At3qADfgJr/QBA9S0q/xNksDEWXHlT149de660uf8Bu628/FJjVgRF5DvHycjQ/Jj6NuaZ
        8AkXiOLnrNiXlrJNtSR02rB6CVWOGtUYmGxqG7Z+z58s9qkvEh5Bh6Q4zkmbuhZhPPSa6B+S74ZqY
        mlUwQ2AQgz1h4fCmVVOgAJ+rJ5g2IfhewPR2fzipz9jQHzI7jmJ9AAzZHYbqMMc1tSz7SmhXVssAa
        YBtn8SWkOS/MtBbLXid3p3mr0/9oCT9T4JTt4XEgRPlrLUG0sTZmzFv5l214mrNUsuTr8vFvxjJIl
        PFXqMU1Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKXij-00FHCo-1j; Thu, 17 Feb 2022 03:44:41 +0000
Message-ID: <3f657ffc-e137-de8f-c89e-90676bc42448@infradead.org>
Date:   Wed, 16 Feb 2022 19:44:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: earlyprintk=xdbc seems broken
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com> <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
 <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
 <yt9dbl00rmgx.fsf@linux.ibm.com>
 <a34be5ca-47e7-95a6-602f-da054e409e85@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a34be5ca-47e7-95a6-602f-da054e409e85@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/22 08:24, Dave Hansen wrote:
> On 1/25/22 05:09, Sven Schnelle wrote:
>>> Now the documentation states we need this super speed A<->A cable, but
>>> could you also update the documentation for usb-c ? There's a fair
>>> number of usb-c only devices out there now.
>> Stupid beginners question: Would every USB3 A-A cable work, or are the
>> debug cables special? I've read the RX/TX pairs have to be swapped, but
>> to me it looks like that's always the case?
> 
> My understanding is that the 5v line is disconnected.  Here's one cable I have:
> 
>> https://designintools.intel.com/SVT_DCI_DbC2_3_A_to_A_Debug_Cable_1_Meter_p/itpdciamam1m.htm
> 
> I think they snip that line to prevent any chance of current flowing between devices.  The cable isn't expensive, but I do remember being astounded at how much Intel charged itself for shipping it. ;)


This one works OK:
https://www.datapro.net/products/usb-3-0-super-speed-a-a-debugging-cable.html

> That said, I've also used the same cable Peter has: just a cheap A-to-A cable I had lying around.  It surely has VBUS connected, so I usually plumb it through a USB hub with a power switch.  This surely isn't the "right" way to do it, but it does seem to work in some situations.

-- 
~Randy
