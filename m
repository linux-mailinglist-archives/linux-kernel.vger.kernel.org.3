Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D656547DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiFMDJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiFMDJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:09:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B5C13D26
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:09:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w21so4665414pfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/pLEswe5U7/A5k2nogy3DN7PRhluk8qf4cmQOk29Z78=;
        b=EKDOWHxKCfMShkFDQedXLkTyG2mrlrhWabyejtW1KBPO5wGTwUJIt+KkWFIxABdMF5
         qS4Ymtd1fpGGE25opVsQfubkztbhvLn4NL7lw7symu5mFTR4V89fK31ijTXrDbouV9Al
         MN7DYElRohzxlHsyW1WLFTXewGa6BSWK74rsD/fjnoA543XIUrPUtjsDPuteLdC72D7V
         izXvQqjDQ884ck+syYzWW1kvwtbnSC3R4TXSkeIgc6b1Vwtj+C+DDzYDujqQwcdhq6dt
         aY1pzWjBAYPQ1Wd9iGQI0whSlbQMU9NDYOzcihiYgjejoq6WTJbY/AB5pBc3KkcQTtji
         DcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/pLEswe5U7/A5k2nogy3DN7PRhluk8qf4cmQOk29Z78=;
        b=AuH9xzu8y1T7EpcpkL0i4rggRVLzEn8Vwru1pehlji8xyMqkN3sWkgH5uFzIfoDuZS
         qEUq8t0o51Mai5O/s4zYfKx1vsmLrvBGnWDSlx4R2rv7NIVrWYHz+6KUlPi7t3eQQUJ8
         YT2QMIsXSltp3s4A2wTWce3jctsVWtplbOgQ6SfzYheWt9I8husxXawp3OuoIPmt9MeF
         55EibWHeQY8pS2qxwWHXz84tnQe/K9qIs7g0tYt7RaL+qZjeUpo+wJrqUdMHKY5P4gAW
         ebvja2qgdDldXeS2LL0jdL3b43Cw3jtyTMR1aD8sIRbfoyEXLciN4uYfcMb2NGXdmEA9
         PTsg==
X-Gm-Message-State: AOAM532KHgKBo7A0wTUGnUUeJa1fCUWLGdP7uoMyb8jjguZE5Sk8R79v
        C9B+tN3pvJorN+WikpOQx6Y=
X-Google-Smtp-Source: ABdhPJzavk0o9G/6joVP9Ji10Y8HfCxyK66lg1vm18Skp6ly3eFgpNTF9oxdZtJFFgp4/487gkifrw==
X-Received: by 2002:a62:868c:0:b0:51b:bd62:4c87 with SMTP id x134-20020a62868c000000b0051bbd624c87mr57009823pfd.83.1655089774870;
        Sun, 12 Jun 2022 20:09:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a6a0a00b001e2f3831102sm3892424pjj.17.2022.06.12.20.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 20:09:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 17:09:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/4] kernfs: make ->attr.open RCU protected.
Message-ID: <Yqaqbas1JaWz25jB@slm.duckdns.org>
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
 <20220602063907.136569-2-imran.f.khan@oracle.com>
 <YqYpTShTDLvAp4vx@slm.duckdns.org>
 <6d1c5a49-fc16-5fc7-e527-8cb91ec0d25c@oracle.com>
 <YqalHuEB6OjjUosV@slm.duckdns.org>
 <c8a8a616-da4c-f2ce-0bb2-e0cba69db24d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a8a616-da4c-f2ce-0bb2-e0cba69db24d@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 12:55:14PM +1000, Imran Khan wrote:
> I took below phrases as reference:
> 
> If the access might be within an RCU read-side critical section on the one hand,
> or protected by (say) my_lock on the other, use rcu_dereference_check(), for
> example:
> 
> p1 = rcu_dereference_check(p->rcu_protected_pointer,
>                            lockdep_is_held(&my_lock));
> 
> 
> and
> 
> 
> If the access might be within an RCU read-side critical section on the one hand,
> or protected by either my_lock or your_lock on the other, again use
> rcu_dereference_check(), for example:
> 
> p1 = rcu_dereference_check(p->rcu_protected_pointer,
>                            lockdep_is_held(&my_lock) ||
>                            lockdep_is_held(&your_lock));

So, both are saying that if a given reference can be under both read
critical section or a lock which blocks updates, you can use deref_check to
cover both cases - we're just using the stronger form of derefing even
though that's not necessary while update side is locked out, which is fine.

The protected one is different in that it doesn't enforce the load ordering
which is required for accesses with only RCU read lock. Given that all
that's required is dependency ordering, I doubt it makes any actual
difference and it likely is more useful in marking a specific dereference as
always being with the update side locked.

tl;dr is that you're way over-thinking the rcu deref code. Just make one
deref accessor which encompasses all three use cases.

Thanks.

-- 
tejun
