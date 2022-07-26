Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89F6581768
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiGZQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiGZQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:26:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DB1CFCC;
        Tue, 26 Jul 2022 09:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F456B8188C;
        Tue, 26 Jul 2022 16:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D89C433C1;
        Tue, 26 Jul 2022 16:26:30 +0000 (UTC)
Date:   Tue, 26 Jul 2022 12:26:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
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
Subject: Re: [PATCH V7 02/16] rv: Add runtime reactors interface
Message-ID: <20220726122629.2a99cb6e@gandalf.local.home>
In-Reply-To: <516e8767f20f47b185b7dc0dceb1f1d3abb36dce.1658778484.git.bristot@kernel.org>
References: <cover.1658778484.git.bristot@kernel.org>
        <516e8767f20f47b185b7dc0dceb1f1d3abb36dce.1658778484.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 22:11:14 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> +/**
> + * reactor_cleanup_monitor - cleanup a monitor reference
> + * @mdef:       monitor's definition.
> + */
> +void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
> +{
> +	mdef->rdef->counter--;
> +}
> +

Doesn't this require a lock? Also you might want to add a WARN_ONCE() if it
goes below zero.

-- Steve
