Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075BE5861A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiGaWLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGaWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:11:44 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C29592
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 15:11:42 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LwwT91fytz9tCs;
        Sun, 31 Jul 2022 22:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659305501; bh=CsOI+E/4KnM+DdNjxS2fc/kMX0NafXZF+YchFal+Wlc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H8b51xMZadM+jdJxTvTOeaCF6P7Te8rpscjyTbBfxh/w3U3rzQQLdSdiiDJJYklE6
         bjn3lBqk/yhy9xyGr/yHorkL6K/CSah0UWWBTE8HZNbYhf1jyMPr4fv6Nmx543N6WR
         2/oikrstzi4t3I/+zLLuxg/VOGG23tX0/GkNeM1s=
X-Riseup-User-ID: DF8F1D7C500EBDCCB3287F70C6FB765612C30DB837C4782BAB02E793DA1936E8
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LwwT502Tsz1y9N;
        Sun, 31 Jul 2022 22:11:36 +0000 (UTC)
Message-ID: <613a3c17-1d76-0a21-5ce2-895f46c2247a@riseup.net>
Date:   Sun, 31 Jul 2022 19:11:34 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v5 4/5] lib/test: introduce cpumask KUnit test suite
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
References: <cover.1659077534.git.sander@svanheule.net>
 <85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net>
 <b6b20883-3fe7-9a5d-ab55-b5a61cef996c@riseup.net>
 <1ad99cc0df85c932a7df18f67560930e37976e2b.camel@svanheule.net>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <1ad99cc0df85c932a7df18f67560930e37976e2b.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/22 12:42, Sander Vanheule wrote:
> On Sun, 2022-07-31 at 12:23 -0300, Maíra Canal wrote:
>> Hi Sander
>>
>> On 7/29/22 04:01, Sander Vanheule wrote:
>>> Add a basic suite of tests for cpumask, providing some tests for empty and
>>> completely filled cpumasks.
>>>
>>> Signed-off-by: Sander Vanheule <sander@svanheule.net>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Suggested-by: Yury Norov <yury.norov@gmail.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Marco Elver <elver@google.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>> Cc: Brendan Higgins <brendanhiggins@google.com>
>>> Cc: David Gow <davidgow@google.com>
>>> Cc: Maíra Canal <mairacanal@riseup.net>
>>> ---
>>> Changes since v4:
>>> - Belated addition of Yury's Suggested-by:
>>> - Follow KUnit style more closely
>>> - Drop full check on cpu_possible_mask
>>> - Update last check on cpu_possible_mask
>>> - Log masks when starting test
>>> - Update commit message 
>>>   
>>> Changes since v3:
>>> - Test for_each_cpu*() over empty mask and cpu_possible_mask
>>> - Add Andy's Reviewed-by
>>> - Use num_{online,present,possible}_cpus() for builtin masks
>>> - Guard against CPU hotplugging during test for dynamic builtin CPU masks
>>>  
>>> Changes since v2:
>>> - Rework for_each_* test macros, as suggested by Yury
>>>
>>> Changes since v1:
>>> - New patch
>>>
>>>  lib/Kconfig.debug  |  12 ++++
>>>  lib/Makefile       |   1 +
>>>  lib/cpumask_test.c | 147 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 160 insertions(+)
>>>  create mode 100644 lib/cpumask_test.c
>>>
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index 2e24db4bff19..e85e74646178 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -2021,6 +2021,18 @@ config LKDTM
>>>         Documentation on how to use the module can be found in
>>>         Documentation/fault-injection/provoke-crashes.rst
>>>  
>>> +config CPUMASK_KUNIT_TEST
>>> +       tristate "KUnit test for cpumask" if !KUNIT_ALL_TESTS
>>> +       depends on KUNIT
>>> +       default KUNIT_ALL_TESTS
>>> +       help
>>> +         Enable to turn on cpumask tests, running at boot or module load
>>> time.
>>> +
>>> +         For more information on KUnit and unit tests in general, please
>>> refer
>>> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
>>> +
>>> +         If unsure, say N.
>>> +
>>>  config TEST_LIST_SORT
>>>         tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
>>>         depends on KUNIT
>>> diff --git a/lib/Makefile b/lib/Makefile
>>> index bcc7e8ea0cde..9f9db1376538 100644
>>> --- a/lib/Makefile
>>> +++ b/lib/Makefile
>>> @@ -59,6 +59,7 @@ obj-$(CONFIG_TEST_BPF) += test_bpf.o
>>>  obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
>>>  obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
>>>  CFLAGS_test_bitops.o += -Werror
>>> +obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_test.o
>>>  obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
>>>  obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
>>>  obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
>>> diff --git a/lib/cpumask_test.c b/lib/cpumask_test.c
>>> new file mode 100644
>>> index 000000000000..0f8059a5e93b
>>> --- /dev/null
>>> +++ b/lib/cpumask_test.c
>>
>> In order to make the tests at lib/ with more compliant naming, it would
>> make more sense to name it test_cpumask.c.
> 
> That's what I had originally, exactly because I copied the naming from other
> files in lib/. That didn't match the style guide [1] which proposes the _test.c
> or _kunit.c suffix.

My mistake!

> 
> Most files in lib/ use the test_ prefix (45), but some use the  _test.c suffix
> (4), or _kunit.c suffix (6). Of the "test_" ones, only 8 are actually KUnit test
> suites. I personally think the style guide makes a good argument to use a
> suffix, as that clearly places the test suite next to the relevant file in an
> alphabetic listing.
> 
> Based on the above, would you agree with using "cpumask_kunit.c" as the
> filename? That distinguishes it from the non-KUnit test files, and follows the
> style guide.

I believe this would be the best option as well, as there is many
different types of tests in this folder. Thank you for noticing this!

Best Regards,
- Maíra Canal

> 
> [1] https://docs.kernel.org/dev-tools/kunit/style.html#test-file-and-module-names
> 
>>
>> Thank you for the respin to the series! All tests are passing now.
>>
>> Tested-by: Maíra Canal <mairacanal@riseup.net>
> 
> Thank you for testing!
> 
> Best,
> Sander
