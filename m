Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3621512D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbiD1HuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiD1HuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:50:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C752E75
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:47:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651132026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RlxAeFcKDl76ZPnOksBCZRs3r20R5jQitVN8scKDEU=;
        b=hMTA9mvsIiyk1Ca/XlyX8AeY2QC/cmtn/usvFpT5/Djp2goDLAtZlPBFoaafnhmo+gsWV0
        gAA2qJKgj+qZimhPbfNxUOJs8iWWDeCzkvBoaIfs+zro0Y4fF3SFLYMDiDyTnwHWPaNLrV
        AvIgvITEN7NkdG0z5l0R0y/yrgHAIpqud/B7JWkaLB3YzmVAP5S2xlFEiZXd4LEppAzy5D
        2Ny5t1DIzzUI8uhvA9ItgQ7p+p8cGwWHA3kN21Q4/QhuluA/7C2nf0d/exdQ4NzXXUN2/P
        G82lHLTpRGIfCBH3yYGX6aXYEfph6CUEJScfB+DN2eklX7Qqflvm/qjIIKs2ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651132026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RlxAeFcKDl76ZPnOksBCZRs3r20R5jQitVN8scKDEU=;
        b=LpsodpvZXHe8SZw4Uj003NnlKa01r3Z9hXv2mXM1y2TK3CC6Cqf9uZRqvWw5y9i1ksLcSK
        b1pb9Zss/p9Q0UBg==
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCH] ipc: Update semtimedop() to use hrtimer
In-Reply-To: <B8775ABA-892E-40FE-BA0D-A72B635D33A9@oracle.com>
References: <1650333099-27214-1-git-send-email-prakash.sangappa@oracle.com>
 <87k0baw59j.ffs@tglx> <B8775ABA-892E-40FE-BA0D-A72B635D33A9@oracle.com>
Date:   Thu, 28 Apr 2022 09:47:06 +0200
Message-ID: <878rrpwsxx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27 2022 at 23:42, Prakash Sangappa wrote:
>> On Apr 27, 2022, at 3:06 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Converting to ktime first makes this cheaper:
>>=20
>>                expires =3D ktime_get() + timespec64_to_ns(timeout);
>
> Since user provided timespec is added to current time, shouldn=E2=80=99t =
it check for overflow?
>
> So, perhaps=20
>
> 		expires =3D ktime_add_safe(ktime_get(), timespec64_to_ns(timeout));

Of course. This was just for illustration and I assumed you figure it
out, which you did. :)

Thanks,

        tglx
