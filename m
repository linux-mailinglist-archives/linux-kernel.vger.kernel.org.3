Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4D57D1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiGUQnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiGUQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C6088F2A;
        Thu, 21 Jul 2022 09:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 963EE61E12;
        Thu, 21 Jul 2022 16:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFD1C3411E;
        Thu, 21 Jul 2022 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658421798;
        bh=3RI6nZRkNzei/6De1TBsop6oUMdID22DlrmrVjPcuuU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fRHyIz91h+5ha6WwsOUAMB52Nr3I7iLScL0AZri8YiK1PW0Hv4kgI9CGfWPO0tZGn
         tnS4sH7vAli5mkzLeGYftCc7DI0KGLhV/wqW41Jj9Up+0GQHfyrpQhw038asFxWK1Y
         kfUQ9cy7tqdL8ssTpedw3FnQTRbot0954iAZ2BZnCAV5vP2YU5MvhUge+uHpro9ZKQ
         Kkz1wv9PIZRQaUY2+pnVTZHh+I2iDs3+9sXYyF7yMj9IPARZdZB7diXmCNzSQ5dwow
         fFQ1PR4UROBaE3apgdm+mUGDGlKRSTk1RHrdr8yIfdMX4uVqYAzzj0T3x9E0WBSBXX
         gFgtmVsEav74Q==
Message-ID: <9845acf0-1567-d4bb-ef56-588d3415f72e@kernel.org>
Date:   Thu, 21 Jul 2022 18:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V6 16/16] rv/reactor: Add the panic reactor
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
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1658244826.git.bristot@kernel.org>
 <2701cbe85b1fd6940fa5eeafdc8cacded1ce99fe.1658244826.git.bristot@kernel.org>
 <20220721113106.31d8a525@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220721113106.31d8a525@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 17:31, Steven Rostedt wrote:
> On Tue, 19 Jul 2022 19:27:21 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> Sample reactor that panics the system when an exception is found. This
>> is useful both to capture a vmcore, or to fail-safe a critical system.
> 
> BTW, do you plan on adding models to model the reactors?

I was about to say that at the panic level, it would not be needed, as code inspection
is reasonable (people in Elisa did IIRC). But then I recalled that we
have a printk reactor, and one might model it - at event level :-)

But then can disable the reactor :-).

-- Daniel

> ;-)
> 
> -- Steve

