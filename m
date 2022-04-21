Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3E50AB82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442467AbiDUWbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiDUWa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:30:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9294B1DE;
        Thu, 21 Apr 2022 15:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ceerddFcOflxFWACROVtDGMz1WNv7h63zUgRdG7WKco=; b=X/QcnW8vDcLAGOfhH7oEwYo90q
        bEIdkSmRUAmqM0WwaaLxYb0V5zunfL4ECMJMld5MbE+o2SX5rraRJ39am4eqRwp3oNZuuJzTjM1RX
        aHNkY3Pj633qVQSo8wyniCjenvwwl2pIfCn8iVqaGSasx8EcjIU8qMt3XmfWzjO+yByltsrdE7Xf7
        2tpdeCHsYtTGZxyvecVwwzGaqy9ehkx/ZTxrFyEtjQAGlmrJFF+jmJL5KDDKXljhbHeTYXH1B7lEI
        9I1WVlckEus4tp6JtOV7Jm27ONm0nFA6erW6x3Sc5BW6+98CJ37wmykOnFnUzOofGPBatXgAds2Wu
        deZGwRog==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhfHN-005V5N-BC; Thu, 21 Apr 2022 22:28:02 +0000
Message-ID: <c86e540f-6611-4ef9-9439-8285fee61831@infradead.org>
Date:   Thu, 21 Apr 2022 15:27:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: drivers/usb/typec/tcpm/tcpm.c:4724:3: error: case label does not
 reduce to an integer constant
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-usb@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com
References: <CA+G9fYvdfYBq+Q=-XUJcKHSYXdubdoqhExRpjrqCgf_N3pPpHQ@mail.gmail.com>
 <15b38d01-702c-b39e-7053-54c3905a0794@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <15b38d01-702c-b39e-7053-54c3905a0794@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/21/22 13:36, Guenter Roeck wrote:
> On 4/21/22 12:03, Naresh Kamboju wrote:
>> Linux mainline and linux next arm64 builds failed with gcc-7.3.x.
>>
>> drivers/usb/typec/tcpm/tcpm.c: In function 'run_state_machine':
>> drivers/usb/typec/tcpm/tcpm.c:4724:3: error: case label does not
>> reduce to an integer constant
>>     case BDO_MODE_TESTDATA:
>>     ^~~~
>> make[4]: *** [scripts/Makefile.build:288: drivers/usb/typec/tcpm/tcpm.o] Error 1
>>                                        ^
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> -- 
> 
> That code is several years old, the define is a constant, and I don't see
> a recent change in the code. What am I missing ?

See a recent patch for the same problem in a different area:

commit 1ef8715975de
Author: Borislav Petkov <bp@suse.de>
Date:   Tue Apr 5 17:15:08 2022 +0200

    ALSA: usb-audio: Fix undefined behavior due to shift overflowing the constant

so those constants probably need to be cast to unsigned int.
(I guess)

-- 
~Randy
