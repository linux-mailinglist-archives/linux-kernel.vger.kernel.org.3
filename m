Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5E583370
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbiG0TWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiG0TVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0957DE4B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658949596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9nlguriVegmCgPjHJ3kVuWSfSUtVD/Ss4LeGmS2Ww38=;
        b=b1EcrmOd6OGH2vrKgoasnO1zBCZn/BHp6VjdsdOr3B0RBGhnKPumQChG+0FRq8ikxajm2S
        QSZyzHp54bzM+azg1iZtgthxCQCmBDNfc7vpnpz1OiX8laIVTVh6B2rvzepsCi4UmnWo6w
        3+GT5mmWCWo3IyG/pKWV4NPVZymanHU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-MuZPaS_KNQGo6zWtw0VHKA-1; Wed, 27 Jul 2022 15:19:53 -0400
X-MC-Unique: MuZPaS_KNQGo6zWtw0VHKA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F9A01C13945;
        Wed, 27 Jul 2022 19:19:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.193])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE353492C3B;
        Wed, 27 Jul 2022 19:19:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Jul 2022 21:19:52 +0200 (CEST)
Date:   Wed, 27 Jul 2022 21:19:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <20220727191949.GD18822@redhat.com>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
 <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
 <YuFdUj5X4qckC/6g@tycho.pizza>
 <20220727175538.GC18822@redhat.com>
 <YuGBXnqb5rPwAlYk@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuGBXnqb5rPwAlYk@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27, Tycho Andersen wrote:
>
> On Wed, Jul 27, 2022 at 07:55:39PM +0200, Oleg Nesterov wrote:
> > On 07/27, Tycho Andersen wrote:
> > >
> > > Hi all,
> > >
> > > On Wed, Jul 20, 2022 at 08:54:59PM -0500, Serge E. Hallyn wrote:
> > > > Oh - I didn't either - checking the sigkill in shared signals *seems*
> > > > legit if they can be put there - but since you posted the new patch I
> > > > assumed his reasoning was clear to you.  I know Eric's busy, cc:ing Oleg
> > > > for his interpretation too.
> > >
> > > Any thoughts on this?
> >
> > Cough... I don't know what can I say except I personally dislike this
> > patch no matter what ;)
> >
> > And I do not understand how can this patch help. OK, a single-threaded
> > PF_EXITING task sleeps in TASK_KILLABLE. send_signal_locked() won't
> > wake it up anyway?
> >
> > I must have missed something.
>
> What do you think of the patch in
> https://lore.kernel.org/all/YsyHMVLuT5U6mm+I@netflix/ ? Hopefully that
> has an explanation that makes more sense.

Sorry, I still do not follow. Again, I can easily miss something. But how
can ANY change in __fatal_signal_pending() ensure that SIGKILL will wakeup
a PF_EXITING task which already sleeps in TASK_KILLABLE state? or even set
TIF_SIGPENDING as the changelog states?

Oleg.

