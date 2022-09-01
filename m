Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF7A5A89B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIAABE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiIAAA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:00:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C0E7B282;
        Wed, 31 Aug 2022 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Vy9viZo5c1Cs22twzs93d/4uL2Kw42CK2c0Hxu3ubro=; b=1soSmH97o8W8jbuZ1w3OF5EvDF
        T8O7g8vlBZakvoElaYA/OrfyamBoMy2Mv1r7ia6r/8+CP+muZpWdmTNCGzZLUgisQhnKpFe+tJPYg
        qcCNA3ohp0mPbstAVcXLiAEJEKC5BGEDqs7YWLtdLhfmOTIruBYHIu0Pu/aNU4FAB7SOqGzdjo75m
        8DHGmXVSpNQ5Ww5yPQduf5BHn0+e5WSDHKB/4elNXe25sLrIxAhH30CUdez1YmoAnpiPzEqzeX6YP
        mJiEMvBCmVcMzFZsz1EfG86mDMxjgGxf83JeeudoJ6Xy7t7Cz0ipkagy6eRFT6+YxrooWZm2rZbX1
        wLR0VYeA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTXde-008l8i-Ay; Thu, 01 Sep 2022 00:00:54 +0000
Message-ID: <f62874b9-4588-52d8-b321-49d2d57fb6c3@infradead.org>
Date:   Wed, 31 Aug 2022 17:00:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: configuration x86/Kconfig bug? or AMD feature request
Content-Language: en-US
To:     Steven J Abner <pheonix.sja@att.net>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>
References: <VQ7IHR.9PMZBSNKURXU1.ref@att.net> <VQ7IHR.9PMZBSNKURXU1@att.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <VQ7IHR.9PMZBSNKURXU1@att.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/31/22 16:54, Steven J Abner wrote:
> Hi
> I am tailoring a kernel for AMD 2400g on ASRock B450 using 5.18.12 as base.
> I found a feature I don't believe I need, and the system seems to work just
> fine without it. A quick glance at the code seems like I'll be just fine, too.
> In /drivers/platform/x86/Kconfig:1159  I altered the text to:
> 
> config PMC_ATOM
>      bool "Intel Atom SOC Power Management Controller Driver"
>      default y
>      depends on PCI
>      select COMMON_CLK

I can't tell what you changed it to.

> Please have a look and decide if x86 must include this code to function properly.
> Nothing but being x86 selects this. 'default y' was chosen only because forced y before.
> Steve
> 
> I wish to be personally CC'ed the answers/comments posted to the list
> in response to my posting, please. I not part of the list.


That kconfig option has been deleted:
commit 3cd8cc98d634
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Tue May 3 16:02:07 2022 +0200

    platform/x86: Drop the PMC_ATOM Kconfig option
    
    The def_bool y PMC_ATOM Kconfig option provides a couple of symbols used
    by the code enabled by the X86_INTEL_LPSS option and it registers some
    clocks. These clocks are only registered on Bay Trail, Cherry Trail and
    Brasswell Intel SoCs and kernels targeting these SoCs must always have
    the X86_INTEL_LPSS option enabled otherwise many things will not work.
    
    Building the PMC_ATOM code on kernels which are not targeting the
    mentioned SoCs and which do not have the X86_INTEL_LPSS enabled is
    not useful.
    
    This means that we can simplify things by replacing the PMC_ATOM Kconfig
    option in Makefiles with X86_INTEL_LPSS and then drop the option.


Maybe that commit should be backported?

-- 
~Randy
