Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E8857B9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiGTPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbiGTPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E50624A9;
        Wed, 20 Jul 2022 08:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D462861C81;
        Wed, 20 Jul 2022 15:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F32C3411E;
        Wed, 20 Jul 2022 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658331206;
        bh=d4mdS9pZTeRzQCM3iqfclNNw6Cc99uSxF1XgR6Nm2dA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F+/iPgUYr6Evj8LIHJNiNnUsFMXKP3GxHNrVLq2kGnoAFuQIo/HDSHnO8B/BtG3Ia
         8ZLP0FymvUvqCSaKcixekcTZ2gKV8z60NgJ8Ph6djL4erJKP1jWqYXXXcmPKBMQn3c
         6pPt7L6Kqhl1CpYH6EMv3QXP13N+d0Cf+/WX99GwOJMXE865mk9Qd0P/NMgu21OpKD
         KgojtGKOlPTXgPn3ARlWkqfGDHVNyLBMNdBn7L79mamq11dtOboB7SKAmmOQ/ZdaXt
         R/+qn0+twyK29bRlK5BpYaLViEwZ2Gz/2hiCUPcUpAIMgoVi29Et1EoymYnPAGPAwa
         hM0WCOELMAC7g==
Message-ID: <34d07ab4-7c95-ea56-054c-039eee704723@kernel.org>
Date:   Wed, 20 Jul 2022 17:33:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V6 01/16] rv: Add Runtime Verification (RV) interface
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
 <69bb4c369b4f6f12014eb9ca3c28b74e4378c007.1658244826.git.bristot@kernel.org>
 <20220720112102.32415cc7@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220720112102.32415cc7@gandalf.local.home>
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

On 7/20/22 17:21, Steven Rostedt wrote:
>> +static void disable_all_monitors(void)
>> +{
>> +	struct rv_monitor_def *mdef;
>> +
> I think you need:
> 
> 	mutex_lock(&rv_interface_lock);
> 
>> +	list_for_each_entry(mdef, &rv_monitors_list, list)
>> +		disable_monitor(mdef);
> 	mutex_unlock(&rv_interface_lock);
> 
>> +}

yes, we need.

-- Daniel
