Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0494F5BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiDFLNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbiDFLL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:11:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7A53949E;
        Wed,  6 Apr 2022 00:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72178B82134;
        Wed,  6 Apr 2022 07:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C4C385A1;
        Wed,  6 Apr 2022 07:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649230575;
        bh=jK09Dxtu5aRITsQz+c7O26Lytnt1MxXldEiiuHkjlhU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ruLd7HM3XuPWc1aEUmSfTgNbujyOoUqZzy1SRJEGjLSQJgnLtGxwNi78tWemCtUvE
         VVg1U37SU4Gu7JLxtVUzgrFWZMScQP+HDGLucxtoWELIeDizS+TjMirLalMTlj8kuI
         GKrZCqvBhK84UdDYIsWtvIIpSW+IR/dvZ9tyATwgc1IALz72xPR1ynUT3cwvKjo5if
         305sRokdoRsCZqSAbcgqTLr+ct9VFpifJsZcGLw0IzAWUgqJCHrt2sEgkVbScWeEy3
         bEquNIybuqmDBa3Aj9DMtYAL+T1ym7lXfJZ9pP1hca0xYOhGSjmNyqNwU6MyIbKmxW
         ZMiLo49G6/dFw==
Message-ID: <fbe3851924a49e10b5f20160ef99a8075fb4f7b8.camel@kernel.org>
Subject: Re: [PATCH V3 15/30] x86/sgx: Support adding of pages to an
 initialized enclave
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, nathaniel@profian.com,
        harald@profian.com
Date:   Wed, 06 Apr 2022 10:37:25 +0300
In-Reply-To: <ff93ac6db5ff524159dd3261e1bdd68dcbbdddb9.camel@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
         <50b9da1f491eb31d9b038afa0d75871965f474eb.1648847675.git.reinette.chatre@intel.com>
         <cd2fc405d541eec1cc80e6fbd511ab978c37aa94.camel@kernel.org>
         <ff93ac6db5ff524159dd3261e1bdd68dcbbdddb9.camel@kernel.org>
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

On Tue, 2022-04-05 at 13:03 +0300, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 08:05 +0300, Jarkko Sakkinen wrote:
> > On Mon, 2022-04-04 at 09:49 -0700, Reinette Chatre wrote:
> > > With SGX1 an enclave needs to be created with its maximum memory dema=
nds
> > > allocated. Pages cannot be added to an enclave after it is initialize=
d.
> > > SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
> > > pages to an initialized enclave. With SGX2 the enclave still needs to
> > > set aside address space for its maximum memory demands during enclave
> > > creation, but all pages need not be added before enclave initializati=
on.
> > > Pages can be added during enclave runtime.
> > >=20
> > > Add support for dynamically adding pages to an initialized enclave,
> > > architecturally limited to RW permission at creation but allowed to
> > > obtain RWX permissions after enclave runs EMODPE. Add pages via the
> > > page fault handler at the time an enclave address without a backing
> > > enclave page is accessed, potentially directly reclaiming pages if
> > > no free pages are available.
> > >=20
> > > The enclave is still required to run ENCLU[EACCEPT] on the page befor=
e
> > > it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT=
]
> > > on an uninitialized address. This will trigger the page fault handler
> > > that will add the enclave page and return execution to the enclave to
> > > repeat the ENCLU[EACCEPT] instruction, this time successful.
> > >=20
> > > If the enclave accesses an uninitialized address in another way, for
> > > example by expanding the enclave stack to a page that has not yet bee=
n
> > > added, then the page fault handler would add the page on the first
> > > write but upon returning to the enclave the instruction that triggere=
d
> > > the page fault would be repeated and since ENCLU[EACCEPT] was not run
> > > yet it would trigger a second page fault, this time with the SGX flag
> > > set in the page fault error code. This can only be recovered by enter=
ing
> > > the enclave again and directly running the ENCLU[EACCEPT] instruction=
 on
