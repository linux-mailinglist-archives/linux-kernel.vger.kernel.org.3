Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86B50FFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351404AbiDZOFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351427AbiDZOEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:04:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45515DD7F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gPViPUzkcVOPyOfAmKq+P6O/W5Kc0Opeg9kXNngHa1I=; b=xfS13vIQBZcAuG1uDcqHev2WfV
        0R2SwuhYLZ6JL3OpmVoWUOstUBaNdEuzwrOIDpRvkkb4lcW9/7EX7UD5PaWSL8G70nhiVBLJ5Veo1
        W6SQEhtbA6JfL9juKovh/bCf7b1Z+62QXp0zDi6U5Q8OdaonA3c596tmep2v/uSfQKJ/dOyBGH+n2
        /wxna34QZpYiJKPAJmj5+ovzG++8kgSwi6KyezBiKXUu3dY5WYw8yiK9e0iT7wGc8r4qe/ElAnf2U
        HULNwDgEuRyb7WpIv3gnfyMWDg9CTeCObH5KB/sdPqlenKJeXxFt0v5EC/Id7ZoQtPqHxjxI5HvGl
        UaIj1GZQ==;
Received: from [12.191.125.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njLjq-00EpGT-VI; Tue, 26 Apr 2022 14:00:23 +0000
Date:   Tue, 26 Apr 2022 07:00:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com,
        donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] smp: cross CPU call interface
Message-ID: <Ymf69iLnB9sJaej0@infradead.org>
References: <20220422200040.93813-1-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-1-dqiao@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:00:29PM -0400, Donghai Qiao wrote:
> The motivation of submitting this patch set is intended to make the
> existing cross CPU call mechanism become a bit more formal interface
> and more friendly to the kernel developers.

As far as I can tell it mostly does the reverse.  The new interfaces
are a lot more verbose for no good reason.  E.g. this is a common
pattern:


-	on_each_cpu(common_shutdown_1, &args, 0);
+	smp_call(SMP_CALL_ALL, common_shutdown_1, &args, SMP_CALL_TYPE_ASYNC);

or this:

-		smp_call_function_single(boot_cpuid, do_remote_read, &x, 1);
+		smp_call(boot_cpuid, do_remote_read, &x, SMP_CALL_TYPE_SYNC);


The old interface more or less made some sense.  The new one is just a mess.

> Patch 1: The smp cross call related structures and definitions are
> consolidated from smp.c smp_types.h to smp.h. As a result, smp_types.h
> is deleted from the source tree.

And a lot of definitions that used to be private are not public.

