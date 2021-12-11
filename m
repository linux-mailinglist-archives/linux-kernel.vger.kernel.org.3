Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76147147D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhLKPh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:37:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54920 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhLKPhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:37:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A495B80AD2;
        Sat, 11 Dec 2021 15:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB725C004DD;
        Sat, 11 Dec 2021 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639237070;
        bh=ezOXs6CcJHDlycNj8lmQU7rq1j6Bz02x9rKOsPw8OgE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A7oGnlOMw//1MxT92AF6CRcLDc+qYZ13y96+6IjTymZPMxDZ0jMx6GOn6AYu+gb+y
         oG0Lxs5rXlOCCJDACsCPts5OTscst3mt8f5Eismwsji2y0F2kh/557Yi5AwVYIaIXO
         uPzqJCZ8mWlIAqvzlW/0HvwcltgjPA5Nl23gN8TioSLo7RLewimtpup9wJqaSR6N73
         2upqBdhuMfnK8Eqo10fD4k3Zu4HJp5wOaMyvI8mLI9Z68IWgjdzSuaz7NFwsrRB0OB
         k/+TSiH9cXpUcFRiMSnG9lGbYhRLV2lmo7DG3yAvQ1lPPQO/PSyMBPivTxDPzNVhim
         oqOI9qzBm0jYg==
Message-ID: <233a2fa4355b060361b9e9a6dc98b3175d1143fb.camel@kernel.org>
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Date:   Sat, 11 Dec 2021 17:37:46 +0200
In-Reply-To: <32abd0a7-bc3c-f7a7-3330-8287ef05131c@intel.com>
References: <20211116162116.93081-1-jarkko@kernel.org>
         <20211116162116.93081-2-jarkko@kernel.org>
         <f25d95e6-e129-597b-5d93-d7264feae8b8@intel.com> <YbCEl9kqhTz2iOY2@zn.tnic>
         <32abd0a7-bc3c-f7a7-3330-8287ef05131c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-08 at 11:38 -0800, Dave Hansen wrote:
> I reworked the changelog quite a bit, addressing some of Borislav's
> questions.  No code changes, though.
>=20
> The result is below.  I've retained Greg's ack.  I'll stick this in
> tip/x86/sgx if this looks OK to everyone.
>=20
> ---
>=20
> From: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> =3D=3D Problem =3D=3D
>=20
> The amount of SGX memory on a system is determined by the BIOS and it
> varies wildly between systems.  It can be as small as dozens of MB's
> and as large as many GB's on servers.  Just like how applications need
> to know how much regular RAM is available, enclave builders need to
> know how much SGX memory an enclave can consume.
>=20
> =3D=3D Solution =3D=3D
>=20
> Introduce a new sysfs file:
>=20
> 	/sys/devices/system/node/nodeX/x86/sgx_total_bytes
>=20
> to enumerate the amount of SGX memory available in each NUMA node.
> This serves the same function for SGX as /proc/meminfo or
> /sys/devices/system/node/nodeX/meminfo does for normal RAM.
>=20
> 'sgx_total_bytes' is needed today to help drive the SGX selftests.
> SGX-specific swap code is exercised by creating overcommitted enclaves
> which are larger than the physical SGX memory on the system.  They
> currently use a CPUID-based approach which can diverge from the actual
> amount of SGX memory available.  'sgx_total_bytes' ensures that the
> selftests can work efficiently and do not attempt stupid things like
> creating a 100,000 MB enclave on a system with 128 MB of SGX memory.
>=20
> =3D=3D Implementation Details =3D=3D
>=20
> Introduce CONFIG_HAVE_ARCH_NODE_DEV_GROUP opt-in flag to expose an
> arch specific attribute group, and add an attribute for the amount of
> SGX memory in bytes to each NUMA node:
>=20
> =3D=3D ABI Design Discussion =3D=3D
>=20
> As opposed to the per-node ABI, a single, global ABI was considered.
> However, this would prevent enclaves from being able to size
> themselves so that they fit on a single NUMA node.  Essentially, a
> single value would rule out NUMA optimizations for enclaves.
>=20
> Create a new "x86/" directory inside each "nodeX/" sysfs directory.
> 'sgx_total_bytes' is expected to be the first of at least a few
> sgx-specific files to be placed in the new directory.  Just scanning
> /proc/meminfo, these are the no-brainers that we have for RAM, but we
> need for SGX:
>=20
> 	MemTotal:       xxxx kB // sgx_total_bytes (implemented here)
> 	MemFree:        yyyy kB // sgx_free_bytes
> 	SwapTotal:      zzzz kB // sgx_swapped_bytes
>=20
> So, at *least* three.  I think we will eventually end up needing
> something more along the lines of a dozen.  A new directory (as
> opposed to being in the nodeX/ "root") directory avoids cluttering the
> root with several "sgx_*" files.
>=20
> Place the new file in a new "nodeX/x86/" directory because SGX is
> highly x86-specific.  It is very unlikely that any other architecture
> (or even non-Intel x86 vendor) will ever implement SGX.  Using "sgx/"
> as opposed to "x86/" was also considered.  But, there is a real chance
> this can get used for other arch-specific purposes.
>=20
> [ dhansen: rewrite changelog ]
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lkml.kernel.org/r/20211116162116.93081-2-jarkko@kernel.org
> ---
>  Documentation/ABI/stable/sysfs-devices-node |  6 ++++++
>  arch/Kconfig                                |  4 ++++
>  arch/x86/Kconfig                            |  1 +
>  arch/x86/kernel/cpu/sgx/main.c              | 20 ++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/sgx.h               |  1 +
>  drivers/base/node.c                         |  3 +++
>  include/linux/numa.h                        |  4 ++++
>  7 files changed, 39 insertions(+)

Thank you! Looks good to me.

/Jarkko

