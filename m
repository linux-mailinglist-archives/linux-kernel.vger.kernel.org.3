Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3044554D05A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357842AbiFORtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbiFORtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:49:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27347060;
        Wed, 15 Jun 2022 10:49:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F33DE68AFE; Wed, 15 Jun 2022 19:49:10 +0200 (CEST)
Date:   Wed, 15 Jun 2022 19:49:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management
 operations
Message-ID: <20220615174910.GA26607@lst.de>
References: <20220610004308.1903626-1-heiko@sntech.de> <20220610004308.1903626-3-heiko@sntech.de> <20220610055608.GA24221@lst.de> <110361853.nniJfEyVGO@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <110361853.nniJfEyVGO@diego>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 06:56:40PM +0200, Heiko Stübner wrote:
> If I'm reading things correctly [0], the default for those functions
> is for those to be empty - but defined in the coherent case.

That's not the point.

Zicbom is just an extension that allows the CPU to support managing
cache state.  Non-coherent DMA is just one of the use cases there
are others like persistent memory.  And when a CPU core supports
Zicbom it might or might not have any non-coherent periphals.  Or
even some coherent and some non-coherent ones, something that
is pretty common in arm/arm64 CPUs, where PCIe is usually cache
coherent, but some other cheap periphals might not be.

That is why Linux ports require the plaform (usually through
DT or ACPI) to mark which devices are coherent and which ones
are not.
