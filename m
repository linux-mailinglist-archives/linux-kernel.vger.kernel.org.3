Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309851ACC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377054AbiEDSbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377034AbiEDSbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:31:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FFC2E9D6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:05:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651687543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlEp+jMSpnfiQZGPYMkkhvpjZdbfCdxdoU3AdD/guDA=;
        b=WipYJZvxNJd7wYzedxJjWsbhnpc/tG2ZqFdMWEDaTdnD8p1yz21fOygnksDiGaccOp3SzB
        4pnyxXpCZ1oInUN7DXgPbscZjGZdInh0FMB8n+Q4LDrGNF7Bzq9ZHPtuRoILCLqHFiBdW0
        10MyzAIkZ/rwA0dVz6i9h3OSNkDHqYLdNtLCQSFxzaxnmHia5E/ETcE/3kg7AAODpr1JSt
        luT3zYn0FbceGA5Lvg++mGIlOp4jp/19WQ/pSXBn2q1SyXdkDECX0+SW4Alp9a4eqeo7mV
        NH0g2fAKNur+yfjJFHfRlumFy0jd12bI5TQH6H64WBU/e0sLyikjoefG5uRRQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651687543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlEp+jMSpnfiQZGPYMkkhvpjZdbfCdxdoU3AdD/guDA=;
        b=m2GRh6e4VDsu+DP9z+QIUyRNeDf+RyzrsvZ9q3I5mhevvsBYoYYZB1nL3IAzHGVIHzGbW4
        cnicNiYGjdPxgwDw==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [patch 0/3] x86/fpu: Prevent FPU state corruption
In-Reply-To: <YnKeag3Ulg0NR58Q@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <YnKeag3Ulg0NR58Q@zx2c4.com>
Date:   Wed, 04 May 2022 20:05:43 +0200
Message-ID: <877d71jhqg.ffs@tglx>
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

On Wed, May 04 2022 at 17:40, Jason A. Donenfeld wrote:
> On Sun, May 01, 2022 at 09:31:42PM +0200, Thomas Gleixner wrote:
>> The recent changes in the random code unearthed a long standing FPU state
>> corruption due do a buggy condition for granting in-kernel FPU usage.
>  
> Thanks for working that out. I've been banging my head over [1] for a
> few days now trying to see if it's a mis-bisect or a real thing. I'll
> ask Larry to retry with this patchset.

You could have just Cc'ed him. :) Did so now.

Larry, can you please test:

 https://lore.kernel.org/lkml/20220501193102.588689270@linutronix.de

Thanks,

        Thomas
