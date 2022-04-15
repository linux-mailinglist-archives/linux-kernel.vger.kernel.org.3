Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539CD502070
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348722AbiDOC2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344697AbiDOC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:28:12 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B8685967;
        Thu, 14 Apr 2022 19:25:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VA5Fc8T_1649989538;
Received: from 30.240.101.97(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VA5Fc8T_1649989538)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 10:25:40 +0800
Message-ID: <e7a0d0d4-b6ca-6fec-df33-929961f0d43e@linux.alibaba.com>
Date:   Fri, 15 Apr 2022 10:25:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
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
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YlgNW0/ji6KlkyZo@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 4/14/22 8:02 PM, Mark Brown wrote:
> On Thu, Apr 14, 2022 at 07:55:44PM +0800, Tianjia Zhang wrote:
> 
>> Allow userspace to detect support for SME (Scalable Matrix Extension)
>> by providing a hwcap for it, using the official feature name FEAT_SME,
>> declared in ARM DDI 0487H.a specification.
> 
> There's already a hwcap for the core feature and all the subfeatures
> added as part of the series I've been posting for SME:
> 
>     https://lore.kernel.org/linux-arm-kernel/20220408114328.1401034-1-broonie@kernel.org/
> 
> Why add something independently, especially given that there is no way
> for userspace to do anything constructive with the feature without the
> rest of the kernel support?  Any attempt to use SME instructions without
> kernel support will trap and generate a SIGILL even if the feature is
> present in hardware.

Great job, I encountered the issue of invalid REVD (requires FEAT_SME)
instruction when developing SVE2 programs, so I plan to gradually
support SME in the kernel, thanks for your contribution, you can ignore
my patch.

In addition, I would like to ask a question, whether there is an
alternative SVE2 instruction for the REVD instruction that can complete
this operation, if the machine does not support SME.

> 
> Do you have a system with SME that you're trying to use?  Review/testing
> on the current series would be appreciated.

Unfortunately, the value currently read by my machine ID_AA64PFR1_EL1
register is 0x121. It seems that the hardware does not support SME. Is
there any other help I can provide?

Kind regards,
Tianjia
