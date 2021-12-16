Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F40476A63
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhLPGct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhLPGcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:32:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A813C061574;
        Wed, 15 Dec 2021 22:32:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1617B81E01;
        Thu, 16 Dec 2021 06:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603F1C36AE4;
        Thu, 16 Dec 2021 06:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639636365;
        bh=6XOCiDrxaA6TA1b5jACdNt8JfeRkOYMHwm8TD7N8ocw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Qh+pqiqPf2Nij1IuzOHnVux0LXehqEUTBI0VVUYbVMxQzFKYf7OEDZg0kZxcV3/4d
         QrpJ/ms2fppwIluHdcPjg0ic4l5E/zJvl67uhvrdh+2Q0D69M5jxstpIBu3RanWHZ4
         vAuaex7fcgfqZcBxBX2kCE5TjWI4bsxqgjKR2/uVQxJI/V3WDAiQmA4NOFG5SLwRc3
         GHE9O82kuF28OwWI7u34uETLTtvwKCGcNvH2yjwmiR3kv3wRGHxyHaKBGIsYFfwkkn
         P3+1HNbU8aJ7EOy7oF6xI/XMRKBomZ4/nCJ3TNsw282r7dO5YvXKGoKD2z4iKpwZO6
         B6l13FWlHAfHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <XedF_WXH1abo9n2bzY4gaRIjq-R1O6ha5QedK8e1W9-R_1p_zo90aAgaKSSfDYMW3WUaMdY0pjONnKWj4zNMh5TbHlbZbAVAe4KG_Zq8Vvk=@wujek.eu>
References: <20211203141515.2448129-1-dev_public@wujek.eu> <20211206225354.BF0AFC341C6@smtp.kernel.org> <jgJW1u3RfTQcv5ZBcVQt4fz8_sA4gvyXsN5x18zzLo_nTR5nfLpZtdAjy-WlEaCMnmnPGZjeFGV5OoiWNtA4Tn5wLhqNJdQEvPw5Cqs1z3I=@wujek.eu> <20211208043054.CEFD6C00446@smtp.kernel.org> <XedF_WXH1abo9n2bzY4gaRIjq-R1O6ha5QedK8e1W9-R_1p_zo90aAgaKSSfDYMW3WUaMdY0pjONnKWj4zNMh5TbHlbZbAVAe4KG_Zq8Vvk=@wujek.eu>
Subject: Re: [PATCH] clk: si5341: Add sysfs property to check selected input
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     wujek dev <dev_public@wujek.eu>
Date:   Wed, 15 Dec 2021 22:32:44 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216063245.603F1C36AE4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting wujek dev (2021-12-09 04:04:48)
>=20
>=20
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>=20
> On Wednesday, December 8th, 2021 at 05:30, Stephen Boyd <sboyd@kernel.org=
> wrote:
>=20
> > Quoting wujek dev (2021-12-06 15:08:03)
> >
> > > Other sysfs properties used by this driver are not documented so I di=
dn't add for this one. Even more not a single property from clk subsystem i=
s described. Shall I the add description of this single property?
> >
> > Please don't top post. sysfs properties are supposed to be single value
> >
> > and for machine consumption. Is this a debugfs property?
> No, I think this is rather sysfs than debugfs. The type of information is=
 similar to other reported by this driver. The values in the added property=
 are the same, this is just a different representation (input selected as a=
n int, as string based on manual and as string as described in the DTB).

Ok what program is going to check the selected input?
