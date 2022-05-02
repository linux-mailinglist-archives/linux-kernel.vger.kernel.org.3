Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6338517323
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385984AbiEBPtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385983AbiEBPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:49:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71611166
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0EE2CE1B33
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1D8C385A4;
        Mon,  2 May 2022 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651506367;
        bh=AGY4CVS//Cd51RpEFYmg5JyDhOouWYthTY1/Nr0uweY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=njbWhNN8ibMkjRTDPRZcGaDo7SemHKG5XJ6k9wLgMbYLJj8XobJmklrPDBgj38+PH
         bt5b/rckNEx151/bvYIMZ/vcvkDM+QNmIZ3hDKAcg/Ipc5KglkeLQjdeT+hX94VJ9a
         Q0ygkTieOXvdgtFzmrQ0OfUy5puN5pmBhsjbMcm2rF+QnN57u34SchHIRcl9DfNZ6u
         qLDRjc9509SemOj4SZ4g3NBSq+Qph9sk8clZUQybLTw/+tRov5pNdJdZBgQ7GCP+uX
         HXVgiMOZEWQq/eGSa/P5H4IRwanN77L33P920KgfXuiUkUpVenFhZ2zogJ2jXI008I
         hLVuLc+nr5BVQ==
Date:   Mon, 2 May 2022 17:45:59 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        pali@kernel.org
Subject: Re: irqdomain API: how to set affinity of parent irq of chained
 irqs?
Message-ID: <20220502174559.78f5cbc0@dellmb>
In-Reply-To: <87mtg0i8m8.wl-maz@kernel.org>
References: <20220502102137.764606ee@thinkpad>
        <87mtg0i8m8.wl-maz@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 May 2022 10:31:11 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Mon, 02 May 2022 09:21:37 +0100,
> Marek Beh=C3=BAn <kabel@kernel.org> wrote:
> >=20
> > Dear Marc, Thomas,
> >=20
> > we have encountered the following problem that can hopefully be put
> > some light onto: What is the intended way to set affinity (and possibly
> > other irq attributes) of parent IRQ of chained IRQs, when using the
> > irqdomain API? =20
>=20
> Simples: you can't. What sense does it make to change the affinity of
> the parent interrupt, given that its fate is tied to *all* of the
> other interrupts that are muxed to it?

Dear Marc,

thank you for your answer. Still:

What about when we want to set the same affinity for all the chained
interrupts?

Example: on Armada 385 there are 4 PCIe controllers. Each controller
has one interrupt from which we trigger chained interrupts. We would
like to configure each controller to trigger interrupt (and thus all
chained interrupts in the domain) on different CPU core.

Moreover we would really like to do this in runtime, through sysfs,
depending on for example whether there are cards plugged in the PCIe
ports.

Maybe there should be some mechanism to allow to change affinity for
whole irqdomain, or something?

Marek
