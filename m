Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626434F24B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiDEH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDEH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:28:04 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB0726AC0;
        Tue,  5 Apr 2022 00:26:04 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5D0781BF205;
        Tue,  5 Apr 2022 07:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649143563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3aYdJv1c3x76qPIILK7iOMtk/QOsfJfFzAQtz6UrxU0=;
        b=o5zJTgpxUzuajIIHNLVIqd6D7PNI0cy1ZbmZHCpqUbDDUd/4HAaRA+CL7ocwWZnYTCY3mk
        b+u90n1nEzLFtu0XgK6KGlU6Sw0X53CVSIJalp9wXnql73H8GvSiBUdiKd//qydDndQmzV
        UeZ/36HfWY7ezAqGsKNaMJTU3SHdmP7ta4BkhrSQ9oHjjfNIKbd6VJgr95khwIC/QlCBbm
        gP/Ab8rTn0nnL2JgIc0BFJxB6o52G3+f7Ueq/LtUawEQtbUUuY8wQVEs/4/lFIBZACmIWF
        oJNNhlQTjgS9peeGM+0RexBOUrbiKxKYHwr8zeg0hQ3RIQEgsZwYgPj5aMbVDw==
Date:   Tue, 5 Apr 2022 09:24:34 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <20220405092434.6e424ed4@fixe.home>
In-Reply-To: <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
        <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, 4 Apr 2022 12:41:37 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> On Thu, Mar 24, 2022 at 03:12:34PM +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> > This series is part of a larger series which aims at adding fwnode
> > support in multiple subsystems [1]. The goal of this series was to
> > add support for software node in various subsystem but in a first
> > time only the fwnode support had gained consensus and will be added
> > to multiple subsystems. =20
>=20
> The goal is describing a solution. What is the problem?
>=20
> What's the scenario where you have a reset provider not described by=20
> firmware providing resets to devices (consumers) also not described by=20
> firmware.

Hi Rob, there was a link attached to this series since there was a
previous one that was sent which described the problem. Here is a link
to the same thread but to a specific message which clarifies the
problem and the solutions that were mentionned by other maintainers
(ACPI overlays, DT overlays, software nodes and so on):

https://lore.kernel.org/netdev/20220224154040.2633a4e4@fixe.home/

>=20
> > For the moment ACPI node support is excluded from the fwnode support
> > to avoid creating an unspecified ACPI reset device description. With
> > these modifications, both driver that uses the fwnode_ API or the of_
> > API to register the reset controller will be usable by consumer
> > whatever the type of node that is used. =20
>=20
> Good, because controlling reset lines directly isn't how the ACPI device=
=20
> model works AFAIK.

This was based on Mark Brown feedback.

>=20
> > One question raised by this series is that I'm not sure if all reset
> > drivers should be modified to use the new fwnode support or keep the
> > existing device-tree support. Maintainer advice on that particular
> > question will be welcome. =20
>=20
> That would be pointless churn IMO. Why do we need to convert drivers=20
> which the vast majority will never use anything but DT?

To have a single interface to maintain and to remove duplicated fields
(of_node, fwnode, fwnode_xlate, of_xlate) from reset controller struct.


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
