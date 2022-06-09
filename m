Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0F544BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbiFIMaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiFIMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:30:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50003140F8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WbC87y9wl4WsCtucOrEr0iSsJGhDjZVjnD/A+Ep8H6k=; b=pbSU+bRTaDv4jE0cm2tg8t7JZi
        sLoAv+oJoZ4LhVl/Kd/G9ctq4kG/KfDXL9qouiIHmvpzaOpmc748lbYq9lNsyrM6Fyq4l+gVeUJac
        Mummxv/4tUgpL+nLTZH/qDSpxZA3OBOppJbNKNnLOP+Nr89d2bpOnMMJ2SdWvp++YmA24HQfR/i4Y
        3aKqWrSaa1cT5eo0CgLGnVk01bhypMBvxw42stT6tPMaQIL5+Y/K0UXCutbdcGo2q/ytI2bVfSRBc
        twKVi+d9iYJ7iduK42/AXH3MtSDboyLKEraBMUxKbi3fg9QNiBExNtWZehb19GtOoe1hbH+463Azg
        TBZfKWyg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzHI9-006N4r-Am; Thu, 09 Jun 2022 12:29:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5316B9816EC; Thu,  9 Jun 2022 14:29:35 +0200 (CEST)
Date:   Thu, 9 Jun 2022 14:29:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huichun Feng <foxhoundsk.tw@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        jserv@ccns.ncku.edu.tw, Chin-En Lin <shiyn.lin@gmail.com>
Subject: Re: [PATCH] sched/fair: avoid redundant hrtimer check
Message-ID: <YqHnr8SA2gbf45ok@worktop.programming.kicks-ass.net>
References: <20220606122612.2580930-1-foxhoundsk.tw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606122612.2580930-1-foxhoundsk.tw@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 08:26:12PM +0800, Huichun Feng wrote:
> The check is required iff HRTICK is enabled and DOUBLE_TICK is disabled,
> avoid the redundant check by adding corresponding sched_feat() .

How about: 'don't do that then'?
