Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117554755F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbhLOKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:13:53 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:36497 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhLOKNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:13:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDWL53dllz4xhp;
        Wed, 15 Dec 2021 21:13:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639563231;
        bh=3WntohgGBSsd5zLTEq/JbPVU3YTQL8XrTLe5DXnpfYU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a8eNNWo605MEiL8ylUOt7YdhmBZnPIijg5uWdKFJI3EqXiu+9jJpFpl0qRgxjzNJr
         55GgeghdhXOIhoWSsLRVt5H5NVVbMTJzW2/EjE5nILpENBmH45hJ0/QPUHs7Pj2XRc
         /o9AAUkwztZJ310T95OfI0JVUjoY7WFCJ+z7ykWMAka6NRYrnV1Q9t1M2A3byErDiI
         cjyrvJtn5OSAe6ONWSFVW8pDPsEZs9qTceN3/135nZOJfw1fK94BI4LRatIT6WHA08
         KkCkMzLAlITDIIbrhWV0KkJLHITxpaRN4bnqsKy8EHEWN95bNBXOqGub2C2EtCC5Xs
         lnLM4fX6QarMA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>, John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frank.rowand@sony.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] of/fdt: Rework early_init_dt_scan_memory() to call
 directly
In-Reply-To: <20211214202652.3894707-1-robh@kernel.org>
References: <20211214202652.3894707-1-robh@kernel.org>
Date:   Wed, 15 Dec 2021 21:13:46 +1100
Message-ID: <871r2emazp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 5e216555fe4f..97d7607625ec 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1078,49 +1078,50 @@ u64 __init dt_mem_next_cell(int s, const __be32 **cellp)
>  /*
>   * early_init_dt_scan_memory - Look for and parse memory nodes
>   */
> -int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
> -				     int depth, void *data)
> +int __init early_init_dt_scan_memory(void)
>  {
> -	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> -	const __be32 *reg, *endp;
> -	int l;
> -	bool hotpluggable;
> -
> -	/* We are scanning "memory" nodes only */
> -	if (type == NULL || strcmp(type, "memory") != 0)
> -		return 0;
> +	int node;
> +	const void *fdt = initial_boot_params;
>  
> -	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
> -	if (reg == NULL)
> -		reg = of_get_flat_dt_prop(node, "reg", &l);
> -	if (reg == NULL)
> -		return 0;
> +	for (node = fdt_node_offset_by_prop_value(fdt, -1, "device_type", "memory", 6);
> +	     node != -FDT_ERR_NOTFOUND;
> +	     node = fdt_node_offset_by_prop_value(fdt, node, "device_type", "memory", 6)) {

The 6 there doesn't work on my machines.

It needs to match the trailing NULL, so 7 or sizeof("memory") works.

cheers
