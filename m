Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9054C57EC33
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 07:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiGWFQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 01:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWFQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 01:16:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897CF12ACD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 22:16:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bk6-20020a17090b080600b001f2138a2a7bso7613730pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDgKb9BFnubXrm8nhsbHpuMtogqppyRnkCcL1soD42Y=;
        b=ITLpKzWCCm+TJvDJ6q0kKJjw+YvIxJNA8z+SPLaB5RIW1thW64NDKtAY5RO/ztYdrb
         Inqt3oXw4e0OEhLMdLHJOilI4hfsGJGCJ23eh3sXVnVPJ/rGdQwi6/P2uu6791mVLOvW
         cwIPkt4o3TCRls3JJ2shQ7E5jgUlOKk97SnSlTkGSYR/ebc3s/SHUbTZS/WID+iflu6t
         e5p633A4ULYZzrakxf5Z86TubkR4VzX0lk+DCnkzBE6y6QpcCbniTdhQyg0kSOTSE/wn
         mTcD3hgbogHYddxyUMsslVE9nXbX7YPpR6oMhoOKn+Z0UxPlnMqp/nLootM/zyHzdJtf
         0w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IDgKb9BFnubXrm8nhsbHpuMtogqppyRnkCcL1soD42Y=;
        b=mrDbokt9I6UzSWmhqPbCmMwjBwtvMR6oMGJ8Mdne32hsbtdIHRcyRRltU7pv8nrEgr
         TSbs22bP8O79wlxgBwewacKD1S/UGrsdYDvnjcnn0c9P2rDcVdwq4mka5qjSnDDl3eE3
         3c9tGsFSN/YocAEvxk9oIzgVc3m73D9BfBJd5v/l+Q3A8iPJnNMxzJEpEIrgD7sZ9g2d
         SaP7RR/u7N5loHVCRhe+l6qk5hmaQYWAYoaC76+piijupxl7jXlcJI+P73vrWjKOZN33
         VJACufl8ZHQGncRvqsLGrr9boYUfZB1yz/mHBRkk64aDTVgOf9vluUuiwvpOx+mhOH6Q
         vWpg==
X-Gm-Message-State: AJIora8/Ctcjuc5Nj4VfgQj0sGHr90MrER+DBaZmHwyXI8YWNVnmi71o
        Wx2O2d3hBtSGvL0MuNCg86E=
X-Google-Smtp-Source: AGRyM1tBkHk5CU/4x+dfJekPgY9GiFCNed9f7jhcEP6MKPMRNgAzkrdpF+r7nVslMfJgMBiWS+03SA==
X-Received: by 2002:a17:90b:4b4d:b0:1ef:a2c2:6bcc with SMTP id mi13-20020a17090b4b4d00b001efa2c26bccmr3321969pjb.186.1658553382689;
        Fri, 22 Jul 2022 22:16:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:d97e])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm1971584plh.30.2022.07.22.22.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 22:16:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Jul 2022 19:16:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to
 exit()
Message-ID: <YtuEJLDkO/lATYeb@slm.duckdns.org>
References: <20220719165743.3409313-1-vschneid@redhat.com>
 <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhv8rqfu6w.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:53:43PM +0100, Valentin Schneider wrote:
> > I think it needs something like task_set_cpumask_possible() which is
> > documented as being usable in (raw) spinlocks and set the task's cpumask
> > to cpu_possible_mask and let the later ttwu help migrate it to a
> > proper non-isolated CPU or let it keep running.
> 
> I'll see what I can come up with, thanks for the suggestion.

Alternatively, we can just kill all the idle kworkers on isolated cpus at
the end of the booting process.

Thanks.

-- 
tejun
