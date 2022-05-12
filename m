Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB135246B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350846AbiELHS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350841AbiELHSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:18:24 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC6BA9AB;
        Thu, 12 May 2022 00:18:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D0F4E200008;
        Thu, 12 May 2022 07:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652339900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wwbmBbhN0kgvtc8FIdoo3gXl6+om9eIUC04sDBGdORA=;
        b=XtJbZgSwaOraJPcYKFXcQISILKkMjY951nDLnOlk2JMK/vIyn3zaBGTDAJxQESL//ivPC6
        2WaeqUOh/4qWcGXip+vCGjVyUxnPTo3fW8HOnmcfan8O1KLxjtNLQuyANIwyp/MS9DaFtR
        tMyKXg+yGXeyT0bvczv/tNq+RALBoh9+eqWe94b6Cbi/6l2Mp2CTz9oqQfkpQiQWh7xtwX
        8K7/eDSn+IgoxD0QM5jsmyUH/pQRkhIGwhhmfqmgiYXV+kJlzXqu6/6oFO0duQBJdGakbw
        pBuEmYyQSksrWBv5skAyr+F824UsvtXjx5TpJYveTZkF2zbGodW5oTMXevUUbA==
Date:   Thu, 12 May 2022 09:18:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Zhilkin <csharper2005@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: add support for Sercomm partitions
Message-ID: <20220512091817.25c653e4@xps13>
In-Reply-To: <10ce5bf1-bf12-b028-49cb-a3f1999f9a07@gmail.com>
References: <20220329122016.4122899-1-csharper2005@gmail.com>
        <20220330100958.57dc4d61@xps13>
        <ede9e050-3b60-ba0e-c626-044f7825adb7@gmail.com>
        <20220511091643.064f9d13@xps13>
        <10ce5bf1-bf12-b028-49cb-a3f1999f9a07@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

csharper2005@gmail.com wrote on Wed, 11 May 2022 23:36:18 +0300:

> On 5/11/2022 10:16 AM, Miquel Raynal wrote:
>=20
> >>>> This is essentially the same code as proposed by NOGUCHI Hiroshi
> >>>> <drvlabo@gmail.com> here:   =20
> >>> I would credit Hiroshi with a Suggested-by at least   =20
> >> I read submitting patches rules again and thought that Signed-off-by is
> >> suitable for this case. Is this ok? =20
> > Either you take his work almost like it is and he must be the author
> > *and* the first signed-off-by line, or you take the authorship if you
> > think you did enough modifications to the code and in this case you can
> > either credit him with a suggested-by before your signed-off, or you
> > can credit him with a co-developed-by + his signed-off and then yours. =
=20
>=20
> Thank you for clarification! My modifications were quite small:
>  - Remove redundant braces and logical NOT operator
>  - Define pr_fmt
>  - Replace kcalloc by kzalloc
>  - Use of_get_child_count() and alloc big enough array before the
>    for_each_child_of_node()
>=20
> Therefore, I prefer to keep the authorship of the original author (NOGUCH=
I Hiroshi).=20
>=20
> Patch is really good and was successfully tested on the hundreds of Serco=
mm devices (5.4, 5.10, 5.15 Kernel). My motivation for upstreaming is work =
under official support for these devices in OpenWrt.
>=20
> What are the next steps from my side in this case? Should I wait for revi=
ew of this patch here (Link: https://lore.kernel.org/linux-mtd/202205101626=
55.21011-1-csharper2005@gmail.com/T/#u
> ) or do I need to do something additionally (for example, send updated se=
t v5 with Acked-by from Krzysztof in the first patch)?=20
>=20
> And sorry for the many questions... I haven't fully mastered the Linux ch=
ange management process and best practices yet.

We are used to incremental changes, so please send another version with
the tags collected, the changes that I requested regarding the
authorship and we'll see what happens to the next version.

Thanks,
Miqu=C3=A8l
