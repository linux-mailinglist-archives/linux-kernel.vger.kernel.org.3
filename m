Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F49573CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiGMSlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiGMSlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB8252B8;
        Wed, 13 Jul 2022 11:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83BC561DA9;
        Wed, 13 Jul 2022 18:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F0EC34114;
        Wed, 13 Jul 2022 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657737676;
        bh=5U9/KEb7MalgDSPmKpw2nAxd6A28C8lrKL2zdH6PIfk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T0+BJJKUKolniQMIaObnkvGYO6pZ1JRMigZZebFNIOVs3wAtO4DI1iwtn0af3xFyM
         Ad3ukheFeZbAB0o/XfkOeUy5SpXR2We5UyZInrNRP1Fndn5GLjjai7y9SFqLwtTBMH
         gY2gknOf+aPK5+4NFXmBxhsVHU9wXfTRm4Krv9COC/ER42yCxPXd7XwGcde9cXiH9W
         04Tlz1BS2caCZ5cM+LTv8abc1eveVbcintzvtJux0/ybXeyMEULda9btSyCDR2qtjk
         mUMU3YeNhwc5IgE1/8MiINXslMxWNY1ysakGuohgyGC9e3ib2cX8c1vu1RQQdV1MMl
         vUw+Inizf5rcw==
Message-ID: <cd43b064-861e-8d7d-4b06-6aae1a037bf4@kernel.org>
Date:   Wed, 13 Jul 2022 20:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 06/20] tools/rv: Add dot2c
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <5b1e664b0c33f4da0430922718adc71a5d58d86c.1655368610.git.bristot@kernel.org>
 <20220628141659.309ec0fb@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220628141659.309ec0fb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 20:16, Steven Rostedt wrote:
> On Thu, 16 Jun 2022 10:44:48 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> +    def get_minimun_type(self):
>> +        min_type="char"
>> +
>> +        if self.states.__len__() > 255:
>> +            min_type="short"
>> +
>> +        if self.states.__len__() > 65535:
>> +            min_type="int"
> Should these be "unsigned"? As char goes from -128 <-> 127
> and short goes from -32768 <-> 32767
> 
> And are you sure you're not going to have more than 2,147,483,647 states ;-)
> (or 4,294,967,296 if it's unsigned).

Fixed! now I am using the "state_max" as the invalid state, so I can use unsigned.

I also revisited all python code for consistency.

-- Daniel
