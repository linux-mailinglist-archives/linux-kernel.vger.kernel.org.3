Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2C469F9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391696AbhLFPuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388618AbhLFPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:34:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2EC08E884
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CoK7AfSqkQue2iVIdMm3Ujn5V1JuX1+w5yvbIOBf/T8=; b=AOjfBIZmfJcwym+inOTj9a9qlf
        7UfjBIcyaToBVTcEDg1Wwpq0QukNYZC+K/EbRJligBVXJU8JJm4ULlMgcF4njSvNajalkVPGtX69Z
        kErFWv5VvPaw+9kHVdB24Y/kXqzQLZwPHmZXmNF0XA1vvyPfYyAh7iJgDyIwXUHkEkguw1/F0BxZl
        zxLqrmOd7iNzm3HNQ0nObGRm6pFnyWx14uRlK5Ua/JbVlDPJoMc4eh2gkW+5yUalQr5je3OFilM+B
        IkFd/PxS9uG/EQMqLRo5gIhzq/wxLmISKly3hgGuJ4IVuwgCCd0V2ymGktKgi6MVZ0A1EECrk+gjv
        LsdcbdrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFme-002aFh-Lt; Mon, 06 Dec 2021 15:20:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 507A6300362;
        Mon,  6 Dec 2021 16:20:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33741202420BC; Mon,  6 Dec 2021 16:20:04 +0100 (CET)
Date:   Mon, 6 Dec 2021 16:20:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2 1/2] sched/fair: Fix asym_fits_capacity() task_util
 type
Message-ID: <Ya4qJHxUbKMzl04d@hirez.programming.kicks-ass.net>
References: <20211118141411.2623521-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118141411.2623521-1-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 02:14:10PM +0000, Vincent Donnefort wrote:
> task_util is an unsigned long value, compared with a CPU capacity which is
> unsigned long as well. There's no need for an intermediate implicit int
> cast.
> 
> Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")

Do either of these patches actually *fix* anything? Afaict they're an
absolute no-op, even in terms of code-gen due to the promotion rules.

Yes, its arguably nicer to not rely on those implicit promotions etc..
but I don't think this warrants a Fixes tag or even being split in two
patches.

Hmm?
