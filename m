Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6058CCB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbiHHRfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHRfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:35:01 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BAE1704C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:34:56 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id A9F2E308464;
        Mon,  8 Aug 2022 19:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659980094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ai4PGhiAGMc1RPAIPLKcFdsH6r8r6WIRdg+EJXmtchg=;
        b=9VZW1zymZAiaVP8EkA0pmw5nqIfOXHuvGe40pAQQ7m1Zg6FEptK8WTVof8drXlhzbVy8zr
        IclwPwLTFdQaiJbHcpPmDPos0Fv/+JGZRgAcM2CIAUivQaJKagTrD5Zt0j3k8GUDCw3878
        1Q0i6AVzfiMKo0NSU6R5wvavdhYJdjXAFXgpVcREWOY6PR+XWGbEaOHyL4CoGyNsSoQ2/L
        I0u5ERt6zzB0OU8d9bXMu8UYwhVLoTv3+wMI5rBXVE3+37Tdao5p7XG9rg4brzwCiaBT3W
        lYhnK37NRROPsdV3DJywBIgwLbD453nnd8jXIppaI2BU08LZj7xol/dHsKln/g==
Message-ID: <e5e85517a918b67ca8315a88ae9a8c1c6ce4da0f.camel@svanheule.net>
Subject: Re: [RFC] issue with cpumask for UniProcessor
From:   Sander Vanheule <sander@svanheule.net>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        ssengar@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Aug 2022 19:34:53 +0200
In-Reply-To: <1659975821-30762-1-git-send-email-ssengar@linux.microsoft.com>
References: <e78c55ecb98172356248a7a89da501479ead6ae0.1659077534.git.sander@svanheule.net>
         <1659975821-30762-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saurabh,

On Mon, 2022-08-08 at 09:23 -0700, Saurabh Sengar wrote:
>=20
> Hi,
>=20
> I am working on a UniProcessor system with latest linux-next kernel
> (20220803).
> I observed two files "shared_cpu_map=E2=80=9D and =E2=80=9Cshared_cpu_lis=
t=E2=80=9D are missing
> for L3 cache (/sys/devices/system/cpu/cpu0/cache/index3). This causes lsc=
pu
> version 2.34 to segfault. On further digging I figured below is the commi=
t
> which introduced this problem.
>=20
> https://lore.kernel.org/lkml/e78c55ecb98172356248a7a89da501479ead6ae0.165=
9077534.git.sander@svanheule.net/
>=20

This is the v5 of the patch, which sadly isn't the version that got merged.=
 The
commit that's triggering your issue is b81dce77cedc ("cpumask: Fix invalid
uniprocessor mask assumption"), which is patch v4.

https://lore.kernel.org/lkml/86bf3f005abba2d92120ddd0809235cab4f759a6.16567=
77646.git.sander@svanheule.net/

>=20
> I am not 100% certain what the proper fix for it is, but below changes fi=
x
> this issue. I understand above patch is already confirmed for linux kerne=
l
> 6.0, please suggest if we need fixing this in 6.0.
>=20
> Regards,
> Saurabh
>=20
>=20
>=20
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index b9728513a4d4..81fc2e35b5b1 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -16,10 +16,14 @@
> =C2=A0 */
> =C2=A0unsigned int cpumask_next(int n, const struct cpumask *srcp)
> =C2=A0{
> +#if NR_CPUS =3D=3D 1
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return n+1;
> +#else

This is ignoring the provided cpumask again, which was exactly what my patc=
h
fixed. If the mask is empty, then cpumask_next(-1, mask) should return (at
least) 1, not 0.

I think the problem could be caused by cpumask_next() getting an empty mask=
.
Then the real issue is would be that a certain mask is empty when it should=
n't
be, which was compensated by the old code's built-in assumption that a cpum=
ask
couldn't be empty.

My MIPS testing system doesn't have these L3 maps, and "shared_cpu_map" and
"shared_cpu_list" are present for index0 and index1. I would propose that y=
ou
look for the point where the files should be created, and check how
cpumask_next() is involved, to find the actual cause of this problem.

Best,
Sander

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* -1 is a legal arg here. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (n !=3D -1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cpumask_check(n);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return find_next_bit(cpumask_b=
its(srcp), nr_cpumask_bits, n + 1);
> +#endif
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(cpumask_next);

