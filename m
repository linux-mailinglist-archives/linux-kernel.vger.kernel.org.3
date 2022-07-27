Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7544D582A67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiG0QK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiG0QK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:10:26 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C44E0DA;
        Wed, 27 Jul 2022 09:10:25 -0700 (PDT)
Date:   Thu, 28 Jul 2022 00:10:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658938223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vDTc2P3W0cdpqM6y0cdrKPPqHIzlLdGjU1Vo1e/Da/8=;
        b=YaH+br3IhFwvw+NOWW8DYs8wG8Ahb3j41ozaHCskwVDzcCFo00PH3xdZfUUcqB/s6k1pet
        Oc4bbVysDNsEBRsBdAcSvLR4GJ/e3QOXmbkiTD3OX5wF+Rn2QWB10gIde6YX1cLiUF2jNA
        zI5l//nodSfPHEOaTR2YicOI+a1f0FY=
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
Subject: Re: [PATCH V7 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <YuFjGK53HH7pjdlv@geo.homenetwork>
References: <cover.1658778484.git.bristot@kernel.org>
 <2aa3b18239f170ba23263f18d166d08634ed65dd.1658778484.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa3b18239f170ba23263f18d166d08634ed65dd.1658778484.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:11:13PM +0200, Daniel Bristot de Oliveira wrote:

> +void rv_put_task_monitor_slot(int slot)
> +{
> +	lockdep_assert_held(&rv_interface_lock);
> +
> +	if (slot < 0 || slot >= RV_PER_TASK_MONITORS) {
> +		WARN_ONCE(1, "RV releasing an invalid slot!: %d\n", slot);
> +		return;
> +	}
> +
> +	WARN_ONCE(!task_monitor_slots[slot], "RV releasing unused task_monitor_slots: %d\n",
> +		  slot);
> +
> +	task_monitor_count--;
> +	task_monitor_slots[slot] = false;
> +}

I would say this can be implemented using bits. Also is an optimization.
But now here just use bool and seems not that needed.

> +static void turn_monitoring_off(void)
> +{
> +	WRITE_ONCE(monitoring_on, false);
> +	/* monitoring_on */
> +	smp_wmb();

Absolutely the sync I can not see.
If not store another after smp_wmb(), even you have smp_wmb() pair,
it is not valid in my poor mind that there is no another load before
loading of monitoring_on that ensure something like if the another
load is *what* then the after load is ensured to be *what* statement
(I am sure I am poor on these, but just some words input yeah).
