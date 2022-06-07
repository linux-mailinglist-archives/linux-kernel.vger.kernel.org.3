Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506753FE84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243546AbiFGMOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiFGMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:14:50 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB4C0E0E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:14:47 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id C7CEBB0012F; Tue,  7 Jun 2022 14:14:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1654604085; bh=/15Jtn/l6rflU2k3fwtc3B718k5z91qYrofnha1OCHI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=wf63nbTf3C53rPmwuG1tCmvb5P2bJo07dXmf3zRdMrTb7TwuGydkqufLv+tVMcya9
         AQkGwZ4TwrUqQYhUJJcjXVlMCTouUt6F3TuytbH68ymm55CCZffOW1PgyD+sl96XPu
         bAgSXiAGZlxSAoyawlxYpncvWYJyxheu3p5M5DKBwEWYRahYstzXtLgZNXjQ7qonr6
         /ty98DDgFbbLPKCpSWCUIkNYP3TmnZf8ESSOkkivXRKR/iR+7nsm3W4PjsNFgoZTfd
         Dr7q8mVlfhyIehMWZpJ6Ty+AqZT7n90thZbDj50dqmttKFYc0xR8igvE14uzCXxFu0
         fRliG+LFUciBg==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C39A7B00060;
        Tue,  7 Jun 2022 14:14:45 +0200 (CEST)
Date:   Tue, 7 Jun 2022 14:14:45 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
In-Reply-To: <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com>
Message-ID: <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com> <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal> <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com> <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022, Rongwei Wang wrote:

> Recently, I am also find other ways to solve this. That case was provided by
> Muchun is useful (Thanks Muchun!). Indeed, it seems that use n->list_lock here
> is unwise. Actually, I'm not sure if you recognize the existence of such race?
> If all agrees this race, then the next question may be: do we want to solve
> this problem? or as David said, it would be better to deprecate validate
> attribute directly. I have no idea about it, hope to rely on your experience.
>
> In fact, I mainly want to collect your views on whether or how to fix this bug
> here. Thanks!


Well validate_slab() is rarely used and should not cause the hot paths to
incur performance penalties. Fix it in the validation logic somehow? Or
document the issue and warn that validation may not be correct if there
are current operations on the slab being validated.


