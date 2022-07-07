Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48637569D63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiGGIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiGGIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:22:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF222F;
        Thu,  7 Jul 2022 01:22:27 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o9MmF-00023V-VO; Thu, 07 Jul 2022 10:22:24 +0200
Message-ID: <40f45d61-2e3a-eef1-d31a-ca41f40cacfd@leemhuis.info>
Date:   Thu, 7 Jul 2022 10:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
Content-Language: en-US
To:     torvic9@mailbox.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>
References: <272584304.305738.1657029005216@office.mailbox.org>
 <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
 <MN0PR12MB61015A04C6E4202B2E8E08A9E2819@MN0PR12MB6101.namprd12.prod.outlook.com>
 <72419963.329229.1657096948079@office.mailbox.org>
 <8ee1bc75-3ecd-9d87-b7cc-37ba15133026@leemhuis.info>
 <CAHk-=whfSg1FNFJXv9QfXXnWFO71YufsoTs9S8sYzonfwjm4XA@mail.gmail.com>
 <830109073.51279.1657180466311@office.mailbox.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <830109073.51279.1657180466311@office.mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1657182147;cf722b2f;
X-HE-SMSGID: 1o9MmF-00023V-VO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.22 09:54, torvic9@mailbox.org wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> hat am 06.07.2022 18:59 GMT geschrieben:
>> On Wed, Jul 6, 2022 at 11:21 AM Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>>
>>> Wild guess, I'm not involved at all in any of the following, I just
>>> noticed it and thought it might be worth mentioning:
>>>
>>> I heard Fedora rawhide added this patch to solve a boot problem that
>>> sounded similar to yours:
>>> https://patchwork.freedesktop.org/patch/489982/
>>
>> Yes, this looks likely, and matches that "starts in 5.19-rc5" since
>> the offending commit came in as
>>
>>   ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
>> removing conflicting FBs")
>>
>> so that does look like a likely cause.
>>
> 
> I confirm that applying
>   "drm/aperture: Run fbdev removal before internal helpers"
> on top of rc5 solves this issue, computer boots normally again.
> I suppose this commit will be cherry-picked for rc6.

Thx for confirming. Yes, that patch is in the drm-misc-fixes tree as
bf43e4521ff3 and thus will likely be merged with this weeks DRM merge.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
