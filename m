Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E19B4E6BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357251AbiCYBXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiCYBXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:23:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B0BD8A5;
        Thu, 24 Mar 2022 18:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEF9DB81DEA;
        Fri, 25 Mar 2022 01:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1DEC340EC;
        Fri, 25 Mar 2022 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648171320;
        bh=uXVMqaZn8hStgjCN0pNM4hKld0mfIcbqMA3pJnIYPY4=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=QonB3hmYM9igmCj52LQMbcAefPCtAeeP62CioWJtLf2WCSIP7BFgpfglLUXgnvy0u
         mTDqb6Hk5pJakb9c6Vy2GiHm0RXtrNdhsBRnI2wvrrxkkAdg4RsRbNJXhLuce0z/SR
         fkr1qO4ORBMri6/liwSEVHHwZ4JaDnFI2y121eLAxhxUGmKIBYdhhCYlUMOmi/x7Ln
         6i1f/NcmkZK6wJHijw/3y5HAXPbcxn19/vFOPNbvTSMhMjI+a7wd4+EzrtCu2c3MJc
         +7PafgAxGjkdpe/+jUG6Nwx90mj/VagvnHNxvRnJQd2OYK/CN4GRiuWPo+Y+f8Vm9X
         B+YaqFWHmyqGA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321231548.14276-2-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <20220321231548.14276-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 01/18] clk: introduce clk_hw_get_index_of_parent new API
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 18:21:58 -0700
User-Agent: alot/0.10
Message-Id: <20220325012200.9D1DEC340EC@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-21 16:15:31)
> Clk can have multiple parents. Some clk may require to get the cached
> index of other parent that are not current associated with the clk.
> We have clk_hw_get_parent_index() that returns the index of the current
> parent but we can't get the index of other parents of the provided clk.
> Introduce clk_hw_get_index_of_parent() to get the cached index of the
> parent of the provided clk. This permits a direct access of the internal
> clk_fetch_parent_index().
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/clk.c            | 14 ++++++++++++++
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8de6a22498e7..bdd70a88394c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1726,6 +1726,20 @@ int clk_hw_get_parent_index(struct clk_hw *hw)
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
> =20
> +/**
> + * clk_hw_get_index_of_parent - return the index of the parent clock

s/return/get/

> + * @hw: clk_hw associated with the clk being consumed
> + * @parent: clk_hw of the parent to be fetched the index of

s/to be fetched/to fetch/

> + *
> + * Fetches and returns the index of parent clock provided.
> + * Returns -EINVAL if the given parent index can't be provided.

I know this is copied from clk_hw_get_parent_index, but it can be
improved.

Return: The index corresponding to @parent for @hw or -EINVAL if
@parent isn't a possible parent of @hw.

> + */
> +int clk_hw_get_index_of_parent(struct clk_hw *hw, const struct clk_hw *p=
arent)
> +{
> +       return clk_fetch_parent_index(hw->core, parent->core);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_get_index_of_parent);
> +
>  /*
>   * Update the orphan status of @core and all its children.
>   */
