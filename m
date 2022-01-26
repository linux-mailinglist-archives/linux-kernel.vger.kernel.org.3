Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD8349D597
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiAZWmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiAZWl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:41:57 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A7C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:41:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u18so1152942edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kmlesg0I4LYJSjpNNLXT1MwRqqz07UkKMgwpQerJZI=;
        b=l9vpOUZB8NcQgpvbNkpOEaeahCnYoHjUgOpPZAywPZfGYpyG0d9jz/Kt1pKMI84twO
         NuOzY+JdgnvBZ7r10vSopglCYsgSKT9oWEBS5FQdK25SkR4NpgnSlqBI6/rh2VirvKh7
         5I6cTxkLzn6QB2Agk++R+m56tpPtRt5DknK/gL66+niqa5azxbOhOw+Fs6WElUJNhzVK
         2EkZv6+jYG2MdXTPjRR1Rf2t3ioib6J+qa1YUhjfYgcFGltmjT0hAU9W1HOVbHwesrwZ
         EknPLiDwrej46VB2W/j7SRp1dWKinvVldzz7NzW1TAXcKs0fs+ykXY8WeUrQEedMPHvk
         BYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kmlesg0I4LYJSjpNNLXT1MwRqqz07UkKMgwpQerJZI=;
        b=377eGlfpeZeH3HRt4aZPJNLYzXGm7QuTHDAw+ZcuntGB+5ij84958/SpT7DJtWqCNk
         cjR8ospk0cXZgyQWUwCOjHv2Dl98sfMRV0X5SijX43KHIFGs1NXVa9tptX430AT8i1Td
         eedl75YlZ3sIZYR2brlr1dfSCBSjJYM8GHxX46Sfh7iaT3NZyWLwysbqhqUJDHKBj+ya
         BdZMAkXK4pL2jVpZ40D0FQrzgu29oxjl+s6iEtFCc7WZGiEC8ghHkBjga5fRUcOrHKDH
         WJTtRpIhxsACc/JC0xd38F4S0nnZLUpwV3sLGTtDsiNhN+AtieWjiqN0llcwS5Vz+CHc
         GW7Q==
X-Gm-Message-State: AOAM531zgIUvkCby70hrEZWZtiy51wWJXH7bXgavSDguT8As2Vo91uKP
        EKfjtxV5ejzpdqScgKJQBAdtvusxBvIEWmIkFM+m
X-Google-Smtp-Source: ABdhPJxGOZMMTCMbY+EL2mon3XorJs4hqbl4sUi6fTTvBfI9j+aAsvtN3RJnWVwHLlK16m+6E5M+wgLU1SCtu09d6TA=
X-Received: by 2002:a05:6402:2793:: with SMTP id b19mr1052162ede.171.1643236915606;
 Wed, 26 Jan 2022 14:41:55 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com> <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
In-Reply-To: <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 17:41:44 -0500
Message-ID: <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Demi Marie Obenour <demiobenour@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
<demiobenour@gmail.com> wrote:
> On 1/25/22 17:27, Paul Moore wrote:
> > On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
> > <demiobenour@gmail.com> wrote:
> >>
> >> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> >> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> >> descriptor being leaked to a process that should not have access to it.
> >>
> >> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> >> ---
> >>  security/selinux/hooks.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >
> > I'm not convinced that these two ioctls should be exempt from SELinux
> > policy control, can you explain why allowing these ioctls with the
> > file:ioctl permission is not sufficient for your use case?  Is it a
> > matter of granularity?
>
> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not just
> files.  If I want to allow them with SELinux policy, I have to grant
> *:ioctl to all processes and use xperm rules to determine what ioctls
> are actually allowed.  That is incompatible with existing policies and
> needs frequent maintenance when new ioctls are added.
>
> Furthermore, these ioctls do not allow one to do anything that cannot
> already be done by fcntl(F_SETFD), and (unless I have missed something)
> SELinux unconditionally allows that.  Therefore, blocking these ioctls
> does not improve security, but does risk breaking userspace programs.
> The risk is especially great because in the absence of SELinux, I
> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
> programs may rely on this.  Worse, if a failure of FIOCLEX is ignored,
> a file descriptor can be leaked to a child process that should not have
> access to it, but which SELinux allows access to.  Userspace
> SELinux-naive sandboxes are one way this could happen.  Therefore,
> blocking FIOCLEX may *create* a security issue, and it cannot solve one.

I can see you are frustrated with my initial take on this, but please
understand that excluding an operation from the security policy is not
something to take lightly and needs discussion.  I've added the
SELinux refpolicy list to this thread as I believe their input would
be helpful here.

--
paul-moore.com
