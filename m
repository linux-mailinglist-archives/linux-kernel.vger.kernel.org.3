Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB86352BBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiERNAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiERNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:00:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361061A492A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:00:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3ClD2Z4qz4xXk;
        Wed, 18 May 2022 23:00:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652878824;
        bh=8HGYHJPOmY1dIKPSQacOtCK4s9CAWP95ivD2NBejQPM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cw4E8HBSr95cBHPK7ZOUBnc5sAKWS6+aTe9yKvjHS2T9aSI55aOoUeJpWZCJzzCiW
         dWqfRJGNK9z3bKJcJtMQrdznCUxRJeDr7HySp1nS57PTqkgoevjLuq+sBgbp5uQUNO
         IrLOY7017oapY48nVynMlSxckU6x/nqsjXUluzFe4N3GeG/StisLvVKeagV42o39N2
         LxUu762iZteZGfGoOCggm/ETSSO9spoGwxEnjrcrdWC/teodjZ+LSjQYZFp/HKj7uj
         3sm83a3U8X5FCHsYxN1ArtqfS2b53aVwzazmWe3PXZodOw601yaDLYmj/enEMRmezI
         lnJAwP8Wgn3Bg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] powerpc: Add generic PAGE_SIZE config symbols
In-Reply-To: <c6cbd41c-4cef-d4d7-324a-b4c3e2498262@csgroup.eu>
References: <20220505125123.2088143-1-mpe@ellerman.id.au>
 <c6cbd41c-4cef-d4d7-324a-b4c3e2498262@csgroup.eu>
Date:   Wed, 18 May 2022 23:00:20 +1000
Message-ID: <87fsl7nggr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 05/05/2022 =C3=A0 14:51, Michael Ellerman a =C3=A9crit=C2=A0:
>> Other arches (sh, mips, hexagon) use standard names for PAGE_SIZE
>> related config symbols.
>>=20
>> Add matching symbols for powerpc, which are enabled by default but
>> depend on our architecture specific PAGE_SIZE symbols.
>>=20
>> This allows generic/driver code to express dependencies on the PAGE_SIZE
>> without needing to refer to architecture specific config symbols.
>
> I guess next step should be to get rid of powerpc specific symbols and=20
> use generic symbols instead.
>
> We have (only) 111 occurences of it.

I thought about doing that, but it's quite a bit of churn. Maybe it's
worth it though to avoid confusion between the two symbols.

There's probably some that could be converted to IS_ENABLED() at the
same time, especially in hash_utils.c.

cheers
