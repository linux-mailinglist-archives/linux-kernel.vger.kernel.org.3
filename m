Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842D24A6919
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbiBBAMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243127AbiBBAMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:12:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924FC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:12:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30042B82FD6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 00:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71DFC340EB;
        Wed,  2 Feb 2022 00:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643760719;
        bh=X+nYR+cvnx5SpctX3+Nw/zOkWXwkurskp2po44UAB9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkyfeQwrn7Y6sjTSxx6e/a0yllyoA1A+TGLXGsqcaP0+RRs+vjjQoTzxJAmAMps89
         LGLzbx24pqScgly/iuO6FeyzMFucjA2NN3qnDKFJmDQQYOuHiHvOMp83wKq+Kfw74W
         8fTKrkfPs6H0TnOFiFF7aOoDvVxVR0foKLi6xKho2G9ABC1yD0v723CUsRZ1S6HxqQ
         5ELokvWiNDQBGkI1iWThf6aQ1vKMXIzExh8ehKtSkGran6L0dVePDf9VFA/htLpRbz
         zhuNFDdEJtLgqucPMU7P25zFQlz6asjpA9sHsH9AdfrcSfT/8+nBY3YK7OVVjaUXR8
         E6vxRWoPGck2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA95040466; Tue,  1 Feb 2022 21:11:56 -0300 (-03)
Date:   Tue, 1 Feb 2022 21:11:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 0/3] Handle chroot tasks properly (v1)
Message-ID: <YfnMTIsKMLAnbF8P@kernel.org>
References: <20220128203950.3371061-1-namhyung@kernel.org>
 <2db9fab4-0aff-b8b0-5012-13556ea496af@linux.intel.com>
 <CAM9d7ciUqaZ02AV4xiknhyAKx0U-4GYKNGJWCa0P=5_CdpxoLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciUqaZ02AV4xiknhyAKx0U-4GYKNGJWCa0P=5_CdpxoLg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 01, 2022 at 12:01:49PM -0800, Namhyung Kim escreveu:
> On Mon, Jan 31, 2022 at 5:16 PM Andi Kleen <ak@linux.intel.com> wrote:
> > On 1/28/2022 12:39 PM, Namhyung Kim wrote:

> > > I found that perf tools don't work well with tasks in a chroot.  The
> > > filenames in MMAP record are from the root directory of the task so
> > > it's different than what it sees from outside.

> > While that's a real problem, and for chroot it can be fixed, it's much
> > more complicated for the more complex container namespace case with
> > custom mounts, including loop back, etc.
 
> Probably.  Note that perf tool can handle namespaces (to some extent)
> but missed chroot support.  I have a bug report because of this issue.
> Let's fix the simple case first.
 
> > It seems it really need some kind of agent to handle all cases. For
> > example the agent could understand container metadata formats and then
> > do the right thing.
> 
> Sounds like a good idea for a long term solution.

I think build ids are the way to go and would be really happy to have
arguments against it to be properly spelled out so we can harvest
documentation.

Its really difficult to associate a mmap to a backing storage, its race
prone, so having something that uniquely identifies the contents at the
time of mmap placement hugely desirable.

We seem to have that in most cases, and there is discussion about what
to do to the cases where parsing the ELF headers when that area is not
in memory, so there is hope that the buildid for an exec VMA will be
always available.

- Arnaldo
