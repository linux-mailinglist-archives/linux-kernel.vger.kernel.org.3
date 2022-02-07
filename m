Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC4E4ACAA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiBGUru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbiBGUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:32:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42420C0401DA;
        Mon,  7 Feb 2022 12:32:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 075F8B816F3;
        Mon,  7 Feb 2022 20:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8BCC004E1;
        Mon,  7 Feb 2022 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644265957;
        bh=qA17gMhLSyJTGkg5IG50iMqfuUUw7uCTxGT40buJCL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KK+IljrjgG5EfwFp52wkU7rrpkEVMmErHv0ovxwMWKJBsekOrkdiXT/F5dglBKU2i
         s3Ycx7lGx3IutqVVivrp3g303jjVDYr1rJ6yLN3kTV/4A6HLsYxM1Nk59zIZYvxpAL
         ByygAUgvH2cG/SXBVs/+pRtMbJ5Ku3nHFEPo6BSb6vS9rQFRQpo6jYRlBwI294KcR1
         jp2WNrRr/vWfkVaeruLBKTC+eArD+rSJHVlRRCqWaQH1b3t99EitB9f24ESgEOnzyb
         9l1oBAETt8kgRlmNnqQG7hv+/K+5P7YQAGJKbqvEG96XRjbZfmLaGyiak3nvH2eMEI
         i/UP9AJapKKqQ==
Date:   Mon, 7 Feb 2022 20:39:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     lars@metafoo.de, valek@2n.cz, gwendal@chromium.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] iio: light: opt3001: possible deadlock in
 opt3001_read_raw() and opt3001_irq()
Message-ID: <20220207203910.76ba3f2e@jic23-huawei>
In-Reply-To: <f04b6000-f128-f928-0e3e-e3acc206d2d1@gmail.com>
References: <f04b6000-f128-f928-0e3e-e3acc206d2d1@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 23:41:49 +0800
Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> Hello,
>=20
> My static analysis tool reports a possible deadlock in the opt3001=20
> driver in Linux 5.16:
>=20
> opt3001_read_raw()
>  =C2=A0 mutex_lock(&opt->lock); --> Line 399 (Lock A)
>  =C2=A0 opt3001_get_lux()
>  =C2=A0=C2=A0=C2=A0 wait_event_timeout(opt->result_ready_queue, ...) --> =
Line 276 (Wait X)
>  =C2=A0 mutex_lock(&opt->lock); --> Line 412 (Unlock A)
>=20
> opt3001_irq()
>  =C2=A0 mutex_lock(&opt->lock); --> Line 693 (Lock A)
>  =C2=A0 mutex_unlock(&opt->lock); --> Line 730 (Unlock A)
>  =C2=A0 wake_up(&opt->result_ready_queue); --> Line 733 (Wake X)
>=20
> When opt3001_read_raw() is executed, "Wait X" is performed by holding=20
> "Lock A". If opt3001_irq() is executed at this time, "Wake X" cannot be=20
> performed to wake up "Wait X" in opt3001_read_raw(), because "Lock A"=20
> has been already hold by opt3001_read_raw(), causing a possible deadlock.
> I find that "Wait X" is performed with a timeout, to relieve the=20
> possible deadlock; but I think this timeout can cause inefficient executi=
on.
Hi Jia-Ju Bai,

There is a quirk in here thatyou haven't mentioned.  The "magic"
opt->ok_to_ignore_lock.

So there are two cases:
1) No irq in use.  In that case the opt3001_irq() will never run and we
   just sleep + check a status flag. That's the best we can do without
   an interrupt.
2) irq in use, the ok_to_ignore_lock =3D true statement occurs and
   in the opt3001_irq() the locks are never taken hence no deadlock.

It is a very odd bit of code though so I'd be surprised if a static
analyser hadn't highlighted it as a possible deadlock!

Now, I'm not immediately sure why the driver is done like this as opposed
to a more complete wait_for_completion() in read_raw(), complete() in the i=
rq
handler and do the actual read of the data back in read_raw().
It's probably related to the other interrupt sources that we need to
differentiate from in the interrupt handler.

The lock definition is missing an documentation of exactly what it's scope
is which definitely doesn't help us understand this unusual structure.

Thanks,

Jonathan


>=20
> I am not quite sure whether this possible problem is real and how to fix=
=20
> it if it is real.
> Any feedback would be appreciated, thanks :)
>=20
>=20
> Best wishes,
> Jia-Ju Bai

