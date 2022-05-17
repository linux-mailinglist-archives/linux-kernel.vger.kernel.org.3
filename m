Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6826C529A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiEQHOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiEQHOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:14:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6560647AE3;
        Tue, 17 May 2022 00:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28387B816BB;
        Tue, 17 May 2022 07:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC76C385B8;
        Tue, 17 May 2022 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652771680;
        bh=KHDlTZzn0+DsUMIZOmXkXySbntEfsxVaMQGokybuLVA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jsl0zGaqmFmNIruk70W1rsKoK+cK4R+HKlwCdhj9lyx3TBLSjIjgTcK/XA1mj2fWg
         XrVbPhm8jVdoPgb9nHE/2Faz/zScwZc9AECuJkiA+NKyL2XGKxw+QkrYd2Uxmj/Twg
         le36wfpRTVX7QJkBfItoGb8nOU4uVfDVY1YoPvXwkbG7IDDOSHlL/4MKe+i7/jrGRW
         9O/FyInAO5LC8ddeOVRTWMTGRSXwQyHKT6vGbLzcUtCB3hW8rxAZjYih7talVfxBBG
         XWJvIbATtwxHeIyLoWp6Ivi46svALr4FnWkfnIrrt3gfqozCRWDMn8MkRERHqmCurZ
         0y199aqM3QSSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e18eb810-e437-6a19-26ec-1f0daedaaf5f@microchip.com>
References: <20220413071318.244912-1-codrin.ciubotariu@microchip.com> <20220422011216.A4A23C385A5@smtp.kernel.org> <e18eb810-e437-6a19-26ec-1f0daedaaf5f@microchip.com>
Subject: Re: [PATCH] clk: at91: generated: consider range when calculating best rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com
To:     Codrin.Ciubotariu@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 May 2022 00:14:38 -0700
User-Agent: alot/0.10
Message-Id: <20220517071440.DAC76C385B8@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin.Ciubotariu@microchip.com (2022-04-26 00:24:15)
> On 22.04.2022 04:12, Stephen Boyd wrote:
> > Quoting Codrin Ciubotariu (2022-04-13 00:13:18)
> >> clk_generated_best_diff() helps in finding the parent and the divisor =
to
> >> compute a rate closest to the required one. However, it doesn't take i=
nto
> >> account the request's range for the new rate. Make sure the new rate
> >> is within the required range.
> >>
> >> Fixes: 8a8f4bf0c480 ("clk: at91: clk-generated: create function to fin=
d best_diff")
> >> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >> ---
> >=20
> > Is this fixing anything real or it's just a thing that you noticed and
> > sent a patch to fix?
>=20
> It fixes the clk_set_min/max_rate() calls to a generated clock. Do you=20
> want me to add this fact in the commit description?
>=20

I wanted to know if there are clk_set_min/max_rate() calls on this clk.
Are there?
