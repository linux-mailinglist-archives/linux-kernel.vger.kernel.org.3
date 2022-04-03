Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94C14F0B80
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359611AbiDCRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359604AbiDCRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:15:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDFA636B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gRtfWuNLHAesYLm4T4vvIRUPh5jkPB771OoKEOCAkLQ=;
        t=1649006014; x=1650215614; b=P9kXroryPUrfHpoCzlf+6mVpjx8a1ceZx0lDAucOhnRonLI
        MZxvl5RBpLT2ND7K4jNKYUnk7AXVYtNze+b0eL5RjnnhN6Rx40P9do77IRN7QL8ZTd81vvRr1qcX9
        /2SbWq8wd8VsW46LUF9kO40tMxKHyxqdy2u7R7d9q6hyM682SD/k/ChYxhRDuEcicgU0o36QI+ZGb
        lNAgMWTGY+7l19qPUSQKeXrTDRg3CVTn6gKvUv8rUc4yX26aoq9HZqAFC029qpL5S00ePKxlZqmaS
        QHmwObKIW75O/kyr55opu8q+2m1S3Y13CjkKf5JVuzMSY7T1a/3kU8l3JHfKf9Qw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nb3my-004NZ5-K1;
        Sun, 03 Apr 2022 19:13:20 +0200
Message-ID: <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Sun, 03 Apr 2022 19:13:19 +0200
In-Reply-To: <877d86m978.ffs@tglx>
References: <20220330110156.GA9250@axis.com>
         <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
         <877d86m978.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-03 at 18:18 +0200, Thomas Gleixner wrote:
> On Sat, Apr 02 2022 at 16:09, Johannes Berg wrote:
> > At init, we get
> > 
> > init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
> > init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf
> > 
> > which makes sense, jiffies is set up to wrap very quickly after boot.
> > 
> > The warning triggers when we have jiffies=0x13fff9600, so it's just
> > after the "next_expiry", so in this code:
> 
> which does not make sense.

If you say so, I have no idea :)

> If next_expiry is 0x13fff8acf and jiffies
> advanced to 0x13fff9600 when the warning triggered, then either it
> missed to expire the timer at 0x13fff8acf or it failed to recalculate
> next_expiry.

There was no timer. If there's ever a timer on this base (BASE_DEF) then
this doesn't happen.

So it has to be the latter, but I'm trying to understand in the code
where it would*ever* recalculate next_expiry if it in fact never
expires?

> Could you enable all [hr]timer tracepoints on the kernel command line,
> set panic on warn and ftrace_dump_on_oops which should spill out the
> tracebuffer on the console and provide the output. That should at least
> give us an hint what's going on.
> 

Sure, but since we simulate ~50 days of uptime, that's a massive number
of events and lots of them are not there:

https://p.sipsolutions.net/fb491cbbde82c600.txt

johannes
