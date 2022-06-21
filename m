Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF3553684
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353033AbiFUPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353074AbiFUPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:43:25 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2CE220DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:43:23 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:43:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1655826199; x=1656085399;
        bh=Fdb4fVtMroR7Gm/kLYIj7bIlDlM/5YAm1cGt21st2Ww=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=FCLamuiguLKbBrChIaZAkrA1fOt9w3ae9qcpHGTqqTt+O7rRxjSgVx9e79mNbu14b
         7Lt0+5IDjiFRExSylGSco0gy63X9Yc7dLPerK6wE+coERFbSjlbD3Vk5h4nO9sIejs
         ORLJx6ck8bebt6ajdes8olHhvbU6fTuqFIRaXc/gsMLZebkz3pI05pPsG9LJZVynx5
         LdzNL1scd/3LiHRs0AFxp3r+fXXvE8BpbQnd8Eumvp39EYeKETRN1S/sZey2euhMIS
         Oe1Xskzd4g6lqR9HQ144dcMtidBiLj5iXyd0YbbH4ar3zGW6ja6xh4usEL1W0WBj1r
         LW4BCgmGNjFXg==
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
From:   "Ryan P. Nicholl" <rnicholl@protonmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: "Ryan P. Nicholl" <rnicholl@protonmail.com>
Subject: Re: Networking Question
Message-ID: <yaXzQ-VgbQxXxbv_b8c4kQRbIG5MGXsnQHf8-yqT___iT2bMmYpXlqi_L5ml14y1KcFhYSkc22-L1nOeJRECv355it-XgjLwjg0DGvUQJ64=@protonmail.com>
In-Reply-To: <b6d8611a-714c-4fb0-5027-584884bb66a1@petrovitsch.priv.at>
References: <6_nVwntZEyEq2Gn0PYDz5w_yuD20E9Je_Bk2rJHsOersGq3v2x3_6hXnyjNm-X83-OTl1KKo4eLoHzyBVM_nzCcDrpPtz4dz3_71A3QezfI=@protonmail.com> <b6d8611a-714c-4fb0-5027-584884bb66a1@petrovitsch.priv.at>
Feedback-ID: 15386781:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to respond to this question, but unfortunately Linux=
's shutdown(2) cannot do what I need. This isn't a general question since P=
OSIX has no standard async API other than AIO which isn't implemented effic=
iently in GNU/Linux, and I don't think the kernel supports any aio calls di=
rectly, instead exposing clone and epoll_* facilities to solve the concurre=
ncy issues. However; none of them do what I need efficiently.

In theory, shutdown(2) could be used, the problem is that it's just not eff=
iciently scalable to 100s of thousands or millions of connections. I'm not =
speaking on behalf of my employeer, but I work for a financial company that=
 processes a lot of network traffic.

What I want essentially is similar to TIME_WAIT but instead of sending an R=
ST packet I want to be notified when the tcp connection is actually drained=
.

If you call shutdown, my understanding is that you get one of two behaviors=
:
1. You send RST and immediately discard the send buffer.
2. The call blocks for the SO_LINGER timeout.

Option 1 isn't acceptable because it gives the wrong behavior. Option 2 can=
 be made to work but the downside is that Linux only exposes a synchronous =
API for it which requires me to have at least 1 thread per shutdown operati=
on. So it could be quite bad if the network is very congested. Unfortunatel=
y threads are many times more expensive than sockets/tcp connections. So id=
eally having few threads and many sockets gives the best use of resources.



--
Ryan P. Nicholl


------- Original Message -------
On Tuesday, June 21st, 2022 at 3:02 AM, Bernd Petrovitsch <bernd@petrovitsc=
h.priv.at> wrote:


> Hi all!
>
> On 21/06/2022 02:29, Ryan P. Nicholl wrote:
>
> > I've been unable to find any Linux API for asynchronously waiting for t=
he TCP send buffer to drain.
> >
> > The problem I have, in a nutshell, is noted in this part of the documen=
tation:
> >
> > If fildes refers to a socket, close() shall cause the socket to
> > be destroyed. If the socket is in connection-mode, and the
>
>
> That's not really a Linux kernel question as such (because that should
> work that way on all TCP connections anywhere) but the shutdown()
> syscall is probably what you need:
> - your side shuts down the sending part of the socket.
> - the other side reads data and gets eventually EOF
> - the other side call shutdown() for it's sending side when it's done.
> - your side gets EOF.
> And then your side knows that no data is in flight.
> - finally, you clean up with close(). You can shutdown() the receiving
> side too but doesn't change anything.
>
> [ deleted SO_LINGER stuff - that's for something completelly different ..=
. ]
>
> Kind regards,
> Bernd
> --
> Bernd Petrovitsch Email : bernd@petrovitsch.priv.at
> There is NO CLOUD, just other people's computers. - FSFE
> LUGA : http://www.luga.at
