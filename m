Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3939854F97B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382859AbiFQOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382802AbiFQOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B71C53FDA1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655477189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WJ3fcpXL0f2WOS1lh4X7CDZ3Ewdk0gaVvZYQvOA7jA=;
        b=d+rJIo9fNstpU1X52hJPrUAmMGTnhuVSTgZJxHx5yiPtBQ4cisIRDhWuE1pnzCV7bC7GWh
        tx1aWNFGVWyWWluaLAdj8+BPtU1wjIVqOBmxhMtMVlCyCpZmnU2bPvxYTfXV2xiDtIRST2
        4NA1TwnLZMfj1U5+T1d5YTWoCAbdJuI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-WPjPXVGsO82LwYy5duO4Rg-1; Fri, 17 Jun 2022 10:46:28 -0400
X-MC-Unique: WPjPXVGsO82LwYy5duO4Rg-1
Received: by mail-qk1-f200.google.com with SMTP id bi36-20020a05620a31a400b006a79f0706e5so5223659qkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9WJ3fcpXL0f2WOS1lh4X7CDZ3Ewdk0gaVvZYQvOA7jA=;
        b=W78abTdmoAS/XujHCyeDIZhIfE8QJRU+/IiFle7HvlUxMp9wj8H/YUhRi4cFbEFIUG
         gSJ5POQB+8weGJhE+Q3G8d64w1v/Ac6XvahD5hQ3G2WVjo5x5fpQUjL1dhLzUJ3GZ+Ty
         OwVWM+MSbnEOmEQgzGyAhMA7bm4LSwbAFox6objJoCRRr+GSAmfsy3FBZTbMptV7Ureh
         TwBzHsBRfNE/GmoTsNB7+y+uEXAtXkR+mhM62gWSkFFCOKMkUq19g7IMd77pXWo+b5xQ
         1aaMDsNakzh3gXWnjt2RWOx8xbvP5glPYNx+aSgoxX20/cDGRHAt7HLkd/7afQZF2nU7
         xvtA==
X-Gm-Message-State: AJIora8Zo86mlSmIQkmZLaJwVNC+ZYydWe3ARXY1B30OHiXqONKp/o5O
        WY+xW5aoqLJERdijYpkmsd7dsUfe+h7uaWCzIsHz4Aa8ySaIt5naa4JXpESY4rYArBnZbMoRT1Z
        0CUM408YwlC2mUeQjT3eFa7u6
X-Received: by 2002:ad4:5c4a:0:b0:464:5920:7c1a with SMTP id a10-20020ad45c4a000000b0046459207c1amr8736674qva.58.1655477188328;
        Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAXwW2mpsUavrlypnLTFvGbZu5tQk5+gn1Z1EAvySMi1FHasDEGVadg1bRJOm3lqNdYXoCAg==
X-Received: by 2002:ad4:5c4a:0:b0:464:5920:7c1a with SMTP id a10-20020ad45c4a000000b0046459207c1amr8736646qva.58.1655477188058;
        Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id a15-20020ac85b8f000000b00304e38fb3dasm4813173qta.35.2022.06.17.07.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:46:27 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tao Zhou <tao.zhou@linux.dev>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
In-Reply-To: <YqyHGxPCgiXuep3/@alley>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <Yqxaf6V+hvCSXQSM@geo.homenetwork>
 <xhsmhh74j7biy.mognet@vschneid.remote.csb> <YqyHGxPCgiXuep3/@alley>
Date:   Fri, 17 Jun 2022 15:46:23 +0100
Message-ID: <xhsmhczf773gg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/22 15:52, Petr Mladek wrote:
> On Fri 2022-06-17 12:52:05, Valentin Schneider wrote:
>> If you look at __crash_kexec() in isolation yes, but if you look at panic()
>> and nmi_panic() only a single NMI can get in there. I think that is also
>> true for invocations via crash_kexec().
>
> It is true that panic() could be called only once, see this code
> in panic():
>
> 	 * Only one CPU is allowed to execute the panic code from here. For
> 	this_cpu = raw_smp_processor_id();
> 	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
>
> 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
> 		panic_smp_self_stop();
>
>
> One the other hand, the aproach with two variables is strage
> and brings exactly these questions.
>
> If a trylock is enough that the mutex can be replaced by two
> simple atomic operations. The mutex would be needed only
> when a user really would need to wait for another one.
>
>
> 	atomic_t crash_kexec_lock;
>
> 	/* trylock part */
> 	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1) != 0)
> 		return -EBUSY;
>
> 	/* do anything guarded by crash_kexec_lock */
>
> 	/* release lock */
> 	atomic_set_release(&crash_kexec_lock, 0);
>
> The _acquire, _release variants will do the barriers correctly.
>

Looks saner! I can't think of anything wrong with it so I'll shove that in
v2. Thanks!

> Best Regards,
> Petr

