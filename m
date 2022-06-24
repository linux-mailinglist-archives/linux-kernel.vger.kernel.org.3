Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD955937F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiFXGcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiFXGcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:32:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB52609CA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:32:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LTnN159zNz4xZj;
        Fri, 24 Jun 2022 16:32:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1656052322;
        bh=P/l9k24ueAGNrZN2eX9B52ADsu9gsrUuIWkIUWXutKk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TnhK007pd8/cxruAnH3n4r2z/szHgOCDRslEwn9VVdQ/+X+Is7Ln62BxoIAYZeC7T
         Kg9l4Bdaq8UMZIQ3PDMxleL6NmeT3aBA20xUGEMUS/tK1tO0ZceChn6AYglus+RxBm
         lW0n5syTWPaz/huNhuPhx7SGnH9LBxpF96H5F8Nm/OV7m9eDqRUTMxvRRqCk6H7AGw
         K3svGvxdFvMtnlxEZkJDBgvwENR0PVgaxGgSCnqU+1kjdTlAV68e0oK7aHZ+vcw1li
         BccZkpc3KOuEX7AnEc1dMaVuFYGv+f/mYY9+oCor8mzfPBFiBnTzppFz6zEV0bfN/+
         E/mrugwXeO7eg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>, benh@kernel.crashing.org,
        paulus@samba.org, nathanl@linux.ibm.com, haren@linux.vnet.ibm.com,
        npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] watchdog: export watchdog_mutex and
 lockup_detector_reconfigure
In-Reply-To: <20220614135414.37746-3-ldufour@linux.ibm.com>
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
 <20220614135414.37746-3-ldufour@linux.ibm.com>
Date:   Fri, 24 Jun 2022 16:31:55 +1000
Message-ID: <871qve6084.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> In some cricunstances it may be interesting to reconfigure the watchdog
> from inside the kernel.
>
> On PowerPC, this may helpful before and after a LPAR migration (LPM) is
> initiated, because it implies some latencies, watchdog, and especially NMI
> watchdog is expected to be triggered during this operation. Reconfiguring
> the watchdog, would prevent it to happen too frequently during LPM.
>
> The watchdog_mutex is exported to allow some variable to be changed under
> its protection and prevent any conflict.
> The lockup_detector_reconfigure() function is exported and is expected to
> be called under the protection of watchdog_mutex.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  include/linux/nmi.h | 3 +++
>  kernel/watchdog.c   | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)

Is there a maintainer for kernel/watchdog.c ?

There's Wim & Guenter at linux-watchdog@vger but I think that's only for
drivers/watchdog?

Maybe we should Cc that list anyway?


> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 750c7f395ca9..84300fb0f90a 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -122,6 +122,9 @@ int watchdog_nmi_probe(void);
>  int watchdog_nmi_enable(unsigned int cpu);
>  void watchdog_nmi_disable(unsigned int cpu);
>  
> +extern struct mutex watchdog_mutex;
> +void lockup_detector_reconfigure(void);

It would be preferable if we didn't export the mutex.

I think you could arrange that by ...

Renaming lockup_detector_configure() to __lockup_detector_configure()
and then adding a new lockup_detector_configure() that is non-static and
takes the lock around __lockup_detector_configure().

cheers
