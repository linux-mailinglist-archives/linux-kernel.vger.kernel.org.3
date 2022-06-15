Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A5454D1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350105AbiFOTlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiFOTlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:41:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ECE546B6;
        Wed, 15 Jun 2022 12:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D779FB82145;
        Wed, 15 Jun 2022 19:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6423AC3411E;
        Wed, 15 Jun 2022 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322091;
        bh=UdusMzWPXrDP8gnWzMVcl30Dbm52/NoNK48rJ/3Zb6I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Tk77MQeNCxft+AMnrEQk3UadjI+HUjjKQfzeQnba/G+6wIbKFBmA6pqCgfw76oM06
         jNT+JfAENHA+Z48QcAX4aIYZfx8xjwHi8TG9qq7gl848zcyiacs3KmrLv3csnnBIN0
         HvrA8yiEIW1zS30b+yPNyqv8JVeJe0kRXa5oIcJlLSaPWlcZ2qzkq5+gskbWORniGV
         G9fiqtywZANe6s9G732QnQxDU8Hiowhabbzw8CTdq5sSirhMjTZQbFlF0kZovMTXXM
         LcnYUaIdjn6Dz4LPwcvmPFsCjD2UTZ4R63N+vBQnxmodmXc9ny1rR1TUvUzKJgA3F2
         4FET9uKdnGrgA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220612145955.385787-3-nikita@trvn.ru>
References: <20220612145955.385787-1-nikita@trvn.ru> <20220612145955.385787-3-nikita@trvn.ru>
Subject: Re: [PATCH v2 2/4] clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
To:     Nikita Travkin <nikita@trvn.ru>, linus.walleij@linaro.org,
        mturquette@baylibre.com
Date:   Wed, 15 Jun 2022 12:41:29 -0700
User-Agent: alot/0.10
Message-Id: <20220615194131.6423AC3411E@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Travkin (2022-06-12 07:59:53)
> Sometimes calculation of d value may result in 0 because of the
> rounding after integer division. This causes the following error:
>=20
> [  113.969689] camss_gp1_clk_src: rcg didn't update its configuration.
> [  113.969754] WARNING: CPU: 3 PID: 35 at drivers/clk/qcom/clk-rcg2.c:122=
 update_config+0xc8/0xdc
>=20
> Make sure that D value is never zero.
>=20
> Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for=
 RCG")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>=20
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
