Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBAB510615
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348194AbiDZSBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347438AbiDZSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:01:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D64BBA0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:58:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg25so11017144wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hZvovRgEONI0evmHfh/dPYE5MYM2igj+YD6jKDmNGA=;
        b=mz/MOvI0F4FWfJZejeJKrAYFuv17SumJoq0jtd/G81PYn06FXP/RonNwOrhy/XMXlE
         85HYzD5ezQznisBUjcu0+ElntaokFyL5kCgIyauuLv1DjZdkq50qZPkvL+LFmNTg6VFw
         pT5GaLO7BEmfw3mNoNWuEFJMnBF5rLO1Tz9QhW/TpgilxHea0wVarwoAAypHTQuV4ohD
         3dT3NLalmx3mti9z6z8jEgtriNvtcI9ZEV1KSfieaW+eJ3E0CJShBCXwKHX7QhWHvsFR
         EfJUWi2M5rKo/ZWqbRW/Pl+hFmVQgSqufCiKOqX1xehrsn1+YStcY7+Sz6NgecE2oiWr
         j2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hZvovRgEONI0evmHfh/dPYE5MYM2igj+YD6jKDmNGA=;
        b=bEHK8hhHIQckAST+eyS9/NcR86785CBcnBFiJBANqTja1xh9FgC852Fzlf+tXdQj0o
         BMzrMFu0F+ZzC5lcXkNkjfPS29n71sS5Bg/0yKiEee3N0BjNr8qibFZCE5ZdTyTtItZw
         eDCgh2pjYT7hSu7sUB+Mi7TQYAo61jAemOSig7TBqom+PYokGVZHlhCTXfDhJnGMVlQB
         eKVaHyNSZ6qPjlV8yzVLMC3ykuFuax1cKAhIfeqx6taDk349993v/SHLyp+/81MwFs0L
         nhI1sp69amR7HW6PkX5OKIQGKs6LL7CwqZtkA3ZTkba/6Wfv8qayG4XJujGFWyIOBusY
         TmnA==
X-Gm-Message-State: AOAM531PTFRkUMOM+luVbBMuyANHlh+bKbXcwF7Is+gbFBM1/23PGjj3
        RoScqwyrpeVX86vicEvP/Pg+Erp052Ryb4z0+VCB
X-Google-Smtp-Source: ABdhPJzNwSILdb0ld2EVSSHHV+FNqqsmoxlGljFVPtAr+Z77PHjh1O4gx3EDrGPncUha4nTXOKAzbWBCOy4QQoeOZU0=
X-Received: by 2002:a05:600c:1456:b0:38e:bd55:700 with SMTP id
 h22-20020a05600c145600b0038ebd550700mr22111097wmi.204.1650995886423; Tue, 26
 Apr 2022 10:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-23-casey@schaufler-ca.com> <c196795a-910a-1e70-4809-c96717767e39@canonical.com>
In-Reply-To: <c196795a-910a-1e70-4809-c96717767e39@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Apr 2022 13:57:55 -0400
Message-ID: <CAHC9VhRhDGMUH-WfyoMDLdDFWbzTcDGhKFZNB22-Ha3dhUKyCQ@mail.gmail.com>
Subject: Re: [PATCH v35 22/29] Audit: Keep multiple LSM data in audit_names
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 7:32 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/18/22 07:59, Casey Schaufler wrote:
> > Replace the osid field in the audit_names structure
> > with a lsmblob structure. This accomodates the use
> > of an lsmblob in security_audit_rule_match() and
> > security_inode_getsecid().
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  kernel/audit.h   |  2 +-
> >  kernel/auditsc.c | 22 ++++++++--------------
> >  2 files changed, 9 insertions(+), 15 deletions(-)

...

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 231631f61550..6fe9f2525fc1 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -700,17 +700,16 @@ static int audit_filter_rules(struct task_struct *tsk,
> >                                        * lsmblob, which happens later in
> >                                        * this patch set.
> >                                        */
> > -                                     lsmblob_init(&blob, name->osid);
> >                                       result = security_audit_rule_match(
> > -                                                             &blob,
> > +                                                             &name->lsmblob,
> >                                                               f->type,
> >                                                               f->op,
> >                                                               &f->lsm_rules);
> >                               } else if (ctx) {
> >                                       list_for_each_entry(n, &ctx->names_list, list) {
> > -                                             lsmblob_init(&blob, n->osid);
> >                                               if (security_audit_rule_match(
> > -                                                     &blob, f->type, f->op,
> > +                                                     &n->lsmblob,
> > +                                                     f->type, f->op,
> >                                                       &f->lsm_rules)) {
> >                                                       ++result;
> >                                                       break;
> > @@ -1589,13 +1588,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
> >                                from_kgid(&init_user_ns, n->gid),
> >                                MAJOR(n->rdev),
> >                                MINOR(n->rdev));
> > -     if (n->osid != 0) {
> > -             struct lsmblob blob;
> > +     if (lsmblob_is_set(&n->lsmblob)) {
> >               struct lsmcontext lsmctx;
> >
> > -             lsmblob_init(&blob, n->osid);
> > -             if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
> > -                     audit_log_format(ab, " osid=%u", n->osid);
> > +             if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
> > +                                          LSMBLOB_FIRST)) {
> > +                     audit_log_format(ab, " osid=?");
>
> is there something better we can do here? This feels like a regression

Unfortunately no, or at least nothing has been suggested that is an
improvement on this approach.  We could overload the existing field,
but that runs the risk of confusing userspace tooling and potentially
bumping into the buffer limit in some more complex configurations.
The "?" value was chosen as it is a commonly accepted way for the
audit subsystem to indicate that a value is "missing" and in the case
of new/updated userspace tooling this would be an indication to look
for the new record type which provides all of the necessary LSM
labels.  In the case of old/unaware userspace tooling it would serve
as a graceful indicator that something is awry, i.e. you are using new
kernel functionality without updating your userspace.

-- 
paul-moore.com
