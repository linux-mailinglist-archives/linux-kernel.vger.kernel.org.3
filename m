Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349C252F81D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354470AbiEUDkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiEUDk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:40:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1802E719C3;
        Fri, 20 May 2022 20:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA1BCB82F29;
        Sat, 21 May 2022 03:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5909FC385A9;
        Sat, 21 May 2022 03:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653104425;
        bh=ISVhewo33uJMRv2Ky/67ulMoXXlMw7gDmiWI46L9w/0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eYd1fyDxv+zyZg4eUMEEdXBJQxbxiRJdZZ44FBpu2E1xD5TRheZu9ayuX6hayGdSh
         u8yMUiXSmPAQA9RNfjsYq7NFbWwCDG7AVU4dQzl3goJIXqt4ozetbbzMhmfe5ehj6J
         446vDEYIJRW36ZN/oOZUzEI6mCKTcSF4nub4EYuXvi71KglTufVnTyTbjq7gd5wVmK
         SGA7VXgy0Ety3W2Mbfpk2hgU2g/hwmAkshVgL3M0UTFKu5Y/TZ0aYEN5wPkvOPTmNJ
         3m1QE+aFVLkNY0L7YgNteZkN9roICK2LWr2M1NfG3BEXCatnFl0EM6T22qXugGIxHZ
         Sn/jDZ4kCrM0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210904131714.2312-1-len.baker@gmx.com>
References: <20210904131714.2312-1-len.baker@gmx.com>
Subject: Re: [PATCH] clk: ti: composite: Prefer kcalloc over open coded arithmetic
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Len Baker <len.baker@gmx.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>
Date:   Fri, 20 May 2022 20:40:23 -0700
User-Agent: alot/0.10
Message-Id: <20220521034025.5909FC385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Len Baker (2021-09-04 06:17:14)
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>=20
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
>=20
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments
>=20
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---

Applied to clk-next
