Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE351063E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353656AbiDZSG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353590AbiDZSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:06:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C827CE6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:03:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v12so19750521wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+onuqX07NQLVnhG5hcq84PDJSKTGZ1KYCLEC+GQraSM=;
        b=g9bTjXUuVtqu1ley+eg3MvLbTvaYERrW5DcPicHR1kWNztwsyfpkcmbfZfHxABsFEg
         BVECFAUSQ9C//qUwXLRfuDlS0cyxk5b4cUZjKfeJ+Ficd/SCYht0Z5/7Qjw5F92uETD4
         W6PK89d0AnfnmFotKNSOfuyhYT3FTq2C9k5suv0XrHigSwB2KhAz3T+lcqNyl81W1NMk
         0F/9/3+MN7KCB3ETbGL1FeZbFzTTc70LjoPM8DwCwaPx+q+akt57kCMz6ivxKwRExdPG
         TxmSUhaNMXlfVjkeyaQHPVs/8m60zXsizWZsE/3vt/c/CXm23lSqE4zdSxOczOEOth03
         1gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+onuqX07NQLVnhG5hcq84PDJSKTGZ1KYCLEC+GQraSM=;
        b=G+XTvzH2jf05L9MzWeetLa0Yun0O/V7tGBRuAE303P23YUfhMZdxAQs6ZpnCSt72cW
         XikDnARxvF7uwW9pIM1LJNwf3365rYBcT4f6kQ6Xkz17P3ho36NNQKTse3ZyJ2GscO/+
         bAmDP2mEtAy5ftuEK3M0Dh8SLX6a3To4BlRqYWnTmvmPXEApp6atl1Wb9UloX3rPwVgK
         jUgPYYKltNpDKqGqQ4OzLNkEqi32IcJqs2qzvavFkeM0PSzu0Mcqesm5BSizfqEb/YyX
         LN5V5cc6HKp6ECj7jNqf7KwQS9lwBv5FxHZNZtRDbDdN0bLDZ3o0MYVw4cs5xRIMOBfs
         5NQA==
X-Gm-Message-State: AOAM533WmiRewxhvhKGYBRWEtnZayAACSy9O0wkBrnIJdDSm3GEdB5F7
        wjnNElXbcwpOgCj4RbMnngGe+9cQNlH+sWT/6cFN
X-Google-Smtp-Source: ABdhPJzvaHhm+gDkGIU/mLn3si/S7ZnD78mhxMStriKTtPLrrYOnHwrB/NGl572b3NM4JieS55hPLJOhkmHdpCMJq1E=
X-Received: by 2002:a5d:590d:0:b0:20a:c3eb:2584 with SMTP id
 v13-20020a5d590d000000b0020ac3eb2584mr18627797wrd.18.1650996193497; Tue, 26
 Apr 2022 11:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com> <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
In-Reply-To: <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Apr 2022 14:03:02 -0400
Message-ID: <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com>
Subject: Re: [PATCH v35 23/29] Audit: Create audit_stamp structure
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

On Mon, Apr 25, 2022 at 7:31 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/18/22 07:59, Casey Schaufler wrote:
> > Replace the timestamp and serial number pair used in audit records
> > with a structure containing the two elements.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  kernel/audit.c   | 17 +++++++++--------
> >  kernel/audit.h   | 12 +++++++++---
> >  kernel/auditsc.c | 22 +++++++++-------------
> >  3 files changed, 27 insertions(+), 24 deletions(-)

...

> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 4af63e7dde17..260dab6e0e15 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -108,10 +114,10 @@ struct audit_context {
> >               AUDIT_CTX_URING,        /* in use by io_uring */
> >       } context;
> >       enum audit_state    state, current_state;
> > +     struct audit_stamp  stamp;      /* event identifier */
> >       unsigned int        serial;     /* serial number for record */
>
> shouldn't we be dropping serial from the audit_context, since we have
> moved it into the audit_stamp?

Unless we make some significant changes to audit_log_start() we still
need to preserve a timestamp in the audit_context so that regularly
associated audit records can share a common timestamp (which is what
groups multiple records into a single "event").

FWIW, I'm working on some patches which will make a lot of this better
in the future, but they aren't ready yet and would almost surely land
after the stacking patches.  Audit will get better at some point in
the future, I promise :)

--
paul-moore.com
