Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7C585F6C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiGaPMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiGaPMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:12:09 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C1C60ED;
        Sun, 31 Jul 2022 08:12:08 -0700 (PDT)
Date:   Sun, 31 Jul 2022 23:11:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659280326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MlYMxr4RTjKSXNttPFczidbRb/FlMGktoNy0WMLR7Gs=;
        b=ix+oqU1eRUu+Lx68xU5+ahbg5V9iJkl/16uOuxdLAS7KKz/rBzS1FeP08md9JxsVEQCmZL
        F5zggzByGr6LnOFWh4277o29exDoNSDfqviguV1lGsL3+OQAj/GvWToz0ACST/oSVcUUJS
        PLrFsWEhfUSf0EIiZnhSIg/n6ezeuEI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V8 02/16] rv: Add runtime reactors interface
Message-ID: <Yuabt8763yqoREnm@geo.homenetwork>
References: <cover.1658940828.git.bristot@kernel.org>
 <8be3e66a8f0ab42feb3de4e6a630775b68df2d58.1658940828.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be3e66a8f0ab42feb3de4e6a630775b68df2d58.1658940828.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 07:11:30PM +0200, Daniel Bristot de Oliveira wrote:
> A runtime monitor can cause a reaction to the detection of an
> exception on the model's execution. By default, the monitors have
> tracing reactions, printing the monitor output via tracepoints.
> But other reactions can be added (on-demand) via this interface.
> 
> The user interface resembles the kernel tracing interface and
> presents these files:
> 
> "available_reactors"
>   - Reading shows the available reactors, one per line.
> 
>    For example:
>      # cat available_reactors
>      nop
>      panic
>      printk
> 
>  "reacting_on"
>    - It is an on/off general switch for reactors, disabling

s/switch/switcher/
s/disabling/enabling\/disabling/

[...]

> + *  "available_reactors"
> + *    - List the available reactors, one per line.
> + *
> + *    For example:
> + *      # cat available_reactors
> + *      nop
> + *      panic
> + *      printk
> + *
> + *  "reacting_on"
> + *    - It is an on/off general switch for reactors, disabling

s/switch/switcher/
s/disabling/enabling\/disabling/

[...]

> +/**
> + * rv_register_reactor - register a rv reactor.
> + * @reactor:	The rv_reactor to be registered.
> + *
> + * Returns 0 if successful, error otherwise.
> + */
> +int rv_register_reactor(struct rv_reactor *reactor)
> +{
> +	int retval = 0;
> +
> +	if (strlen(reactor->name) >= MAX_RV_REACTOR_NAME_SIZE) {

s/>=/>/
