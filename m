Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13957AD45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbiGTBlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbiGTBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:40:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6A7AB22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:32:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so1322384wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFJ7CZhIyt7Ssrykbv8kM2S+JMXiMSgZGBb+WDmkybI=;
        b=GQBSn18YXc5a1Vg115mj7mzNNR3H9JpDcz/bapsgiFbNzf+3zZ5JPHxQ67bvQ0C+Q6
         39K7vJACGmZEVMV8wBg2DnXlsV2v97MwvLULYiSiFau6hIQ9Y0cjyC3TNDxlXImxA+m2
         E3UVbO4IDqtJHKRo1WddtroXHK3Z6XFxoZXhwaMZkvdRkyUNQVo+u9Qs+8CqXituAktq
         9GRmIFiWRRMruWoPCuFmOarxs/Tc8AzI4kPAAB/WRS0+xpkx6xAKU4CiENIt7LkpcPkd
         Fv6PjYDHfMxzyd+/M+EO3B73gT7XcDR7/eNUuaO3Pivmgus+b9tb7L2C7x8Eh7Wbmk+t
         V7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFJ7CZhIyt7Ssrykbv8kM2S+JMXiMSgZGBb+WDmkybI=;
        b=B+QAqpSsB79kIJK0E4TpvXGmBk+PCRDxfEnuUzVW0fW6rEyTpYcuXkCjAaE//sqhOa
         RdrLjk3EYbP/mjEoOUVF7S7WvRboYQ772svLbiISW59XhJ2S0L/ObAy75Hmsftei2e6a
         hUTBQug3nsgj0hr16jpzNHrcbvaGtKTHTQWgSQ73Ka7HUJYOQVS1IlphDP+KExog60dV
         pAEzaIXQKkjPXtLTAQZXM8p/jp3GuELvdrMIGY2nTx0Won13a0/zYfUwrSRdU2IQSpqD
         uhXgKxrSY7dmzyGyhlW8xoAp5a9BUR+rh7UKozVjkxgkFGokTnsSoSYlXwJ4h53zN+us
         GE1A==
X-Gm-Message-State: AJIora9lUDhMPUZTiSsBcKoTjL0zrTubEWE66dVbJjSPJVXBQneuKOus
        pKyR2CMxwBv9EY3Mcj+IfoidxnRmY7iy9d/f2zAk
X-Google-Smtp-Source: AGRyM1uWDMAPpLcAcuhuXmGi220naKmTccHLcXTkaRT/NUDVG1/wgr1FCbEQ6qb3r+rzrfrLeILxcvpi7tI7/QDmcUg=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr28631806wrp.161.1658280746684; Tue, 19
 Jul 2022 18:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220707223228.1940249-1-fred@cloudflare.com> <20220707223228.1940249-5-fred@cloudflare.com>
In-Reply-To: <20220707223228.1940249-5-fred@cloudflare.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jul 2022 21:32:15 -0400
Message-ID: <CAHC9VhTkvPvqGQjyEKbi2pkKBtRQE=Uat34aoKsxjWU0qkF6CA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selinux: Implement create_user_ns hook
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 6:32 PM Frederick Lawler <fred@cloudflare.com> wrote:
>
> Unprivileged user namespace creation is an intended feature to enable
> sandboxing, however this feature is often used to as an initial step to
> perform a privilege escalation attack.
>
> This patch implements a new namespace { userns_create } access control
> permission to restrict which domains allow or deny user namespace
> creation. This is necessary for system administrators to quickly protect
> their systems while waiting for vulnerability patches to be applied.
>
> This permission can be used in the following way:
>
>         allow domA_t domB_t : namespace { userns_create };
>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
>
> ---
> Changes since v1:
> - Introduce this patch
> ---
>  security/selinux/hooks.c            | 9 +++++++++
>  security/selinux/include/classmap.h | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index beceb89f68d9..73fbcb434fe0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4227,6 +4227,14 @@ static void selinux_task_to_inode(struct task_struct *p,
>         spin_unlock(&isec->lock);
>  }
>
> +static int selinux_userns_create(const struct cred *cred)
> +{
> +       u32 sid = current_sid();
> +
> +       return avc_has_perm(&selinux_state, sid, sid, SECCLASS_NAMESPACE,
> +                                               NAMESPACE__USERNS_CREATE, NULL);
> +}

As we continue to discuss this, I'm beginning to think that having a
dedicated object class for the userns might be a good idea.  I believe
I was the one who gave you these code snippets, so feel free to blame
me for the respin ;)

This is what I'm thinking:

  static int selinux_userns_create(const struct cred *cred)
  {
    u32 sid = current_sid();

    return avc_has_perm(&selinux_state, sid, sid,
                        SECCLASS_USER_NAMESPACE,
                        USER_NAMESPACE__CREATE, NULL);
  }

> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index ff757ae5f253..9943e85c6b3e 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -254,6 +254,8 @@ const struct security_class_mapping secclass_map[] = {
>           { COMMON_FILE_PERMS, NULL } },
>         { "io_uring",
>           { "override_creds", "sqpoll", NULL } },
> +       { "namespace",
> +         { "userns_create", NULL } },

The above would need to change to:

  { "user_namespace",
    { "create", NULL } }

-- 
paul-moore.com
