Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39516573EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiGMVXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbiGMVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:22:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF013F03;
        Wed, 13 Jul 2022 14:22:23 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657747341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1yBttfM1OIBrcobeykZD9o4tbtZiHFfM1/f7oRhcDk0=;
        b=YKWajG8WfsiE2Hr4rJ3Kr0aJnB1C5SjgyGRO2LpCbAHowS403vGXprtO4TNatWTuIIrbBB
        2QBdSMS71kwtHcIsBpC+6tg8qEtkzKx1SDDccULp5gTGGZri/Rmw34adavSWgoxmocVOsE
        PFlYzwvYHTmBGZOlJu/1nv98ho/aW60ahxsHO+H3Rd9sinJNmqdLKwuF9NoLU0xm39uda4
        1juleGNMm3I6Pq5opoampRysUKqd8Boa2RyqIio8Ds0ek71C2RNJFgg5n+owfT2zPpioDv
        XdQMBjldIjR4NjfkyJmoav0QVREhc9LOnODw3L1WIr9vwCZ88al4CRhEPlcc3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657747341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1yBttfM1OIBrcobeykZD9o4tbtZiHFfM1/f7oRhcDk0=;
        b=ztDAuM+VYw/ELLKYIWq1oUmmyc0nNOrLOLf5XoW48EDkkvcr0GcedXNhsyqdMtVBvwREuG
        THBcfEwAco6coVAQ==
To:     todd.e.brandt@linux.intel.com,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, rafael.j.wysocki@intel.com,
        len.brown@intel.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
In-Reply-To: <7d79e9877d63cdb74144f38d8736959281b562cc.camel@linux.intel.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
 <87czegxccb.fsf@jogness.linutronix.de>
 <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
 <87tu7qvx1q.fsf@jogness.linutronix.de>
 <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
 <87o7xwbuoy.fsf@jogness.linutronix.de> <Ysvbp8vz7R9hDNqx@alley>
 <Ysv3JNs4RwE7kAou@google.com> <87ilo1wdac.fsf@jogness.linutronix.de>
 <c60f5634e8605cb4c2ef4646b6e511e6135bea48.camel@linux.intel.com>
 <7d79e9877d63cdb74144f38d8736959281b562cc.camel@linux.intel.com>
Date:   Wed, 13 Jul 2022 23:28:20 +0206
Message-ID: <875yk0908j.fsf@jogness.linutronix.de>
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

On 2022-07-13, Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> URGENT: Removing the commit FIXES the issue.
>
> I just ran a 5.19.0-rc6 kernel with the offending commit removed and
> it fixed the problem completely on all 3 machines.

I believe to have found the issue. A patch was posted to bugzilla:

https://bugzilla.kernel.org/attachment.cgi?id=301413

Please test this. Thanks.

John Ogness
