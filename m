Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44B7494E76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiATM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:58:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36758 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiATM6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:58:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E755C616F2;
        Thu, 20 Jan 2022 12:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC7EC340E0;
        Thu, 20 Jan 2022 12:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642683492;
        bh=PjsGNV1TcOlrmGioweXTIZy082puxUuggsqwMwI5MpU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mx1W0FiMlD35wnnWBZfIXrXLDShM3EwMl1GNK30GOr7khcsY3oXmwRX5jgHz+yVRw
         Qn+IrwNTxZkvR1KtBDtich2OaVcjzsSzyb/WnAehzDJh5TFx4sf9M/ylVazu+1BVhL
         NrD9PH/J+5R9BODGMuddhCf7Ske77FeYXHvOfLtCz6TBHhkems4fy7pNl/vkS+nwNu
         lR54GWBs8r6htUqebRIN0GC5mhCgt9TfVDiSEVYAxKzSlnrXAeNPV/ZTSFO4rXV6kH
         vkqfmgNHLqnSPNiBWj5zEyP9P/4kJHbZ5IQGlkfKT9np+UP+sZd1OMGqBZMsvV0IeL
         GnRfFLMNKn4qg==
Message-ID: <80083e5ca3fd0a5bd2de43ebc803fc914d09ac3c.camel@kernel.org>
Subject: Re: [PATCH] x86/sgx: Add poison handling to reclaimer
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 20 Jan 2022 14:57:56 +0200
In-Reply-To: <ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com>
References: <ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 15:05 -0800, Reinette Chatre wrote:
> The machine check recovery handling in SGX added the changes
> listed below to the freeing of pages in sgx_free_epc_page().
> The SGX reclaimer contains an open coded version of
> sgx_free_epc_page() and thus did not obtain the changes in
> support of poison handling.
>=20
> The changes made to EPC page freeing in support of poison handling
> are:
> 1) A new SGX_EPC_PAGE_IS_FREE flag is set when the EPC page is
> =C2=A0=C2=A0 freed. Introduced in commit d6d261bded8a ("x86/sgx: Add new
> =C2=A0=C2=A0 sgx_epc_page flag bit to mark free pages").
> 2) A new "poison" field in struct sgx_epc_page is used to
> =C2=A0=C2=A0 determine whether a newly freed EPC page should be placed
> =C2=A0=C2=A0 on the list of poisoned or list of free pages. Introduced
> =C2=A0=C2=A0 in commit 992801ae9243 ("x86/sgx: Initial poison handling
> =C2=A0=C2=A0 for dirty and free pages").
> 3) The owner field in struct sgx_epc_page is cleared when the EPC
> =C2=A0=C2=A0 page is freed.=C2=A0 Introduced in commit 992801ae9243 ("x86=
/sgx:
> =C2=A0=C2=A0 Initial poison handling for dirty and free pages").
>=20
> Replace the open coded enclave page freeing code in the reclaimer
> with sgx_free_epc_page() to obtain support for poison page handling.
>=20
> Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark
> free pages")

AFAIK, this patch does not semantically break anything so it is not
a legit fixes tag.

BR, Jarkko
