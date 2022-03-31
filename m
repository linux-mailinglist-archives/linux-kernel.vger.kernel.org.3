Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D324ED756
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiCaJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCaJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:55:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F73B1AB2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:53:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4390E68B05; Thu, 31 Mar 2022 11:53:37 +0200 (CEST)
Date:   Thu, 31 Mar 2022 11:53:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v8 02/14] riscv: integrate alternatives better into the
 main architecture
Message-ID: <20220331095336.GB23422@lst.de>
References: <20220324000710.575331-1-heiko@sntech.de> <20220324000710.575331-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324000710.575331-3-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 01:06:58AM +0100, Heiko Stuebner wrote:
> Right now the alternatives need to be explicitly enabled and
> erratas are limited to SiFive ones.
> 
> Over time with more SoCs and additional RiscV extensions, many more
> erratas or other patch-worthy features will emerge, so it doesn't
> really make sense to have the core alternatives able to get
> deactivated.
> 
> So make it part of the core RiscV kernel and drop the main
> RISCV_ERRATA_ALTERNATIVES config symbol.
> 
> This mimics how other architectures like for example arm64 handle
> their alternatives implementation.

For minimal kernels like the k210 it would be really good to be
able to avoid any not strictly neeed code.  So I'd much rather
have the alternatives mechanism only built when it actually is needed,
not (semi-)unconditional.
