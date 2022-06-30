Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1471E56102D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiF3E2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiF3E2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:28:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6D11CB21;
        Wed, 29 Jun 2022 21:28:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C5E568AA6; Thu, 30 Jun 2022 06:28:30 +0200 (CEST)
Date:   Thu, 30 Jun 2022 06:28:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, rdunlap@infradead.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH v5 3/4] riscv: Implement Zicbom-based cache management
 operations
Message-ID: <20220630042830.GB4958@lst.de>
References: <20220629215944.397952-1-heiko@sntech.de> <20220629215944.397952-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629215944.397952-4-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 11:59:43PM +0200, Heiko Stuebner wrote:
> The Zicbom ISA-extension was ratified in november 2021
> and introduces instructions for dcache invalidate, clean
> and flush operations.
> 
> Implement cache management operations based on them.
> 
> Of course not all cores will support this, so implement an
> alternative-based mechanism that replaces empty instructions
> with ones done around Zicbom instructions.
> 
> As discussed in previous versions, assume the platform
> being coherent by default so that non-coherent devices need
> to get marked accordingly by firmware.

The subject here seems somewhat odd.  Yes, it does implement the
low-level cache management ops, but more importantly it adds
support for devices that are not DMA coherent.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
