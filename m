Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B748F2E3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiANXRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiANXQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:16:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FE7C061574;
        Fri, 14 Jan 2022 15:16:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DEE62069;
        Fri, 14 Jan 2022 23:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB353C36AE7;
        Fri, 14 Jan 2022 23:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642202217;
        bh=HsftLIf5iEt9qf6u589RLSowTzG+vqNn6xCHtEXuZsc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=b8iCq/Nhe0N9zsHG+BAL8qNvLgE+5anhTeyh8dE7FUJxvN95xb2HXP6p38hqAUAFg
         0wwZo3698lkcqVLqw0aoPTpN3mVj3eOJUjsXX514MDvm0uNJiAM5buafDZyWZ/Lu+/
         MfjLNhgNBsndYZZU+STY3OwEJpkxrHIK0D48RVGh2EMh/MgUsApJJOOWhsTfYujqWP
         +0gVWwCY7M9EKHM/YFaw9L93U52r9COfwxmKiZJoh0nnxswgA5VUc0wVo53DkD09U1
         ENXeYrjmuYUtEnJ+jtBPdJ7BVlGTksG+tA1BZ1vbpuQwVxZl7IUR0uKJaUVDfSNuoC
         NfZRSvidU0JRA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220114230549.56co4qcpnq32muwj@pali>
References: <20210930095838.28145-1-pali@kernel.org> <20211103214209.azo2z3z4gy7aj5hu@pali> <87ee6bm9hn.fsf@BL-laptop> <20220114105100.im6gmkt6fjl2aiwl@pali> <20220114225659.D5D79C36AE9@smtp.kernel.org> <20220114230549.56co4qcpnq32muwj@pali>
Subject: Re: [PATCH v7 0/6] serial: mvebu-uart: Support for higher baudrates
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Fri, 14 Jan 2022 15:16:55 -0800
User-Agent: alot/0.10
Message-Id: <20220114231657.AB353C36AE7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2022-01-14 15:05:49)
> On Friday 14 January 2022 14:56:58 Stephen Boyd wrote:
> >=20
> > If we're adding new support why can't we break with backwards
> > compatibility for the binding and do it a different way?
>=20
> Because DTS are backwards compatible. I was told more times that kernel
> drivers should work correctly with older DTS files. On some boards are
> DTB files provided by bootloader and they do not use in-kernel DTS
> files.

I'm not suggesting to break the kernel driver when used with older DTBs.
New features are fair game to change the compatible string and do
something different. If the user wants the new feature they update their
DTB. We shouldn't be constrained by backwards compatibility here.
