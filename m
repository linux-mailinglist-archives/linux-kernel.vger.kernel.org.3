Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82A573376
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiGMJrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiGMJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:47:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B5F788A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:47:18 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oBYxf-0003Fh-01; Wed, 13 Jul 2022 11:47:15 +0200
Message-ID: <22805e12-7144-037f-c58c-4bc182d27919@leemhuis.info>
Date:   Wed, 13 Jul 2022 11:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Regression in v5.19-rc4 Sound Distortion
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Daniel Exner <dex@dragonslave.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de>
 <f8725aba-2cd1-c79c-eaf9-d272c140049e@collabora.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <f8725aba-2cd1-c79c-eaf9-d272c140049e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1657705638;a0956047;
X-HE-SMSGID: 1oBYxf-0003Fh-01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.22 18:35, Dmitry Osipenko wrote:
> On 7/12/22 19:02, Daniel Exner wrote:
>
>> Since  v5.19-rc4 this box got some *loud* distorting sound on boot and
>> after some time without any sound if something plays sound again from
>> the integrated speakers in my monitor.
>>
>> I managed to bisect this down to:
>>
>>> commit 202773260023b56e868d09d13d3a417028f1ff5b
>>> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Date:   Fri Jun 17 15:24:02 2022 +0300
>>>
>>>    PM: hibernate: Use kernel_can_power_off()
>>
>> Reverting that commit on top of v5.19-rc6 does indeed fix the problem here.
> 
> You're saying that the problem is on boot, but this patch is about
> suspension to disk, which has nothing to do neither with the boot nor
> with power-off. I'm afraid your bisection is incorrect.

After quickly looking at the code this looks appropriate, but why does
reverting that commit help then? That's a bit odd. Daniel: are you maybe
using suspend-to-disk and forgot to mention it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.


