Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30D55B478
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiFZXd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 19:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiFZXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 19:33:56 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856942BEC;
        Sun, 26 Jun 2022 16:33:54 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 0617E113A; Sun, 26 Jun 2022 18:33:53 -0500 (CDT)
Date:   Sun, 26 Jun 2022 18:33:52 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] security: Add LSM hook to setgroups() syscall
Message-ID: <20220626233352.GA31265@mail.hallyn.com>
References: <20220616171809.783277-1-mortonm@chromium.org>
 <034eb96c-573e-a074-2506-99456ec7f6f7@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034eb96c-573e-a074-2506-99456ec7f6f7@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:15:05AM -0700, Casey Schaufler wrote:
> On 6/16/2022 10:18 AM, Micah Morton wrote:
> > Give the LSM framework the ability to filter setgroups() syscalls. There
> > are already analagous hooks for the set*uid() and set*gid() syscalls.
> > The SafeSetID LSM will use this new hook to ensure setgroups() calls are
> > allowed by the installed security policy. Tested by putting print
> > statement in security_task_fix_setgroups() hook and confirming that it
> > gets hit when userspace does a setgroups() syscall.
> > 
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> 
> I don't see any problems with this.
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> 

Ditto.  Thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> > ---
> >   include/linux/lsm_hook_defs.h |  1 +
> >   include/linux/lsm_hooks.h     |  7 +++++++
> >   include/linux/security.h      |  7 +++++++
> >   kernel/groups.c               | 13 +++++++++++++
> >   security/security.c           |  5 +++++
> >   5 files changed, 33 insertions(+)
> > 
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index eafa1d2489fd..806448173033 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -201,6 +201,7 @@ LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
> >   	 int flags)
> >   LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
> >   	 int flags)
> > +LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
> >   LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
> >   LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
> >   LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 91c8146649f5..84a0d7e02176 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -702,6 +702,13 @@
> >    *	@old is the set of credentials that are being replaced.
> >    *	@flags contains one of the LSM_SETID_* values.
> >    *	Return 0 on success.
> > + * @task_fix_setgroups:
> > + *	Update the module's state after setting the supplementary group
> > + *	identity attributes of the current process.
> > + *	@new is the set of credentials that will be installed.  Modifications
> > + *	should be made to this rather than to @current->cred.
> > + *	@old is the set of credentials that are being replaced.
> > + *	Return 0 on success.
> >    * @task_setpgid:
> >    *	Check permission before setting the process group identifier of the
> >    *	process @p to @pgid.
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 7fc4e9f49f54..1dfd32c49fa3 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -415,6 +415,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
> >   			     int flags);
> >   int security_task_fix_setgid(struct cred *new, const struct cred *old,
> >   			     int flags);
> > +int security_task_fix_setgroups(struct cred *new, const struct cred *old);
> >   int security_task_setpgid(struct task_struct *p, pid_t pgid);
> >   int security_task_getpgid(struct task_struct *p);
> >   int security_task_getsid(struct task_struct *p);
> > @@ -1098,6 +1099,12 @@ static inline int security_task_fix_setgid(struct cred *new,
> >   	return 0;
> >   }
> > +static inline int security_task_fix_setgroups(struct cred *new,
> > +					   const struct cred *old)
> > +{
> > +	return 0;
> > +}
> > +
> >   static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
> >   {
> >   	return 0;
> > diff --git a/kernel/groups.c b/kernel/groups.c
> > index 787b381c7c00..9aaed2a31073 100644
> > --- a/kernel/groups.c
> > +++ b/kernel/groups.c
> > @@ -134,13 +134,26 @@ EXPORT_SYMBOL(set_groups);
> >   int set_current_groups(struct group_info *group_info)
> >   {
> >   	struct cred *new;
> > +	const struct cred *old;
> > +	int retval;
> >   	new = prepare_creds();
> >   	if (!new)
> >   		return -ENOMEM;
> > +	old = current_cred();
> > +
> >   	set_groups(new, group_info);
> > +
> > +	retval = security_task_fix_setgroups(new, old);
> > +	if (retval < 0)
> > +		goto error;
> > +
> >   	return commit_creds(new);
> > +
> > +error:
> > +	abort_creds(new);
> > +	return retval;
> >   }
> >   EXPORT_SYMBOL(set_current_groups);
> > diff --git a/security/security.c b/security/security.c
> > index 188b8f782220..15c686145ad6 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1803,6 +1803,11 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
> >   	return call_int_hook(task_fix_setgid, 0, new, old, flags);
> >   }
> > +int security_task_fix_setgroups(struct cred *new, const struct cred *old)
> > +{
> > +	return call_int_hook(task_fix_setgroups, 0, new, old);
> > +}
> > +
> >   int security_task_setpgid(struct task_struct *p, pid_t pgid)
> >   {
> >   	return call_int_hook(task_setpgid, 0, p, pgid);
