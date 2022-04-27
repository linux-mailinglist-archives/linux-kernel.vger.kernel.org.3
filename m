Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6697A511CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiD0QGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243373AbiD0QFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:05:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFBC3C305F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:02:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q23so3178692wra.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuXdH3mbYd4Gnl44e//+j/klraKOvkpgOliwGw+YZ7s=;
        b=BnT4/TnG/yQ41vtWz0BFedhJxhOAqjpLvHN9LNyXhyV8m+8PnZpCz0iC3bfWLFc8PQ
         Jxw2c4EagSdCNgndlDqapohrwulYpJAwBMaP3C6yZpshJxRG6Sd92TyOVPOVZloVMfo1
         grZekdjRWmzxzm7BLam6dnAFrfMnghKS5GrLT32H8wSh5EbfG+4gXEvNzkcpEwnMqrk6
         sUCctJvhvEeGZJXctjBr06vKK30nynGDVRhNXBjTLUBENOBiXnKBsX0DmtPbi6Mwi5Rs
         JEnp1p5+QxWZusg6F/RzyB1pyHNHvhIymslg5vMAabB6TXqTlwYj2F5oMN9pM3f1trzw
         p5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuXdH3mbYd4Gnl44e//+j/klraKOvkpgOliwGw+YZ7s=;
        b=UmeB2g4Dx4WB1Ek4oGmlcXhi8CsbJYWEHCoFcnJkhHcm6dDFfo7wHQf2A1UpHFAV/G
         AIy9Wh5xKTcSe2WSNiqQCyH2WQ6Ba0GHseObjIpjhgVPiCNUdPs1kft7R7g9TsK7q953
         3cSMUlp62jLSBWz+63CFJ/8LfCHOpWHeKgnK/o+Gvb8kenIe1PyseAK3PWlWYS7eC2O9
         yi3XzteOnaxnCbxzypdXTxZi3k7JyBZGfSpGlU6cM9HUSyVJ8UF3UDEnTUfn+RG4V2c3
         WpeUqHqR5/Sk8qIVh88RHYs+dILALZXQ2dPV7h2cTFJZdG8OMXoCqd+Z7OZFr8putZ04
         9mnw==
X-Gm-Message-State: AOAM533zyviVhz+Zzhk2azHzxOyQtLVRoIZAw6deliQLiuDIQjxzTSYu
        4LwdQ4czBgYpoSBwEykjLVAqhNyqb5LrAfYfnWv5
X-Google-Smtp-Source: ABdhPJzYoyxpMLnD9ubmid4unahg+b0PsIWIS3wxLIoFgmxDjN1rv/qVRxVkpAaGGwTHUHfo5yOg/ZMc8seG7EODIqc=
X-Received: by 2002:a5d:590d:0:b0:20a:c3eb:2584 with SMTP id
 v13-20020a5d590d000000b0020ac3eb2584mr22239195wrd.18.1651075352543; Wed, 27
 Apr 2022 09:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com> <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
 <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com>
 <26eca0aa-111a-9473-8925-e4b12cadbd79@canonical.com> <CAHC9VhQQysL8aEt8w5G-nemJzapY-Q4pYKn0TCdnVjpuiTKqhw@mail.gmail.com>
 <4ec176c6-1f66-3951-f40f-1eb0d5b66a09@schaufler-ca.com>
In-Reply-To: <4ec176c6-1f66-3951-f40f-1eb0d5b66a09@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Apr 2022 12:02:21 -0400
Message-ID: <CAHC9VhQow5MaC0O-YJHxXh_=SR5eo3+97pznVyUq4YhkTuBBmg@mail.gmail.com>
Subject: Re: [PATCH v35 23/29] Audit: Create audit_stamp structure
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:49 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 4/26/2022 12:18 PM, Paul Moore wrote:
> > On Tue, Apr 26, 2022 at 2:58 PM John Johansen
> > <john.johansen@canonical.com> wrote:
> >> On 4/26/22 11:03, Paul Moore wrote:
> >>> On Mon, Apr 25, 2022 at 7:31 PM John Johansen
> >>> <john.johansen@canonical.com> wrote:
> >>>> On 4/18/22 07:59, Casey Schaufler wrote:
> >>>>> Replace the timestamp and serial number pair used in audit records
> >>>>> with a structure containing the two elements.
> >>>>>
> >>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>>> Acked-by: Paul Moore <paul@paul-moore.com>
> >>>>> ---
> >>>>>   kernel/audit.c   | 17 +++++++++--------
> >>>>>   kernel/audit.h   | 12 +++++++++---
> >>>>>   kernel/auditsc.c | 22 +++++++++-------------
> >>>>>   3 files changed, 27 insertions(+), 24 deletions(-)
> >>> ...
> >>>
> >>>>> diff --git a/kernel/audit.h b/kernel/audit.h
> >>>>> index 4af63e7dde17..260dab6e0e15 100644
> >>>>> --- a/kernel/audit.h
> >>>>> +++ b/kernel/audit.h
> >>>>> @@ -108,10 +114,10 @@ struct audit_context {
> >>>>>                AUDIT_CTX_URING,        /* in use by io_uring */
> >>>>>        } context;
> >>>>>        enum audit_state    state, current_state;
> >>>>> +     struct audit_stamp  stamp;      /* event identifier */
> >>>>>        unsigned int        serial;     /* serial number for record */
> >>>> shouldn't we be dropping serial from the audit_context, since we have
> >>>> moved it into the audit_stamp?
> >>> Unless we make some significant changes to audit_log_start() we still
> >>> need to preserve a timestamp in the audit_context so that regularly
> >>> associated audit records can share a common timestamp (which is what
> >>> groups multiple records into a single "event").
> >>>
> >> sure, but the patch changes things to use ctx->stamp.serial instead of
> >> ctx->serial ...
> > My apologies, I read your original comment wrong; I was thinking you
> > were suggesting removing the timestamp info from audit_context in
> > favor of using the timestamp info contained in the audit_buffer.
> >
> > Yes, audit_context:serial is no longer needed with audit_context:stamp.
>
> Thank you for catching that. Easy (I expect) fix.
> BTW, I'm not supposed to be working the next few weeks,
> but I should be able to sneak v36 in before the next merge
> window.

Enjoy the time away :)

FWIW, this isn't my call to make, but I would strongly prefer if this
got a *full* run in linux-next before it was merged into Linus' tree
during the merge window.  For example, get this into the LSM -next
tree at -rc1 instead of -rc6.

-- 
paul-moore.com
