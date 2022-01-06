Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29701485D36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbiAFAdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343830AbiAFAdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:33:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00864C0611FF;
        Wed,  5 Jan 2022 16:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93105619D6;
        Thu,  6 Jan 2022 00:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28E7C36AE9;
        Thu,  6 Jan 2022 00:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429199;
        bh=zi773/Lk0MrksSQWQX9rCDCJ+LO012+V0hNqkC5OMzE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gH+L+xCGYyg2fCcebgWVOryDZIfLI3h7VH8xMUcewIq+szAv5ghX/VFCAUWqHGNhd
         JDdSKLorpZKB0qHdOcGQ7MyxvQPPYRYVOun3rk1oTv4D/Nd+nJ7QXKIy9bb0b5h3Hn
         YvfubrAyfhinaM/qP1iYo4VgVQYV4pQXKZFqx80zu8T/fqTZFH3rvaqCibtK7RcRYv
         X/7uVX8HnH9EAGJiTpGSKXddoMS2o3IaWobcCk6xmjbxxFbxnVRMDqwkbMfDzrk8KV
         NLyp7nUwIlLKHudyadX038cYbo4huzvid0sQ9n2WPn0p/+D4vrQBNFzCSt9CPF0EA4
         B06fStln48MAg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211230150321.167576-1-colin.i.king@gmail.com>
References: <20211230150321.167576-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] clk: socfpga: remove redundant assignment after a mask operation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
To:     Colin Ian King <colin.i.king@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-clk@vger.kernel.org
Date:   Wed, 05 Jan 2022 16:33:17 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106003318.E28E7C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin Ian King (2021-12-30 07:03:21)
> The assignment operation after a & mask operation is redundant, the
> variables being assigned are not used afterwards. Replace the &=3D
> operator with just & operator.
>=20
> Cleans up two clang-scan warnings:
> drivers/clk/socfpga/clk-gate.c:37:10: warning: Although the value stored
> to 'l4_src' is used in the enclosing expression, the value is never
> actually read from 'l4_src' [deadcode.DeadStores]
>                 return l4_src &=3D 0x1;
>                        ^         ~~~
> drivers/clk/socfpga/clk-gate.c:46:10: warning: Although the value stored
> to 'perpll_src' is used in the enclosing expression, the value is never
> actually read from 'perpll_src' [deadcode.DeadStores]
>                 return perpll_src &=3D 0x3;
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied to clk-next
