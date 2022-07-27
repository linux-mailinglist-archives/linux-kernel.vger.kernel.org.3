Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141795825C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiG0Lji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiG0LjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:39:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D249B69;
        Wed, 27 Jul 2022 04:38:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtBck6JMdz4x1b;
        Wed, 27 Jul 2022 21:38:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658921926;
        bh=vZ1KHTTvl4WPZCMlJGF7NAqeZrcXyA51xm2ZpU8RaFs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HdzweyLffYlDjINn3KByiOAq2xYh8/sex4xMv+SVDRPDCVaB7HUEtM0/hD32aZDR8
         gUPymMEIBmarc1AreFhzNyo1quyf71VI7EqCv78Evz1HHhAPCag7lOaPaB24P8VVcz
         i9+Jzbd/b2L7BV2I4BmJ3rHH2IZscj34Tb5C8zxFFAKPBhXbN+I9mN+Tdf91d3vZz3
         j00Sx7bTsyuN+MyhXJVIb4C8jXptBpyUozcU4aIq2wMUI0nheRq4CEFn11qBMjQNqp
         7RPkFWe2DIBSfHb+USXKU5sytMm/PI0XFsBl7bBYV4+h20kF6bCOweEdk1nouxP0Gh
         InPlO/YEquB3w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-next@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] watchdog: Fix build error when
 CONFIG_SOFTLOCKUP_DETECTOR is not set
In-Reply-To: <20220727092109.31362-1-ldufour@linux.ibm.com>
References: <20220727092109.31362-1-ldufour@linux.ibm.com>
Date:   Wed, 27 Jul 2022 21:38:44 +1000
Message-ID: <87sfmmaipn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> Sachin reported the following build error when CONFIG_SOFTLOCKUP_DETECTOR
> is not set:
>
> kernel/watchdog.c:597:20: error: static declaration of 'lockup_detector_reconfigure' follows non-static declaration
>  static inline void lockup_detector_reconfigure(void)
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from kernel/watchdog.c:17:
> ./include/linux/nmi.h:125:6: note: previous declaration of 'lockup_detector_reconfigure' was here
>  void lockup_detector_reconfigure(void);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The definition of lockup_detector_reconfigure should be exported even in
> that case, and __lockup_detector_reconfigure should remain static.
>
> Fixes: 24a1260705b7 ("watchdog: export lockup_detector_reconfigure")
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  kernel/watchdog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.

I'll squash that in to the original commit.

cheers
