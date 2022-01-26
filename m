Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6293B49D5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiAZXMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiAZXMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:12:39 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21962C061749
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:12:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b13so1311318edn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skxNWSw4qMDs36v/OC+NXFbUqe9KBpL8K2ambS/Ai7o=;
        b=VFSBrg6hQe2y2/NXUMR8+uK4YZ40V5HHbzwmGe2Az89s+d01D4NAYmUWoZmnFFRgeU
         K6RGqgr9Fuu4BIYy3bQ0yAdhZqNiBH1wafXxCQP+e1/NL9EMa7NCosuZif/AjWJ0VBnd
         p8qceKEyUJ7j8MWZtta6QsrXq/m9g7IkR8h3mI4QqYYr68Am75ojEH6o+yTwPTJ8S5HN
         A47FI7iDSKrE+tHyr7HDTT8mlaTD8hLkdIa8P0Pc3cXd6sg/F8AxZCjidl/cNQyhCOfg
         ARKjxucVwPkQlWNmeA+fhyYe/FJEJ6qxL/8yKrjwPiVOx8XEpFgE88JBigHJ620a/NZn
         pHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skxNWSw4qMDs36v/OC+NXFbUqe9KBpL8K2ambS/Ai7o=;
        b=WutpBi46FHmrNx3U3QKYtwWBQZrh8NAxHtV/rjH3HnjhDfAlWBg5HCA3OLBqXqtzY0
         zpL7YIydg+f4NbDDNVrEPS7GX6OieNDm31ZjxFt7bpZv1FekSCSm2gKxMP00vyOrIeHX
         1Cq4qF8ouX2kC3hqJU9LR9GTgPFyFZMAXkKM9ZfdY1y5g9NHNGhtfGoIWq/rouRzgt4k
         oYQw2mV/JLo4KxuNd88GmjZnGSqZ31+r3GragQLewsUa8/oImJhp2S4SqHyDM7h4eAk/
         Y9lq4kSG+A00ScR5Etm2agg33i8YpTu6njQCrmqAmMRxLb9/TAv5qU7zGcbAuoTcNKzs
         R2Tw==
X-Gm-Message-State: AOAM533cv7q0mWc1WekAwiFSHLG7u0/R7QxUveXrwi5WcoMPoRRARkHV
        g1JoxPSxHSI6xghQX6kJRtWhk2ASo3qKcVTVe5QPu2qr0Z5hXtY=
X-Google-Smtp-Source: ABdhPJzS1eFcTV1+fJaYoQiwUEgiDGhUoNK/qqLzKGMFBUSrmTfiIoPwNwzlq8Tha3ylFkCsqIoWDL80c5Y/P0A7eg8=
X-Received: by 2002:a05:6402:270f:: with SMTP id y15mr1093080edd.409.1643238757607;
 Wed, 26 Jan 2022 15:12:37 -0800 (PST)
