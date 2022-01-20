Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B1B49538F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiATRvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiATRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:51:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5649C061574;
        Thu, 20 Jan 2022 09:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 825616170C;
        Thu, 20 Jan 2022 17:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8989C340E3;
        Thu, 20 Jan 2022 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642701101;
        bh=bm38eXYxmLEzcgTe+zpSIq3GwobhEX1p5CEOe0aqQP8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Qu9nhmnB0R+jfggGDA2GbYU0O6LZgQHhpTBLoesO90woOn/ouEJELZvNWD1HCkZUV
         1kpHfGbp8CdCejEuB5tEmyYkF0/WsFiJCT+FmpvV3CECVmpmYyoYjJGmETqSKOoiu4
         ysu9RaqWm5ABSdRQhbgF9PaprJE0tMvHNjCoLfIhbZ3Df+QX2db/j5E/rhZk/rD6Nb
         0sPtiHB9bt3tP3WaYInQ7S1KT5VKfg9G41MRIvESY9T1UqQtsx0WcUfCwMoRn8vp1I
         ZMG2TseWL12lV1MgCj19AFrvZrOT2V58MH6M2g0qL0mkb26qe/zkCfOAzBEaYoip9t
         uVEIdACnRCEMQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGS_qxoMRsvx8HDex9Aq9KUALAQrdNe3VVYikyzT59TEYfbLdg@mail.gmail.com>
References: <20220120052303.2098394-1-sboyd@kernel.org> <CAGS_qxoMRsvx8HDex9Aq9KUALAQrdNe3VVYikyzT59TEYfbLdg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: gate: Add some kunit test suites
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com
To:     Daniel Latypov <dlatypov@google.com>
Date:   Thu, 20 Jan 2022 09:51:39 -0800
User-Agent: alot/0.10
Message-Id: <20220120175140.D8989C340E3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Latypov (2022-01-19 22:26:50)
>  On Wed, Jan 19, 2022 at 9:23 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > +
> > +static void clk_gate_test_exit(struct kunit *test)
> > +{
> > +       struct clk_gate_test_context *ctx =3D test->priv;
> > +
> > +       clk_hw_unregister_gate(ctx->hw);
> > +       clk_hw_unregister_fixed_rate(ctx->parent);
> > +       kfree(ctx);
>=20
> I think we forgot to drop some kfree's now that we're using
> test->priv =3D ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>=20
> This will result in duplicate kfree's.

Good catch! I forgot that it was a managed allocation like that. Doesn't
help that I had to go all the way to the kunit_kmalloc_array()
kernel-doc to read that test managed means it is freed when the test is
done.

> > +
> > +static void clk_gate_test_is_enabled(struct kunit *test)
> > +{
> > +       struct clk_hw *hw;
> > +       struct clk_gate_test_context *ctx;
> > +
> > +       ctx =3D clk_gate_test_alloc_ctx(test);
> > +       ctx->fake_reg =3D BIT(7);
> > +       hw =3D clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fa=
ke_mem, 7,
> > +                                 0, NULL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> > +       KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
> > +
> > +       clk_hw_unregister_gate(hw);
> > +       kfree(ctx);
>=20
> ditto
>=20
>=20

Thanks! Next time can you trim your mails? It's quite long and I have to
scroll down to find everything.
