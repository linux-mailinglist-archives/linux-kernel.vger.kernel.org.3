Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E01470CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbhLJWIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344573AbhLJWIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:08:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CCC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hy+SQdosn84mdM2jPMgG1/WVzgxfL3QTjKyO5cTZVWA=; b=pJtMmYbRn/x90/bqZIlJyzaYJ7
        oDWT+hoGrQ0zPGEPDXY0wwejani1+ytlJrUR0kCV8K8lWHGVLrEq+QBi3jiZwrKfWPncvg9Bjy2jQ
        2F2dOx3hP2eHqjVMoJ+d9HyEOigBUjVnZREpk8RIC0fA6ln6IHMZsIkbWxSzXCmByZhW7EdTnXbPE
        BVnTOWlYoI1cC9FeIxtboFOHAaWECAFDgH6JbPklguTIjbH8xQECglmM1gYTx/z2ISFRZA+PLZXEq
        YDJk1QRFxG5SD9CXZUufXZfIfbh84IFLhYWbi5+9XImxS+pohBEdJhBIaTO6B8lQPaqSW/sYdiPvR
        wbMXVS0g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvo0z-003vF0-6g; Fri, 10 Dec 2021 22:05:17 +0000
Date:   Fri, 10 Dec 2021 14:05:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YbPPHTO3URnz+tFy@bombadil.infradead.org>
References: <YbLvDWdyFivlj7pP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbLvDWdyFivlj7pP@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> +static ssize_t module_xz_decompress(struct load_info *info,
> +				    const void *buf, size_t size)
> +{
> +	static const u8 signature[] = { 0xfd, '7', 'z', 'X', 'Z', 0 };
> +	struct xz_dec *xz_dec;
> +	struct xz_buf xz_buf;
> +	enum xz_ret xz_ret;
> +	size_t new_size = 0;
> +	ssize_t retval;
> +
> +	if (size < sizeof(signature) ||
> +	    memcmp(buf, signature, sizeof(signature))) {
> +		pr_err("not an xz compressed module\n");
> +		return -EINVAL;
> +	}
> +
> +	xz_dec = xz_dec_init(XZ_DYNALLOC, (u32)-1);
> +	if (!xz_dec)
> +		return -ENOMEM;
> +
> +	xz_buf.in_size = size;
> +	xz_buf.in = buf;
> +	xz_buf.in_pos = 0;
> +
> +	do {
> +		struct page *page = module_get_next_page(info);
> +		if (!page) {
> +			retval = -ENOMEM;
> +			goto out;
> +		}

This looks very similar to fw_decompress_xz_pages() on
drivers/base/firmware_loader/main.c

Is there any sharing possible with decompression between the two?

  Luis
