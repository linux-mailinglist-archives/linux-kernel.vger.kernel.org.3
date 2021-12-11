Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8147147B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhLKPgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLKPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:36:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7622C061714;
        Sat, 11 Dec 2021 07:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 63688CE094C;
        Sat, 11 Dec 2021 15:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3763C004DD;
        Sat, 11 Dec 2021 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639236995;
        bh=cF1A5jbPqge4rANTbCPUUfKutHCzr7QR7uCHRv4qXi0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j6Qk1xF7jgVkoGnjV3SqPCZ5dkkRFjKppH4Xd4AlQ13H7eaZOIt+UV/oS6a5fKGED
         OFqSAuEXDMjRTzTEV2x3u0tO7nF1saG4+Jx6Hv28l8hGImmW3W0jyuCCAw1FFzR53n
         yMPPm6f29MK9zT+NN6Ma7WxrJogXAKOQvpNJqpETjSAuMSLQME6/T8kqYAzVkZdCxq
         yuu/XjMdExdC7ABaEWKd2LZypFCLW9B/PsjSs1caCO67hvYV1WCMYvufcCOOJpHnVw
         ZZbMQXMde5/4l0d15pvXyhaEX/tGRB8ySSOD0fvEMGucOoiuwRje3elVaOJe+d7cU5
         sw+ydLt/q0dIA==
Message-ID: <d6ec8429763db7ddba42d9ff658a929b274f2711.camel@kernel.org>
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org
Date:   Sat, 11 Dec 2021 17:36:31 +0200
In-Reply-To: <f25d95e6-e129-597b-5d93-d7264feae8b8@intel.com>
References: <20211116162116.93081-1-jarkko@kernel.org>
         <20211116162116.93081-2-jarkko@kernel.org>
         <f25d95e6-e129-597b-5d93-d7264feae8b8@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-07 at 11:36 -0800, Dave Hansen wrote:
> On 11/16/21 8:21 AM, Jarkko Sakkinen wrote:
> > The amount of SGX memory on the system is determined by the BIOS and it
> > varies wildly between systems.  It can be from dozens of MB's on deskto=
ps
> > or VM's, up to many GB's on servers.  Just like for regular memory, it =
is
> > sometimes useful to know the amount of usable SGX memory in the system.
> >=20
> > Introduce CONFIG_HAVE_ARCH_NODE_DEV_GROUP opt-in flag to expose an arch
> > specific attribute group, and add an attribute for the amount of SGX
> > memory in bytes to each NUMA node:
> >=20
> > /sys/devices/system/node/nodeX/x86/sgx_total_bytes
>=20
> There's some context missing here:
>=20
> This serves the same function for SGX memory as /proc/meminfo or
> /sys/devices/system/node/nodeX/meminfo does for normal RAM.  It
> enumerates how much physical SGX memory is present so that you can size
> enclaves on different systems.
>=20
> This specific file (sgx_total_bytes) is needed today to help drive the
> SGX selftests.  The SGX selftests need to create overcommitted enclaves
> which are larger than the physical SGX memory on the system.  They
> currently use a CPUID-based approach which can diverge from the actual
> amount of SGX memory available.  This file ensures that the selftests
> can work efficiently and do not attempt stupid things like creating a
> 100,000 MB enclave on a system with 128 MB  of SGX memory.
>=20
> The nodeX/x86 directory is used because SGX is highly x86-specific.
> It's very unlikely that any other architecture (or even non-Intel x86
> vendor) will ever implement SGX.  It needs its own directory (as opposed
> to being in the nodeX/ "root") because this is expected to be the first
> of a few different things that need to get exported.  This avoids
> cluttering the root with several "sgx_*" files.
>=20
> How many of these files will there be?  Just scanning /proc/meminfo,
> these are the no-brainers that we have for RAM, but we need for SGX:
>=20
> MemTotal:       xxxx kB // sgx_total_bytes (this patch)
> MemFree:        yyyy kB // sgx_free_bytes
> SwapTotal:      zzzz kB // sgx_swapped_bytes
>=20
> So, at *least* three.  I think we will eventually end up needing
> something more along the lines of a dozen.

These three I've had in mind for the moment. The latter two will be
trivial to add now that we have pattern how to add the sysfs attribute
in the correct way.

/Jarkko
