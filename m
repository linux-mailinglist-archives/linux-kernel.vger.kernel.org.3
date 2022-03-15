Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10CE4DA66E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352634AbiCOXtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352621AbiCOXtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:49:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923DF19280
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:48:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb39so905087ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55uBJNGfFSwhoL7ti2OP1GOHOeKbzGbKL1QmB15AYo8=;
        b=sHGF0vbCsbUzF8D2X3d4wLrBtJv+2CBMBqG9v7oZWfpbkvpwCFDmx9dm2522Nm3A9N
         eSL/6x/sXOfvWNyp1Bv0KLQI3fms81caiywr6HKDruGB7cLN44HbnUfBD3Mow3qguhsq
         W7+FFV+M08CZg80uqVMq0VkkyL4w7aq5SHB1F7fffzvEgQVbQbq9RqXcPxr+TNvR1CiI
         tZWZq2TJ1BCSiqvl41Y5+1ZaJazqH0hBmWjOBmM5+uc2UEVMIPI46ZEXMDRZ95EXdmCA
         1QiIjd9jUPZ9musFpKKEAJxR/a/LOu/V4NmP0iFkFT/oOeYZmzeCCZuHdxKw9I/UcyZC
         4r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55uBJNGfFSwhoL7ti2OP1GOHOeKbzGbKL1QmB15AYo8=;
        b=bFIAsI9m5xDxfe/rLWVfNJun/7tAT7jzEGFpm8+iTND17cQ/iknyINBMmJ4i3XDEy9
         TQJAm0OYNIjBwGU9P+bF1XT8f2YoHvI6DX3e6ohE9MAIUQb9NPKNRno4PY0HPH872/iZ
         pF63BjnhZkrx+j9Xuy+BVbyBraSRedBr5glideTdMJ46eqP3vCvHzPyaDKzmH+wWr9HV
         B4zIfoS14vSWxYPCghWnjwiAZ23MXh3peS95HYZBy5BIFe9cz2YutcpsWEnpB3BJJkOJ
         gf5YjO9pMY/UTy+VN5yt4rdXnpHVdRqRJEn7KW9HU3bwciM3UFAv/pPCM82ZIB75JyNC
         diOQ==
X-Gm-Message-State: AOAM53182bOP+t5DNKVQH3PTlOKHJyY/yv5PgMIE8jc+CCl6BLnqWuh0
        xmPRHRSeX4QvBDhlNfML61Ar9Yuih5+/aDaEuWly
X-Google-Smtp-Source: ABdhPJxXSbQSSBAAgk0E/lOTRNDBp736WROX3nbU+C3kqyr313Q2wEQp0EC3OLZ2gWYAfHoqyp64mxGxkE7iBomcGoo=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr24777721ejb.517.1647388081861; Tue, 15
 Mar 2022 16:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234632.16194-1-casey@schaufler-ca.com> <20220310234632.16194-28-casey@schaufler-ca.com>
In-Reply-To: <20220310234632.16194-28-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Mar 2022 19:47:50 -0400
Message-ID: <CAHC9VhQWv+04hETu3keU7Ev2nLn5MARW2R_p5hKVp3OfhD185A@mail.gmail.com>
Subject: Re: [PATCH v33 27/29] Audit: Add record for multiple object security contexts
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 7:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1421) record is:
>
>     type=MAC_OBJ_CONTEXTS[1421]
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
>
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  5 +++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 47 +++++++++++++++++++++++
>  kernel/auditsc.c           | 79 ++++++++++++--------------------------
>  4 files changed, 77 insertions(+), 55 deletions(-)

...

> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index af0aaccfaf57..d25d76b29e3c 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -144,6 +144,7 @@
>  #define AUDIT_MAC_CALIPSO_ADD  1418    /* NetLabel: add CALIPSO DOI entry */
>  #define AUDIT_MAC_CALIPSO_DEL  1419    /* NetLabel: del CALIPSO DOI entry */
>  #define AUDIT_MAC_TASK_CONTEXTS        1420    /* Multiple LSM task contexts */
> +#define AUDIT_MAC_OBJ_CONTEXTS 1421    /* Multiple LSM objext contexts */
>
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index ad825af203cf..ac92e7fc5aa6 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2202,6 +2202,53 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
>         ab->skb = skb_peek(&ab->skb_list);
>  }
>
> +void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
> +{
> +       int i;
> +       int error;
> +       struct lsmcontext context;
> +
> +       if (!lsm_multiple_contexts()) {
> +               error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
> +               if (error) {
> +                       if (error != -EINVAL)
> +                               goto error_path;
> +                       return;
> +               }
> +               audit_log_format(ab, " obj=%s", context.context);
> +               security_release_secctx(&context);
> +       } else {
> +               audit_log_format(ab, " obj=?");
> +               error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
> +               if (error)
> +                       goto error_path;
> +
> +               for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +                       if (blob->secid[i] == 0)
> +                               continue;
> +                       error = security_secid_to_secctx(blob, &context, i);
> +                       if (error) {
> +                               if (error != -EINVAL)
> +                                       audit_panic("error in audit_log_object_context");
> +                               audit_log_format(ab, "%sobj_%s=?",
> +                                                i ? " " : "",
> +                                                lsm_slot_to_name(i));
> +                       } else {
> +                               audit_log_format(ab, "%sobj_%s=%s",
> +                                                i ? " " : "",
> +                                                lsm_slot_to_name(i),
> +                                                context.context);
> +                               security_release_secctx(&context);
> +                       }
> +               }
> +
> +               audit_buffer_aux_end(ab);
> +       }
> +       return;
> +
> +error_path:
> +       audit_panic("error in audit_log_object_context");
> +}

The comment from patch 26/29 regarding the audit_panic() placement
also applies to audit_log_object_context().

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 7848e7351cf9..923e4e3a5697 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1114,36 +1114,25 @@ static inline void audit_free_context(struct audit_context *context)
>         kfree(context);
>  }
>
> -static int audit_log_pid_context(struct audit_context *context, pid_t pid,
> -                                kuid_t auid, kuid_t uid,
> -                                unsigned int sessionid,
> -                                struct lsmblob *blob, char *comm)
> +static void audit_log_pid_context(struct audit_context *context, pid_t pid,
> +                                 kuid_t auid, kuid_t uid,
> +                                 unsigned int sessionid,
> +                                 struct lsmblob *blob, char *comm)
>  {
>         struct audit_buffer *ab;
> -       struct lsmcontext lsmctx;
> -       int rc = 0;
>
>         ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>         if (!ab)
> -               return rc;
> +               return;
>
>         audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>                          from_kuid(&init_user_ns, auid),
>                          from_kuid(&init_user_ns, uid), sessionid);
> -       if (lsmblob_is_set(blob)) {
> -               if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
> -                       audit_log_format(ab, " obj=(none)");
> -                       rc = 1;
> -               } else {
> -                       audit_log_format(ab, " obj=%s", lsmctx.context);
> -                       security_release_secctx(&lsmctx);
> -               }
> -       }
> +       if (lsmblob_is_set(blob))
> +               audit_log_object_context(ab, blob);
>         audit_log_format(ab, " ocomm=");
>         audit_log_untrustedstring(ab, comm);
>         audit_log_end(ab);
> -
> -       return rc;
>  }
>
>  static void audit_log_execve_info(struct audit_context *context,
> @@ -1373,18 +1362,10 @@ static void show_special(struct audit_context *context, int *call_panic)
>                                  from_kgid(&init_user_ns, context->ipc.gid),
>                                  context->ipc.mode);
>                 if (osid) {
> -                       struct lsmcontext lsmcxt;
>                         struct lsmblob blob;
>
>                         lsmblob_init(&blob, osid);
> -                       if (security_secid_to_secctx(&blob, &lsmcxt,
> -                                                    LSMBLOB_FIRST)) {
> -                               audit_log_format(ab, " osid=%u", osid);
> -                               *call_panic = 1;
> -                       } else {
> -                               audit_log_format(ab, " obj=%s", lsmcxt.context);
> -                               security_release_secctx(&lsmcxt);
> -                       }
> +                       audit_log_object_context(ab, &blob);

While we lose the "osid=X" in case of failure, the secid/SID is a
private kernel value meaning it was always of questionable value.


--
paul-moore.com
