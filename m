Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4617946F84D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhLJBTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhLJBTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:19:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D5C061746;
        Thu,  9 Dec 2021 17:16:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31E14B8270A;
        Fri, 10 Dec 2021 01:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13FDC341C6;
        Fri, 10 Dec 2021 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639098958;
        bh=dbI5sTHyFXJhJ2LZ+wZe4mrteYlH76MwHZtF+BbA7Yw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jr8WNJnVYSsOTxi0Fm6sA7qnMGB21CwN/kYkwiLwu+x3QCmzWeCVWjXKNHVQq0CLt
         LOScOja7eLi/dRJqaS14ErFS+5F4toi21w1a/PqcBPNGXI6XD7fV4ngqFob+V/Oo+/
         kFnIvaYv+y7drtUScPZ015PXHK6dm/ZYqgNpnKhyZ+LevjkaeyrihnirzhPh3ENCh7
         XNQ69QEOcE6J/7oKQctDJsaFPztmvUxzf6hofzjRaEwEhyKwq70MWU24VKNKI8o/L3
         rE1jXvX1bEtU65aDsbqWUIjBI22azWp6JiVYf8vGLooZHxnwZruBtEbRZzIl4IGD2L
         7b17jpZu5uoGw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211208041534.3928718-1-sboyd@kernel.org>
References: <20211208041534.3928718-1-sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: clk_core_get() can also return NULL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 09 Dec 2021 17:15:56 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210011557.E13FDC341C6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-12-07 20:15:33)
> Nothing stops a clk controller from registering an OF clk provider
> before registering those clks with the clk framework. This is not great
> but we deal with it in the clk framework by refusing to hand out struct
> clk pointers when 'hw->core' is NULL, the indication that clk_register()
> has been called.
>=20
> Within clk_core_fill_parent_index() we considered this case when a
> clk_hw pointer is referenced directly by filling in the parent cache
> with an -EPROBE_DEFER pointer when the core pointer is NULL. When we
> lookup a parent with clk_core_get() we don't care about the return value
> being NULL though, because that was considered largely impossible, but
> it's been proven now that it can be NULL if two clk providers are
> probing in parallel and the parent provider has been registered before
> the clk has. Let's check for NULL here as well and treat it the same as
> direct clk_hw references.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
