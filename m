Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D646516D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384276AbiEBJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384260AbiEBJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:41:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C515A22;
        Mon,  2 May 2022 02:37:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651484267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQykcMLoo3whmre75eemO2BA9Si3o9mNKcRIijtvUfk=;
        b=XBdjfKe1Dkrz1xS4lgbxg4+Xdi9FHfpQWtUHVGsy+kluZqlqT5HZ34j07EpaeTp6Nuoz4A
        7JN3rh8M87SxPSIMTNlEsEBEB0sFMp893gzxSswdwVWAO4EdASuIxNMtYSiAqEIllm5MmK
        gxJMraMEpJ+N08aJagDo6zZB0xfsE6yTxAyR2yvbp/iMrGay8rvkO8zo5IEctDWTSgwFVn
        0XNXVRTetdkyle6WknpSNIXALp1DO7LvKWKHT+oRLzQDtPNLWyqWKqlr2POgteln6/o0fU
        F7/lLdfFi2fY442kwsD0EkowbQr7KaYER/bqp/R/Qk6Oa2kCbKweNpOTF30keg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651484267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQykcMLoo3whmre75eemO2BA9Si3o9mNKcRIijtvUfk=;
        b=LY1K/DPFg7Mos6VSpKHVS2booc8Iw7choSEnDW2iiCcxWF2qLPVcST9n1fhHDocoNcuJZw
        XgOMvnVhGCvCepBg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v6 06/17] timekeeping: add raw clock fallback for
 random_get_entropy()
In-Reply-To: <YmageFiSs0h1jzS7@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-7-Jason@zx2c4.com> <87y1zt1gqw.ffs@tglx>
 <YmageFiSs0h1jzS7@zx2c4.com>
Date:   Mon, 02 May 2022 11:37:46 +0200
Message-ID: <87y1zkmg0l.ffs@tglx>
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

On Mon, Apr 25 2022 at 15:22, Jason A. Donenfeld wrote:
> On Mon, Apr 25, 2022 at 02:37:11PM +0200, Thomas Gleixner wrote:
>> On Sat, Apr 23 2022 at 23:26, Jason A. Donenfeld wrote:
>> >
>> > Cc: Thomas Gleixner <tglx@linutronix.de>
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Theodore Ts'o <tytso@mit.edu>
>> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> 
>> Not that I care much, but in general taking over authorship w/o
>> attribution via Suggested-by or such is frowned upon.
>
> Sorry about that. Usually I'm pretty good about adding those. I guess
> something must have gotten lost this time through, as the v1 of this
> started out using sched_clock() (Arnd's suggestion) and then moved to
> using the raw ktime clock after your suggestion, and I missed the
> Suggested-by. I'll add that. Meanwhile, do you want to Ack this patch?
> Do the technical aspects look okay to you?

Yes. Please fix the subject line:

     timekeeping: Add raw clock fallback for random_get_entropy()

and stick the Cc's below the SOB, so it conforms with the TIP tree
rules. Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
