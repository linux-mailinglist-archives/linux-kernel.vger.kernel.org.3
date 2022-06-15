Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4063B54C8C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbiFOMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbiFOMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:42:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7186DFC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3exYkbkGVA6ONvFcqLC/UiBhYiMhudeXJrj19fyXfHU=; b=Rp+lH575wjGmNq83/mfaaH/jyj
        Qv0XxFkQB1d8mzui7iHsYYRAD1KhfvjfHt2+gjqMXmAyL+qVHrFvMKCZxF5uoYk/g/vG+PPgk/FET
        2wmBLCY224PlgsrQAVzIoMic/rLKHys7LgzlAQa+uK+Tmb3b02J71QpePNMyFsalQ8faX7UaI6jJG
        SM1Xc+ogSUkG2Sz5mouAYWQsY4I+hSJHOByMwz2glWJoIpT+dqlQqVWFmOrMPMPySrpW0LE7Q5gqa
        +z+38S2rg+wKsi+s0d11+NDgRd35QrJMILGkCZAVP0qHmUDyLNk23UI7w46JrW73UAIetnik/SK5n
        LwXZn0KA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1SLs-0013Qh-1s; Wed, 15 Jun 2022 12:42:28 +0000
Date:   Wed, 15 Jun 2022 13:42:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/page_alloc: make calling prep_compound_head more
 reliable
Message-ID: <YqnTtGDt+NdQ3Jxf@casper.infradead.org>
References: <20220607144157.36411-1-linmiaohe@huawei.com>
 <20220607113257.84b1bdd993f19be26b8c4944@linux-foundation.org>
 <65e5da9c-32d1-17d7-d8c6-96cbfac23fec@oracle.com>
 <4a30f026-789a-9235-2fbd-f553e4d7b45d@huawei.com>
 <YqiJaOiGnUzzB1+W@casper.infradead.org>
 <40a07ce5-414a-a3b8-53ee-6c348635f03a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a07ce5-414a-a3b8-53ee-6c348635f03a@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:44:06PM +0800, Miaohe Lin wrote:
> > We definitely don't need the unlikely here.
> 
> Could you please give me a more detailed explanation? IIUC, the above if condition
> will only meet at a probability of 1/512. So unlikely tells the compiler to do some
> optimization around it. Or am I miss something?

Only add unlikely() when the compiler can't figure out for itself that
it's unlikely.  You should also check the generated code and/or
benchmark the results to be sure that it's actually an improvement.
Using unlikely() needs to be backed up with more than just a feeling.
