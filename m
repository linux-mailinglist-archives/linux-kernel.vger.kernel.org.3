Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12334573382
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiGMJwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiGMJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:52:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E973F897D;
        Wed, 13 Jul 2022 02:51:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657705916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OiPMrFEyQe09Ik/mc4Cz2IRz2WPEoPYREf4eHc+dNlM=;
        b=eNrAgHXOJTS2gB/NYwQji3rAYE3xs+vAnvpjpOf1sHBg0OuXt/906UbaeczJQGPzKK8iFa
        JW7HQs/14m6SGr2igUw/epjeL7zkTTMQd3PzLQ4TuscCoZU+lBByKtbF3mxaOcUvIa5XUX
        QvUjWeFDMJh+rCiyeoySGzNG7Vd03aKAcu5CgM/IOHTZqsBbh/CxA2uRmQOUSbw+/y9w72
        1l1n5/pdKJvRdTfAupi/CWpgU9TmNB/nzjv4zNYRSdJ6rhUc33aHMvwyVZdTCb4lmwKu9p
        COKyDu3bqQs1QtU/YOHzgR6WRu9nGaHrY+V1G++LmzrdS/O2N/UK3EtPjAIZIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657705916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OiPMrFEyQe09Ik/mc4Cz2IRz2WPEoPYREf4eHc+dNlM=;
        b=/O5M5nhkmNfN4WPl4XIhK6viOvo+DR8qTPgSJhLCrduuKOti4uRRt5/1crrwrNfkroAXFj
        eJy//FvBig4jiRBQ==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        todd.e.brandt@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
In-Reply-To: <Ysv3JNs4RwE7kAou@google.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
 <87czegxccb.fsf@jogness.linutronix.de>
 <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
 <87tu7qvx1q.fsf@jogness.linutronix.de>
 <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
 <87o7xwbuoy.fsf@jogness.linutronix.de> <Ysvbp8vz7R9hDNqx@alley>
 <Ysv3JNs4RwE7kAou@google.com>
Date:   Wed, 13 Jul 2022 11:57:55 +0206
Message-ID: <87ilo1wdac.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-11, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> It seems that __pr_flush() does not check whether all consoles are
>> suspended. In this case the progress is not possible and it has to
>> wait the entire timeout.
>
> But isn't console_suspended set after pr_flush() call?

There should not be any printing after the suspend_console() message. If
Todd's report is coming from 5.19-rc1, then it is likely a kthread
issue, where the kthread is not respecting @console_suspended. (This
would still need to be fixed for the kthreads, but would not be relevant
for 5.19.)

John
