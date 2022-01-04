Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F744841A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiADM3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:29:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37994 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiADM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:29:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC146B811D9;
        Tue,  4 Jan 2022 12:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3D5C36AE7;
        Tue,  4 Jan 2022 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641299347;
        bh=67LOQtcueTMAI0ld45ARZL7TA7k11DlREbbqGl7s4x0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T3r245F93SyjBK61i7mujJxcpAK/z09AVqrAEulvJJZMHyiSX7sgVr0fzbVRZmH3E
         TBUvvlOlSsDcywgnlhHP7/SLUpHnZjKkyOO/3bLq9RhWreC3Sp35PgmZaQf5cGryqL
         541ddFp+xgxrcBycBbU0W4Icd9XFOscf+MsHXdYb91hNJV2UZfra4QOvhKeDh7UASn
         xiDW4d4i4kkIH+sdzE68clCK5zMX99pBvUB7Gqzp5+fKeG40oPJXI08hEPhdYiVUlV
         wXqf3Z80CyFHJ/3G1HI8dkvWoULvQxo/TWEONkiT1xOa4t563cx1CItbskpTaKe+Ft
         gJGupiiYg59iw==
Message-ID: <21d74364d3006b350502067ab5a51f5dd1cd3f31.camel@kernel.org>
Subject: Re: PROBLEM: SLAB use-after-free with ceph(fs)
From:   Jeff Layton <jlayton@kernel.org>
To:     Bastian Blank <bastian.blank@credativ.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Jan 2022 07:29:05 -0500
In-Reply-To: <YdQ7msXTCF5kKl4V@softhammer.credativ.lan>
References: <YdQYEF9WCTWTAzOp@softhammer.credativ.lan>
         <22cf685dbf61e09a4e5e7c3a48d1117a769548a8.camel@kernel.org>
         <YdQ7msXTCF5kKl4V@softhammer.credativ.lan>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-04 at 13:20 +0100, Bastian Blank wrote:
> Hi
> 
> On Tue, Jan 04, 2022 at 07:00:31AM -0500, Jeff Layton wrote:
> > On Tue, 2022-01-04 at 10:49 +0100, Bastian Blank wrote:
> > > > [152791.777458] cache_from_obj: Wrong slab cache. jbd2_journal_handle but object is from kmalloc-256
> 
> > At first blush, this looks like the same problem as:
> >     https://tracker.ceph.com/issues/52283
> > ...but that should have been fixed in v5.14.
> 
> Nope, does not make sense.  This reported issue tried to free a
> "ceph_cap_flush", while mine tries to free "jbd2_journal_handle", which
> is far away.
> 

There was some ambiguity in how those objects got freed. What you're
seeing could just be a different manifestation of the same problem, but
it could be something else as well.

> > You may also want to try v5.16-rc8 if you're able to build your own
> > kernels. There were some patches that went in to improve how the client
> > handles inodes that become inaccessible.
> 
> I try to get them to install a 5.16-rc8 or newer, get a new crash dump
> and report that to https://tracker.ceph.com/.
> 

Sounds good. I suspect you have more than one problem.

The crash is clearly a kernel bug, but it's occurring while the client
is removing caps due to receiving a session message. It may be that the
MDS blocklisted the client in this case. You may want to check the MDS
logs or see if the kernel logged anything to that effect.

v5.16 may help the client more sanely handle tearing down inodes in this
situation, but it may not do anything to help whatever is causing the
blocklisting in the first place.
-- 
Jeff Layton <jlayton@kernel.org>
