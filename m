Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FEB4E4305
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiCVPdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiCVPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:33:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85374240A3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:31:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647963094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bBFbvuG1P3ENTldXzdHW0OPm8FUpt+pPGQqmRl21Rso=;
        b=1ytBCYh24Yo33FRo3xIQd4+MpG8COUes9SSMTCcO8Xj/9njvEl4pFMbkoxlL7c16b5ysEl
        A+tsDQuIDCJyAaAIL7+9grtGZ7PhlpJc6bES7NJEqfNZrQAQK3tLoW759SZHK/LuWKdy8g
        KD7Kuv68B6HgNj/GoDJL9eytoQZbYrq3feR8qpTQBXogw/Y/yJIthLaKP1f0Mbc5MnKg+y
        o4EPzbTxkZn4+WdX6pJ9s/DUi5ClU3sqH2WPP2lOmnIlXsN83ddhC/ITC4UJZNZ3nAYziy
        U7pKGqAg8SsTA0+pic8SSY8kdOQOfMDHtJ3aigTy5qyLh2dEk2xu8JSL6RAiLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647963094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bBFbvuG1P3ENTldXzdHW0OPm8FUpt+pPGQqmRl21Rso=;
        b=PNWxKerQHdXolJrf/V7DnxS6nhZ2/egOeRxP8urJK6MdVgtTyDyLMGQdjqnmVVpZeHmg+j
        PaRQQ45sjBTcT/Cw==
To:     Steven Price <steven.price@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] cpu/hotplug: Set st->cpu earlier
In-Reply-To: <20220316153637.288199-1-steven.price@arm.com>
References: <20220316153637.288199-1-steven.price@arm.com>
Date:   Tue, 22 Mar 2022 16:31:33 +0100
Message-ID: <878rt2atre.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 15:36, Steven Price wrote:
> Setting the 'cpu' member of struct cpuhp_cpu_state in cpuhp_create() is
> too late as other callbacks can be made before that point.

What?

        CPUHP_OFFLINE = 0,
        CPUHP_CREATE_THREADS,

The create threads callback is the very first callback which is invoked
for a to be plugged CPU on the control CPU. So which earlier callback
can be invoked and fail?

Thanks,

        tglx
