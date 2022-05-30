Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154855386F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbiE3SDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiE3SDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:03:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44112A205F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC28BB80E90
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BD8C385B8;
        Mon, 30 May 2022 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653933784;
        bh=LBBitGgiAKVXLtDxeCl3tGKXqWxtw4q3wByIYW0Mkvg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=raccM0ofMwCi3iDKadgiI+WugX5BbjhDG4RfRngJG04/coxgm5HTWCELUM7uJo71H
         Ybc0u2JPew1LQ+GAu/wiAoutyCl9gGOokABCkqGTJ8bgVmWPPsk259nXzxXqCbL9Ib
         jRdcWlIMB1+XQfMLvfBidvhhveAe2Is9ESguJAHjedzmzQGjebhkjYEdUrKeEY729L
         f8ucfIFO4LTSPdbspXzPONoAFT57dC8HX+HSPPMABTciNWA0Tl0T/dmDghex5mU8ep
         /1vZtvuvA3rES1SY1oNSf+7FrejM37hYSTR93m31aDASR0UtLo3LDyyQsiGoqqqJoP
         b+5BB3DwgU/uA==
Message-ID: <315b0b80f7f541b99a49a9fecb743874f31d95ba.camel@kernel.org>
Subject: Re: [PATCH 20/21] rcu/context_tracking: Merge dynticks counter and
 context tracking states
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Mon, 30 May 2022 20:02:57 +0200
In-Reply-To: <20220519145823.618983-21-frederic@kernel.org>
References: <20220519145823.618983-1-frederic@kernel.org>
         <20220519145823.618983-21-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Thu, 2022-05-19 at 16:58 +0200, Frederic Weisbecker wrote:
> Updating the context tracking state and the RCU dynticks counter
> atomically in a single operation is a first step towards improving CPU
> isolation. This makes the context tracking state updates fully ordered
> and therefore allow for later enhancements such as postponing some work
> while a task is running isolated in userspace until it ever comes back
> to the kernel.
>=20
> The state field becomes divided in two parts:
>=20
> 1) Two Lower bits for context tracking state:
>=20
> 	CONTEXT_KERNEL =3D 0
>    	CONTEXT_IDLE =3D 1,
> 	CONTEXT_USER =3D 2,
> 	CONTEXT_GUEST =3D 3,
>=20
> 2) Higher bits for RCU eqs dynticks counting:
>=20
>     RCU_DYNTICKS_IDX =3D 4
>=20
>    The dynticks counting is always incremented by this value.
>    (state & RCU_DYNTICKS_IDX) means we are NOT in an extended quiescent
>    state. This makes the chance for a collision more likely between two
>    RCU dynticks snapshots but wrapping up 28 bits of eqs dynticks
>    increments still takes some bad luck (also rdp.dynticks_snap could be
>    converted from int to long?)
>=20
> Some RCU eqs functions have been renamed to better reflect their broader
> scope that now include context tracking state.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Cc: Yu Liao<liaoyu15@huawei.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> Cc: Alex Belits <abelits@marvell.com>
> ---

While working on a feature on top of this series (IPI deferral stuff) I bel=
ieve
I've found a discrepancy on how context state is being updated:

 - When servicing an IRQ from user-space, we increment dynticks, and clear =
the
   ct state to show we're in-kernel.

 - When servicing an IRQ from idle/guest or an NMI from any context we only
   increment the dynticks counter. The ct state remains unchanged.

Regards,
Nicolas
