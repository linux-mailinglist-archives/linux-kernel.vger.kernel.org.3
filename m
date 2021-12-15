Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3980A4758DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbhLOM3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:29:33 -0500
Received: from foss.arm.com ([217.140.110.172]:50642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242428AbhLOM3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:29:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9700CD6E;
        Wed, 15 Dec 2021 04:29:31 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093E43F774;
        Wed, 15 Dec 2021 04:29:29 -0800 (PST)
Message-ID: <96bbd76e-3667-749a-1fda-458e6fa40a27@arm.com>
Date:   Wed, 15 Dec 2021 12:29:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: ARM64 kernel crash
Content-Language: en-GB
To:     Mark Rutland <mark.rutland@arm.com>, tjcw@cantab.net
Cc:     linux-kernel@vger.kernel.org, Chris Ward <tjcw01@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <CAC=wTOhV_QTAbH+u8amNF4+wu6ae5qCLmtWW4Z2zNdVZHrfA=Q@mail.gmail.com>
 <YbnCbyPdsRNFb1iz@FVFF77S0Q05N>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YbnCbyPdsRNFb1iz@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-15 10:53, Mark Rutland wrote:
> Hi Chris,
> 
> On Wed, Dec 15, 2021 at 07:36:34AM +0000, Chris Ward wrote:
>> Please personally cc me on answers/comments as I am not currently
>> subscribed to the LKML.
>> Trying again because I messed up the format badly the first time
>> round. Apologies for that.
> 
> For arm/arm64 stuff, it's best to also Cc LAKML
> (linux-arm-kernel@lists.infradead.org). I've added that here, and for the
> benefit of others I've kept your entire mail as context. In future replies I
> will trim this.
> 
> Please also note that kernel mailing list style is to reply inline (as I've don
> with this mail) rather than to top-post. That helps to keep discussions
> legible, and makes it possible to trim irrelevant context. Please keep any
> replies in kind with that style.
> 
>> My team has a problem which is being bounced between Canonical support
>> and Xilinx support.
>> We are using kernel 5.4.0-xilinx-v2020.2 built from sources under
>> https://github.com/Xilinx/linux-xlnx with a Ubuntu 20.04 userland on
>> an ARM64 embedded linux machine (i.e. not x86-64).
> 
> Can you share the config used? e.g. was that `defconfig`, or something else?
> 
>> When trying to set up a file system on a ramdisk, we get a kernel crash for
>> sizes of ramdisk larger than 2GB while trying to 'dd if=/dev/zero ...'  in
>> preparation for issuing mkfs.

FWIW "larger than 2GB" immediately stands out as a massive red flag for 
signed integer overflow leading to memory corruption *somewhere*, and 
all the splats in the log below do look like they could simply be 
fallout from that.

Building the vendor kernel with KASAN enabled might be another 
worthwhile avenue of investigation - if that can flag up a wild memory 
access at the point where it actually occurs, you've got more chance of 
working backwards from there to the root cause.

Robin.
