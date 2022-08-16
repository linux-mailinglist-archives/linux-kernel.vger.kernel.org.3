Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13459576C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiHPKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiHPKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:02:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133936151
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=74WdhM3RJ8Wo5N9OpOLYgg9V2/ybAAKlqBWdhxmgksg=; b=AsnPzLPKeK/V4Mg8Pbq1zEuEFY
        xUYgJ2YkpkTbS5is5va44wYbcCZJyiCw2wY/ttAc1s7dcHppDr9dY8h0eqi+8VrWiclazgSzYTBwy
        UYYEWpNxOOe+rIC40hTe/11h3r7n/CS2qRssPt3/F4QV9pKrxWJD7UP5At0zkqS3nKrqWlWJFDiuJ
        iiSAbcTiHkqu9hqJoXY9a2zIbp9JMiRCp8XTQhNv3qokl8wy0KkCb1lChYglFCaW+SBs6wU68NyqS
        HUFUY+9FUKlONhPp+uJQb2nLbQ9D/8xGEJmfyTxUlOfWyREq8uC8fSW6tYgr9lLlLnRSiqNfqD2Xr
        MtKtGn/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNsi7-002uob-38; Tue, 16 Aug 2022 09:18:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE98F980163; Tue, 16 Aug 2022 11:18:03 +0200 (CEST)
Date:   Tue, 16 Aug 2022 11:18:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tuo Cao <91tuocao@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: core: remove access_ok() before copy_to_user()
Message-ID: <YvtgyxoZ/RmtfOs/@worktop.programming.kicks-ass.net>
References: <20220815142137.29982-1-91tuocao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815142137.29982-1-91tuocao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:21:37PM +0800, Tuo Cao wrote:
> If usize > ksize, usize may be not valid and if(!access_ok()) will return
> -EFAULT. But ksize may be valid, copy_to_user() should be executed.And
> also, copy_to_user() will calls access_ok() to test whether a block of
> memory is a valid user space address.

I don't follow, why do you want this to continue if the user provided
garbage input?
