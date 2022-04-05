Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252E04F4E52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588801AbiDFARW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354664AbiDEKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:15:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15916C1F8;
        Tue,  5 Apr 2022 03:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B53CB81C98;
        Tue,  5 Apr 2022 10:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDACC385A2;
        Tue,  5 Apr 2022 10:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649152938;
        bh=hPS68ta6Tx4zhA9DEjz9ol4zuAM1pHbQpkUR5XA8yMs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y22IBL2T6dsXLg6kfNgEus0hgN6dGinZ39wTT6FuQ78x9CrB1kNDeAA2guy7GC2UY
         oFUVRXKA5o9MKHGPP5m1z9Xvaj75evHZDQ2lrEG0gS/1hO/U47SHD+0U297ejAsUXG
         KlaRwtyGWubv8gI2IR2KzbvNTvQ8QQIdogCZAwHXtEiIruCxlrgUGZadqw3E7HSkFA
         8vZgw35FOH5GL8UqhiVkw5Q6hX764u5+2Xr9/FuhMFOhtF9WiiLnsUbE5ljf/aJhhk
         etf+PVB1LX+xQzJpv5peYW3GIVflo4lXeznSD2WeWmfD2c4/jUSHPi/oFnsUwWAmua
         6CDaiaWoZyVVw==
Message-ID: <ff93ac6db5ff524159dd3261e1bdd68dcbbdddb9.camel@kernel.org>
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
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Apr 2022 13:03:28 +0300
In-Reply-To: <cd2fc405d541eec1cc80e6fbd511ab978c37aa94.camel@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
         <50b9da1f491eb31d9b038afa0d75871965f474eb.1648847675.git.reinette.chatre@intel.com>
         <cd2fc405d541eec1cc80e6fbd511ab978c37aa94.camel@kernel.org>
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

