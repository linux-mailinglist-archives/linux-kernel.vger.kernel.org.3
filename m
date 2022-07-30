Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F2E585C78
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiG3WFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiG3WFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 18:05:40 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D36645D;
        Sat, 30 Jul 2022 15:05:38 -0700 (PDT)
Date:   Sun, 31 Jul 2022 06:05:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659218736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O6t8U9DPpS42ZsZYWrBzNl2G1omnGmJa9yVgTrzYG2s=;
        b=IE1YYEdm60OSB67r/4j9d5Xmprt5S27Wr0IOdncXMCbeeTA3nPOmc7AdmudBzKiBexuZtS
        aMTaV48EUy8yITnlMAI5ZSkZh9MUkkRl3pWwxMI4ritrsN0OxxEyhHbExb8pvj0RZ4PRvQ
        /67pTtE6XbGoavK6gURFmzNgXYhz5Q4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: Re: [PATCH V9 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <YuWrI18qjmnOOPEE@geo.homenetwork>
References: <cover.1659052063.git.bristot@kernel.org>
 <a4bfe038f50cb047bfb343ad0e12b0e646ab308b.1659052063.git.bristot@kernel.org>
 <YuU7TGxm5pzmBFTx@geo.homenetwork>
 <20220730130145.46f0d57c@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730130145.46f0d57c@rorschach.local.home>
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

On Sat, Jul 30, 2022 at 01:01:45PM -0400, Steven Rostedt wrote:
> #define rv_attach_trace_probe(monitor, tp, rv_handler)                                  \
>         ({                                                                            \
>                 check_trace_callback_type_##tp(rv_handler);                             \
>                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
>                                 "fail attaching " #monitor " " #tp "handler");          \
>         })
> 
> Where the macro returns the result of the WARN_ONCE() which is zero on
> success (no warning) and non-zero otherwise.

The modification of macro make sense to me even though I do not know trace enough. Thanks,
