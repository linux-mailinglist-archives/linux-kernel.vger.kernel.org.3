Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10423551002
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiFTGBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiFTGBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:01:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009EDFD8;
        Sun, 19 Jun 2022 23:01:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90D1A68D06; Mon, 20 Jun 2022 08:01:28 +0200 (CEST)
Date:   Mon, 20 Jun 2022 08:01:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, rdunlap@infradead.org
Subject: Re: [PATCH 1/4] of: also handle dma-noncoherent in
 of_dma_is_coherent()
Message-ID: <20220620060127.GA10297@lst.de>
References: <20220619203212.3604485-1-heiko@sntech.de> <20220619203212.3604485-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619203212.3604485-2-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 10:32:09PM +0200, Heiko Stuebner wrote:
>  bool of_dma_is_coherent(struct device_node *np)
>  {
>  	struct device_node *node;
> +	bool ret = false;

I'd rename this to coherent or is_coherent.

>  
>  	if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
> -		return true;
> +		ret = true;

And then do this at initialization time:

	bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);

but otherwise this looks good to me.
