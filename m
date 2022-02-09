Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2C4AEA90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiBIGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiBIGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:45:43 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF444C0401C7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 22:45:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i15so2302232wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 22:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qWz9q7D5W23mIWnyiOa6dx/TNUHhgX78pIzzQmVSN4E=;
        b=h7Y3VPrLX/7F8A+Wd+mTD+J8MLqn3UErPb3rzT3syRfetXnJo1ITBYCt/JERTucrO0
         AfeylxeUwoP8KuWEWhv3Ed2N4VLES8M3zS+33p5y+KF6pCWDNBkQB2Dm2vrr4BIFJjkf
         iNLUFZ1884XcFKlRDmMZ6MICCPa63f5LTlVpSkgwnutlBDoBl1/GITRsEjIwVsdllh8R
         XdxwMrhWSf6NvcO3XcAKjzSG9K51cwISRTj/wVvxqqtXb+woTCA26fsnzToQM1JGtwYO
         K4hJpayw50Ku2N4VT4MpJY/HWoBobX6+IEppR54ALJ9YgG0+L0UbA/pV4K3inE22kTqS
         Cfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qWz9q7D5W23mIWnyiOa6dx/TNUHhgX78pIzzQmVSN4E=;
        b=hgcAzZdLLZpVeLNdxRabxIVWgtQwg4dZdvzT2JMYfKNZkFj2AoenIM3Juc9DRiO2G9
         nQVrty9eQLgbtGK9pfqKz3U80+NZzj6Z6mgS/PaDPUBnFbVR1p4lordUllJ+lZ7cgQ/9
         gwVgx9FrIdnz8U+7Np3hUdO/ixGNF3j4bNZeziFoyyRHUfyyKRi15T/RCzmrvN/gAtUF
         Eu4LE5/6c9HqtWlf49M0mr9wkHhz8DpH3kPhmlPuvK3IKX8gv1xvU4oua+MQ6rHdjfwF
         IFGD79ej0cvCoSzXPcKNsFTABcKMsG2HZpG6AgzHphld274ZRSo0qaN1mtKIOxz9s2Oq
         XHkQ==
X-Gm-Message-State: AOAM530EzG8PRhjcbVtTf3W21mUVW1DhtSDEz7DmXScpnRL8FaJHf5v3
        HwXx/pNRzNMUL0QNDrlGevnIyKmfglc=
X-Google-Smtp-Source: ABdhPJy+4BZ3MOJep0ENnzTTTtcxnadmff3gRxeojP99Hp9QkLNIL2u8T1Fik0tL+SNJ+8fHMGrngQ==
X-Received: by 2002:a2e:b042:: with SMTP id d2mr592734ljl.147.1644388674797;
        Tue, 08 Feb 2022 22:37:54 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id q5sm160739lfb.70.2022.02.08.22.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:37:53 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id EE1FD5A0020; Wed,  9 Feb 2022 09:37:52 +0300 (MSK)
Date:   Wed, 9 Feb 2022 09:37:52 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Adrian Reber <adrian@lisas.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YgNhQEdZjlKNr61Z@grain>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org>
 <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org>
 <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <a4865e63-4778-d701-f902-2753cb862077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4865e63-4778-d701-f902-2753cb862077@gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:54:14PM +0000, Dmitry Safonov wrote:
> [un-Cc'ed a lot of people, as the question is highly off-topic, so I
> don't feel like the answer is of big interest to them, keeping x86
> maintainer in]
> 
> On 2/8/22 17:02, Cyrill Gorcunov wrote:
> >>> Probably a kind of latch in the task_struct which would trigger off once
> >>> returt to a different address happened, thus we would be able to jump inside
> >>> paratite code. Of course such trigger should be available under proper
> >>> capability only.
> >>
> >> I'm not fully in touch with how parasite, etc works.  Are we talking about save or restore?
> > 
> > We use parasite code in question during checkpoint phase as far as I remember.
> > push addr/lret trick is used to run "injected" code (code injection itself is
> > done via ptrace) in compat mode at least. Dima, Andrei, I didn't look into this code
> > for years already, do we still need to support compat mode at all?
> 
> Cyrill, I haven't been working on/with Virtuozzo people last 5 years, so
> I don't know. As you're more connected to Vz, your question seems to
> imply that ia32 C/R is no longer needed by Vz customers. If it's not
> needed anymore - I'm all for stopping testing of it in CRIU.

Nope. I didn't see any sign that Vz is intended to drop ia32 suport. But
Vz's criu instance is following vanilla's one, that is why I asked you
and Andrew about ia32 support. This ia32 code snippet with stack
manipulation simply popped out in my mind immediately when Andy asked
how we deal with stack.

Also we adjust stack in restorer code but I need some time to recall
all thses details since as I said I didn't work with criu code for
years already.

	Cyrill
