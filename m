Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36F94BAD38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiBQXZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:25:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBQXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:25:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430315577F;
        Thu, 17 Feb 2022 15:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDEC617A9;
        Thu, 17 Feb 2022 23:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E944BC340E8;
        Thu, 17 Feb 2022 23:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645139957;
        bh=qqLBlmQvhTEWaDAiGN/X+JRlQrUcjRSE7i7NNj0rTIs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pqTSSePX1hiSmLrSe+M4/EeD+VE6nKICsiAdWQ2G9/VxvhNk305AXT/siVvwi2VJh
         Mt7HSmmtz9Sz/0P15HKKWfzeU+OcEcnFh5/SNTWcwrmlmRSGmOusXJEWdE7d2naTar
         7zE700yGewFCn9LfL9VbueSGP+6lytc1Mqs0QOmVM0gS6G1tUfEHZZE9SqB5j6tiR6
         Ltyjd1eTHR36M7J5EyccsR+4V3sUx2HYOKHhx2Y8EF730lXY7meEDbPJUTO4fP3kRh
         tAEQrYip3RY8YoGlprD3TyED3OFLs+G3hgySmv7O8PT070QJzdbyRj90nMWUbWj7VM
         hDmjOI3msOGGQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YgVoM2QZTJAbu6WR@builder.lan>
References: <20220209172513.17873-1-tdas@codeaurora.org> <YgRBnExwlzI+lPlR@builder.lan> <20220210072842.3E796C004E1@smtp.kernel.org> <YgVoM2QZTJAbu6WR@builder.lan>
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for GDSCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Thu, 17 Feb 2022 15:19:15 -0800
User-Agent: alot/0.10
Message-Id: <20220217231916.E944BC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-02-10 11:32:03)
> On Thu 10 Feb 01:28 CST 2022, Stephen Boyd wrote:
>=20
> > I'd prefer we invert the logic so that we don't need to litter this flag
> > all over the place. I recall that the wait values were incorrect a long
> > time ago on early gdsc using designs but hopefully they've been fixed
> > now and we can simply use the default power on reset (POR) values.
>=20
> Are you suggesting that we make it the default to not update the values
> and then provide means to specify it where needed?

Sure!

>=20
> I like that suggestion.
>=20
> But as mentioned in my reply yesterday, GPU_CX on several platforms
> needs a different CLK_DIS_WAIT_VAL - and not the same value.
>=20
> Are these values ever 0? Or could we simply add the three numbers to
> struct gdsc and have 0 denote "use hw default"?

I don't think they're ever set to zero. That would most likely just
break things because they need a few clk cycles to wait between
transitioning states. Otherwise the GDSC gets stuck and the clks don't
work.
