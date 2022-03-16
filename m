Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D04DA736
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352879AbiCPBJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348762AbiCPBJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:09:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8000243EE2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:08:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dr20so1127733ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4yJTBFrYxfC9d71JFIt7TJ1Pyac9aie49haagZLT7M=;
        b=3gDlKTc4TJ5D37yFflHfb3SjMMeRE6vABJRAxukK3Wbi9sS86YcFxRL/T+d7J0y+rW
         kgf5CLNBMiGVhrblLVvXHsM4xVl8lKjQ2Aaxod5fquAk3Sw6F5Xo77feHzQfr6DzN6fA
         Vto75EWTlMCvkOmoXymTVFMduLDSYEg98V1xl56vheSaEh2N20EZF95fEFA50i+rkirG
         19QNzBGD43yNleI5RahGLzuq54uKlRleHuHvG+1HDnXxei/ukuUKiWad494s+nR+G27I
         W3YSuzYNlf9Fr/gmNE+2DIP+I77g+dLK7bxpi8JFVbA6sfDc+0B7vwsGv9t5bllW1hFH
         K8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4yJTBFrYxfC9d71JFIt7TJ1Pyac9aie49haagZLT7M=;
        b=nxfvKlCQOWrnpJcXyWoBxEMjYQc7ZklRUkofvtXW3Na1BnqawaD5PvtytGT+ayYmrs
         X5OVlmIKsEUm8UDwIrh7uEmKcxLWY5VZs5qyvoaBPDskAJQWsgHYk1i3oU7+Yrm81pz/
         TpzjJGKficaYjewjwKdAc0LHHe+9nEdZZZtfcAPN4PLyoNqActm3cbtCFBvykuAmCrQC
         ys0G6ECuBn3ta75HW5Re018CnanJVRBwRkix/W4cCOjoLshjl/C9Dj97LBXJnzILnVjU
         Xjp6ilimXipxXqtZPRB8E/dFL4spyjPjXWrIEsdLQFo46cyQf0JgJLLy2NNeE2N5IN1t
         UR+Q==
X-Gm-Message-State: AOAM532Tq2iuXb8BSBqpiqkk1FL1k+3TEHOPUOlVHxuvMI0isvG9kfmq
        AmW7zy0FLbeW7BgwnQYZ5LzC8rihod2zmegkFxg1
X-Google-Smtp-Source: ABdhPJz+3ez8xrnU+3o745dhyZ/+LfaOfJ4CIyYsCJwxt1BoOAITZMIZnjbEyIlJbjF9qDPVb/2j1V8hj1Wa86guV90=
X-Received: by 2002:a17:907:9803:b0:6db:ab21:738e with SMTP id
 ji3-20020a170907980300b006dbab21738emr17937334ejc.112.1647392915955; Tue, 15
 Mar 2022 18:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234632.16194-1-casey@schaufler-ca.com>
 <20220310234632.16194-28-casey@schaufler-ca.com> <CAHC9VhQWv+04hETu3keU7Ev2nLn5MARW2R_p5hKVp3OfhD185A@mail.gmail.com>
 <987800d2-797c-e780-60f5-0e499081572f@schaufler-ca.com>
In-Reply-To: <987800d2-797c-e780-60f5-0e499081572f@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Mar 2022 21:08:24 -0400
Message-ID: <CAHC9VhSYYy2_cTqZuDrVdoCboMeaUPy0a-1ArRpAhiMYr58r3g@mail.gmail.com>
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

On Tue, Mar 15, 2022 at 8:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/15/2022 4:47 PM, Paul Moore wrote:
> > On Thu, Mar 10, 2022 at 7:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> >> An example of the MAC_OBJ_CONTEXTS (1421) record is:
> >>
> >>      type=MAC_OBJ_CONTEXTS[1421]
> >>      msg=audit(1601152467.009:1050):
> >>      obj_selinux=unconfined_u:object_r:user_home_t:s0
> >>
> >> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> >> the "obj=" field in other records in the event will be "obj=?".
> >> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> >> multiple security modules that may make access decisions based
> >> on an object security context.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>   include/linux/audit.h      |  5 +++
> >>   include/uapi/linux/audit.h |  1 +
> >>   kernel/audit.c             | 47 +++++++++++++++++++++++
> >>   kernel/auditsc.c           | 79 ++++++++++++--------------------------
> >>   4 files changed, 77 insertions(+), 55 deletions(-)

...

> >> @@ -1373,18 +1362,10 @@ static void show_special(struct audit_context *context, int *call_panic)
> >>                                   from_kgid(&init_user_ns, context->ipc.gid),
> >>                                   context->ipc.mode);
> >>                  if (osid) {
> >> -                       struct lsmcontext lsmcxt;
> >>                          struct lsmblob blob;
> >>
> >>                          lsmblob_init(&blob, osid);
> >> -                       if (security_secid_to_secctx(&blob, &lsmcxt,
> >> -                                                    LSMBLOB_FIRST)) {
> >> -                               audit_log_format(ab, " osid=%u", osid);
> >> -                               *call_panic = 1;
> >> -                       } else {
> >> -                               audit_log_format(ab, " obj=%s", lsmcxt.context);
> >> -                               security_release_secctx(&lsmcxt);
> >> -                       }
> >> +                       audit_log_object_context(ab, &blob);
> > While we lose the "osid=X" in case of failure, the secid/SID is a
> > private kernel value meaning it was always of questionable value.
>
> I could come up with a change to audit_log_object_context() that
> would put out an osid= in the single security module case. I would
> prefer not to if that would be acceptable.

What I think you have right now is fine.  I thought others might point
out the field differences so I was trying to say that the existing
code really isn't very useful in case of error, there is no practical
way for someone in userspace to do anything meaningful with an
osid/secid/SID value as they are transient kernel-private values.

My apologies for the confusion.

-- 
paul-moore.com
