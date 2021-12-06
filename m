Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FCA468F47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhLFCry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbhLFCrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:47:53 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67877C061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 18:44:25 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r11so36654960edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 18:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jolb7Z2E3vQPbl5IKSlRQLil6VgsmE1hIu1eFEbQx74=;
        b=NMyAehe6JFrvDzK0o0k7ivWHR/WAgEYmeG+ZSsEKSr1OF56N6qvSfnMUIJE72ZNfLC
         3C0NDd3FKEujWoJuLUlLjiLO/O13sJbdj0gmzJgss4YqdSzo+C898LLfqNZFEgdsjLFn
         UX1QukprgJMj5fTLkRrjK6/alcGWQF8mW6aMo335/jtGkLkjRo0QER1/4SISoqAEnfbl
         0eONp2bTGmI+HWyoSmUGoxQ+ndouumBaN53GUxgD/36HZppEqpyCUZXxBO8f22fuvDYu
         lm8WV2M3AOr145B2SCatd0cy0e9rfC7LCIwPrHLzBv12/5k0ZRxZx5UD+QAPD4FjqMtI
         wBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jolb7Z2E3vQPbl5IKSlRQLil6VgsmE1hIu1eFEbQx74=;
        b=zQbV/kNGbMyt3ktN7qMRdDKMRpYHEOoFJOVR5dbprw+QGeDiXBoPMOSdu8Vmw7Qv9D
         oJWiaG7WadJ0uiIfCe/et33wj+H9G1/NnKKo1iRBMvSS1MaoylLPWZopIYCAV3GID9tF
         wAyBtiWoxsgWnWIPU+n4bcAvjqma4s9RwKfZ7E1GzKUoy/s5b0NPPc/IrDEDx2AjzDe5
         JbeFRYJ8jC4xbSAdS5GD3xWLJ1UpG/ypq9OSWYUMlVF50+m9ZWGTafoWZu2An3LB3Fwh
         iF9HaQynHM65qcG+KJUUlaeosKOSbgK8pptvsd2ep0gphJyKa0/7EieQRSlqRMP9DLcX
         8Kig==
X-Gm-Message-State: AOAM5335f7dunn6nYcXw2hfp7L8titPQNzAoZZLkh8TztC02JebYjeJW
        oCb+ltYG6ZnkCuGBfqolag0cmkiBRkdwc6ukxeXC
X-Google-Smtp-Source: ABdhPJwRrhPSJNMuYDnyiTs9XT+eCI/7geA7mQVYBBaRGEqrkv/s51N3owOCPU+A7cUhUd/5tWXCxsHI4JIFMWpxV7U=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr42542158ejc.187.1638758663920;
 Sun, 05 Dec 2021 18:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-4-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-4-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:44:13 -0500
Message-ID: <CAHC9VhTOMt3NSvpJ2uE4tD4t3PTK6p6_ribSOXwRo8nucZ2XqA@mail.gmail.com>
Subject: Re: [PATCH v30 03/28] LSM: Add the lsmblob data structure.
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 8:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
>
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
>
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
>
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> A new structure audit_rules is defined to avoid the
> confusion which commonly accompanies the use of
> void ** parameters.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        | 10 ++++-
>  include/linux/lsm_hooks.h    | 12 +++++-
>  include/linux/security.h     | 74 +++++++++++++++++++++++++++++---
>  kernel/auditfilter.c         | 24 ++++++-----
>  kernel/auditsc.c             | 17 +++-----
>  security/apparmor/lsm.c      |  7 ++-
>  security/bpf/hooks.c         | 12 +++++-
>  security/commoncap.c         |  7 ++-
>  security/landlock/cred.c     |  2 +-
>  security/landlock/fs.c       |  2 +-
>  security/landlock/ptrace.c   |  2 +-
>  security/landlock/setup.c    |  5 +++
>  security/landlock/setup.h    |  1 +
>  security/loadpin/loadpin.c   |  8 +++-
>  security/lockdown/lockdown.c |  7 ++-
>  security/safesetid/lsm.c     |  8 +++-
>  security/security.c          | 82 ++++++++++++++++++++++++++++++------
>  security/selinux/hooks.c     |  8 +++-
>  security/smack/smack_lsm.c   |  7 ++-
>  security/tomoyo/tomoyo.c     |  8 +++-
>  security/yama/yama_lsm.c     |  7 ++-
>  21 files changed, 254 insertions(+), 56 deletions(-)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index d06134ac6245..943584128399 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -11,6 +11,7 @@
>
>  #include <linux/sched.h>
>  #include <linux/ptrace.h>
> +#include <linux/security.h>
>  #include <linux/audit_arch.h>
>  #include <uapi/linux/audit.h>
>  #include <uapi/linux/netfilter/nf_tables.h>
> @@ -59,6 +60,10 @@ struct audit_krule {
>  /* Flag to indicate legacy AUDIT_LOGINUID unset usage */
>  #define AUDIT_LOGINUID_LEGACY          0x1
>
> +struct audit_rules {
> +       void    *rule[LSMBLOB_ENTRIES];
> +};

It would be nice to call this struct "audit_lsm_rules" to help
distinguish it from general audit filter rules.

>  struct audit_field {
>         u32                             type;
>         union {
> @@ -66,8 +71,9 @@ struct audit_field {
>                 kuid_t                  uid;
>                 kgid_t                  gid;
>                 struct {
> -                       char            *lsm_str;
> -                       void            *lsm_rule;
> +                       bool                    lsm_isset;
> +                       char                    *lsm_str;
> +                       struct audit_rules      lsm_rules;
>                 };

Is lsm_isset strictly necessary?  Unless I missed something it seems
like a NULL check on lsm_str would serve the same purpose.

--
paul moore
www.paul-moore.com
