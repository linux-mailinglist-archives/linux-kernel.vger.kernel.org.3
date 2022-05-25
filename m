Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9614B534065
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245129AbiEYPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiEYPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:30:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A5332F03F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:29:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 650E41424;
        Wed, 25 May 2022 08:29:58 -0700 (PDT)
Received: from wubuntu (unknown [10.57.65.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11A563F73D;
        Wed, 25 May 2022 08:29:57 -0700 (PDT)
Date:   Wed, 25 May 2022 16:29:56 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Paul Bone <pbone@mozilla.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scheduling for heterogeneous computers
Message-ID: <20220525152956.5oz2chfwlgevvaul@wubuntu>
References: <20220308092141.GF748856@aluminium>
 <20220321121611.ssa7o2npy3ahdofk@wubuntu>
 <CANdLaqA6aHr3K0apZLsXVbx1_zZvK6iMvX+HVcu7888HOeEjhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANdLaqA6aHr3K0apZLsXVbx1_zZvK6iMvX+HVcu7888HOeEjhg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

On 05/24/22 15:23, Paul Bone wrote:
> Hi Qais,
> 
> That's excellent.
> 
> I'll definitely check out those links.  This could be very interesting for
> people using firefox on a phone/tablet, where we can run background tasks with
> a lower UCLAMP_MAX

If you're running on Android, you might find that you won't have permission to
use uclamp directly. Android restricts access and requires you to use higher
level APIs sometimes.

And I'm not sure if they have API to allow you to do what you want. I've seen
they have the concept of creating Foreground and Background jobs in one of
their Google IO presentations. But not sure if this will be tied to uclamp_max.
It might give you similar results still though regardless of the underlying
mechanism.

If you're running on mainline kernel, then the biggest issue you might
encounter is that sched_setattr() syscall is not part of any libc yet. So you
need to create your own wrapper - look at uclampset for an example.

Laptops can still benefit from this by the way. Hopefully everyone is moving to
schedutil by default which is a pre-requisite to using uclamp. It can also help
in SMP environments to avoid driving frequency high for tasks that don't really
care about performance but otherwise busy.

You can also use UCLAMP_MIN to boost bursty tasks that are not busy but require
to get work done within a certain amount of time and DVFS delays can prevent
them from running at adequate frequency. UCLAMP_MIN will ensure they always
perceive a performance point specified by UCLAMP_MIN at a minimum when they
wakeup.

RT tasks respect uclamp values too. You can opt-in to run at a different
frequency than MAX frequency which leads to high power consumption on battery
powered devices. RT tasks always run at constant frequency, so need to be
controlled with UCLAMP_MIN only.

Happy hacking ;-)

Cheers

--
Qais Yousef
