Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B108150D0CB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiDXJaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiDXJaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:30:19 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E7191C77;
        Sun, 24 Apr 2022 02:27:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VB0eA6j_1650792433;
Received: from 30.240.100.40(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VB0eA6j_1650792433)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 17:27:14 +0800
Message-ID: <03e81a57-ea4b-fe96-0175-759b791d9293@linux.alibaba.com>
Date:   Sun, 24 Apr 2022 17:27:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH] arm64/sme: Add hwcap for Scalable Matrix Extension
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414115544.36204-1-tianjia.zhang@linux.alibaba.com>
 <YlgNW0/ji6KlkyZo@sirena.org.uk>
 <e7a0d0d4-b6ca-6fec-df33-929961f0d43e@linux.alibaba.com>
 <Yl6/+baDhElVxwyC@sirena.org.uk>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <Yl6/+baDhElVxwyC@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 4/19/22 9:58 PM, Mark Brown wrote:
> On Fri, Apr 15, 2022 at 10:25:33AM +0800, Tianjia Zhang wrote:
>> On 4/14/22 8:02 PM, Mark Brown wrote:
>>> On Thu, Apr 14, 2022 at 07:55:44PM +0800, Tianjia Zhang wrote:
> 
>>> Why add something independently, especially given that there is no way
>>> for userspace to do anything constructive with the feature without the
>>> rest of the kernel support?  Any attempt to use SME instructions without
>>> kernel support will trap and generate a SIGILL even if the feature is
>>> present in hardware.
> 
>> Great job, I encountered the issue of invalid REVD (requires FEAT_SME)
>> instruction when developing SVE2 programs, so I plan to gradually
>> support SME in the kernel, thanks for your contribution, you can ignore
>> my patch.
> 
> I see.  Unfortunately all the new registers mean that we really need to
> define all the ABI as soon as we enable anything and the only thing we
> can really skip out on when doing initial enablement is KVM (which I
> have in fact skipped for the time being, I'll look at that at some point
> after the initial support is landed).
> 
>> In addition, I would like to ask a question, whether there is an
>> alternative SVE2 instruction for the REVD instruction that can complete
>> this operation, if the machine does not support SME.
> 
> I'm not aware of anything, but I am mostly focused on the OS support
> rather than any of the actual mathematical operations that are more the
> point of these architecture features so I might be missing something.
> 
>>> Do you have a system with SME that you're trying to use?  Review/testing
>>> on the current series would be appreciated.
> 
>> Unfortunately, the value currently read by my machine ID_AA64PFR1_EL1
>> register is 0x121. It seems that the hardware does not support SME. Is
>> there any other help I can provide?
> 
> Other than verifying that the series doesn't cause trouble for systems
> without SME

Thanks for your reply, I have indirectly implemented the functionality
of the REVD instruction using the tbl instruction on a machine that does
not support SME.

For this group of patchsets, I will do some tests later, which may take
a long time, and there is currently no exclusive machine at hand.

Best regards,
Tianjia
