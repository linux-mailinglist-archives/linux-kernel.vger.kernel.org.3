Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1915B5108D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353846AbiDZTVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347024AbiDZTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:21:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78905644F6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:18:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so26831883wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D51WhcFY/UMeRUO4RGgJqs3BnSIqLPLR50R7pSPgCJk=;
        b=41hn5Zs+Qibe7XUS82jY/4Yq9kjs81xMeDW2Al5Wv4emYj7RXpxHg9m/a74sGulFA4
         u7y1fTPot16F8zf/57piTeqrziJ+vUuuPyb5/ArPm07y0CptVtmUNy+cPC1+xb7/ZFg6
         hJ+GeLntfyA7sCcy02UFG8KSwAVd49QPBMi0gGNIu/M/Sn6ha74BLytHSk5CuzBBUSdB
         vGt0pDb7OsvHBuTS2jYecFd14v1eBEIRWVzLLoXNdSq6JxWX6Tal26NvfjJkZ0Gj9i+a
         qv0KixQFvy4J/D9N+b5mlflsWKcS/uT4A4UBBU7+ZlGBMMDvcR672AWcOC+20JFsxnhA
         UQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D51WhcFY/UMeRUO4RGgJqs3BnSIqLPLR50R7pSPgCJk=;
        b=WL6lv/GZRlj1kI4sBmVcM6LPFnrDfYkI+RcyZDl90se9DzZClnYbWdX35PvhwuA2+j
         IGm754NMX4bP3kb48IIvld3krgvzOR5J0LZgNxVI3TpwoogsAF9zvxa9S0UKks0rgh4U
         ZxXg424Hia7cJ7dCLwrY4D4vVqIEo+l1tedhNzgc4uesVPLeFNsmivO2C6fmlmlBoMJh
         LGAz8dnzfRylYdwTrGrXLNTmNuZewJoiQhF54QwLySrh0wV/l1tLubqCGBkuwUYwl+rD
         QCg8VmHVPv3jL+8nYNwEI8uSabJOVxnKNa/0+9hwe+QXaYj6h5YN9NVZ6isvmiJwfY/o
         7rFg==
X-Gm-Message-State: AOAM530lgXxwtJ1H0SobENkUcUEkJAjb54SK9MKeS2VGJNVzeHRWQ93A
        VrovjxR6rpM57A5SUVnXoMQOx3GsB/85hSOPsPfl
X-Google-Smtp-Source: ABdhPJyN5wrn3K+iI2j26/cBIbWY3KxJyXj68+WgqqkU4W4HlKBXb8XI2ye1xUXf6KEOe8QcVbMtcJEumNqu4jkWPrM=
X-Received: by 2002:a5d:590d:0:b0:20a:c3eb:2584 with SMTP id
 v13-20020a5d590d000000b0020ac3eb2584mr18829655wrd.18.1651000705042; Tue, 26
 Apr 2022 12:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com> <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
 <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com> <26eca0aa-111a-9473-8925-e4b12cadbd79@canonical.com>
In-Reply-To: <26eca0aa-111a-9473-8925-e4b12cadbd79@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Apr 2022 15:18:13 -0400
Message-ID: <CAHC9VhQQysL8aEt8w5G-nemJzapY-Q4pYKn0TCdnVjpuiTKqhw@mail.gmail.com>
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

On Tue, Apr 26, 2022 at 2:58 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/26/22 11:03, Paul Moore wrote:
> > On Mon, Apr 25, 2022 at 7:31 PM John Johansen
> > <john.johansen@canonical.com> wrote:
> >> On 4/18/22 07:59, Casey Schaufler wrote:
> >>> Replace the timestamp and serial number pair used in audit records
> >>> with a structure containing the two elements.
> >>>
> >>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>> Acked-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>  kernel/audit.c   | 17 +++++++++--------
> >>>  kernel/audit.h   | 12 +++++++++---
> >>>  kernel/auditsc.c | 22 +++++++++-------------
> >>>  3 files changed, 27 insertions(+), 24 deletions(-)
> >
> > ...
> >
> >>> diff --git a/kernel/audit.h b/kernel/audit.h
> >>> index 4af63e7dde17..260dab6e0e15 100644
> >>> --- a/kernel/audit.h
> >>> +++ b/kernel/audit.h
> >>> @@ -108,10 +114,10 @@ struct audit_context {
> >>>               AUDIT_CTX_URING,        /* in use by io_uring */
> >>>       } context;
> >>>       enum audit_state    state, current_state;
> >>> +     struct audit_stamp  stamp;      /* event identifier */
> >>>       unsigned int        serial;     /* serial number for record */
> >>
> >> shouldn't we be dropping serial from the audit_context, since we have
> >> moved it into the audit_stamp?
> >
> > Unless we make some significant changes to audit_log_start() we still
> > need to preserve a timestamp in the audit_context so that regularly
> > associated audit records can share a common timestamp (which is what
> > groups multiple records into a single "event").
> >
> sure, but the patch changes things to use ctx->stamp.serial instead of
> ctx->serial ...

My apologies, I read your original comment wrong; I was thinking you
were suggesting removing the timestamp info from audit_context in
favor of using the timestamp info contained in the audit_buffer.

Yes, audit_context:serial is no longer needed with audit_context:stamp.

-- 
paul-moore.com
