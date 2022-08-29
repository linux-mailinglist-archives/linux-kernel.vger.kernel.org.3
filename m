Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C215A4F18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiH2OXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiH2OXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A079751F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3456D60FB7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2903BC433C1;
        Mon, 29 Aug 2022 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661783000;
        bh=j7vGQJvqDnFs0uYLxzOYOWDD/LHImupkpYX+0EhVnw0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r9k5NNb2ita6InCHdKCQ3uFixTGXAXKFJP3KfK/qewxxyUeGHGRoZjRNNWMd+Ux6R
         5xQggWLWS8GusNP9L5mEeiLiQxYIf8iGuxvo3rXf/47nV/7Ld11tvFt1zXwrFrwPFo
         ekoZpSMPQ1rHxB+Ve3KuKbb8UaZSSsCGVvqjpZH5U/mJQbP4Q2pMUfjFyvyqxqu1Wg
         yRxBsLV2eAXtgcJsIlVq365PzXhREgo6ytvFfs/NvuSlJJXB2XeBBoPXat9g/bgWvH
         2mJPyN5aY+tNl0wKOYLKco6tRzSzGNAcFj+AwwtCwd93F9vh1ukbN3tv2IMvzTA9Af
         9XVROmhXSCb1Q==
Message-ID: <25456937-8034-2742-4a8a-68fb83b37ea2@kernel.org>
Date:   Mon, 29 Aug 2022 07:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com> <Yvybq+hYT4tG/yAg@gmail.com>
 <Yvyfi9XC8bu0cOG+@gmail.com> <YvyiHGMbp2MtV0Vr@zn.tnic>
 <YvzXsf0mGEcOlZC5@araj-dh-work> <Yvzay5jOu5XBJpWa@zn.tnic>
 <YvzfebgOWVKYLClJ@araj-dh-work> <Yvz4/ASoX4SiXbhp@zn.tnic>
 <Yv0D88jxFkXcc18o@araj-dh-work>
Content-Language: en-MW
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <Yv0D88jxFkXcc18o@araj-dh-work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 08:06, Ashok Raj wrote:
> On Wed, Aug 17, 2022 at 04:19:40PM +0200, Borislav Petkov wrote:
>> On Wed, Aug 17, 2022 at 12:30:49PM +0000, Ashok Raj wrote:
>>> You will find out when system returns after reboot and hopefully wasn't
>>> promoted to a cold-boot which will loose MCE banks.
>> Not good enough!
> I probably misread your question.. are you suggesting we add some WARN when
> we initiate late_load? I thought you were asking if the HW must signal
> something and OS should log when an MCE happens if MCIP=1
>
>
>> This should issue a warning in dmesg that a potential MCE while update
>> is running would cause a lockup. That is if we don't disable MCE around
>> it.
>>
>> If we decide to disable MCE, it should say shutdown.
> Ok, that clarifies it.. "IF we choose to set MCIP=1, we should tell users
> that hell can break loose, get under the table" :-)
>
>>> Meaning deal with the effect of a really rare MCE. Rather than trying to
>>> avoid it. Taking the MCE is more important than finishing the update,
>>> and loosing what the error signaled was trying to convey.
>> Right now I'm inclined to not do anything and warn of a potential rare
>> situation.
> Encouraging.. So I'll drop that patch from the list next time around.


If I followed all this correctly, I agree. If we set MCIP to force a 
crash if we get MCE, then we are guaranteed to crash.  If we don't, then 
we might crash.


An imperfect alternative would be to set a (percpu?) flag that we're 
doing a ucode update and then detect that flag early in the MCE handler 
and warn very loudly.  This seems like it will give us the best chance 
of getting a useful diagnostic.
