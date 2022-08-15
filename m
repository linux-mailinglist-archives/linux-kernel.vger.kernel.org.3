Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F96A5951E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiHPFSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiHPFSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:18:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5482F025;
        Mon, 15 Aug 2022 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tuvXtJ9soadoXTBDCJEvykEK+n8KHhNOlNc8G7ICye8=; b=eabBcTanE3+CVJsxCs6eIwiHha
        X6f69KoRSYCJYi+Uj2nD632SMnTFfIDzrrF1zHlFV45YknO/IA1KFyjED8Q26UbRLQZ6n7bzIzKgv
        i8rIi6dkB5gnKxN9+/FjXvPB45T6iiJe8sFHAMP1DfraoCAzduQXckuZLqfcBF5cTTwllh4MBqhFu
        UPbc+B2uTdMA/ClGg0Jt4NdoWY733Fq+M3+KKhsgxxITOaCwQJS1DuAN3SLcxYR9LbT9AMGGCWk4D
        FXfO6SKT9ee3cMf71mHOsOIbMBfdb3unqKaK67CT6oyVJtrFx3rRx1/Af1MWmu2JIfnuy6v1HT9fE
        0vcEZppQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNhow-004ocU-2p;
        Mon, 15 Aug 2022 21:40:26 +0000
Date:   Mon, 15 Aug 2022 22:40:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>, linux-fs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH RFC] fs,ipc: batch RCU synchronization in free_ipc
Message-ID: <Yvq9SmCUX/eeUuR1@ZenIV>
References: <20220815172620.5d7d4a78@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815172620.5d7d4a78@imladris.surriel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:26:20PM -0400, Rik van Riel wrote:
> TL;DR: it runs better than it looks, and I am looking for ideas on how to make it look better

> Unfortunately there seems to be a tradeoff between temporarily
> allocating things on the stack, and having slightly uglier code,
> or adding a struct rcu_work to the struct vfsmount.
> 
> I am not entirely happy with the way this code looks, and hoping
> for suggestions on how to improve it.
> 
> However, I am quite happy with how this code runs. Between batching
> the kern_unmount RCU synchronization, moving to the expedited RCU
> grace period in kern_unmount_array, and grabbing things off the
> llist that were added after the work item started, freeing ipc
> namespaces is 2-3 orders of magnitude faster than before, and
> able to keep up with the test case above.

IMO you are going in wrong direction with that; it's a long story,
and I've partial writeup on that, but I won't have it ready for
posting until the end of the week.  Put it that way - there's
a possibility of reorganizing the way mount refcounts work,
eliminating this synchronize_rcu().  RCU delay still has to happen
in some form, but we get smarter ways to wait for it.

Anyway, it's about 15 pages of writeup right now, and it's going
to be a major massage, part for the coming cycle, part for the
next one.  I'll post it to fsdevel later this week, will make sure
to Cc you.
