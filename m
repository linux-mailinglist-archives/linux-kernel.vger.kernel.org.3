Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594A6552899
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 02:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiFUA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 20:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiFUA3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:29:37 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760DB20F78
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:29:34 -0700 (PDT)
Date:   Tue, 21 Jun 2022 00:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1655771372; x=1656030572;
        bh=KP4otxWVhQW8iB5l/zwSnHapuVrUU7ofdACUxCcrn7I=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=x9H2OR/u31qzawfH5gCI6p2JsQ5s8Ltq5J4GMPD9TdoneToj23qm2CVezFCCwpbSU
         3CAN8kyEyqY+2YjW7rGHQ8DEbrvFlJoRoJRZAS+5jKvWN4ElBdaIomTOHbER3yZne5
         hMGZQg5F9owZmJDWxMURv2HVeupWvZssRu6t9vYQjUkLyijFWdfOn53JV2z3dHXnt+
         XqDVKl/hLLrbsvDYdJXWyKoDeq51l9ZahnrVX7Jh3+fvZ+qpdFWqTRuppelU6fG414
         A+iB+MrJc45RFv5O363WQMmhOjhy0Id3D63N1uwFHgd6dT59FPtenD5czTLBiOG7pc
         LdaVf9zqONpoA==
To:     linux-kernel <linux-kernel@vger.kernel.org>
From:   "Ryan P. Nicholl" <rnicholl@protonmail.com>
Reply-To: "Ryan P. Nicholl" <rnicholl@protonmail.com>
Subject: Networking Question
Message-ID: <6_nVwntZEyEq2Gn0PYDz5w_yuD20E9Je_Bk2rJHsOersGq3v2x3_6hXnyjNm-X83-OTl1KKo4eLoHzyBVM_nzCcDrpPtz4dz3_71A3QezfI=@protonmail.com>
Feedback-ID: 15386781:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been unable to find any Linux API for asynchronously waiting for the T=
CP send buffer to drain.

The problem I have, in a nutshell, is noted in this part of the documentati=
on:

       If fildes refers to a socket, close() shall cause the socket to
       be destroyed. If the socket is in connection-mode, and the
       SO_LINGER option is set for the socket with non-zero linger time,
       and the socket has untransmitted data, then close() shall block
       for up to the current linger interval until all data is
       transmitted.

Ok, so not good for asynchronous programming, so I could disable the SO_LIN=
GER option, but that leaves me with another problem, namely that I *want* t=
he socket to linger.

The behavior I want is something like, calling "close", getting EAGAIN inst=
ead of triggering TCP RST, and something like EPOLLWRITEFLUSHED to wait for=
 the TCP send buffer to be drained. I know neither of these are possible.

Right now the only solution I can think of is to enable SO_LINGER and spawn=
 a thread to run close in, but this might spawn a lot of threads, and doesn=
't support cancellation well.

Alternatively, I could call getsockopt with TCP_INFO in a loop, but this tr=
iggers a lot of wake-ups and might result in sockets hanging around a lot l=
onger than they need to.

I want to allow linger indefinitely on close until some event happens like =
running out of ram or other resources, basically to intelligently do someth=
ing like: "OK, we're running low on RAM/resources, time to send RST and dro=
p the send buffer for the 5k worst behaving connections". So unfortunately =
even with the timeout provided by SO_LINGER, even assuming close would some=
how complete in the background, this could be an issue.

Is there any way to do this properly on Linux? If not, any possibility that=
 something like adding EPOLLWRITEFLUSHED would be a welcome addition?

Please CC me on responses.

--
Ryan P. Nicholl
