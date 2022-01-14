Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A6E48F285
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiANWlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiANWld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:41:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F045C061574;
        Fri, 14 Jan 2022 14:41:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BBC6202D;
        Fri, 14 Jan 2022 22:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9E5C36AE9;
        Fri, 14 Jan 2022 22:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642200092;
        bh=1yWWNTr99SbOPjD2CMX1nN1AHYuz4jAl1o3plfsU8Qw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DQ95m8RY/VQl+X8/9LMhRNDHTtvWR7AbG/jMSS8cCUOJiiQgVvg+xfPsZTw2wu1aJ
         MwNOtD9TU682Yq4W+wYEAgPNpE/YV2rTrSurI2K2envtiHM0ogm1gN9uMy63T1yLEd
         JpyvN8ZVScLt6ttXk2+RsI7azU48uThwyHweRcFvBHyU926X0majFC8X+Xj0km8Vl2
         jF/WFllLL1zW+Nm1+BGeQPnq3CzyG0+B6S0dziQgKGCE4nlJpepcywFUTeamZHybxS
         xttFnaHh2K5UJF+0D7gn2dMb5IvWOhITIl198j8udzrwDDTlkhfDdX6CQX4xQ15wiY
         tfzR6fbRYrdvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220114161556.vgxhetm4ccokik4b@houat>
References: <20210914093515.260031-1-maxime@cerno.tech> <20210914093515.260031-2-maxime@cerno.tech> <20220112033716.63631C36AEA@smtp.kernel.org> <20220112114652.hmfdcpqil5jg2vz6@houat> <20220113214426.95292C36AEA@smtp.kernel.org> <20220114161556.vgxhetm4ccokik4b@houat>
Subject: Re: [PATCH v2 1/3] clk: Introduce a clock request API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Emma Anholt <emma@anholt.net>, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
To:     Maxime Ripard <maxime@cerno.tech>
Date:   Fri, 14 Jan 2022 14:41:30 -0800
User-Agent: alot/0.10
Message-Id: <20220114224132.4F9E5C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-01-14 08:15:56)
> On Thu, Jan 13, 2022 at 01:44:25PM -0800, Stephen Boyd wrote:
> >
> > I don't see a problem with re-evaluating the rate every time we call
> > clk_set_rate_range(). That's probably the bug that I can't recall. Can
> > you fix the API so it works that way?
>=20
> Yep, I'll work on it next week.


BTW, this is an area that's easily tested with kunit. I'm going to
re-post kunit tests for clk-gate.c today. We should add unit tests for
this and other parts of clk.c so that future changes don't break this.
