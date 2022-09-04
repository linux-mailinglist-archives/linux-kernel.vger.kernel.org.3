Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CDF5AC655
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiIDUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 16:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiIDUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 16:23:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828A28729
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 13:23:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 9so3500644plj.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ySzswEK7H7/mId1gd4B+DRPGrFPxULy/Wv8aaKMazJE=;
        b=M6ErLHlE/E3jmkdGrZHFVP+dfOoGtPv8dkB4INMMGkjRrvur3lx6OspxA2w7I8a7KD
         IntMW6L4HFRlUDgVIqwITLjGCEja8VbVEwdFZCeOQAMmGIddzUnvpSApRlobBp9j1BDq
         iDHirYE4PPSIJaUKjf5+SEaMpGDP8mHtVGlm1p7KXCJe7ZJTOmXXQhwxXJgEa2UFWjzU
         bSsRViP6Ph/Zze1tKgVHKYnvLEX3QoYHr3ZKI5mbDvbKeVzKuvnZjw+/P0n0qLBb+eX6
         27utxgesDFoUw5iExveYjdgl8ILBnfcOcoyWsdCaLO6gFgwPc6/jtrwnxmRrRJoxKvF+
         SVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ySzswEK7H7/mId1gd4B+DRPGrFPxULy/Wv8aaKMazJE=;
        b=0JUH1I3aaLOrM1OidIrwZKAUU1qvvjekBwUNwWqaVkxuoVZYXujIEPZpN45pGMudpm
         mQjPK73Y/5oWkISRc/EIh67QATY/juyKKrnOJG5t+mxZ5NWA+yOXz/o1n5ufciPngjm3
         Iq1Nbsqwh0xvO/hQpelp/DWpDpHDmb8/QPBOlh7BatTakpN07B1iPR1mb5xkqhbWgWAI
         IYLeD+fg654PjlVP/yWBMDkcwDXMg6+vtQ/XVUA8V4ZpqBMz7XbYWuaA+VSlnxC1L0Hd
         +u0X27V9iOj2T2DcEL8eyM6Fbqi489bGqR/EYykI2SAhbjGKdDu4XCIyOa2xvWQNRKMA
         Onkg==
X-Gm-Message-State: ACgBeo0LKY/XTR8hjlXMREa7KNXpth2bFnJopuyU/+QPW+9I3DPRJk18
        x3QODgOjvd00Yu4HAC3IJFA=
X-Google-Smtp-Source: AA6agR7XFkK7zMI442nuR6eEYXtZoJJgk6O5wZzScogcYHLGLL5SDb9NyG4Ww6eLus7EaPEv7L6r+A==
X-Received: by 2002:a17:902:b581:b0:172:a34e:18fd with SMTP id a1-20020a170902b58100b00172a34e18fdmr45125432pls.163.1662323008752;
        Sun, 04 Sep 2022 13:23:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:291b])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001708b189c4asm986423pln.137.2022.09.04.13.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:23:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Sep 2022 10:23:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [PATCH] workqueue: Protects wq_unbound_cpumask with
 wq_pool_attach_mutex
Message-ID: <YxUJPrRGmUTQu5VS@slm.duckdns.org>
References: <Yvrb3hfZuUzSpX5e@slm.duckdns.org>
 <20220818143348.1134136-1-jiangshanlai@gmail.com>
 <Ywlmb1ADhHnfFUI8@slm.duckdns.org>
 <CAJhGHyB69M7uSu6Ot5JQ=Uc_svRCKqXbvUvwFK1xCm=FcS9Zmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyB69M7uSu6Ot5JQ=Uc_svRCKqXbvUvwFK1xCm=FcS9Zmw@mail.gmail.com>
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

Hello,

On Tue, Aug 30, 2022 at 05:32:17PM +0800, Lai Jiangshan wrote:
> > Is this enough? Shouldn't the lock be protecting a wider scope? If there's
> > someone reading the flag with just pool_attach_mutex, what prevents them
> > reading it right before the new value is committed and keeps using the stale
> > value?
> 
> Which "flag"? wq_unbound_cpumask?

Oh, yeah, sorry.

> This code is adding protection for wq_unbound_cpumask and makes
> unbind_workers() use a stable version of wq_unbound_cpumask during
> operation.
> 
> It doesn't really matter if pool's mask becomes stale later again
> with respect to wq_unbound_cpumask.
> 
> No code ensures the disassociated pool's mask is kept with the newest
> wq_unbound_cpumask since the 10a5a651e3af ("workqueue: Restrict kworker
> in the offline CPU pool running on housekeeping CPUs") first uses
> wq_unbound_cpumask for the disassociated pools.
> 
> What matters is that the pool's mask should the wq_unbound_cpumask
> at the time when it becomes disassociated which has no isolated CPUs.
> 
> I don't like 10a5a651e3af for it not synching the pool's mask
> with wq_unbound_cpumask. But I think it works anyway.

Hmm... I see. Can you add a comment explaining why we're grasbbing
wq_pool_attach_mutex there?

Thanks.

-- 
tejun
