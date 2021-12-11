Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8310D471296
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 08:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhLKHwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 02:52:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58490 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 02:52:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E6F2DCE2F30;
        Sat, 11 Dec 2021 07:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6D2C004DD;
        Sat, 11 Dec 2021 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639209134;
        bh=3cmlYiZfvEvce9dE5Zb6G0iPDgODFBSuLd4Q6ByWMkc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=McS99EN6U03g3uukch/q6ysF5OA1Bc56b1F2UgL+4TJ4ATAiQkWUnlYbDbAG3qhPJ
         mY58wprpAkXVyfveCophFPINd6T1CFXFIJOg5y6xK7ZOLz9P1+6G/9U3pqvHxmba7Z
         96aKSg9RP24u3kY61EJarwkk/4/fSkURLTtDot0BkwCJbvAEwZhSAZVLUtKxqlSFbL
         KkBDKKka5AnwtqA5Lft7N/IMIOzdjQfG/4P9GHEX/LBkcNPo1MEEWwcp32MRSfJJNZ
         1KVGic1uHl9Nx54AchG8qKhV7o3sdV6dTyAdvOfkOZXDBa19WeV99EcFZCYNEfEmMr
         N4OAXGA/4YXcw==
Message-ID: <917c53ff755d9a20e1f4bcb48c70add8364d1065.camel@kernel.org>
Subject: Re: [PATCH 07/25] x86/sgx: Move PTE zap code to separate function
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 09:52:11 +0200
In-Reply-To: <66151f3a-0e32-fc57-cb54-5b714588389b@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <bd228c90c139437bb4fcc4b7b99063bfd3eb1439.1638381245.git.reinette.chatre@intel.com>
         <Yavy5JTYAkdZjnK2@iki.fi> <66151f3a-0e32-fc57-cb54-5b714588389b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:30 -0800, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 12/4/2021 2:59 PM, Jarkko Sakkinen wrote:
> > On Wed, Dec 01, 2021 at 11:23:05AM -0800, Reinette Chatre wrote:
> > > The SGX reclaimer removes page table entries pointing to pages that a=
re
> > > moved to swap. SGX2 enables changes to pages belonging to an initiali=
zed
> > > enclave, for example changing page permissions. Supporting SGX2 requi=
res
> > > this ability to remove page table entries that is available in the
> > > SGX reclaimer code.
> >=20
> > Missing: why SGX2 requirest this?
>=20
> The above paragraph states that SGX2 needs to remove page table entries=
=20
> because it modifies page permissions. Could you please elaborate what is=
=20
> missing?

It does not say why SGX2 requires an ability to remove page table entries.

/Jarkko
