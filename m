Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CCC4CD578
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiCDNwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiCDNwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:52:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DDF1B84CC;
        Fri,  4 Mar 2022 05:51:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708E360F7F;
        Fri,  4 Mar 2022 13:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28253C340E9;
        Fri,  4 Mar 2022 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646401883;
        bh=hc+lvWubWOKT1aKBNUngymND4LBOo6Ckf5qw8BV+5gU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=shVUR4M+OzZ/agKHU1EHornYecnKtzoFhxQ7WXZ3mPquKObEjDCa9VWRPpmyuwfzD
         Edmta7gjv9mKgo725mIt71JmjJNyWw8RKA/4U/sl9sYyarOIJLQffU2tYvVApRoXP3
         iioz3sqOiDg3svzKVQCGsNiP4boiiFLnZHkB9ohMgO+/9vjGpuriCcUQFmvnCJ3JZB
         iK0UPwVid5eTs/5R6lf4HkgX+PC1l7IB8tSI9cYI7thkTUXPMUFb9lOhdWHhLBLNFD
         ghMjc5l6nDh/KvaRwFBENn954F82ENg4o3s3CVySNlxOWhRy2bMl38YpgpHvAbcb7/
         pC6LSV0p2FjJQ==
Message-ID: <13e0c364328ed822c5d358416bb13aa5faea3195.camel@kernel.org>
Subject: Re: [PATCH RFC] x86: Add SGX_IOC_ENCLAVE_AUGMENT_PAGES
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Mar 2022 15:50:43 +0200
In-Reply-To: <20220304122852.563475-1-jarkko@kernel.org>
References: <20220304122852.563475-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 14:28 +0200, Jarkko Sakkinen wrote:
> With SGX1 an enclave needs to be created with its maximum memory demands
> allocated. Pages cannot be added to an enclave after it is initialized.
> SGX2 introduces a new function, ENCLS[EAUG], that can be used to add page=
s
> to an initialized enclave. With SGX2 the enclave still needs to set aside
> address space for its maximum memory demands during enclave creation, but
> all pages need not be added before enclave initialization. Pages can be
> added during enclave runtime.
>=20
> Add support for dynamically adding pages to an initialized enclave with
> SGX_IOC_ENCLAVE_AUGMENT_PAGES, which performs EAUG's to a given range of
> pages. Do not enforce any particular permissions from kernel, like is don=
e
> for the pages added during the pre-initialization phase, as enclave
> controls the final permissions and content for these pages by issuing
> either ENCLU[EACCEPT] (empty RW) or ENCLU[EACCEPTCOPY] (arbitrary data an=
d
> permissions).
>=20
> Explicit EAUG ioctl is a better choice than an implicit EAUG from a page
> fault handler because it allows to have O(1) number of kernel-enclave rou=
nd
> trips for EAUG-EACCEPT{COPY} process, instead of O(n), as it is in the ca=
se
> when a page fault handler EAUG single page at a time.
>=20
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Nathaniel McCallum <nathaniel@profian.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> Is contained in sgx2-v2.1 branch of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/jarkko/linux-sgx.git

I created sgx2-v2.2 branch, which has #PF EAUG removed. I
also moved selftests to the tail in the patch sets so that
it is easier to update them reflecting these and future
changes. Having them intervened makes things just complicated.

I focus now to implement mmap() for Enarx with this, so no
kselftest update just yet.

Roughly the sequence in Enarx is:

1. Enclave traps on syscall (opcode).
2. Host jumps to shim expection handler.
3. Enclave copies the mmap() arguments to a buffer outside
   the enclave.
4. Enclave exists back to the host.
5. Host performs EAUG to the mmap range.
6. Host performs mmap() to the mmap range, which succeeds
   given that vm_max_prot_bits is RWX (i.e. disabled for
   dynamic pages).
7. Host jumps back to the enclave and execution continues
   there in the mmap handler.
8. mmap handler does a series of EACCEPTCOPY operations for
   the range with given permissions and empty page as the
   input data.

Some details might differ a bit but this gives the basic idea.
I like the fact the roud-trips are kind of in control and not
variable, and it is pretty easy to use to implement the basic
syscall behaviour. This has of course some corner cases but
my sequence describes the main flow anyway.

Take it or leave it but this does give at least for me a sound
way to implement my workload. I'll use this up until my changes
have been inducted to the original patch set, or it starts to
look sane with other solutions. The original patch set simply
does not work for us at all.

BR, Jarkko
