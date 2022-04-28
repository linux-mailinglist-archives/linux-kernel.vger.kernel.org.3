Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF85F513E44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiD1WFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352711AbiD1WFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:05:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89552580EA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:02:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651183346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gbZvfRhPMmTSD5nbuZzzAIPDWoDEZq0xcd/J+SCn5uk=;
        b=ACvx1adzKuznliJZzRQQnYF9HoCYN6RqF4lHJ54AV4uRtn56hElAnusUn8mgbx64fbgzd8
        CYIbzxp5O7MkQ3bpCwb9+sIeNrSxNtRoJE+5oENfLZDCzTUqyFKfLtnvkBIgY+laR83ZmX
        8rTjMEXsQuh156qnydET1EjnrVwQVN16M7FdhKAQkdmwNv4/xSCdqH6Ser57gSqO3jnfTp
        O3xuNenI0JD/znIq6HnnKn/OP9flmrSNUMsypUYyVgveDxh/trjgXr9oKErlFJgsX4029h
        LD+VzU/IhBMA8r/icrvwISdeuvLQTG1mUhex73I11jsCWUwYCfyKYgEK4r0n7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651183346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gbZvfRhPMmTSD5nbuZzzAIPDWoDEZq0xcd/J+SCn5uk=;
        b=VuX4wGSIB7hLlFHYeojy1rUeYBLonGtw64LQTAvVCvtwsd8ijeVuZSuOoG0PvmXTU83HAx
        tV3krXBdcSoJlCBg==
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        peterz@infradead.org, manfred@colorfullife.com
Subject: Re: [PATCH v3] ipc: Update semtimedop() to use hrtimer
In-Reply-To: <20220428205001.hiuzwpn5emxtrh4s@offworld>
References: <1651178767-447-1-git-send-email-prakash.sangappa@oracle.com>
 <20220428205001.hiuzwpn5emxtrh4s@offworld>
Date:   Fri, 29 Apr 2022 00:02:25 +0200
Message-ID: <87zgk4ooi6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28 2022 at 13:50, Davidlohr Bueso wrote:
> On Thu, 28 Apr 2022, Prakash Sangappa wrote:
>>-		if (timeout)
>>-			jiffies_left = schedule_timeout(jiffies_left);
>>-		else
>>-			schedule();
>>+		timed_out = !schedule_hrtimeout_range(exp,
>>+				current->timer_slack_ns, HRTIMER_MODE_ABS);
>
> I'm wondering if the slack parameter instead of passing the timer_slack_ns
> value immediately, we should do a rt_task() check and pass zero if so.

We should have a wrapper function which takes care of that instead of
having checks all over the place.

Thanks,

        tglx
