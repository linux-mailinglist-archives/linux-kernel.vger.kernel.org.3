Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B574AC45F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377132AbiBGPvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356919AbiBGPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:47:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3740C0401C1;
        Mon,  7 Feb 2022 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4r4fwg2Jt/Ek25Xo6fonjBQ+D000c2reLDmY5W0tK0o=; b=duJXrWdNEv0Tx43zBxRsTH01w5
        3+oOJtYgIj6WL2FZsDK+WDaK3EDmy3jtR8u8FwGAm4CiSYyHGzUQx/ZUyi+J18I48I5pHYmUI/9vF
        qIxLw0Bpyxjz/2If4gs9UXF59hJ7wuJE5YB4OpW7xj/9dtcFPM8ELwTYtN2ccXZmvqWyMl1IAbzrm
        y0PtkiG6jHSYjznbWBWdQekVumGySSPn4LLlA2NBQwqELo/1BNd1WhCgSbsmiCWRiG9AWFS0h86r4
        7m4f4uJUD4c92Ivu0Gjeyp0yOSKy17IViVsq6twtC/2/DIcmHz43Z1YHfLOLAeQ6Umh48A1NQMcA7
        n+HBe/zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH6Eu-007oGI-V1; Mon, 07 Feb 2022 15:47:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BE2E986235; Mon,  7 Feb 2022 16:47:39 +0100 (CET)
Date:   Mon, 7 Feb 2022 16:47:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: Semantics vs. usage of mutex_is_locked()
Message-ID: <20220207154739.GH23216@worktop.programming.kicks-ass.net>
References: <CAFqZXNt0Xp1j7+hTrV9XZ936Yz+H8Le0pqazhLr3drO0tEzB2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNt0Xp1j7+hTrV9XZ936Yz+H8Le0pqazhLr3drO0tEzB2w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:15:27PM +0100, Ondrej Mosnacek wrote:
> Also, any opinions on the name of the new helper? Perhaps
> mutex_is_held()? Or mutex_is_locked_by_current()?

lockdep_assert_held*() and friends work on mutexes just fine.
