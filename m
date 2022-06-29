Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049CE55FBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiF2JTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2JTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:19:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985FE30560
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:19:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LXwrQ0988z4xD7;
        Wed, 29 Jun 2022 19:19:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1656494342;
        bh=29PJfeDSMkOLNf2FkZWI9rQBkaWRAs9aho80WSfhaCs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MBGFcoYjn2Jfli66pfv4CZB0mz1WUjsFH5XNsjNxXmsIw2ZzCyS/mVWa+Fb8jvRw4
         M4RwMT1do9//Tw6q8lrN5Ia3qG5Urb+dd13i666kFmwXPs5CWKuQo20bIOz1p2QrRP
         MwHS4Qg3oswg9Cu5QcglLayvEyxxFUMqJqoGe7Hco/EeI1/LN0v4x622MPWfmwBH4v
         IymQzdt2Cqj4Nh1ZFc87if+ahpFVYDQRwqJl+aVrF1Tp1uRLEeZuy2uy9IDVxe9umO
         +ImAPIgwA1VUhe4mc2hXPbqwGBWIhlG0/irSWIvSosQpVZZFPAJAIM27tHJ3E7zuWk
         yqW0JbzkYr+qQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, npiggin@gmail.com,
        brking@linux.ibm.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/smp: poll cpu_callin_map more aggressively in
 __cpu_up()
In-Reply-To: <20220125072103.70715-1-nathanl@linux.ibm.com>
References: <20220125072103.70715-1-nathanl@linux.ibm.com>
Date:   Wed, 29 Jun 2022 19:19:01 +1000
Message-ID: <87wncz3jzu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@linux.ibm.com> writes:
> Replace the outdated iteration and timeout calculations here with
> indefinite spin_until_cond()-wrapped poll of cpu_callin_map. __cpu_up()
> already does this when waiting for the cpu to set its online bit before
> returning, so this change is not really making the function more brittle.

Sorry for the glacial response.

I'm not sure I agree that this doesn't make the code more brittle.

The existing indefinite wait you mention is later in the function, and
happens after the CPU has successfully come into the kernel.

I think it's more common that a stuck/borked CPU doesn't come into the
kernel at all, rather than comes in and then fails to online.

So I think the bail out when the CPU fails to call in is useful, I would
guess I see that "Processor x is stuck" message multiple times a year
while debugging various things.

> Removing the msleep(1) in the hotplug path here reduces the time it takes
> to online a CPU on a P9 PowerVM LPAR from about 30ms to 1ms when exercised
> via thaw_secondary_cpus().

That is a nice improvement.

Can we do something that returns quickly in the happy case and still has
a timeout when things go wrong? Seems like a busy loop with a
time_after() check would do the trick.

cheers
