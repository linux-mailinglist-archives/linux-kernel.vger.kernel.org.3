Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A032566834
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiGEKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiGEKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:39:18 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 949EFC24;
        Tue,  5 Jul 2022 03:39:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 836A1FF9BF;
        Tue,  5 Jul 2022 10:39:16 +0000 (UTC)
Date:   Tue, 5 Jul 2022 12:39:12 +0200
From:   Max Staudt <max@enpas.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220705123912.1dfc6242.max@enpas.org>
In-Reply-To: <CAMuHMdW5tTVP6cQ6a8KtgYAxb_g1Y52a9+hHwEtNLV3xYpWsVA@mail.gmail.com>
References: <20220618195031.10975-1-max@enpas.org>
        <20220627150557.qluqtejrddj5nfif@pengutronix.de>
        <20220627190126.4eb57a2b.max@enpas.org>
        <CAMuHMdUYCiRC+9UnQB6-2XGp+wOjYq1U_J3bDQT+WNm==mS4qg@mail.gmail.com>
        <20220705094927.vgtxcjh4klw6dcg3@pengutronix.de>
        <20220705115613.69d32b22.max@enpas.org>
        <CAMuHMdW5tTVP6cQ6a8KtgYAxb_g1Y52a9+hHwEtNLV3xYpWsVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 12:16:08 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > > > I had a quick glance through the various revisions posted, and
> > > > it doesn't seem like anyone mentioned the serial bus.  Would
> > > > there be any advantage in migrating to the serial bus?  
> > >
> > > Does serial bus work with hot plug devices like USB Serial
> > > Adapters and/or devices that are not described in the device
> > > tree?  
> 
> Probably it cannot work with hot-plug devices yet.
> And devices must be described in some way (DT, ACPI), it does not
> support auto-detect.

Correct!


> So far I've seen serial bus used with e.g. bluetooth and DT.
> I'm wondering if/how people use it with bluetooth connected to a
> hot-pluggable device like usb-serial.

They don't :)

serdev is (currently, still, AFAIK) only for devices permanently
attached to a platform - hence they can be reliably described as part
of the platform itself, be it via DT or ACPI or whatever. So the fact,
say, that the "Nokia N900" has a BT module permanently soldered to "UART
2", that's something you can encode in its DT, because it applies to
this device, and this device only.

The ELM327 and clones are merely naked USB/BT-UART bridges with default
VID/PID to the computer, and some variants are classic RS232 devices.
No way to identify them, as they can appear/disappear on any UART,
anywhere. So you need to attach them manually - and to my knowledge,
such a manual mechanism is still missing from serdev. So we have to use
a line discipline, as that has an API to attach from userspace.

This also explains how to use Bluetooth via USB: Either it's a VID/PID
known to some driver speaking native USB, or... well, for UARTs there's
btattach and hciattach (both part of BlueZ), and both use the N_HCI
line discipline. No serdev involved. I don't know if any USB-UART-BT
device with a unique VID/PID exists, and I don't know whether serdev
could be attached kernel-side in this case.


Max
