Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1E54A130
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiFMVSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352076AbiFMVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:17:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE246C89
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:00:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so13377384ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3pP4CUDi16OPdqz61PfqfFdQ3Rj/mvHUE3nwdWy4vY=;
        b=Xf8LMzKjbk+b55bDO0mBuR+UF0qvlWKx5z6+YUrGHK3R9b2cJHFIXwacUxmYBlCteL
         ZH/mNca1asTSoeNjBu1JtIV/TllMG97497AB4ZdnnUlwfpwx5RVYAJfRlegBcaYS6H8t
         O/oreJ10UWSczwuf7xTac2Ci2RLQ8efz0/fXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3pP4CUDi16OPdqz61PfqfFdQ3Rj/mvHUE3nwdWy4vY=;
        b=C3cE3Lqwy/C1nPSM1tmQN8YgsDLHAwuma08J8ZjDvmffdVUSOcSqUo2W2XzvDLSJit
         sI/4jP2oj9/A3AeepOVQQwZ3CFKi6fD5wAY/nLFNsmKXd856mbDabaW9aNnsu/cUAJjZ
         iTm4L9XyO3c6E7fI6fgLpw3lxVgpq0muBLyLnv1VufWNpPy1+ZTFurrpWH6PGmKza1bl
         4dzJQQgZgEjGzCgQzE5xgwVOEwGeevsl3AJv0sCyr2S3m2R3QP4ofAy49XJkqs/6bw5m
         nBd0EdWxwQrf6jfoVkzWFIHLaR6pkkWSdNDxvrV46ANyzRAhOfTcoxa9QIs9FiPRfesF
         /OYg==
X-Gm-Message-State: AOAM5336rd7H/v7f/aOu7gysNm2xSwT8InrODb4NEa8ltJdVbeXeWjBQ
        v0vgbcEScHo0KGE2aAJRYIZ4WQyO8PZZzm6I/7+LnA==
X-Google-Smtp-Source: AGRyM1ucT5R14o2oIO4/ePjhpMN27L5o4IEeZvgoyohkGgv/PQU7BQGgAMv2Xw1L0+4aHOZpAR5CsxBtgSenzyxfBGw=
X-Received: by 2002:a17:906:a0ce:b0:6d1:cb30:3b3b with SMTP id
 bh14-20020a170906a0ce00b006d1cb303b3bmr1411366ejb.582.1655154014725; Mon, 13
 Jun 2022 14:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220613202852.447738-1-mortonm@chromium.org>
In-Reply-To: <20220613202852.447738-1-mortonm@chromium.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 13 Jun 2022 14:00:03 -0700
Message-ID: <CAJ-EccOhrYG6n6As72R7YzSk+Zzy=oFFJ62hG9476njprpJuvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy handling
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 1:28 PM Micah Morton <mortonm@chromium.org> wrote:
>
> The SafeSetID LSM has functionality for restricting setuid()/setgid()
> syscalls based on its configured security policies. This patch adds the
> analogous functionality for the setgroups() syscall. Security policy
> for the setgroups() syscall follows the same policies that are
> installed on the system for setgid() syscalls.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> ---
> NOTE: this code does nothing to prevent a SafeSetID-restricted process
> with CAP_SETGID from dropping supplementary groups. I don't anticipate
> supplementary groups ever being used to restrict a process' privileges
> (rather than grant privileges), so I think this is fine for the
> purposes of SafeSetID.
>
> Developed on 5.18
>
>  security/safesetid/lsm.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 963f4ad9cb66..01c355e740aa 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -97,15 +97,9 @@ static int safesetid_security_capable(const struct cred *cred,
>                 return 0;
>
>         /*
> -        * If CAP_SET{U/G}ID is currently used for a setid() syscall, we want to
> -        * let it go through here; the real security check happens later, in the
> -        * task_fix_set{u/g}id hook.
> -         *
> -         * NOTE:
> -         * Until we add support for restricting setgroups() calls, GID security
> -         * policies offer no meaningful security since we always return 0 here
> -         * when called from within the setgroups() syscall and there is no
> -         * additional hook later on to enforce security policies for setgroups().
> +        * If CAP_SET{U/G}ID is currently used for a setid or setgroups syscall, we
> +        * want to let it go through here; the real security check happens later, in
> +        * the task_fix_set{u/g}id or task_fix_setgroups hooks.
>          */
>         if ((opts & CAP_OPT_INSETID) != 0)
>                 return 0;
> @@ -241,9 +235,36 @@ static int safesetid_task_fix_setgid(struct cred *new,
>         return -EACCES;
>  }
>
> +static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old)
> +{
> +       int i;
> +
> +       /* Do nothing if there are no setgid restrictions for our old RGID. */
> +       if (setid_policy_lookup((kid_t){.gid = old->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
> +               return 0;
> +
> +       get_group_info(new->group_info);
> +       for (i = 0; i < new->group_info->ngroups; i++) {
> +               if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {

Oops, should be:

!id_permitted_for_cred(old, (kid_t){.gid = new->group_info->gid[i]}, GID)

Guess I won't send a whole new patch just for that one line

> +                       put_group_info(new->group_info);
> +                       /*
> +                        * Kill this process to avoid potential security vulnerabilities
> +                        * that could arise from a missing allowlist entry preventing a
> +                        * privileged process from dropping to a lesser-privileged one.
> +                        */
> +                       force_sig(SIGKILL);
> +                       return -EACCES;
> +               }
> +       }
> +
> +       put_group_info(new->group_info);
> +       return 0;
> +}
> +
>  static struct security_hook_list safesetid_security_hooks[] = {
>         LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
>         LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
> +       LSM_HOOK_INIT(task_fix_setgroups, safesetid_task_fix_setgroups),
>         LSM_HOOK_INIT(capable, safesetid_security_capable)
>  };
>
> --
> 2.36.1.476.g0c4daa206d-goog
>
