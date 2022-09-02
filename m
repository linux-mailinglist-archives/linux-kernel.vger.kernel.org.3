Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9E5AB4DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiIBPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiIBPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:17:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56EC28717
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aZ+oBpeo8JsuvtNdwggGcqsSE9afnliueCxoJZqBN7U=; b=RAadmeaUeYbulm9czRnwLyIs2I
        WGb29yXZX4DZLJGpVl2nRhLsckXMLIiJSJVrV6LFl8X+wPJuomJYZh1vQggraP9Pdnhv/gGikP9Qu
        th93zu2WpmdgXVac6wraItw1t1YbqW67M1jYL6VtttTEynEM/urS1xL7pSpQMAmKGMg9Iq//2Ggcq
        P1w0VkeNNhKdGxuOVfjUmje02hm0DZPe3MHA6LEi4L94zZuNE7sFbdwjoT9d4oHoLNJYGTmYKucF1
        Vy1wm7IRZ1IdAVc1VgIHfAJqFW2dcQV7w2VzMj3Y5UCeoGZSdlw5jrpv1pvVp53LTEpSQ6l/LSVyC
        +Bp2YXWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oU7z5-00BMvU-LF;
        Fri, 02 Sep 2022 14:49:27 +0000
Date:   Fri, 2 Sep 2022 15:49:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <YxIX96nUnwz56fte@ZenIV>
References: <20220902031518.1116-1-kuyo.chang@mediatek.com>
 <YxGUBzp9C7kcNgps@kroah.com>
 <5ce45c874d6a05ca69abed3961d413c4a4360e79.camel@mediatek.com>
 <YxGpp/+lWSzwpVLZ@kroah.com>
 <f14e71182ebf1520aeede06afb44af49ec6128a0.camel@mediatek.com>
 <YxHI2sRgF2gqYcHk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxHI2sRgF2gqYcHk@kroah.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:11:54AM +0200, Greg Kroah-Hartman wrote:

> +/**
> + * debugfs_lookup_and_remove - lookup a directory or file and recursively remove it
> + * @name: a pointer to a string containing the name of the item to look up.
> + * @parent: a pointer to the parent dentry of the item.
> + *
> + * This is the equlivant of doing something like
> + * debugfs_remove(debugfs_lookup(..)) but with the proper reference counting
> + * handled for the directory being looked up.
> + */
> +void debugfs_lookup_and_remove(const char *name, struct dentry *parent)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = debugfs_lookup(name, parent);
> +	if (IS_ERR_OR_NULL(dentry))
> +		return;

	Could somebody explain how could that return ERR_PTR()?

Incidentally, IS_ERR_OR_NULL is almost always a sign of bad interface - or
that of lazy cargo-culting.  Please, don't propagate that garbage... ;-/
