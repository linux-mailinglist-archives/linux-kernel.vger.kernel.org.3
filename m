Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6034C56BD86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiGHPfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbiGHPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:35:04 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113951A3A6;
        Fri,  8 Jul 2022 08:35:03 -0700 (PDT)
Date:   Fri, 8 Jul 2022 23:36:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657294501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Q2U10fVxflJg1wRLdlpzwKmLUZ/H+6ZbjlQlytlu3A=;
        b=pJRgOhPVgBRx5k/MVV3WVOImpOZpAmgGUHRC8Xe6Yp0ObR686Ffe1OFZFNoD8VisQ6GmQQ
        StZiq1oHCeETbNXCHZKSeUJxMnZ0xy85ksgkew4ADsAcnC/Y9KbDhojByL3ea13S7/mV92
        /j4QlyOQCmKHb86QCySPxf+vSsWkbiM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V4 01/20] rv: Add Runtime Verification (RV) interface
Message-ID: <YshO5tSeNyFpNFc4@geo.homenetwork>
References: <cover.1655368610.git.bristot@kernel.org>
 <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
 <YsXLDvjHqOxYtckg@geo.homenetwork>
 <YsXMEeqGr2vdJCa7@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsXMEeqGr2vdJCa7@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 06:53:21PM +0100, Matthew Wilcox wrote:

> On Thu, Jul 07, 2022 at 01:49:02AM +0800, Tao Zhou wrote:
> > > +struct rv_monitor {
> > > +	const char		*name;
> > > +	const char		*description;
> > > +	bool			enabled;
> > 
> > Can the 'bool enabled;' be put at the end like the definition of
> > structure rv_monitor_def. If '8+8+sizeof(bool)+8+8+8' not the same
> > as '8+8+8+8+8+sizeof(bool)', I mean is it possible that after the
> > end of stucture there is a int or char not require to align to 8 as
> > an example from my nonsense.
> 
> That will make no difference at all.  C doesn't allow other variables
> to "fill in the hole" at the end of the structure like that.  For
> example, one could legitimately do 'memset(&rvm, sizeof(rvm))',
> and that would wipe out those other variables as well.

I mean if it is possible that if @enabled placed at the end of the
structure rv_monitor will save some bytes.
If @enabled place in between, the next function pointer which is 8 bytes
will align to be in x8 address and the size of structure rv_monitor is
larger than been placed at the end of the structure.
Or the compiler can do magic that I can not guess.

Sorry for my late reply. I am not sure about this. But your reply is not
about what I mean. You say that the size of structure is the same(I doute about this).
But what my concert is that the other data next to the structure rv_monitor 
how to align if placing the @enabled at the end.

Place in between, bytes:
8+8+8(padd)+8+8+8=48

Place at the end, bytes:
8+8+8+8+8+sizeof(bool)=?

? is small than 48 and the data next to the data structure rv_monitor can use
the saved byte which is the result of placing @enabled at the end of structure
to place the data.