MIME-Version: 1.0
References: <YfGwggaTu8imJ0uc@redhat.com>
In-Reply-To: <YfGwggaTu8imJ0uc@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 18:12:26 -0500
Message-ID: <CAHC9VhSd9PMyN9K3EWGjd=nkSeRtEpEZ6Kg9v4LzgWr9gpeWOA@mail.gmail.com>
Subject: Re: [PATCH] security, lsm: dentry_init_security() Handle multi LSM registration
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, ceph-devel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Stephen Muth <smuth4@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 3:35 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> A ceph user has reported that ceph is crashing with kernel NULL pointer
> dereference. Following is the backtrace.
>
> /proc/version: Linux version 5.16.2-arch1-1 (linux@archlinux) (gcc (GCC)
> 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Thu, 20 Jan 2022
> 16:18:29 +0000
> distro / arch: Arch Linux / x86_64
> SELinux is not enabled
> ceph cluster version: 16.2.7 (dd0603118f56ab514f133c8d2e3adfc983942503)
>
> relevant dmesg output:
> [   30.947129] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [   30.947206] #PF: supervisor read access in kernel mode
> [   30.947258] #PF: error_code(0x0000) - not-present page
> [   30.947310] PGD 0 P4D 0
> [   30.947342] Oops: 0000 [#1] PREEMPT SMP PTI
> [   30.947388] CPU: 5 PID: 778 Comm: touch Not tainted 5.16.2-arch1-1 #1
> 86fbf2c313cc37a553d65deb81d98e9dcc2a3659
> [   30.947486] Hardware name: Gigabyte Technology Co., Ltd. B365M
> DS3H/B365M DS3H, BIOS F5 08/13/2019
> [   30.947569] RIP: 0010:strlen+0x0/0x20
> [   30.947616] Code: b6 07 38 d0 74 16 48 83 c7 01 84 c0 74 05 48 39 f7 75
> ec 31 c0 31 d2 89 d6 89 d7 c3 48 89 f8 31 d2 89 d6 89 d7 c3 0
> f 1f 40 00 <80> 3f 00 74 12 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 31
> ff
> [   30.947782] RSP: 0018:ffffa4ed80ffbbb8 EFLAGS: 00010246
> [   30.947836] RAX: 0000000000000000 RBX: ffffa4ed80ffbc60 RCX:
> 0000000000000000
> [   30.947904] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   30.947971] RBP: ffff94b0d15c0ae0 R08: 0000000000000000 R09:
> 0000000000000000
> [   30.948040] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000
> [   30.948106] R13: 0000000000000001 R14: ffffa4ed80ffbc60 R15:
> 0000000000000000
> [   30.948174] FS:  00007fc7520f0740(0000) GS:ffff94b7ced40000(0000)
> knlGS:0000000000000000
> [   30.948252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   30.948308] CR2: 0000000000000000 CR3: 0000000104a40001 CR4:
> 00000000003706e0
> [   30.948376] Call Trace:
> [   30.948404]  <TASK>
> [   30.948431]  ceph_security_init_secctx+0x7b/0x240 [ceph
> 49f9c4b9bf5be8760f19f1747e26da33920bce4b]
> [   30.948582]  ceph_atomic_open+0x51e/0x8a0 [ceph
> 49f9c4b9bf5be8760f19f1747e26da33920bce4b]
> [   30.948708]  ? get_cached_acl+0x4d/0xa0
> [   30.948759]  path_openat+0x60d/0x1030
> [   30.948809]  do_filp_open+0xa5/0x150
> [   30.948859]  do_sys_openat2+0xc4/0x190
> [   30.948904]  __x64_sys_openat+0x53/0xa0
> [   30.948948]  do_syscall_64+0x5c/0x90
> [   30.948989]  ? exc_page_fault+0x72/0x180
> [   30.949034]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   30.949091] RIP: 0033:0x7fc7521e25bb
> [   30.950849] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00
> 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 0
> 0 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14
> 25
>
> Core of the problem is that ceph checks for return code from
> security_dentry_init_security() and if return code is 0, it assumes
> everything is fine and continues to call strlen(name), which crashes.
>
> Typically SELinux LSM returns 0 and sets name to "security.selinux" and
> it is not a problem. Or if selinux is not compiled in or disabled, it
> returns -EOPNOTSUP and ceph deals with it.
>
> But somehow in this configuration, 0 is being returned and "name" is
> not being initialized and that's creating the problem.
>
> Our suspicion is that BPF LSM is registering a hook for
> dentry_init_security() and returns hook default of 0.
>
> LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,...)
>
> I have not been able to reproduce it just by doing CONFIG_BPF_LSM=y.
> Stephen has tested the patch though and confirms it solves the problem
> for him.
>
> dentry_init_security() is written in such a way that it expects only one
> LSM to register the hook. Atleast that's the expectation with current code.
>
> If another LSM returns a hook and returns default, it will simply return
> 0 as of now and that will break ceph.
>
> Hence, suggestion is that change semantics of this hook a bit. If there
> are no LSMs or no LSM is taking ownership and initializing security context,
> then return -EOPNOTSUP. Also allow at max one LSM to initialize security
> context. This hook can't deal with multiple LSMs trying to init security
> context. This patch implements this new behavior.
>
> Reported-by: Stephen Muth <smuth4@gmail.com>
> Tested-by: Stephen Muth <smuth4@gmail.com>
> Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: <stable@vger.kernel.org> # 5.16.0
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |    2 +-
>  security/security.c           |   15 +++++++++++++--
>  2 files changed, 14 insertions(+), 3 deletions(-)

Thanks for putting this patch together Vivek.

Acked-by: Paul Moore <paul@paul-moore.com>

> Index: redhat-linux/include/linux/lsm_hook_defs.h
> ===================================================================
> --- redhat-linux.orig/include/linux/lsm_hook_defs.h     2022-01-24 14:56:14.338030140 -0500
> +++ redhat-linux/include/linux/lsm_hook_defs.h  2022-01-25 18:48:46.917496696 -0500
> @@ -80,7 +80,7 @@ LSM_HOOK(int, 0, sb_clone_mnt_opts, cons
>          unsigned long *set_kern_flags)
>  LSM_HOOK(int, 0, move_mount, const struct path *from_path,
>          const struct path *to_path)
> -LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
> +LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
>          int mode, const struct qstr *name, const char **xattr_name,
>          void **ctx, u32 *ctxlen)
>  LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
> Index: redhat-linux/security/security.c
> ===================================================================
> --- redhat-linux.orig/security/security.c       2022-01-25 18:46:59.166496696 -0500
> +++ redhat-linux/security/security.c    2022-01-26 14:31:43.454568468 -0500
> @@ -1048,8 +1048,19 @@ int security_dentry_init_security(struct
>                                   const char **xattr_name, void **ctx,
>                                   u32 *ctxlen)
>  {
> -       return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
> -                               name, xattr_name, ctx, ctxlen);
> +       struct security_hook_list *hp;
> +       int rc;
> +
> +       /*
> +        * Only one module will provide a security context.
> +        */
> +       hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security, list) {
> +               rc = hp->hook.dentry_init_security(dentry, mode, name,
> +                                                  xattr_name, ctx, ctxlen);
> +               if (rc != LSM_RET_DEFAULT(dentry_init_security))
> +                       return rc;
> +       }
> +       return LSM_RET_DEFAULT(dentry_init_security);
>  }
>  EXPORT_SYMBOL(security_dentry_init_security);

-- 
paul-moore.com
