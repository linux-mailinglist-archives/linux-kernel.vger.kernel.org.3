Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7B58376C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiG1DSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiG1DSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:18:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D6240A0;
        Wed, 27 Jul 2022 20:18:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtbSf4JbGz4x1V;
        Thu, 28 Jul 2022 13:18:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658978290;
        bh=0a1SfDZjYD0OjVyntTUgHptnneGyXdJhKfGnfOBAcAk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a48R+Va3VM2n7bEBvtkDWOplWR6rP69PNaK3OuAIn8INxiKx7288pkLbBWhnRs16G
         iYTj9nx+eF16wfWB51OkE0Le6h1HYKKmqagmGUL/GeuTdOGjdAl+CwvP+0EPhmznMS
         pmXU69swH3Pi1WD7yCK9FCG2/G471to6MX9Lut3Pu2VaMkBJOpdzdrYekLYkzuzrA6
         yspLWaTi3ljnnWDvHlwbL/hDkdnZ2Bd+5blK8aqa/TSfOBYfQnOO4/WadyGmYFedqC
         emdvFN3PhdFum3waxqwwJSesFdnHrzFOVo5phJ40S/lewFI1hMBJGYTB3zPD9jro3a
         cplF1dyD6Rf+w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-next@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] watchdog: Fix build error when
 CONFIG_SOFTLOCKUP_DETECTOR is not set
In-Reply-To: <4dd9afa4-ddc1-c6c9-1205-bca28a858022@linux.ibm.com>
References: <20220727092109.31362-1-ldufour@linux.ibm.com>
 <87sfmmaipn.fsf@mpe.ellerman.id.au>
 <4dd9afa4-ddc1-c6c9-1205-bca28a858022@linux.ibm.com>
Date:   Thu, 28 Jul 2022 13:18:06 +1000
Message-ID: <87ilni9b81.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> Le 27/07/2022 =C3=A0 13:38, Michael Ellerman a =C3=A9crit=C2=A0:
>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>> Sachin reported the following build error when CONFIG_SOFTLOCKUP_DETECT=
OR
>>> is not set:
>>>
>>> kernel/watchdog.c:597:20: error: static declaration of 'lockup_detector=
_reconfigure' follows non-static declaration
>>>  static inline void lockup_detector_reconfigure(void)
>>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> In file included from kernel/watchdog.c:17:
>>> ./include/linux/nmi.h:125:6: note: previous declaration of 'lockup_dete=
ctor_reconfigure' was here
>>>  void lockup_detector_reconfigure(void);
>>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> The definition of lockup_detector_reconfigure should be exported even in
>>> that case, and __lockup_detector_reconfigure should remain static.
>>>
>>> Fixes: 24a1260705b7 ("watchdog: export lockup_detector_reconfigure")
>>> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
>>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>>> ---
>>>  kernel/watchdog.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> Thanks.
>>=20
>> I'll squash that in to the original commit.
>
> Thanks Michael,
>
> I was thinking this is too late for such a squash.

It usually would be, if I was organised, so sending a follow-up was the
correct thing for you to do :)

cheers
