Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2612B5B2111
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiIHOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiIHOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF0558C9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662648302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1NWLsPufrv1Z1Z1oT9L72C7JiwJYlyGG1fa5hFdEoc=;
        b=PVx855HONZv7tAvBuviq6riQYwqnHmRjGiJDETDYIX0xP0eBpDXXmZYF2Kf3Ckc/o67HKq
        OM70uMNHcXlTl1DNWJPYCWTj27Osbb3wcdc22qWsxJ+inHnYXD9EuOX43ZelrNslP+PviH
        oY+phoEfKD0wzMI3LJeFm8niZj5G0gc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-2BjxvtEdPpagh8NSQ7u33g-1; Thu, 08 Sep 2022 10:45:01 -0400
X-MC-Unique: 2BjxvtEdPpagh8NSQ7u33g-1
Received: by mail-wm1-f72.google.com with SMTP id p3-20020a7bcc83000000b003b2973dab4bso1234399wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=D1NWLsPufrv1Z1Z1oT9L72C7JiwJYlyGG1fa5hFdEoc=;
        b=OsJT0NksPuO0xd+6vvXo+rFqgjqComXDl0lo9dRlwiEjy2hM88YsHjDA6ysgrDoUzl
         i1x5+zBtOi0/dUWDeZUAqfxlU4Dyq059m3LvuZKOCoB2oIRjUW0Wc6WObL7qirfYQDH4
         NNgApqfKsOEhL50rO3KGkQ8eXXMyBfLZC4sfaY1VamHdslSGH8JhP3LESGRfQENw1DnO
         1wN+PHMyNGfljUSg27Htj8lE/CLCKWPauKSnYKf0gmllwKMmeaAXVvNBbcmTdSraw0UF
         ttHe+6zx7M81jQ1yA1yv2lqpj9uVJoDOo645mdEqnssQkRaYt/CuZgEWsRXxxYrU0HJI
         w8lw==
X-Gm-Message-State: ACgBeo3zAf5XXGcbD9aQJ4xX65RE8TBkatUBoilsmqaV4av5dsAcszfh
        rmJzm4oqFmJw5yesaKES4EMNk/NIm/FYVg/9DCh89K41h6qdwFwXTm0n9/S0U7b8ZllEnd4tluF
        1OSxb8o1pGv86BNgML4uWmglA
X-Received: by 2002:a05:600c:1c23:b0:3a5:d936:e5bb with SMTP id j35-20020a05600c1c2300b003a5d936e5bbmr2387517wms.59.1662648300352;
        Thu, 08 Sep 2022 07:45:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7fJgOmrcKJ8ShbrwnUHuBpfa0K9y45SnAFXKT+MRGLC/LnSpWU83I3ibPwXZDWaCCVfMnJPw==
X-Received: by 2002:a05:600c:1c23:b0:3a5:d936:e5bb with SMTP id j35-20020a05600c1c2300b003a5d936e5bbmr2387497wms.59.1662648300076;
        Thu, 08 Sep 2022 07:45:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id z11-20020a056000110b00b00228dcf471e8sm9480472wrw.56.2022.09.08.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:44:59 -0700 (PDT)
Message-ID: <52fcd27efafb415baa0bc52440296306110c56d7.camel@redhat.com>
Subject: Re: [PATCH net v3] net: mptcp: fix unreleased socket in accept queue
From:   Paolo Abeni <pabeni@redhat.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        menglong8.dong@gmail.com
Cc:     mathew.j.martineau@linux.intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, fw@strlen.de,
        peter.krystad@linux.intel.com, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Mengen Sun <mengensun@tencent.com>
Date:   Thu, 08 Sep 2022 16:44:58 +0200
In-Reply-To: <e4b7eddc-3a73-0994-467e-6d65d6ad80c0@tessares.net>
References: <20220907111132.31722-1-imagedong@tencent.com>
         <e4b7eddc-3a73-0994-467e-6d65d6ad80c0@tessares.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 15:56 +0200, Matthieu Baerts wrote:
> Hi Menglong,
> 
> On 07/09/2022 13:11, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> > 
> > The mptcp socket and its subflow sockets in accept queue can't be
> > released after the process exit.
> > 
> > While the release of a mptcp socket in listening state, the
> > corresponding tcp socket will be released too. Meanwhile, the tcp
> > socket in the unaccept queue will be released too. However, only init
> > subflow is in the unaccept queue, and the joined subflow is not in the
> > unaccept queue, which makes the joined subflow won't be released, and
> > therefore the corresponding unaccepted mptcp socket will not be released
> > to.
> 
> Thank you for the v3.
> 
> Unfortunately, our CI found a possible recursive locking:
> 
> > - KVM Validation: debug:
> >   - Unstable: 1 failed test(s): selftest_mptcp_join - Critical: 1 Call Trace(s) ❌:
> >   - Task: https://cirrus-ci.com/task/5418283233968128
> >   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5418283233968128/summary/summary.txt
> 
> https://lore.kernel.org/mptcp/4e6d3d9e-1f1a-23ae-cb56-2d4f043f17ae@gmail.com/T/#u
> 
> Do you mind looking at it please?

Ah, that is actually a false positive, but we must silence it. The main
point is that the lock_sock() in mptcp_close() rightfully lacks the
_nested annotation.

Instead of adding such annotation only for this call site, which would
be both ugly and dangerous, I suggest to factor_out from mptcp_close()
all the code the run under the socket lock, say in:
 
bool __mptcp_close(struct sock *sk, long timeout)
	// return true if the caller need to cancel the mptcp worker
	// (outside the socket lock)

and then in mptcp_subflow_queue_clean():

	sock_hold(sk);

	slow = lock_sock_fast_nested(sk);
        next = msk->dl_next;
        msk->first = NULL;
        msk->dl_next = NULL;
	do_cancel_work = __mptcp_close(sk, 0);
	unlock_sock_fast(sk, slow);

	if (do_cancel_work)
		mptcp_cancel_work(sk);
	sock_put(sk);

All the above could require 2 different patches, 1 to factor-out the
helper, and 1 to actually implement the fix.

Cheers,

Paolo

