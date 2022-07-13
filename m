Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76806573F46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbiGMWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGMWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:01:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD6431218;
        Wed, 13 Jul 2022 15:01:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657749664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YnBn9SiT5WrnT/4mLV7Ah48VHNLH73En/1THWTXmgH4=;
        b=xc4A0CCfR/DqNBm/26nzSMUenJbgvtBmO30hw2aGZZ9YXIvZCVaAo7RZK+nejrW1WrEo4O
        +FvyYW2g/Q1PUUiL7p4nCn2U5Qvzw/PeQc5lKVY7p8dDQGmXYjz5+4I7qIodB2aUdfor6h
        YoWkF6CVOVQ69ABDtlZ9AOjUpeaXR/FKxYiNeeSlMXq8M8o73llLu0yj3eOCWUIPIx4CMq
        IUAhu69YcJ9gbMoQkjul4xRmoLtsqaxjsdmky6z8Te++Lz3ybaEMg7ANVuvVnlXxBPZziQ
        xFyzyEHtrThUqHQL+BaA3AL/Z/GAOxY/blgix2EG7K0p7qYww17lDxLc24lCdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657749664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YnBn9SiT5WrnT/4mLV7Ah48VHNLH73En/1THWTXmgH4=;
        b=XuMw8bvJzqqx00ogc3ukYl45zs97QqC/1oMtsX9weKzewKXIc10g0RhaRvyki3N2y7byXq
        bk7IvqpqAfu6kWDg==
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
In-Reply-To: <875yk0908j.fsf@jogness.linutronix.de>
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
 <875yk0908j.fsf@jogness.linutronix.de>
Date:   Thu, 14 Jul 2022 00:07:04 +0206
Message-ID: <8735f48yfz.fsf@jogness.linutronix.de>
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

Hi,

I have posted a v2 to bugzilla:

https://bugzilla.kernel.org/attachment.cgi?id=301414

This version allows console_stop()/console_start() to flush for the
non-suspend case.

Please test. Thanks.

John Ogness
