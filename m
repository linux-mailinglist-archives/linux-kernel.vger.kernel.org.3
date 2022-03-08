Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955944D1087
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbiCHGzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbiCHGzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:55:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C22B251;
        Mon,  7 Mar 2022 22:54:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4147068AFE; Tue,  8 Mar 2022 07:54:44 +0100 (CET)
Date:   Tue, 8 Mar 2022 07:54:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pata_parport: paride replacement
Message-ID: <20220308065443.GA24269@lst.de>
References: <20220305201411.501-1-linux@zary.sk> <20220306085825.GA22425@lst.de> <202203061136.36700.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203061136.36700.linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 11:36:36AM +0100, Ondrej Zary wrote:
> On Sunday 06 March 2022 09:58:25 Christoph Hellwig wrote:
> > Hi Ondrej,
> > 
> > I just took a quick glance and it seems like the actual protocol
> > modules still are basically almost exactly the same ones as the
> > paride ones.  Is there a way to just keep the existing modules?
> > 
> > The only big thing I noticed is the host template, but at least
> > for the transitional periode we could probably allocate that
> > dynamically in the core.  I think would reduce the amount of code
> > churn nicely and make review much easier.
> 
> Yes, only small changes in the protocol modules regarding (un)registration.
> 
> Getting the original modules work with pata_parport (like in 1st preview) required some hacks that break paride (disabling EXPORT_SYMBOLs in paride).
> 
> Maybe the protocol modules can be moved (git mv) from paride and then patched? A copy would be better but there's no "git cp".

Hmm, how would be break the old PARIDE code?  You'd need the new libata
support exlusive to the old PARIDE code so that only one of them can
export the registration symbols at a time.  The git-mv can happen
once the old paride code is removed after a release or two.

> 
> -- 
> Ondrej Zary
---end quoted text---
