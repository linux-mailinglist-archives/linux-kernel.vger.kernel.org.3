Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1A521419
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiEJLsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiEJLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:48:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEE2044D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:44:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652183045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Js8RDp7iMnj24JVY5ETKpHQgMOnO+QR2UvUOw/t3NVI=;
        b=iiIyquw+8QYZcovxorjqRFjfwhtMfLsHJEqe7bb762UGT/v/l/uDU2MlyH5t4U6gak6twB
        cCyHPEaUDEHU0enPu0J4DBw0J15rjARHL269aYiMpCupYu3BwyjP2tKIEcoTzzuFT76fSs
        Z0yC68PLfuFj70wdQZ68UUH/P13qMaOf9EUpMqUg6EgaWEupFN2HWfhg6OWSZyr0hg/ZGt
        Qzi4v4cd/H7wytmGiF+HHWJ9XcNU3cDxrdhX3LKr8Dq8hqBErcTwz/b/6JL8w7xTiMyZdu
        TWiYR1JW/491ynSImOymZIIK8iEtjvf2oz1jdx2qz/HmDYNZXQ9LjnzhjQSgpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652183045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Js8RDp7iMnj24JVY5ETKpHQgMOnO+QR2UvUOw/t3NVI=;
        b=wrd2WsMhhsrFIarhn4h+pO3O6mNNt4p+QTgQfzqOJMhou7WWpPXvvVvQJWm3tmm+PLi6JN
        3qRFd4zzo70zIfDQ==
To:     Nicholas Piggin <npiggin@gmail.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining
 tsc_khz
In-Reply-To: <1652180070.1r874kr0tg.astroid@bobo.none>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
 <1652180070.1r874kr0tg.astroid@bobo.none>
Date:   Tue, 10 May 2022 13:44:05 +0200
Message-ID: <87ilqdpq7u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10 2022 at 21:16, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
>> +	/*
>> +	 * If in use, the HPET hardlockup detector relies on tsc_khz.
>> +	 * Reconfigure it to make use of the refined tsc_khz.
>> +	 */
>> +	lockup_detector_reconfigure();
>
> I don't know if the API is conceptually good.
>
> You change something that the lockup detector is currently using, 
> *while* the detector is running asynchronously, and then reconfigure
> it. What happens in the window? If this code is only used for small
> adjustments maybe it does not really matter but in principle it's
> a bad API to export.
>
> lockup_detector_reconfigure as an internal API is okay because it
> reconfigures things while the watchdog is stopped [actually that
> looks untrue for soft dog which uses watchdog_thresh in
> is_softlockup(), but that should be fixed].
>
> You're the arch so you're allowed to stop the watchdog and configure
> it, e.g., hardlockup_detector_perf_stop() is called in arch/.
>
> So you want to disable HPET watchdog if it was enabled, then update
> wherever you're using tsc_khz, then re-enable.

The real question is whether making this refined tsc_khz value
immediately effective matters at all. IMO, it does not because up to
that point the watchdog was happily using the coarse calibrated value
and the whole use TSC to assess whether the HPET fired mechanism is just
a guestimate anyway. So what's the point of trying to guess 'more
correct'.

Thanks,

        tglx

