Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787F50DFB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiDYMMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiDYMMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:12:13 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794AA5A177
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:09:08 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 94730B000C1; Mon, 25 Apr 2022 14:09:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 938E4B00078;
        Mon, 25 Apr 2022 14:09:06 +0200 (CEST)
Date:   Mon, 25 Apr 2022 14:09:06 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Aaron Tomlin <atomlin@redhat.com>
cc:     frederic@kernel.org, mtosatti@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
In-Reply-To: <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
Message-ID: <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
References: <20220422193647.3808657-1-atomlin@redhat.com> <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de> <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022, Aaron Tomlin wrote:

> Yes, in the context of nohz, this patch should ensure it, if required, when
> the idle tick is to be stopped.

What I said was that it is generally useful. Even in the non NOHZ case.

Folding the vmstat diffs *always* when entering idle prevents unnecessary
wakeups and processing in the future and also provides more accurate
counters for the VM allowing better decision to be made on reclaim.

