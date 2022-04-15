Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A555025F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350862AbiDOHDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245147AbiDOHDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:03:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700038BE8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:01:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3B8C81F47DA4;
        Fri, 15 Apr 2022 08:01:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650006061;
        bh=oDcnz0m1mddcgO5NTlXqk8XUEUGT5espCP0WO07gMYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BqoNpi73XsRvh2WdiBmbhYZ5vFnRU5vebFpBxD/SKyw977vSyO9VpL23vPM4gmFvt
         zBA8w74ae/N+oLLB2g6MtNK5UxWSgsvGC4qVrHDtoaJEfIy8otJdhn8t0L1tItMaAT
         vWHFPwRPA7vkZnA/KaFCLY9eKqNwSxEHLtHwamW6k7r8OWOujpJaUp5Luv2jPd466C
         VB/0KSlvHxcwhHsdanmzpHZhUyIPu4x+iXWhDQChp1ai6qzfGyMf5FAS7VjjvggIK3
         yY/T88bYcKPSIix8MacYKu9C3eVni8nI0CsFF7ulNyOH1qM7c1h+MbUuxEov6zzzoD
         2VMyiKsmCtvZA==
Date:   Fri, 15 Apr 2022 09:00:58 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 2/3] mtd: spinand: add support for detection with
 param page
Message-ID: <20220415090058.5044ae17@collabora.com>
In-Reply-To: <20220415034844.1024538-3-gch981213@gmail.com>
References: <20220415034844.1024538-1-gch981213@gmail.com>
        <20220415034844.1024538-3-gch981213@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 11:48:43 +0800
Chuanhong Guo <gch981213@gmail.com> wrote:

> +
> +static const struct spinand_manufacturer *spinand_onfi_manufacturers[] = {};

Do we really need a separate manufacturer array? Looks like we could
re-use the one we have in core.c and do the matching against it (we
just need an extra NULL sentinel to detect the end of this array).

> +
> +static const struct spinand_onfi_info *
> +spinand_onfi_chip_match(struct nand_onfi_params *p,
> +			const struct spinand_manufacturer *m)
> +{
> +	size_t i, j;
> +
> +	for (i = 0; i < m->nchips; i++)
> +		for (j = 0; m->onfi_chips[i].models[j]; j++)
> +			if (!strcasecmp(m->onfi_chips[i].models[j], p->model))
> +				return &m->onfi_chips[i];
> +	return NULL;
> +}

> +/**
> + * struct spinand_onfi_info - Structure used to describe SPI NAND with ONFI
> + *			      parameter page
> + * @models: Model name array. Null terminated.
> + * @flags: OR-ing of the SPINAND_XXX flags
> + * @eccinfo: on-die ECC info
> + * @op_variants: operations variants
> + * @op_variants.read_cache: variants of the read-cache operation
> + * @op_variants.write_cache: variants of the write-cache operation
> + * @op_variants.update_cache: variants of the update-cache operation
> + * @select_target: function used to select a target/die. Required only for
> + *		   multi-die chips
> + *
> + * Each SPI NAND manufacturer driver should have a spinand_onfi_info table
> + * describing all the chips supported by the driver.
> + */
> +struct spinand_onfi_info {
> +	const char **const models;
> +	u32 flags;
> +	struct spinand_ecc_info eccinfo;
> +	struct {
> +		const struct spinand_op_variants *read_cache;
> +		const struct spinand_op_variants *write_cache;
> +		const struct spinand_op_variants *update_cache;
> +	} op_variants;
> +	int (*select_target)(struct spinand_device *spinand,
> +			     unsigned int target);
> +};

Can't we just extend spinand_info instead of defining a new struct.
AFAICT, the only difference is that model is replaced by a model array,
and devid is dropped, and I think we can rework the existing ID-based
matching logic to return ->models[0] instead of ->model.

