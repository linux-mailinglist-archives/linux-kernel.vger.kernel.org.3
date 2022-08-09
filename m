Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791B858DEC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbiHISXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346307AbiHISVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:21:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D030F42;
        Tue,  9 Aug 2022 11:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AE8EB818D8;
        Tue,  9 Aug 2022 18:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE785C43470;
        Tue,  9 Aug 2022 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660068420;
        bh=2EdjzasIB09m+gY3gToosq99knMnczwU9bRriEj/PHU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=c1B7ErLrUkL2D0AfWZ630nEllP0wRB5x2SrJ/43UfDEoqJ8KUfFWubojQSoA05sLB
         q/P7JrySK0pw+C1zV4u3bdXr/WicT0eT8eZFe25OvEbRZwXLTDh6GpBzU47NZ4X+VX
         0vb40g8RtiQV+V2Ubbfe8G4D7Vmr5NZiutl3u2Q5xbl7ObyEvNZviib8IWWIaAQkeu
         6dEetgrnGfD8PKc5U9WDQoqktd0mkCaAJosBrdhiORlBsEfYc8cDkU9+gcCj2tW6Zd
         6JwH8yOyhnZEjsA4A/wcrJeDWtb9EYvvYEMKeYI/wBoG5Q3nFesHO78ufd6kfE5VGM
         EKNIpDMOp21vg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d92dd996-6961-5291-9504-1fe284b40dd6@gmail.com>
References: <20220419051114.1569291-1-seanga2@gmail.com> <d92dd996-6961-5291-9504-1fe284b40dd6@gmail.com>
Subject: Re: [RFT PATCH] clk: ls1c: Fix PLL rate calculation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Du Huanpeng <dhu@hodcarrier.org>,
        Yang Ling <gnaygnil@gmail.com>
To:     Sean Anderson <seanga2@gmail.com>, linux-clk@vger.kernel.org,
        linux-mips@vger.kernel.org
Date:   Tue, 09 Aug 2022 11:06:58 -0700
User-Agent: alot/0.10
Message-Id: <20220809180700.BE785C43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean Anderson (2022-08-03 16:28:41)
> On 4/19/22 1:11 AM, Sean Anderson wrote:
> >  =20
> >       pll =3D __raw_readl(LS1X_CLK_PLL_FREQ);
> > -     rate =3D ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
> > +     rate =3D (pll & 0xff00) + ((pll >> 16) & 0xff);
> >       rate *=3D OSC;
> > -     rate >>=3D 2;
> > +     rate >>=3D 10;
> >  =20
> >       return rate;
> >   }
> >=20
>=20
> Since there have been no objections, can we apply this?
>=20

Can you resend it? I can apply it after the merge window closes next
week.
