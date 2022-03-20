Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02B4E1DE8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbiCTVOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiCTVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:14:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C682C5132A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 14:13:21 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id w21so5289764pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8QgnP7UE8gcARv7sLJZW+I9q72JODMo6EJTdNQS+2wU=;
        b=SQzxoz7s5621WVGH6xw4gN/niC6ixiYE3upMb078Vd/5NI1Dsx5FgoXdwpwhQHq41T
         eLKKEh1nh594gaDoiqcAEVqgjxOd4/eEg3nt8IdlPcZqePOXzmT+RtWHO0sWjjlCfwRt
         WPGOOilKoJRqGxShU2FHfEpQmFzSdmTXwtg7z6HDuzLIf6yRMIwAj5VrZclQsnKbIwka
         nnGT+Zz+DNV7zcWpUqSamcVdvm24ublAKfAd0IZYhC5d3fdYjf2Ea76Pg1S60eM0/k/z
         TJgjcDGZBPeh/Yb1Rf37A/ACQeAoXfbBijNU09G0cpnUvBiE8VD9HOrqe+kLY7vfify3
         H0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8QgnP7UE8gcARv7sLJZW+I9q72JODMo6EJTdNQS+2wU=;
        b=T0WXHpHfGbY/rnCfA8kdsPXpBIeRTrnV3JTMCKHaAkXWoglMQCzUwUT23bFI9T4h6b
         VwT+D9a2SWjRfltmpB77+NhqG8ab3iqLLD6DNps983nxJw/eKl/9h94Xg++9zHbnnIY7
         LQsr4JBA/sS9X9J8h3a/VGuOkmjf4bOPw08gsnHexq2O7N9eJYuAPbWaD6BOFRHRmYJy
         Btep/in/Lht6P9kDql3HHGJPX5uheuiy3j6Wg1HVdZUAsDANRJJJZMvG6FtjoiU65hf/
         L8B/LoCpL1g7I/PmUdns6mCGVjDQesMOx5n0qAtKswe8SFN1/XFp7dVJuvMi2FoAUHph
         eFfg==
X-Gm-Message-State: AOAM530T9FjNz/1tVscYjyBWOxEMauu4vuMNeZAgnPeD0TXIaRJ50dyP
        wHqaSn5nf4zOLcxfxKLqOnc=
X-Google-Smtp-Source: ABdhPJzgq/DRYZUuTy6XlEDhoZLKJRWamc37XxFO1vFMmcGnSWJE6gOse8hFzfojkx/YIdUJAwM+Qg==
X-Received: by 2002:a62:643:0:b0:4f7:2b29:159a with SMTP id 64-20020a620643000000b004f72b29159amr20763476pfg.16.1647810801203;
        Sun, 20 Mar 2022 14:13:21 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id k10-20020a056a00168a00b004f7e2a550ccsm16708922pfc.78.2022.03.20.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:13:18 -0700 (PDT)
Date:   Mon, 21 Mar 2022 06:13:16 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Jonas Bonn <jonas@southpole.se>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 5/5] openrisc: Move to ticket-spinlock
Message-ID: <YjeY7CfaFKjr8IUc@antec>
References: <20220319035457.2214979-6-guoren@kernel.org>
 <202203200824.EQJTy8pW-lkp@intel.com>
 <CAJF2gTQXgXJjX6h5d_5tM312Ky_QfCKm-wLZP2SJBuYtHvE9xQ@mail.gmail.com>
 <CAAfxs74xtts3bzMGsVp9fOyxfZzj1vQPgrEsquXFa6AGAAC+_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfxs74xtts3bzMGsVp9fOyxfZzj1vQPgrEsquXFa6AGAAC+_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 12:36:31PM +0900, Stafford Horne wrote:
> On Sun, Mar 20, 2022, 12:05 PM Guo Ren <guoren@kernel.org> wrote:
> 
> > Hi openrisc guys,
> >
> > >    kernel/signal.c:2625:49: sparse:     expected struct sighand_struct
> > *sighand
> > >    kernel/signal.c:2625:49: sparse:     got struct sighand_struct
> > [noderef] __rcu *sighand
> >
> > Some warning here, Is that all right? I don't think it is because of
> > changing arch_spinlock_t from struct qspinlock to atomic_t.
> >
> 
> I haven't built or tested this series yet.  But this doesn't look like a
> new problem. It looks like this patch series may have introduced a new
> instance of the existing issue.
> 
> I have some patches to clean up sparse warnings and I've seen this pattern
> before but haven't spent the time to clean it up. This is a good
> opportunity to do that now.  Let me have a look in the next few days.

Hello Guo Ren,

I was able to build the patch series for OpenRISC, but after applying the
openrisc SMP kernel build no longer can boot.  It doesn't boot on single core
system or multi-core systems.  I don't get any console output to help with
debugging it.

It may take be a bit longer to debug this.

-Stafford
