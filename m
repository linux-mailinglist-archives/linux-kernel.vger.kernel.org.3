Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF55728D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiGLVzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiGLVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:55:14 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A69550709
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:55:12 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 02324F92620;
        Tue, 12 Jul 2022 23:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1657662907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aPbSpp/ipo3YS/Xfdmee6X2Ppr9vPQwAusfYqW6orH0=;
        b=XgYe4cf5/Gr/94EthsKyiSMm2wJUNbiqaTErGeVBrcqrRkMkLw6ahb9oj4lIbvkjMIAH3/
        WSDyYFOXFd0kviH4zCkHxvfro2EYXM5SdkRSAtpV0N05MzecuJAV5NwTjYXa80JcVkZ1fu
        6pyT/gCgg+xy3s741UMT75/EVc4Xogs=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] amd-pstate doesn't work since v5.18.11
Date:   Tue, 12 Jul 2022 23:55:05 +0200
Message-ID: <6967031.z0QvQKZeIK@natalenko.name>
In-Reply-To: <4c9e3a4c-40b2-3ce9-da88-ad507769658b@amd.com>
References: <3559249.JlDtxWtqDm@natalenko.name> <2414945.NDPYyZybsh@natalenko.name> <4c9e3a4c-40b2-3ce9-da88-ad507769658b@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C3=BAter=C3=BD 12. =C4=8Dervence 2022 22:07:15 CEST Limonciello, Mario =
wrote:
> See if this helps out:
>=20
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 734b96454896..88a81e6b9228 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -16,6 +16,13 @@ bool cpc_supported_by_cpu(void)
>          switch (boot_cpu_data.x86_vendor) {
>          case X86_VENDOR_AMD:
>          case X86_VENDOR_HYGON:
> +               if (boot_cpu_data.x86 =3D=3D 0x19 &&
> +                   ((boot_cpu_data.x86_model >=3D 0x00 &&=20
> boot_cpu_data.x86_model <=3D 0x0f) ||
> +                   (boot_cpu_data.x86_model >=3D 0x20 &&=20
> boot_cpu_data.x86_model <=3D 0x2f)))
> +                       return true;
> +               else if (boot_cpu_data.x86 =3D=3D 0x17 &&
> +                        boot_cpu_data.x86_model >=3D 0x70 &&=20
> boot_cpu_data.x86_model <=3D 0x7f)
> +                       return true;
>                  return boot_cpu_has(X86_FEATURE_CPPC);
>          }
>          return false;
>=20
> If that works and no one has a better idea how to do it for these=20
> systems I'll send out a proper proper patch tomorrow.

This patch (also mirrored here [1]) works for me, thanks.

[1] https://codeberg.org/pf-kernel/linux/commit/cc5c57b8c349c85b81b44cf5fe2=
d2577b947a7de

=2D-=20
Oleksandr Natalenko (post-factum)


