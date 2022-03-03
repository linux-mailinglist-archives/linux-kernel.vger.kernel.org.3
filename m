Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81944CCA17
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiCCXhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiCCXhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:37:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EE11688FF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:36:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d10so13930873eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 15:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nb52pq5dwlw/x2u3OPYN+2SF0B5k1laAEuKkJVbBr4o=;
        b=rJI2DXVkWPj5uDVV0a8h5IZT2qmRhjPy258S2ixfFAGCehG0NCvnOlSViiq6a1MhOo
         mzLWojJ/hVPjpgDAqqdV7MT+jyulaMBvHAq7ga/tjZ2AXvzf9VxNNddJoZgHsrKHRT83
         HxRzOFKI2w7lc/5qrh9Fls1oUYcxI52mfYK1+Vi7xwLm5ZN9TJsvdWC5tK9qdX88u4Jr
         htOrf1pbbdADBOa5eozZpLpTeMhBwA2OKENPEhcnKPk/bGvqTIXeefXHR2CaZdSL4Do6
         FFnSFbh73hVAy9UwZWt7wVHs5XBvmCLekoLpCC9XwpFLuf+EkOtrtwd56DEg8YjlFtDo
         QkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nb52pq5dwlw/x2u3OPYN+2SF0B5k1laAEuKkJVbBr4o=;
        b=MzLTl0nXrojbjjuJkiawF9A3OaPpXv2gDiyDwOyHmJOIZxVWomjaN6VeBxyKB3SHLR
         ctHhehbJBh1ZXyGpp90JEtL/qwa/ijsnLglxpBETafhEXbHliLzvbV+mELzIDpdLwd92
         vikVH/HHpQZCmmGqlzQ4bpX3ovkoZtfQb36yEGT0eq/Slr/L8iptQL09ATBr4fS7IWXi
         n/UYbC4Yq6JFUDclVUOh5Xb+oe4i/7z71zTzwUoc6cS+lfd8eej4MxXUPPzPQ0s24Lom
         /eOxc1ucBvv56fyY72xJoPsHP4DblCYRkxzLzY0zHRCs3xppMTmbvLA+M/U5PtcOVnPu
         shZA==
X-Gm-Message-State: AOAM533LgkMEzkC06NqyuCcQO1qTvYQLeCehbe7PTaKCTE3EMjhEx6wQ
        c6HHcjAHjcbfFqof11xI0sX87ss808S2MThuEc1w
X-Google-Smtp-Source: ABdhPJxKEAyDYNVXQ2OKTY1WIHVsrCxubx7bpOujfmBHDjh52hmHm4rYHPPHBUaDP2eSDbwDexxPo3qbkEM9473s3os=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr9031911ejc.701.1646350588003; Thu, 03
 Mar 2022 15:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20220202235323.23929-1-casey@schaufler-ca.com> <20220202235323.23929-27-casey@schaufler-ca.com>
In-Reply-To: <20220202235323.23929-27-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Mar 2022 18:36:17 -0500
Message-ID: <CAHC9VhR3d23Zd8=cP1=Sh5DjTEgEAyTc71M-zca4Beuiw7bywQ@mail.gmail.com>
Subject: Re: [PATCH v32 26/28] Audit: Add record for multiple object security contexts
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 7:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
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
>  include/linux/audit.h      |  5 ++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 59 ++++++++++++++++++++++++++++++++++++++
>  kernel/auditsc.c           | 37 ++++--------------------
>  4 files changed, 70 insertions(+), 32 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index e8744e80ef21..3b9ce617b150 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2199,6 +2200,43 @@ int audit_log_task_context(struct audit_buffer *ab)
>  }
>  EXPORT_SYMBOL(audit_log_task_context);
>
> +void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
> +{
> +       struct audit_context_entry *ace;
> +       struct lsmcontext context;
> +       int error;
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
> +               /*
> +                * If there is more than one security module that has a
> +                * object "context" it's necessary to put the object data
> +                * into a separate record to maintain compatibility.
> +                */

I know this is nitpicky, but I'm going to say it anyway ... the
separate record isn't purely for compatibility reasons, it's for size
reasons.  There is a fear that multiple LSM labels could blow past the
record size limit when combined with other fields, so putting them in
their own dedicated record gives us more room.  If that wasn't the
case we could just tack them on the end of existing records.

However, converting the existing "obj=" field into "obj=?" when
multiple LSM labels are present *is* a compatibility nod as it allows
existing userspace tooling that expects a single "obj=" field to
continue to work.

> +               audit_log_format(ab, " obj=?");
> +               ace = kzalloc(sizeof(*ace), ab->gfp_mask);
> +               if (!ace)
> +                       goto error_path;
> +               INIT_LIST_HEAD(&ace->list);
> +               ace->type = AUDIT_MAC_OBJ_CONTEXTS;
> +               ace->lsm_objs = *blob;
> +               list_add(&ace->list, &ab->aux_records);
> +       }
> +       return;
> +
> +error_path:
> +       audit_panic("error in audit_log_object_context");
> +}
> +EXPORT_SYMBOL(audit_log_object_context);
> +

-- 
paul-moore.com
