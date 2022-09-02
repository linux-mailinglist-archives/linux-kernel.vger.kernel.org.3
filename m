Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399F05AB4FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiIBPXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiIBPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4E38BA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1394661E34
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB38C433D7;
        Fri,  2 Sep 2022 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662130568;
        bh=8HxsyLelsYqwOCxhTJ5jpbUjl0UPkAy78gN1FK3B4KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIfrCsnC9TPzpq/x+bzxefF3RTtWsi1KGr682ovbh1PBJBn9g8++/aZpERT2Hewmq
         poSK1QtcWyTv+MHbfWWtQZnuTeqVdBDlR4m7Bm6CxoPZ0ZLTstOh/bnB1mYSAUrYFI
         UGcx0TJUS/P9oScrPgZQT/BrI8uvssK25MpOCLp0=
Date:   Fri, 2 Sep 2022 16:56:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kuyo Chang <kuyo.chang@mediatek.com>, major.chen@samsung.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, hongfei.tang@samsung.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] sched/debug: fix dentry leak in
 update_sched_domain_debugfs
Message-ID: <YxIZhWB2tCXzlzWj@kroah.com>
References: <20220902031518.1116-1-kuyo.chang@mediatek.com>
 <YxGUBzp9C7kcNgps@kroah.com>
 <5ce45c874d6a05ca69abed3961d413c4a4360e79.camel@mediatek.com>
 <YxGpp/+lWSzwpVLZ@kroah.com>
 <f14e71182ebf1520aeede06afb44af49ec6128a0.camel@mediatek.com>
 <YxHI2sRgF2gqYcHk@kroah.com>
 <YxIX96nUnwz56fte@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxIX96nUnwz56fte@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:49:27PM +0100, Al Viro wrote:
> On Fri, Sep 02, 2022 at 11:11:54AM +0200, Greg Kroah-Hartman wrote:
> 
> > +/**
> > + * debugfs_lookup_and_remove - lookup a directory or file and recursively remove it
> > + * @name: a pointer to a string containing the name of the item to look up.
> > + * @parent: a pointer to the parent dentry of the item.
> > + *
> > + * This is the equlivant of doing something like
> > + * debugfs_remove(debugfs_lookup(..)) but with the proper reference counting
> > + * handled for the directory being looked up.
> > + */
> > +void debugfs_lookup_and_remove(const char *name, struct dentry *parent)
> > +{
> > +	struct dentry *dentry;
> > +
> > +	dentry = debugfs_lookup(name, parent);
> > +	if (IS_ERR_OR_NULL(dentry))
> > +		return;
> 
> 	Could somebody explain how could that return ERR_PTR()?

If debugfs is not enabled then debugfs_lookup() will return an
ERR_PTR().  But, doh, this _IS_ debugfs so you are right, that will
never happen.

> Incidentally, IS_ERR_OR_NULL is almost always a sign of bad interface - or
> that of lazy cargo-culting.  Please, don't propagate that garbage... ;-/

Fair enough, I'll fix that up, many thanks for noticing it.

greg k-h
