Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34679511F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbiD0RZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244082AbiD0RZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:25:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B246B29;
        Wed, 27 Apr 2022 10:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69429B825F9;
        Wed, 27 Apr 2022 17:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C747C385A9;
        Wed, 27 Apr 2022 17:22:07 +0000 (UTC)
Date:   Wed, 27 Apr 2022 13:22:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock
 tai
Message-ID: <20220427132205.386be5e6@gandalf.local.home>
In-Reply-To: <20220427112759.1cedda69@gandalf.local.home>
References: <20220414091805.89667-1-kurt@linutronix.de>
        <20220414091805.89667-2-kurt@linutronix.de>
        <20220426175338.3807ca4f@gandalf.local.home>
        <87r15i9azg.fsf@kurt>
        <20220427112759.1cedda69@gandalf.local.home>
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

On Wed, 27 Apr 2022 11:27:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm able to trigger this on x86 64bit too.
> 
> One thing I noticed, is that the two numbers I have (from a different
> trace, but very similar to the above)
> 
> $ printf "%llx\n" 498151194674148935
> 6e9c9df4afd3647
> 
> $ printf "%llx\n" 1651072699280995911
> 16e9c9df4afd3647
> 
> That is, the last nibble either is 0 or 1, causing the change?
> 
> 06e9c9df4afd3647
> 16e9c9df4afd3647
> 
> The numbers are the same except for that last nibble.

And I just realized what the issue is. The ring buffer only allows for 59
bits of timestamp, as there's times it needs to inject a timestamp into the
buffer, which is 16 bytes, and the first 5 bits are meta data, leaving 59
bits for the timestamp. Since no timestamp came close to that before this
timer, everything worked.

Thus, when a full timestamp is injected, it takes off the 5 MSBs of the
timestamp (which took off that 1) and that is what is happening.

I can see if I can play some games to detect this and replace the top 5
bits with the saved timestamp at the head of the sub buffer.

-- Steve