On Tue, 2022-04-05 at 08:05 +0300, Jarkko Sakkinen wrote:
> On Mon, 2022-04-04 at 09:49 -0700, Reinette Chatre wrote:
> > With SGX1 an enclave needs to be created with its maximum memory demand=
s
> > allocated. Pages cannot be added to an enclave after it is initialized.
> > SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
> > pages to an initialized enclave. With SGX2 the enclave still needs to
> > set aside address space for its maximum memory demands during enclave
> > creation, but all pages need not be added before enclave initialization=
.
> > Pages can be added during enclave runtime.
> >=20
> > Add support for dynamically adding pages to an initialized enclave,
> > architecturally limited to RW permission at creation but allowed to
> > obtain RWX permissions after enclave runs EMODPE. Add pages via the
> > page fault handler at the time an enclave address without a backing
> > enclave page is accessed, potentially directly reclaiming pages if
> > no free pages are available.
> >=20
> > The enclave is still required to run ENCLU[EACCEPT] on the page before
> > it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT]
> > on an uninitialized address. This will trigger the page fault handler
> > that will add the enclave page and return execution to the enclave to
> > repeat the ENCLU[EACCEPT] instruction, this time successful.
> >=20
> > If the enclave accesses an uninitialized address in another way, for
> > example by expanding the enclave stack to a page that has not yet been
> > added, then the page fault handler would add the page on the first
> > write but upon returning to the enclave the instruction that triggered
> > the page fault would be repeated and since ENCLU[EACCEPT] was not run
> > yet it would trigger a second page fault, this time with the SGX flag
> > set in the page fault error code. This can only be recovered by enterin=
g
> > the enclave again and directly running the ENCLU[EACCEPT] instruction o=
n
> > the now initialized address.
> >=20
> > Accessing an uninitialized address from outside the enclave also
> > triggers this flow but the page will remain inaccessible (access will
> > result in #PF) until accepted from within the enclave via
> > ENCLU[EACCEPT].
> >=20
> > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > ---
> > Changes since V2:
> > - Remove runtime tracking of EPCM permissions
> > =C2=A0 (sgx_encl_page->vm_run_prot_bits) (Jarkko).
> > - Move export of sgx_encl_{grow,shrink}() to separate patch. (Jarkko)
> > - Use sgx_encl_page_alloc(). (Jarkko)
> > - Set max allowed permissions to be RWX (Jarkko). Update changelog
> > =C2=A0 to indicate the change and use comment in code as
> > =C2=A0 created by Jarkko in:
> > https://lore.kernel.org/linux-sgx/20220306053211.135762-4-jarkko@kernel=
.org
> > - Do not set protection bits but let it be inherited by VMA (Jarkko)
> >=20
> > Changes since V1:
> > - Fix subject line "to initialized" -> "to an initialized" (Jarkko).
> > - Move text about hardware's PENDING state to the patch that introduces
> > =C2=A0 the ENCLS[EAUG] wrapper (Jarkko).
> > - Ensure kernel-doc uses brackets when referring to function.
> >=20
> > =C2=A0arch/x86/kernel/cpu/sgx/encl.c | 124 ++++++++++++++++++++++++++++=
+++++
> > =C2=A01 file changed, 124 insertions(+)
> >=20
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/e=
ncl.c
> > index 546423753e4c..fa4f947f8496 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -194,6 +194,119 @@ struct sgx_encl_page *sgx_encl_load_page(struct s=
gx_encl *encl,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __sgx_encl_load_=
page(encl, entry);
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * sgx_encl_eaug_page() - Dynamically add page to initialized enclave
> > + * @vma:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMA obtained from fa=
ult info from where page is accessed
> > + * @encl:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enclave accessing the pag=
e
> > + * @addr:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0address that triggered th=
e page fault
> > + *
> > + * When an initialized enclave accesses a page with no backing EPC pag=
e
> > + * on a SGX2 system then the EPC can be added dynamically via the SGX2
> > + * ENCLS[EAUG] instruction.
> > + *
> > + * Returns: Appropriate vm_fault_t: VM_FAULT_NOPAGE when PTE was insta=
lled
> > + * successfully, VM_FAULT_SIGBUS or VM_FAULT_OOM as error otherwise.
> > + */
> > +static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct s=
gx_encl *encl, unsigned long addr)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_pageinfo pginfo =
=3D {0};
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_encl_page *encl_p=
age;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_epc_page *epc_pag=
e;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_va_page *va_page;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long phys_addr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 secinfo_flags;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vm_fault_t vmret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!test_bit(SGX_ENCL_INITI=
ALIZED, &encl->flags))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ignore internal permissio=
n checking for dynamically added pages.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * They matter only for data=
 added during the pre-initialization
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * phase. The enclave decide=
s the permissions by the means of
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * EACCEPT, EACCEPTCOPY and =
EMODPE.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0secinfo_flags =3D SGX_SECINF=
O_R | SGX_SECINFO_W | SGX_SECINFO_X;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page =3D sgx_encl_page_=
alloc(encl, addr - encl->base, secinfo_flags);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(encl_page))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_OOM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0epc_page =3D sgx_alloc_epc_p=
age(encl_page, true);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(epc_page)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0kfree(encl_page);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0va_page =3D sgx_encl_grow(en=
cl);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(va_page)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D PTR_ERR(va_page);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err_out_free;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&encl->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Copy comment from sgx_enc=
l_add_page() to maintain guidance in
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this similar flow:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Adding to encl->va_pages =
must be done under encl->lock.=C2=A0 Ditto for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * deleting (via sgx_encl_sh=
rink()) in the error path.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (va_page)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0list_add(&va_page->list, &encl->va_pages);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D xa_insert(&encl->pag=
e_array, PFN_DOWN(encl_page->desc),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_p=
age, GFP_KERNEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If ret =3D=3D -EBUSY then=
 page was created in another flow while
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * running without encl->loc=
k
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err_out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pginfo.secs =3D (unsigned lo=
ng)sgx_get_epc_virt_addr(encl->secs.epc_page);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pginfo.addr =3D encl_page->d=
esc & PAGE_MASK;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pginfo.metadata =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D __eaug(&pginfo, sgx_=
get_epc_virt_addr(epc_page));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err_out;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->encl =3D encl;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->epc_page =3D epc_=
page;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl_page->type =3D SGX_PAGE=
_TYPE_REG;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encl->secs_child_cnt++;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sgx_mark_page_reclaimable(en=
cl_page->epc_page);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phys_addr =3D sgx_get_epc_ph=
ys_addr(epc_page);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Do not undo everything wh=
en creating PTE entry fails - next #PF
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * would find page ready for=
 a PTE.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmret =3D vmf_insert_pfn(vma=
, addr, PFN_DOWN(phys_addr));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vmret !=3D VM_FAULT_NOPA=
GE) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&encl->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&encl->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_NOPAGE;
> > +
> > +err_out:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xa_erase(&encl->page_array, =
PFN_DOWN(encl_page->desc));
> > +
> > +err_out_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sgx_encl_shrink(encl, va_pag=
e);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&encl->lock);
> > +
> > +err_out_free:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sgx_encl_free_epc_page(epc_p=
age);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(encl_page);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > +}
> > +
> > =C2=A0static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long addr =3D =
(unsigned long)vmf->address;
> > @@ -213,6 +326,17 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *v=
mf)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(!encl))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return VM_FAULT_SIGBUS;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The page_array keeps trac=
k of all enclave pages, whether they
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are swapped out or not. I=
f there is no entry for this page and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the system supports SGX2 =
then it is possible to dynamically add
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a new enclave page. This =
is only possible for an initialized
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * enclave that will be chec=
ked for right away.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cpu_feature_enabled(X86_=
FEATURE_SGX2) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!xa_load=
(&encl->page_array, PFN_DOWN(addr))))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return sgx_encl_eaug_page(vma, encl, addr);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&encl->lock)=
;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0entry =3D sgx_encl_load=
_page_in_vma(encl, addr, vma->vm_flags);
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
