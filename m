Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1FF5AB231
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiIBNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiIBNwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:52:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10F4134193
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7B96B829FB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85A0C433D6;
        Fri,  2 Sep 2022 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662122807;
        bh=hW87bCjg7mhQfCQ8qK8L55df2bf6Oy03cAkiFazu4jQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRtcezHyRLdYAKxIdu4kAggfw0eKH/zs1cQ2efUFrRo1AS30kqqkFagEU4KstWLaC
         04G/dmgX/kISBd/LoWRLHYmMNdFXr/H//90i3ynoJMrukKa0x2LLegCo3gOK5tG8XU
         Pn4Yyz/D+SLbGUrDGTlabt8F51O7Zlp55hsTB3kE=
Date:   Fri, 2 Sep 2022 14:46:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Major Chen <major.chen@samsung.com>, stable <stable@kernel.org>,
        Kuyo Chang <kuyo.chang@mediatek.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] sched/debug: fix dentry leak in
 update_sched_domain_debugfs
Message-ID: <YxH7NIe0Inz2V6sH@kroah.com>
References: <20220902123107.109274-1-gregkh@linuxfoundation.org>
 <20220902123107.109274-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902123107.109274-2-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:31:07PM +0200, Greg Kroah-Hartman wrote:
> Kuyo reports that the pattern of using debugfs_remove(debugfs_lookup())
> leaks a dentry and with a hotplug stress test, the machine eventually
> runs out of memory.
> 
> Fix this up by using the newly created debugfs_lookup_and_remove() call
> instead which properly handles the dentry reference counting logic.
> 
> Cc: Major Chen <major.chen@samsung.com>
> Cc: stable <stable@kernel.org>
> Reported-by: Kuyo Chang <kuyo.chang@mediatek.com>
> Tested-by: Kuyo Chang <kuyo.chang@mediatek.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/sched/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As this needs patch 1/2 to work properly, and Kuyo has tested this out
already, I'll take both of them through my driver core git tree to Linus
so that we can start getting the other debugfs_lookup() leaks fixed up
as well.

thanks,

greg k-h
