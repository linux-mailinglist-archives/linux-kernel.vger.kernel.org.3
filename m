Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9B55E061
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiF0Mmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbiF0Mma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 978D1B4BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656333746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+n3Y/O+OmufE7x8Fqncdr2+EU4ZYCNX0XlR2Xu4Dqo=;
        b=O8Tp3GSZCmspWr/f4S7n9Aoy7hd8k7pjwe8ryfxc3D2wpDfPFom8PedzQcJNYKeu4Qx+OJ
        aHmwdvbeY72yp1wlmT4qffXVO288TvHCNsv7HaOCeEU1ffFdhr4ceAENg6IhKjVpRj+EPE
        s0WEzfY4KNSu4es26AdyJJOCDqWZbZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-1Fj0OMlXMsWfukRiUUhjCw-1; Mon, 27 Jun 2022 08:42:25 -0400
X-MC-Unique: 1Fj0OMlXMsWfukRiUUhjCw-1
Received: by mail-wm1-f71.google.com with SMTP id c187-20020a1c35c4000000b003970013833aso3523928wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=E+n3Y/O+OmufE7x8Fqncdr2+EU4ZYCNX0XlR2Xu4Dqo=;
        b=au7as+eQpq6zvR71dzt0E8ybH4haCTz3A9cwrKwq/v+BGv1yUu3Hx4SuYb9ehcx4eo
         h/+d1piBbC5zmkja0alFaT+yWWrWfhKafDtMVFaF4np+N+zp38aL517kswmiK64x8g8v
         h/meuLsap9iGLVvToX0z9O46M+mv+wmKM5KFS9Y4ytk3dVbdZ6x0YliDsdJN4ziNOUN0
         rj1IQLxDGwv+a/hIVQxniu5Z0lmqtRsmDrc1pdzDDH6fDrMqszdOT/RuxfAgcpTGehz/
         H7N6rh71UKQJbD8DKbjG+OgwC2LwKp47ltTNUmtFsrGwGXNYHpLFPRiREF8FQIdH3pd7
         kJXQ==
X-Gm-Message-State: AJIora/WVxYKRzAzbR2TYC+4uRUOpj83gLOQxkUFknqYxS1KvcdUy2W1
        XitrAPjoeDKonwOLJdW1tHoL4NQMYfD0lZOl4gXgBbB9bcrnE2YvQQ8tlXlcLDVjpDaYk6VVfD7
        +SxlUTY+SHAnaooT7f0fOfxdQ
X-Received: by 2002:a05:6000:69c:b0:21b:9280:9b2d with SMTP id bo28-20020a056000069c00b0021b92809b2dmr11433065wrb.203.1656333744230;
        Mon, 27 Jun 2022 05:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sJQ27sm+aJCjHu6xlQQhyYlKZ+HBejyIkW+SlC/p31t1lmrQbyAqnkqUNfQtUZa+j6nj85CQ==
X-Received: by 2002:a05:6000:69c:b0:21b:9280:9b2d with SMTP id bo28-20020a056000069c00b0021b92809b2dmr11433043wrb.203.1656333743939;
        Mon, 27 Jun 2022 05:42:23 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id bk20-20020a0560001d9400b0021b8b998ca5sm9882182wrb.107.2022.06.27.05.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:42:23 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 27 Jun 2022 13:42:22 +0100
Message-ID: <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/22 12:04, Eric W. Biederman wrote:
> I am not particularly fond of this patch as it adds more complexity than
> is necessary to solve the problem.
>
> Calling a spade a spade PREEMPT_RT's mutex_trylock implementation is
> broken as it can not support the use cases of an ordinary mutex_trylock.
> I have not seen (possibly I skimmed too quickly) anywhere in the
> discussion why PREEMPT_RT is not being fixed.  Looking at the code
> there is enough going on in try_to_take_rt_mutex that I can imagine
> that some part of that code is not nmi safe.  So I can believe
> PREEMPT_RT may be unfix-ably broken.
>

AFAICT same goes for !PREEMPT_RT given the mutex_unlock(); it's a bit
convoluted but you can craft scenarios where the NMI ends up spinning on
mutex->wait_lock that is owned by the interrupted task, e.g.

  CPU0                    CPU1

                          crash_shrink_memory()
                            mutex_lock();
  crash_get_memory_size()
    mutex_lock()
      raw_spin_lock(&lock->wait_lock);
      // Lock acquired
  <NMI>
                            mutex_unlock()
                              <Release lock->owner>;

  // Owner is free at this point so this succeeds
  mutex_trylock();
  // No kexec_crash_image
  mutex_unlock()
    raw_spin_lock(&lock->wait_lock);

>
> At this point I recommend going back to being ``unconventional'' with
> the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
> use a mutex for locking rather than xchg()").
>
> That would also mean that we don't have to worry about the lockdep code
> doing something weird in the future and breaking kexec.
>
> Your change starting to is atomic_cmpxchng is most halfway to a revert
> of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
> xchg()").  So we might as well go the whole way and just document that
> the kexec on panic code can not use conventional kernel locking
> primitives and has to dig deep and build it's own.  At which point it
> makes no sense for the rest of the kexec code to use anything different.
>

Hm, I'm a bit torn about that one, ideally I'd prefer to keep "homegrown"
locking primitives to just where they are needed (loading & kexec'ing), but
I'm also not immensely fond of the "hybrid" mutex+cmpxchg approach.

> Eric

