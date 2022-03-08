Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0633A4D1B36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347709AbiCHPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbiCHPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:00:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C54D633
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:59:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646751579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcGRkjg8+BFqZodBvhvBSx+26nPdc2c0IldY/TkN6SM=;
        b=wDij4aHwno+BB7bJO6Z+9KlCNGg3hEjy/IwGx1BlBmbVC5XtkOBoNoCsHkljnNUMzCi+OA
        OJl7tsOzHKVHaRhxcJmBIwP4Zy2QnJuscsxONpG0djTCDAfPKLdzwG8QKW/5iQE2YE1Rel
        G/G/zd/7Sd8JO6EJryS3aVzjskQ/QlyJPwLNt7fP5R2cASaY80s4aEtOYrXA7uYvCjbqVe
        M8vDp3WJuLPj0InPwiVgZHo++DBdqePzyNuJyUCVzYpXQ4ilo9vMoSLw5owAy5aelRQJY1
        KLIdGtSSHT7PW1erRLJCISGI6ghtVhD0s53vzK7JHcwdRRVXDo0dBcLTTTKAOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646751579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcGRkjg8+BFqZodBvhvBSx+26nPdc2c0IldY/TkN6SM=;
        b=ozt5VIY7GOPKsAE3mzc9JaCfFkXME6y1rf+sc65y7D/iLpUiytIRtg+awVzBqiOwi2gdht
        6jnkA5ByIXdU6zCQ==
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/split_lock: Make life miserable for split lockers
In-Reply-To: <YialXwpbED5kAUaZ@agluck-desk3.sc.intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <877d95l7jo.ffs@tglx> <YialXwpbED5kAUaZ@agluck-desk3.sc.intel.com>
Date:   Tue, 08 Mar 2022 15:59:39 +0100
Message-ID: <87mti0jxr8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On Mon, Mar 07 2022 at 16:37, Tony Luck wrote:
> On Mon, Mar 07, 2022 at 11:30:35PM +0100, Thomas Gleixner wrote:
>> On Wed, Feb 16 2022 at 17:27, Tony Luck wrote:
>> > Questions for this RFC:
>> >
>> > 1) Does this need to be a new option? Maybe just update the
>> >    existing "warn" mode to add this level of extra pain.
>> 
>> That's fine. Warn is the default today, right?
>
> Yes. Warn is the current default.
> Does "That's fine" mean ok to change exiting warn code to add
> this level of pain? Or OK to add a new option?

Add pain to the existing warn code.

>> The question is whether this is something to worry about. If so, then we
>> need to go back to the drawing board.
>
> I don't think it is worth worrying about. The case you describe is
> a process that is about to be preempted when the #AC trap happens.
> In that case this CPU (in fact both HT threads on this core) get
> two jiffies of free split locks.  Cases from here:
>
> 1) The original process gets to run on either of these threads
> before the timeout. They get to execute their split lock and carry
> on running.
>
> 2) The process is scheduled on a different core during the two jiffie
> window. They take an #AC trap and block on the semaphore until the
> original core releases. Then they get their chance to run on this new
> core.
>
> 3) The original process doesn't get rescheduled for two jiffies, then
> runs somewhere. The original core has released the sempahore and re-enabled
> split lock checking. So the process takes #AC, gets the semaphore, kernel
> disables split lock checking ... and we try again.
>
> Now it is possible that the process may repeatedly be preempted in between
> getting the semaphore and actually getting all the way to user space
> to split a lock ... but can only happen if there are multiple processes
> splitting locks. The goal of this patch is to be mean to all of them. If
> we happen to be extra mean to some of them, well so be it.

Fair enough.

I still do not like the inconsistent state between the TIF flag and the
SLD MSR.

Thanks,

        tglx
