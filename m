Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA63E51E175
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444628AbiEFV7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444638AbiEFV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:59:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D913EB9D;
        Fri,  6 May 2022 14:55:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651874151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46h2Hr/IsT6nyxT/z/VdRWKEtH5wioEThA8g1esMAtQ=;
        b=Rnqp9ONu4zCHSmLhqnNupUMQ6ZHLbshP0vr06cP8G+5sR7hI/k1YoTMHfBYUP3hCBarywd
        E2DqMTAv97Oo8rZ/7s0IisoDFW/Yf7M9SRkex3UsoFy0ZHXZ7/05lUHiex/y0Z0E6g8U/K
        vwEYhVfB5wF2nZGNDovtjFuzxilejrVJez2DgJ41LNYcJGF6HCRjBpwHHqHTldGPqb7Tc5
        rJ6Kkv892ZluslAezWqHulOPbg6znHdOEFVi1pZFZQ/WlZQntJemxgPLhVWq+Rj/zH3Md0
        CryhobcQfQ7QXzyRjxC5MMD1ZgSSO5tRyDXC3Aznt6CPEINXgbPEJjwg7WpXgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651874151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46h2Hr/IsT6nyxT/z/VdRWKEtH5wioEThA8g1esMAtQ=;
        b=z6Zy9L+uxVBevM1TI0IR5CgbNIKCtjDsuhmKueNbsNIyokpXNb3H6xGkzL4KCMjquXf+sv
        lLTKMOjTmdrqSqBw==
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] entry: Rename arch_check_user_regs() to
 arch_enter_from_user_mode()
In-Reply-To: <YnV7sD3r/PzY+1lA@osiris>
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
 <20220504062351.2954280-2-tmricht@linux.ibm.com> <87bkwah2p1.ffs@tglx>
 <YnV7sD3r/PzY+1lA@osiris>
Date:   Fri, 06 May 2022 23:55:50 +0200
Message-ID: <87fslmfhqx.ffs@tglx>
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

On Fri, May 06 2022 at 21:49, Heiko Carstens wrote:
> On Fri, May 06, 2022 at 09:38:02PM +0200, Thomas Gleixner wrote:
>> On Wed, May 04 2022 at 08:23, Thomas Richter wrote:
>> > From: Sven Schnelle <svens@linux.ibm.com>
>> >
>> > arch_check_user_regs() is used at the moment to verify that struct pt_regs
>> > contains valid values when entering the kernel from userspace. s390 needs
>> > a place in the generic entry code to modify a cpu data structure when
>> > switching from userspace to kernel mode. As arch_check_user_regs() is
>> > exactly this, rename it to arch_enter_from_user_mode().
>> >
>> > Cc: Thomas Gleixner <tglx@linutronix.de>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Andy Lutomirski <luto@kernel.org>
>> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> 
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>
> Is it ok for you if this gets routed via the s390 tree?

Sure.
