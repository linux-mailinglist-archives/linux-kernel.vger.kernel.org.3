Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D8F494E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbiATNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359696AbiATNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:09:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92523C06173F;
        Thu, 20 Jan 2022 05:09:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33BF56171C;
        Thu, 20 Jan 2022 13:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16837C340E0;
        Thu, 20 Jan 2022 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684158;
        bh=B/A4UPVf4GNLpx96eUOAeOf78iuwBGAiJPieKTrPAV8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oXrEZE4JIOC7YBOt6qZtAh5coTwdSFOypRTAx2nFV/JJvgc39Dwtfr9nfToEV8OC/
         LR/qFukBwJYJjgNV5zzFGqrqrZQY15x0X6wyBlK6NEQ3vuPX4pOfR+kovmVWysl5Lk
         n9MxQ8adK72vgS7J9DaBk7pBm6Fma6VUfGoI5EurAl8TeuLhCyQGgnm2/7BJ8gjyTC
         c40X5h8QLVNOx1NN4BopqEleHq77W/LzqU+g0BGik+XjBymmCUKJcMTJamCZMManFn
         InLCBO+Mg52uV0cnSd/VBmkwGCLIAx6XlJ57sZA0s3hijGMCvY6iZSBx9GaG9dhfF/
         ADeybHu1kaicQ==
Message-ID: <3bfe66204ee84a0bbccaf7cd20af0d8300fb9f26.camel@kernel.org>
Subject: Re: [PATCH V2] x86/sgx: Add poison handling to reclaimer
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 20 Jan 2022 15:09:03 +0200
In-Reply-To: <be5af586f667c7bcb8ef01286ce75675de5d100f.1642630582.git.reinette.chatre@intel.com>
References: <be5af586f667c7bcb8ef01286ce75675de5d100f.1642630582.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 14:23 -0800, Reinette Chatre wrote:
> The SGX reclaimer code lacks page poison handling in its main
> free path. This can lead to avoidable machine checks if a
> poisoned page is freed and reallocated instead of being
> isolated.
>=20
> A troublesome scenario is:
> =C2=A01. Machine check (#MC) occurs (asynchronous, !MF_ACTION_REQUIRED)
> =C2=A02. arch_memory_failure() is eventually called
> =C2=A03. (SGX) page->poison set to 1
> =C2=A04. Page is reclaimed
> =C2=A05. Page added to normal free lists by sgx_reclaim_pages()
> =C2=A0=C2=A0=C2=A0 ^ This is the bug (poison pages should be isolated on =
the
> =C2=A0=C2=A0=C2=A0 sgx_poison_page_list instead)
> =C2=A06. Page is reallocated by some innocent enclave, a second
> (synchronous)
> =C2=A0=C2=A0=C2=A0 in-kernel #MC is induced, probably during EADD instruc=
tion.
> =C2=A0=C2=A0=C2=A0 ^ This is the fallout from the bug
>=20
> (6) is unfortunate and can be avoided by replacing the open coded
> enclave page freeing code in the reclaimer with sgx_free_epc_page()
> to obtain support for poison page handling that includes placing the
> poisoned page on the correct list.
>=20
> Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark
> free pages")
> Fixes: 992801ae9243 ("x86/sgx: Initial poison handling for dirty and
> free pages")

Same comment as for the first version: remove the first fixes tag.

BR, Jarkko