> > > the now initialized address.
> > >=20
> > > Accessing an uninitialized address from outside the enclave also
> > > triggers this flow but the page will remain inaccessible (access will
> > > result in #PF) until accepted from within the enclave via
> > > ENCLU[EACCEPT].
> > >=20
> > > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > > ---
> > > Changes since V2:
> > > - Remove runtime tracking of EPCM permissions
> > > =C2=A0 (sgx_encl_page->vm_run_prot_bits) (Jarkko).
> > > - Move export of sgx_encl_{grow,shrink}() to separate patch. (Jarkko)
> > > - Use sgx_encl_page_alloc(). (Jarkko)
> > > - Set max allowed permissions to be RWX (Jarkko). Update changelog
> > > =C2=A0 to indicate the change and use comment in code as
> > > =C2=A0 created by Jarkko in:
> > > https://lore.kernel.org/linux-sgx/20220306053211.135762-4-jarkko@kern=
el.org
> > > - Do not set protection bits but let it be inherited by VMA (Jarkko)
> > >=20
> > > Changes since V1:
> > > - Fix subject line "to initialized" -> "to an initialized" (Jarkko).
> > > - Move text about hardware's PENDING state to the patch that introduc=
es
> > > =C2=A0 the ENCLS[EAUG] wrapper (Jarkko).
> > > - Ensure kernel-doc uses brackets when referring to function.
> > >=20
> > > =C2=A0arch/x86/kernel/cpu/sgx/encl.c | 124 ++++++++++++++++++++++++++=
+++++++
> > > =C2=A01 file changed, 124 insertions(+)
> > >=20
> > > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx=
/encl.c
> > > index 546423753e4c..fa4f947f8496 100644
> > > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > > @@ -194,6 +194,119 @@ struct sgx_encl_page *sgx_encl_load_page(struct=
 sgx_encl *encl,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __sgx_encl_loa=
d_page(encl, entry);
> > > =C2=A0}
> > > =C2=A0
> > > +/**
> > > + * sgx_encl_eaug_page() - Dynamically add page to initialized enclav=
e
> > > + * @vma:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMA obtained from =
fault info from where page is accessed
> > > + * @encl:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enclave accessing the p=
age
> > > + * @addr:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0address that triggered =
the page fault
> > > + *
> > > + * When an initialized enclave accesses a page with no backing EPC p=
age
> > > + * on a SGX2 system then the EPC can be added dynamically via the SG=
X2
> > > + * ENCLS[EAUG] instruction.
> > > + *
> > > + * Returns: Appropriate vm_fault_t: VM_FAULT_NOPAGE when PTE was ins=
talled
> > > + * successfully, VM_FAULT_SIGBUS or VM_FAULT_OOM as error otherwise.
> > > + */
> > > +static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t sgx_encl *encl, unsigned long addr)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_pageinfo pginfo=
 =3D {0};
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_encl_page *encl=
_page;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_epc_page *epc_p=
age;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_va_page *va_pag=
e;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long phys_addr;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 secinfo_flags;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vm_fault_t vmret;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!test_bit(SGX_ENCL_INI=
TIALIZED, &encl->flags))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ignore internal permiss=
ion checking for dynamically added pages.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * They matter only for da=
ta added during the pre-initialization
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * phase. The enclave deci=
des the permissions by the means of
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * EACCEPT, EACCEPTCOPY an=
d EMODPE.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0secinfo_flags =3D SGX_SECI=
NFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page =3D sgx_encl_pag=
e_alloc(encl, addr - encl->base, secinfo_flags);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(encl_page))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_OOM;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0epc_page =3D sgx_alloc_epc=
_page(encl_page, true);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(epc_page)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0kfree(encl_page);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_page =3D sgx_encl_grow(=
encl);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(va_page)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D PTR_ERR(va_page);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err_out_free;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&encl->lock);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Copy comment from sgx_e=
ncl_add_page() to maintain guidance in
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this similar flow:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Adding to encl->va_page=
s must be done under encl->lock.=C2=A0 Ditto for
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * deleting (via sgx_encl_=
shrink()) in the error path.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (va_page)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0list_add(&va_page->list, &encl->va_pages);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D xa_insert(&encl->p=
age_array, PFN_DOWN(encl_page->desc),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enc=
l_page, GFP_KERNEL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If ret =3D=3D -EBUSY th=
en page was created in another flow while
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * running without encl->l=
ock
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err_out_unlock;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pginfo.secs =3D (unsigned =
long)sgx_get_epc_virt_addr(encl->secs.epc_page);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pginfo.addr =3D encl_page-=
>desc & PAGE_MASK;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pginfo.metadata =3D 0;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D __eaug(&pginfo, sg=
x_get_epc_virt_addr(epc_page));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err_out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->encl =3D encl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->epc_page =3D ep=
c_page;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->type =3D SGX_PA=
GE_TYPE_REG;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl->secs_child_cnt++;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sgx_mark_page_reclaimable(=
encl_page->epc_page);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phys_addr =3D sgx_get_epc_=
phys_addr(epc_page);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Do not undo everything =
when creating PTE entry fails - next #PF
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * would find page ready f=
or a PTE.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmret =3D vmf_insert_pfn(v=
ma, addr, PFN_DOWN(phys_addr));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vmret !=3D VM_FAULT_NO=
PAGE) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&encl->lock);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&encl->lock);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_NOPAGE;
> > > +
> > > +err_out:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xa_erase(&encl->page_array=
, PFN_DOWN(encl_page->desc));
> > > +
> > > +err_out_unlock:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sgx_encl_shrink(encl, va_p=
age);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&encl->lock);
> > > +
> > > +err_out_free:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sgx_encl_free_epc_page(epc=
_page);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(encl_page);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > > +}
> > > +
> > > =C2=A0static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long addr =
=3D (unsigned long)vmf->address;
> > > @@ -213,6 +326,17 @@ static vm_fault_t sgx_vma_fault(struct vm_fault =
*vmf)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(!encl))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The page_array keeps tr=
ack of all enclave pages, whether they
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are swapped out or not.=
 If there is no entry for this page and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the system supports SGX=
