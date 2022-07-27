Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD72583286
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiG0S4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiG0Szv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C8278052D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658944544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=70KAGnfv8UJJ+vlSDeqdToDvV6amtpqy/ROgE4cjYlE=;
        b=dGQ+tR+TtUt2S7wK6zFcIG/XqIXy+ZbdFWVM3Ny8jS30aEkIvkDX9atM45BytbNsRkpHvP
        +sNLQvpS6KziMIMoV3Wu3taa1KTf7TL7BXTcrerMQBgsw+OkK/ZeNZcv/lVO2wPnmVKHTR
        Swu27mLGBS4FYn2BoCZg4+HaNqTb/Mw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-mklhdHPCPoKVdH_1RkztBA-1; Wed, 27 Jul 2022 13:55:43 -0400
X-MC-Unique: mklhdHPCPoKVdH_1RkztBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C29DC101A589;
        Wed, 27 Jul 2022 17:55:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.193])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1CFD640CF8E2;
        Wed, 27 Jul 2022 17:55:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Jul 2022 19:55:42 +0200 (CEST)
Date:   Wed, 27 Jul 2022 19:55:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <20220727175538.GC18822@redhat.com>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
 <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
 <YuFdUj5X4qckC/6g@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFdUj5X4qckC/6g@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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
> Hi all,
>
> On Wed, Jul 20, 2022 at 08:54:59PM -0500, Serge E. Hallyn wrote:
> > Oh - I didn't either - checking the sigkill in shared signals *seems*
> > legit if they can be put there - but since you posted the new patch I
> > assumed his reasoning was clear to you.  I know Eric's busy, cc:ing Oleg
> > for his interpretation too.
>
> Any thoughts on this?

Cough... I don't know what can I say except I personally dislike this
patch no matter what ;)

And I do not understand how can this patch help. OK, a single-threaded
PF_EXITING task sleeps in TASK_KILLABLE. send_signal_locked() won't
wake it up anyway?

I must have missed something.

Oleg.

