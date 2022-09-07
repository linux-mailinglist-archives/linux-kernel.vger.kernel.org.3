Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251985AFF09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiIGIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIGIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:31:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10137A344D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:31:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6306D33B69;
        Wed,  7 Sep 2022 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662539513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQcC/MuTwXER3Fk3pTkmfsGu8/AW27uF6DMj9e4ZVeM=;
        b=uyLPzlsRIGuQdITOAHCzMjT689KH7zBjEqf8ecC89Z6tOURVAF7h2M9mc02HuJ/1Wn0utE
        zZkwMmhbsGSMw2tc2FZBkfYnkVBHv30Qt1lF/MSOeaJkNQ0nnP2JfxDEfkhZ0RuQIO1GR6
        S8dolF5DcB8q67PTNlZhz+SQg1bJ4Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662539513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQcC/MuTwXER3Fk3pTkmfsGu8/AW27uF6DMj9e4ZVeM=;
        b=seZhZwbUAvusV1tezHal7EPPhIPPVMUGUYsoz/BYVQAJj/qq3+TJPPyWpfBP2Kagi+viNb
        uTZVMms7lMgtIlCg==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A3FFD2C142;
        Wed,  7 Sep 2022 08:31:50 +0000 (UTC)
Date:   Wed, 7 Sep 2022 09:31:46 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Kuyo Chang <kuyo.chang@mediatek.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-mediatek@lists.infradead.org, jing-ting.wu@mediatek.com,
        yt.chang@mediatek.com, jonathan.jmchen@mediatek.com
Subject: Re: BUG: list_add corruption while doing migrate_swap -> balance_push
Message-ID: <20220907083146.lp6eyv4txjbhuevl@suse.de>
References: <6dab6e564e43c952f63f83ef868da6ed829fc1a8.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6dab6e564e43c952f63f83ef868da6ed829fc1a8.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 08:54:58PM +0800, Kuyo Chang wrote:
> Hi,
> 
> [Syndrome]
> A list_add corruption error at kernel-5.15, the log shows.
> list_add corruption. prev->next should be next (ffffff81a6f08ba0), but
> was 0000000000000000. (prev=ffffff81a6f05930).
> 

Is this a vanilla 5.15 kernel or modified? Does it happen on 5.19 or
6.0-rc4? Given that this appears to be a bug triggered by NUMA balancing
racing against memory hotplug, is there a reproducer for this?

-- 
Mel Gorman
SUSE Labs