2 then it is possible to dynamically add
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a new enclave page. Thi=
s is only possible for an initialized
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * enclave that will be ch=
ecked for right away.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cpu_feature_enabled(X8=
6_FEATURE_SGX2) &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!xa_lo=
ad(&encl->page_array, PFN_DOWN(addr))))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return sgx_encl_eaug_page(vma, encl, addr);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&encl->loc=
k);
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0entry =3D sgx_encl_lo=
ad_page_in_vma(encl, addr, vma->vm_flags);
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

For what is worth I also get a full pass with our test suite,
where the runtime is using EAUG together with EACCEPTCOPY:

    Finished test [unoptimized + debuginfo] target(s) in 0.26s
     Running unittests src/main.rs (target/debug/deps/enarx-ee7f422740eab40=
4)

running 7 tests
test backend::sgx::attestation::tests::request_target_info ... ignored
test backend::sev::snp::tests::test_const_id_macro ... ok
test backend::sev::snp::firmware::test::test_vcek_url ... ok
test backend::sgx::ioctls::tests::restrict_permissions ... ok
test cli::snp::tests::test_empty_cache_path ... ok
test workldr::wasmldr::test::is_builtin ... ok
test cli::snp::tests::test_get_or_write ... ok

test result: ok. 6 passed; 0 failed; 1 ignored; 0 measured; 0 filtered out;=
 finished in 0.20s

     Running tests/c_integration_tests.rs (target/debug/deps/c_integration_=
tests-f7a69c2274f59f90)

running 21 tests
test get_att ... ignored
test bind ... ok
test clock_gettime ... ok
test close ... ok
test exit_one ... ok
test getegid ... ok
test geteuid ... ok
test sgx_get_att_quote ... ignored
test sgx_get_att_quote_size ... ignored
test exit_zero ... ok
test getgid ... ok
test write_emsgsize ... ignored
test write_stderr ... ignored
test getuid ... ok
test listen ... ok
test read ... ok
test read_udp ... ok
test readv ... ok
test socket ... ok
test uname ... ok
test write_stdout ... ok

test result: ok. 16 passed; 0 failed; 5 ignored; 0 measured; 0 filtered out=
; finished in 18.46s

     Running tests/rust_integration_tests.rs (target/debug/deps/rust_integr=
ation_tests-0122fb231e20ea63)

running 6 tests
test rust_sev_attestation ... ignored
test echo ... ok
test cpuid ... ok
test memory_stress_test ... ok
test memspike ... ok
test unix_echo ... ok

test result: ok. 5 passed; 0 failed; 1 ignored; 0 measured; 0 filtered out;=
 finished in 48.22s

     Running tests/wasmldr_tests.rs (target/debug/deps/wasmldr_tests-98b6ff=
656b9d815e)

running 9 tests
test check_tcp ... ok
test hello_wasi_snapshot1 ... ok
test memspike ... ok
test echo has been running for over 60 seconds
test memory_stress_test has been running for over 60 seconds
test no_export has been running for over 60 seconds
test return_1 has been running for over 60 seconds
test wasi_snapshot1 has been running for over 60 seconds
test memory_stress_test ... ok
Error: default export in '' is not a function
test no_export ... ok
test return_1 ... ok
test wasi_snapshot1 ... ok
test zerooneone ... ok
test echo ... ok

test result: ok. 9 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out;=
 finished in 102.75s

BR, Jarkko
