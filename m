Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583554F5D00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiDFL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiDFL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:58:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529E55282E1;
        Wed,  6 Apr 2022 00:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE7361B07;
        Wed,  6 Apr 2022 07:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EB4C385A1;
        Wed,  6 Apr 2022 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649230159;
        bh=WHZxYEvNQiEvtRPZJjD6sKPf3DA/I8Quteci7raP7+Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MsicdsXTVN+4lvCDpJgIPSRDbktbL6zh0EK3k2no2cKH6aQa+UN7k3DdvMSGOIJLd
         aitJqfAcYad/4kvevRDfPDeioeaIQU1B0lgdHCV+qPzGDwHZbTR0Im5mcrmsec6DzQ
         6qbEm+j55w5Tsnv1lKR6mwHIMk0uwl473EfQ6u527pNWeKbOBWt9SgfOq1Igu681Re
         AiR7DuxdTi5MAD5TkYXGCwywvY11C7WfpfpRiuPmg/u2554jkDVYHssth2rX8pqZoE
         PoagkEueDKRcOHnVSLXgvpMMV1WC6LZjIMT9jcH5riyhRBLHf+OI8Wx2GgOcTx6ela
         gno1GVqyY3O9g==
Message-ID: <2bf954521a3cfc7c677887b1eef772cfcc9e3157.camel@kernel.org>
Subject: Re: [PATCH V3 14/30] x86/sgx: Support restricting of enclave page
 permissions
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, nathaniel@profian.com
Date:   Wed, 06 Apr 2022 10:30:28 +0300
In-Reply-To: <38603303-f683-cb79-57e5-57fad5c5ae3b@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
         <8ed9ee98ca26c9eefde0fd49062bca6e7b9efe80.1648847675.git.reinette.chatre@intel.com>
         <c9071aa19076c7c618294f0c9cb830a8be96ae09.camel@kernel.org>
         <26ab773de8842d03b40caf8645ca86884b195901.camel@kernel.org>
         <91a02d50b2cba34dfb058fd864ba20ef1e6a5554.camel@kernel.org>
         <10303ca73ea02a300636580e87446766374f66cb.camel@kernel.org>
         <6e0feeadc562b9e3f0a524040469d4f5c3484824.camel@kernel.org>
         <ca08465b6fa8af4121592c6381023fda5e0ade70.camel@kernel.org>
         <59910ad4-a898-4eb2-5e2b-856c686b53fb@intel.com>
         <0f44fba956288bcad69e076f84118bc50f8e5d2f.camel@kernel.org>
         <38603303-f683-cb79-57e5-57fad5c5ae3b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-05 at 11:59 -0700, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 4/5/2022 11:39 AM, Jarkko Sakkinen wrote:
> > On Tue, 2022-04-05 at 09:49 -0700, Reinette Chatre wrote:
> > > Hi Jarkko,
> > >=20
> > > On 4/5/2022 7:52 AM, Jarkko Sakkinen wrote:
> > > > n Tue, 2022-04-05 at 17:27 +0300, Jarkko Sakkinen wrote:
> > > > > According to SDM having page type as regular is fine for EMODPR,
> > > > > i.e. that's why I did not care about having it in SECINFO.
> > > > >=20
> > > > > Given that the opcode itself contains validation, I wonder
> > > > > why this needs to be done:
> > > > >=20
> > > > > if (secinfo.flags & ~SGX_SECINFO_PERMISSION_MASK)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > >=20
> > > > > if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > >=20
> > > > > perm =3D secinfo.flags & SGX_SECINFO_PERMISSION_MASK;
> > > > >=20
> > > > > I.e. why duplicate validation and why does it have different
> > > > > invariant than the opcode?
> > > >=20
> > > > Right it is done to prevent exceptions and also pseudo-code
> > > > has this validation:
> > > >=20
> > > > IF (EPCM(DS:RCX).PT is not PT_REG) THEN #PF(DS:RCX); FI;=20
> > >=20
> > > The current type of the page is validated - not the page type
> > > provided in the parameters of the command.
> > >=20
> > > >=20
> > > > This is clearly wrong:
> > >=20
> > > Could you please elaborate what is wrong? The hardware only checks
> > > the permission bits and that is what is provided.
> >=20
> > I think it's for most a bit confusing that it takes a special Linux
> > defined SECINFO instead of what you read from spec.=20
> >=20
> > >=20
> > > >=20
> > > > /*
> > > > =C2=A0* Return valid permission fields from a secinfo structure pro=
vided by
> > > > =C2=A0* user space. The secinfo structure is required to only have =
bits in
> > > > =C2=A0* the permission fields set.
> > > > =C2=A0*/
> > > > static int sgx_perm_from_user_secinfo(void __user *_secinfo, u64 *s=
ecinfo_perm)
> > > >=20
> > > > It means that the API requires a malformed data as input.
> > >=20
> > > It is not clear to me how this is malformed. The API requires that on=
ly
> > > the permission bits are set in the secinfo, only the permission bits =
in secinfo
> > > is provided to the hardware, and the hardware only checks the permiss=
ion bits.
> > >=20
> > > >=20
> > > > Maybe it would be better idea then to replace secinfo with just the
> > > > permission field?
> > >=20
> > > That is what I implemented in V1 [1], but was asked to change to seci=
nfo. I could
> > > go back to that if you prefer.
> >=20
> > Yeah, if I was the one saying that, I was clearly wrong. But also
> > perspective is now very different after using a lot of these
> > features.
>=20
> No problem, I understand.
>=20
> I plan to replace the current "secinfo" field in struct sgx_enclave_restr=
ict_permissions
> with a new "permissions" field that contain only the permissions. Please =
let
> me know if you have concerns with this (I also discuss this more in reply=
 to
> your other message related to the page type change ioctl()).

I'm cool with it but if it is named as "permissions", then=C2=A0
it is already software-defined entity, i.e. meaning just that
have this check in place in the ioctl:

if (addp->permissions & !(PROT_READ | PROT_WRITE | PROT_EXEC))
	return -EINVAL;

BR, Jarkko
