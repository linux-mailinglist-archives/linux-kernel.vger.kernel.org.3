Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE653E2BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiFFIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiFFIdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:33:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E02FE66
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:33:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EF1B71F461;
        Mon,  6 Jun 2022 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654504409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJjaloV5+HcQZaXHw0f2gF+Srokd4wPErX0W6s9DSTk=;
        b=mr9DatIXY6/NaJHuzz/M8tzq7pvqO1aylMjVb+LQFp0SlIoyDdjNP1/7i7x1eLDZMlqveD
        hJQjB4y6xBUBvJ5hX2QDSZALFiamLe5HLZjUBK3zoM6V9aj8AhDSKcIvJetIUGnTGRtEug
        iUfDMtu0S96uvVi+kFbXG/aA+8WP6uE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AE1082C141;
        Mon,  6 Jun 2022 08:33:29 +0000 (UTC)
Date:   Mon, 6 Jun 2022 10:33:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zackary Liu <zackary.liu.pro@gmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/oom_kill: break evaluation when a task has been
 selected
Message-ID: <Yp272UqXecNsmC1z@dhcp22.suse.cz>
References: <YpcZFvVZRPTyTQ7s@dhcp22.suse.cz>
 <6BC32F66-2AC4-450D-90D5-B7A09455B617@getmailspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6BC32F66-2AC4-450D-90D5-B7A09455B617@getmailspring.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-06-22 18:35:19, Zackary Liu wrote:
> 
> On Jun 1 2022, at 3:45 pm, Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Sat 14-05-22 15:52:28, Zhaoyu Liu wrote:
> >> oom points no longer need to be calculated if a task is oom_task_origin(),
> >> so return 1 to stop the oom_evaluate_task().
> > 
> > This doesn't really explain why this is really desired. Is this a fix,
> > optimization?
> > 
> > Please also note that this change has some side effects. For one, the
> > task marked as oom origin will get killed even if there is still a
> > pending oom victim which hasn't been fully dismantled. Is this
> > intentional?
> 
> Thank you very much for reminding.
> 
> From my point of view, the victim was marked in the last oom, and now it
> has entered the oom again, which means that the system still has no
> deprecated memory available.

This is not an unusual situation. OOM victims can take some time to die
and release their memory. The oom_reaper is there to fast forward that
process and guarantee a forward progress. But this can still take some
time. Our general policy is to back off when there is an alive oom
victim encountered. Have a look at the tsk_is_oom_victim test in
oom_evaluate_task. For that heuristic to be effective the whole task
list (wether the global one or memcg) has to be evaluated.

> In order to ensure that the system can
> return to normal as soon as possible, killing the origin task
> immediately should be A good choice, and the role of this patch is to
> end oom_evaluate_task and return true as soon as the origin task is found.

Could you be more specific how does this patch guarantees a forward
progress? What is the actual usecase that benefits from this change?

These are all important information for future reference. Please note I
am not saying the patch is wrong. I just still do not see why it is
useful.

> Maybe this patch is not the optimal solution, it has a trade-off.

If there are trade-offs, please document them in the changelog.

The way I see it is that oom_task_origin heuristic has been introduced
to help killing swapoff operation because the swapped out memory doesn't
fit into memory. This is a very reasonable thing to do in general but it
also represents an early failure visible to the userspace. If there is a
pre-existing oom victim then I would argue that we should try to avoid
the failure.

-- 
Michal Hocko
SUSE Labs
