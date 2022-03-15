Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FED4D9615
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbiCOIYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345847AbiCOIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:24:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB9A11151;
        Tue, 15 Mar 2022 01:23:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F46868AA6; Tue, 15 Mar 2022 09:23:01 +0100 (CET)
Date:   Tue, 15 Mar 2022 09:23:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0] pata_parport: add driver (PARIDE replacement)
Message-ID: <20220315082301.GA3502@lst.de>
References: <20220310212812.13944-1-linux@zary.sk> <202203111955.15743.linux@zary.sk> <c0a6065c-3e89-a4be-e257-ce25711e4368@opensource.wdc.com> <202203121221.56068.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203121221.56068.linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 12:21:55PM +0100, Ondrej Zary wrote:
> > Here, I am assuming that block/paride is the core code used by both
> > PARIDE and PATA_PARPORT. Not sure what PARPORT_PC does nor what its
> > dependency on block/paride code is.
> 
> There's no common core in block/paride. The block/paride/Makefile says:
> obj-$(CONFIG_PARIDE)            += paride.o
> obj-$(CONFIG_PARIDE_ATEN)       += aten.o
> obj-$(CONFIG_PARIDE_...other protocol drivers
> 
> So if PARIDE and all protocol drivers are disabled, nothing is compiled there.

Yeah.  The pattern of unconditionally descending into a subdirectory
isn't entirely uncommon.  I think this is perfectly fine here.
