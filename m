Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680E5A6807
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiH3QSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiH3QSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:18:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D099C6B71
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:18:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y3so23251155ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mREfjPyAZE8fR8BbY6J8ChRmeGgj52ZYtbGLQB+Yl64=;
        b=Pb7d9l19y97oNgQaeYdhiQ+Bd+pVG+plxWtfgRvphPOnXTtvxZU1nsqpOkAjdVPPzi
         3OAwiJDtg/Tq/6Fo3iDXejNMbxNNlsFnE+08YdD9h+4aPcy447bFVmbpHq5eYzVXz9aG
         UOzZhSw6z5Z6lwQxqtWlFrHuGfaFLHYNdHof4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mREfjPyAZE8fR8BbY6J8ChRmeGgj52ZYtbGLQB+Yl64=;
        b=dZSjKZI72eIaGYxNdQ0j46M8lXNSekTQr6Jqjg16aQEdiwOzQPGK9GfcD/9wp0CE/s
         HtlDK+CdlZ9nakV40e4kBhZFY5uQ5K3kqH7Au1cqU5YNhyStvOHcOIDsQckcQnycPL/l
         G2+0XCXcmmRaImS+fXue5OmG5sK+gHRfABG8czd3SyeFy6v0D1/eJKFo+DjULs1JKUoG
         PsfYCwujBHRDFlBp0RSVxecGSxdvVKkeyGP+8VpNlzLVpxankv9cEcprsDqBHZX23xSu
         uk/+uPbAK9KV1NtV9Ee7JgSKMN8M1f7NnngvJK8j2+UoOjdpnezFTxrDNRzd+PA8w14p
         wDLA==
X-Gm-Message-State: ACgBeo2k/R1uzrzAcXFMwO+5MCTx/qCzbX/0tc2vpVAmOjkU2aoytTca
        GA4nnhRWKTtQ8J5iVCDCfojQrttro/ZUJOq9
X-Google-Smtp-Source: AA6agR6rA+2mlFnA94Wyp1EAJW0qH0iZbq3paWGDk4bINMO4+qBmf+BvMhpSVvyF3LiZ0Et7cOTtrg==
X-Received: by 2002:a17:907:6d98:b0:741:3872:b9c2 with SMTP id sb24-20020a1709076d9800b007413872b9c2mr12785494ejc.259.1661876305402;
        Tue, 30 Aug 2022 09:18:25 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906315700b007420aaba67esm1399937eje.36.2022.08.30.09.18.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 09:18:23 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id bq11so14898050wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:18:23 -0700 (PDT)
X-Received: by 2002:a5d:6881:0:b0:225:28cb:332f with SMTP id
 h1-20020a5d6881000000b0022528cb332fmr9403684wru.405.1661876302923; Tue, 30
 Aug 2022 09:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211116012912.723980-1-longman@redhat.com> <CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com>
 <20220719104104.1634-1-hdanton@sina.com> <CAD=FV=Xng_Mcd-9SaK29XSbsthDWLTR6sz53VEktAQFng6a27A@mail.gmail.com>
 <20220722115510.2101-1-hdanton@sina.com> <CAD=FV=XS_AqMveo=a2zN+=b3DxM-yJQapd27Dq8dR+kSb2oL_A@mail.gmail.com>
 <20220723001713.2156-1-hdanton@sina.com> <CAD=FV=X7FnrwHSedA=1xJsrfSgQZcqu0YEAKrfoJC6BhDc-gFA@mail.gmail.com>
 <2fcf84e6-168b-4ee7-bc9e-5b1c3c9a3d4e@redhat.com> <CAD=FV=UyAecgOfiA18WoA+Dd7DxwD7v1RbjrKUs9=LqrZ6C70g@mail.gmail.com>
In-Reply-To: <CAD=FV=UyAecgOfiA18WoA+Dd7DxwD7v1RbjrKUs9=LqrZ6C70g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Aug 2022 09:18:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUfB5kZQZ=T4AdKgiA_59OwTUppUZXDidAcxLTu4cDcA@mail.gmail.com>
Message-ID: <CAD=FV=VUfB5kZQZ=T4AdKgiA_59OwTUppUZXDidAcxLTu4cDcA@mail.gmail.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more consistent
To:     Waiman Long <longman@redhat.com>, Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 5, 2022 at 12:16 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Aug 5, 2022 at 12:02 PM Waiman Long <longman@redhat.com> wrote:
> >
> >
> > On 8/5/22 13:14, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Fri, Jul 22, 2022 at 5:17 PM Hillf Danton <hdanton@sina.com> wrote:
> > >> On Fri, 22 Jul 2022 07:02:42 -0700 Doug Anderson wrote:
> > >>> Thanks! I added this diff to your previous diff and my simple test
> > >>> still passes and I don't see your WARN_ON triggered.
> > >> Thanks!
> > >>> How do we move forward? Are you going to officially submit a patch
> > >>> with both of your diffs squashed together? Are we waiting for
> > >>> additional review from someone?
> > >> Given it is not unusual for us to miss anything important, lets take
> > >> a RWSEM_WAIT_TIMEOUT nap now or two.
> > > It appears that another fix has landed in the meantime. Commit
> > > 6eebd5fb2083 ("locking/rwsem: Allow slowpath writer to ignore handoff
> > > bit if not set by first waiter").
> > >
> > > ...unfortunately with that patch my test cases still hangs. :(
> >
> > The aim of commit 6eebd5fb2083 ("locking/rwsem: Allow slowpath writer to
> > ignore handoff bit if not set by first waiter") is to restore slowpath
> > writer behavior to be the same as before commit d257cc8cb8d5
> > ("locking/rwsem: Make handoff bit handling more consistent").
>
> Ah, OK. I just saw another fix to the same commit and assumed that
> perhaps it was intended to address the same issue.
>
>
> > If the hang still exists, there may be other cause for it. Could you
> > share more information about what the test case is doing and any kernel
> > splat that you have?
>
> It's all described in my earlier reply including my full test case:
>
> https://lore.kernel.org/r/CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com
>
> Previously I tested Hillf's patches and they fixed it for me.

Hillf: do you have any plan here for your patches?

I spent some time re-testing this today atop mainline, specifically
atop commit dcf8e5633e2e ("tracing: Define the is_signed_type() macro
once"). Some notes:

1. I can confirm that my test case still reproduces a hang on
mainline, though it seems a bit harder to reproduce (sometimes I have
to run for a few minutes). I didn't spend lots of time confirming that
the hang is exactly the same, but the same testcase reproduces it so
it probably is. If it's important I can drop into kgdb and dig around
to confirm.

2. Blindly applying the first (and resolving the trivial merge
conflict) or both of your proposed patches no longer fixes the hang on
mainline.

3. Reverting Waiman's commit 6eebd5fb2083 ("locking/rwsem: Allow
slowpath writer to ignore handoff bit if not set by first waiter") and
then applying your two fixes _does_ still fix the patch on mainline. I
ran for 20 minutes w/ no reproduction.

So it seems like Waiman's recent commit interacts with your fix in a bad way. :(

-Doug







-Doug
