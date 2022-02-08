Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6C4AE1E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353675AbiBHTHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352581AbiBHTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:07:50 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C38C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:07:49 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHVq1-000S8r-Iw; Tue, 08 Feb 2022 19:07:41 +0000
Date:   Tue, 8 Feb 2022 19:07:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Waiman Long <longman@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_process(): Move fd_install() out of
 sighand->siglock critical section
Message-ID: <YgK/fdYWi0wWysci@zeniv-ca.linux.org.uk>
References: <20220208163912.1084752-1-longman@redhat.com>
 <YgKziblMKsmHkP4f@zeniv-ca.linux.org.uk>
 <bd83aca3-059f-92dd-e094-b27f51f9481a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd83aca3-059f-92dd-e094-b27f51f9481a@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:51:35PM -0500, Waiman Long wrote:
> On 2/8/22 13:16, Al Viro wrote:
> > On Tue, Feb 08, 2022 at 11:39:12AM -0500, Waiman Long wrote:
> > 
> > > One way to solve this problem is to move the fd_install() call out of
> > > the sighand->siglock critical section.
> > > 
> > > Before commit 6fd2fe494b17 ("copy_process(): don't use ksys_close()
> > > on cleanups"), the pidfd installation was done without holding both
> > > the task_list lock and the sighand->siglock. Obviously, holding these
> > > two locks are not really needed to protect the fd_install() call.
> > > So move the fd_install() call down to after the releases of both locks.
> > 	Umm... That assumes we can delay it that far.  IOW, that nothing
> > relies upon having pidfd observable in /proc/*/fd as soon as the child
> > becomes visible there in the first place.
> > 
> > 	What warranties are expected from CLONE_PIDFD wrt observation of
> > child's descriptor table?
> > 
> I think the fd_install() call can be moved after the release of
> sighand->siglock but before the release the tasklist_lock. Will that be good
> enough?

Looks like it should, but I'd rather hear from the CLONE_PIDFD authors first...
Christian, could you comment on that?
