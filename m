Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4E50BA7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448826AbiDVOpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448879AbiDVOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:45:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1275BE79
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:42:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650638573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ab1B9xAubV3zZLLUQejgYIXK0dy0QH0QGOT/yEDKvw=;
        b=a0jKXGBB05Wms0CsvBuwLt0SWse/M2Cfy6qwtqtqn1QZxAXKAaoeifkiJtABRWHlf6geJh
        KlRBPORdqhDY6DZKejJQxsg70PqSMcXXJwMamN9zuVPewbA3ykr3f0ur0aLXaObfLeua0p
        69n1YIn9VeZFM0j5AqOA2oca7E8X6Bxk/vuOPyaCaGRWgf3EQUNsg/i34HFxshdS5yGjiZ
        +S2AU2c/vDIix5rwwwRP+mwPBTQjVONXWZts8ETS7arRbkJ4W/Hk8lO9LQ5zfZJj2waQOj
        gMCufq8fpm936wCmsvJ2q7BeYx0SGeZEo0LJr5v9WV2qzeGUiJ9LGoJ0QcPwmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650638573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ab1B9xAubV3zZLLUQejgYIXK0dy0QH0QGOT/yEDKvw=;
        b=fZ3WO591Dbl4IIhNV9yo29PTdXOG3vfQqufJ5DX1cdJowXaOalC9ivx2rOgYkKMnQhyxaU
        GXBCQf2Dp3Sy7+Ag==
To:     Nico Pache <npache@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?Q?An?= =?utf-8?Q?dr=C3=A9?= Almeida 
        <andrealmeid@collabora.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/3] futex: exit: Print a warning when futex_cleanup fails
In-Reply-To: <90124b02-76b5-d775-ac7d-a2e9d7677fa1@redhat.com>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-3-npache@redhat.com> <87r15qrwdt.ffs@tglx>
 <90124b02-76b5-d775-ac7d-a2e9d7677fa1@redhat.com>
Date:   Fri, 22 Apr 2022 16:42:52 +0200
Message-ID: <87r15p5gcz.ffs@tglx>
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

On Fri, Apr 22 2022 at 10:23, Nico Pache wrote:
> On 4/21/22 16:53, Thomas Gleixner wrote:
>> On Thu, Apr 21 2022 at 15:05, Nico Pache wrote:
>> Robust futexes are best effort as I explained you before and spamming
>> dmesg won't help anything.
> It would have helped find the OOM/Robust Futex issue more quickly. It may also
> help detect breakages in the pthread code (or any other users of robust futex)
> if someone is doing something incorrectly.

If we follow that line of argumentation then we have to sprinkle printks
en masse all over the place as there are a gazillion ways to create hard
to debug issues.

Thanks,

        tglx


