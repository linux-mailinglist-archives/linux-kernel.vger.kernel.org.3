Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA67C4F23DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiDEHD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiDEHDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:03:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675F311166;
        Tue,  5 Apr 2022 00:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1A061585;
        Tue,  5 Apr 2022 07:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC1DC3410F;
        Tue,  5 Apr 2022 07:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649142084;
        bh=qeuggA1+KO5iAMlX3bB809echedXTe6pgL4zA29sttA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfQakS2HdugbZnnhAJ9lZSZ0dfiHxwPJaNz8g2555IzKK5EjOV9kOQ0Vocce43IPA
         o6BKUwUSOuH+akcPEESjNUsFeQeBzOLixx5qTR5raKkHnklfJ2XssiWObxLSxccXhu
         dDvOOK4BTfcCC98p4UCYwJjdMQ6kpsLeWmiNxWLaRGvsfx+kvpwPBUBkZATD5R03/2
         jOrNv8JGEe7LxrywbeSxKqu/BH2jItNGZifDN2hqxZYo43wt35on0iK8q/0H5tNiQ5
         Z/2fnPcjVy13arT5H+5yYQuld47od8iALfGvMv0noIGgSvkaOpl0VhRUUNK7/DCfKo
         j7CGUA8R4qzpw==
Date:   Tue, 5 Apr 2022 10:02:35 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 21/30] selftests/sgx: Add test for EPCM permission
 changes
Message-ID: <Ykvpi6HRL9cLorw6@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <b2304ac0322d945b4bfdce36d3aae654f6ed35a0.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2304ac0322d945b4bfdce36d3aae654f6ed35a0.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:29AM -0700, Reinette Chatre wrote:
> EPCM permission changes could be made from within (to relax
> permissions) or out (to restrict permissions) the enclave. Kernel
> support is needed when permissions are restricted to be able to
> call the privileged ENCLS[EMODPR] instruction. EPCM permissions
> can be relaxed via ENCLU[EMODPE] from within the enclave but the
> enclave still depends on the kernel to install PTEs with the needed
> permissions.
> 
> Add a test that exercises a few of the enclave page permission flows:
> 1) Test starts with a RW (from enclave and kernel perspective)
>    enclave page that is mapped via a RW VMA.
> 2) Use the SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl() to restrict
>    the enclave (EPCM) page permissions to read-only.
> 3) Run ENCLU[EACCEPT] from within the enclave to accept the new page
>    permissions.
> 4) Attempt to write to the enclave page from within the enclave - this
>    should fail with a page fault on the EPCM permissions since the page
>    table entry continues to allow RW access.
> 5) Restore EPCM permissions to RW by running ENCLU[EMODPE] from within
>    the enclave.
> 6) Attempt to write to the enclave page from within the enclave - this
>    should succeed since both EPCM and PTE permissions allow this access.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - Modify test to support separation between EPCM and PTE/VMA permissions
>   - Fix changelog and comments to reflect new relationship between
>     EPCM and PTE/VMA permissions.
>   - With EPCM permissions controlling access instead of PTE permissions,
>     check for SGX error code now encountered in page fault.
>   - Stop calling SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and ensure that
>     only calling ENCLU[EMODPE] from within enclave is necessary to restore
>     access to the enclave page.
> - Update to use new struct name struct sgx_enclave_restrict_perm -> struct
>   sgx_enclave_restrict_permissions. (Jarkko)
> 
> Changes since V1:
> - Adapt test to the kernel interface changes: the ioctl() name change
>   and providing entire secinfo as parameter.
> - Remove the ENCLU[EACCEPT] call after permissions are relaxed since
>   the new flow no longer results in the EPCM PR bit being set.
> - Rewrite error path to reduce line lengths.
> 
>  tools/testing/selftests/sgx/defines.h   |  15 ++
>  tools/testing/selftests/sgx/main.c      | 218 ++++++++++++++++++++++++
>  tools/testing/selftests/sgx/test_encl.c |  38 +++++
>  3 files changed, 271 insertions(+)
> 
> diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
> index 02d775789ea7..b638eb98c80c 100644
> --- a/tools/testing/selftests/sgx/defines.h
> +++ b/tools/testing/selftests/sgx/defines.h
> @@ -24,6 +24,8 @@ enum encl_op_type {
>  	ENCL_OP_PUT_TO_ADDRESS,
>  	ENCL_OP_GET_FROM_ADDRESS,
>  	ENCL_OP_NOP,
> +	ENCL_OP_EACCEPT,
> +	ENCL_OP_EMODPE,
>  	ENCL_OP_MAX,
>  };
>  
> @@ -53,4 +55,17 @@ struct encl_op_get_from_addr {
>  	uint64_t addr;
>  };
>  
> +struct encl_op_eaccept {
> +	struct encl_op_header header;
> +	uint64_t epc_addr;
> +	uint64_t flags;
> +	uint64_t ret;
> +};
> +
> +struct encl_op_emodpe {
> +	struct encl_op_header header;
> +	uint64_t epc_addr;
> +	uint64_t flags;
> +};
> +
>  #endif /* DEFINES_H */
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index dd74fa42302e..0e0bd1c4d702 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -25,6 +25,18 @@ static const uint64_t MAGIC = 0x1122334455667788ULL;
>  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
>  vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
>  
> +/*
> + * Security Information (SECINFO) data structure needed by a few SGX
> + * instructions (eg. ENCLU[EACCEPT] and ENCLU[EMODPE]) holds meta-data
> + * about an enclave page. &enum sgx_secinfo_page_state specifies the
> + * secinfo flags used for page state.
> + */
> +enum sgx_secinfo_page_state {
> +	SGX_SECINFO_PENDING = (1 << 3),
> +	SGX_SECINFO_MODIFIED = (1 << 4),
> +	SGX_SECINFO_PR = (1 << 5),
> +};
> +
>  struct vdso_symtab {
>  	Elf64_Sym *elf_symtab;
>  	const char *elf_symstrtab;
> @@ -555,4 +567,210 @@ TEST_F(enclave, pte_permissions)
>  	EXPECT_EQ(self->run.exception_addr, 0);
>  }
>  
> +/*
> + * Enclave page permission test.
> + *
> + * Modify and restore enclave page's EPCM (enclave) permissions from
> + * outside enclave (ENCLS[EMODPR] via kernel) as well as from within
> + * enclave (via ENCLU[EMODPE]). Check for page fault if
> + * VMA allows access but EPCM permissions do not.
> + */
> +TEST_F(enclave, epcm_permissions)
> +{
> +	struct sgx_enclave_restrict_permissions restrict_ioc;
> +	struct encl_op_get_from_addr get_addr_op;
> +	struct encl_op_put_to_addr put_addr_op;
> +	struct encl_op_eaccept eaccept_op;
> +	struct encl_op_emodpe emodpe_op;
> +	struct sgx_secinfo secinfo;
> +	unsigned long data_start;
> +	int ret, errno_save;
> +
> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
> +
> +	memset(&self->run, 0, sizeof(self->run));
> +	self->run.tcs = self->encl.encl_base;
> +
> +	/*
> +	 * Ensure kernel supports needed ioctl() and system supports needed
> +	 * commands.
> +	 */
> +	memset(&restrict_ioc, 0, sizeof(restrict_ioc));
> +	memset(&secinfo, 0, sizeof(secinfo));
> +
> +	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS,
> +		    &restrict_ioc);
> +	errno_save = ret == -1 ? errno : 0;
> +
> +	/*
> +	 * Invalid parameters were provided during sanity check,
> +	 * expect command to fail.
> +	 */
> +	ASSERT_EQ(ret, -1);
> +
> +	/* ret == -1 */
> +	if (errno_save == ENOTTY)
> +		SKIP(return,
> +		     "Kernel does not support SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl()");
> +	else if (errno_save == ENODEV)
> +		SKIP(return, "System does not support SGX2");
> +
> +	/*
> +	 * Page that will have its permissions changed is the second data
> +	 * page in the .data segment. This forms part of the local encl_buffer
> +	 * within the enclave.
> +	 *
> +	 * At start of test @data_start should have EPCM as well as PTE and
> +	 * VMA permissions of RW.
> +	 */
> +
> +	data_start = self->encl.encl_base +
> +		     encl_get_data_offset(&self->encl) + PAGE_SIZE;
> +
> +	/*
> +	 * Sanity check that page at @data_start is writable before making
> +	 * any changes to page permissions.
> +	 *
> +	 * Start by writing MAGIC to test page.
> +	 */
> +	put_addr_op.value = MAGIC;
> +	put_addr_op.addr = data_start;
> +	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
> +
> +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	/*
> +	 * Read memory that was just written to, confirming that
> +	 * page is writable.
> +	 */
> +	get_addr_op.value = 0;
> +	get_addr_op.addr = data_start;
> +	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
> +
> +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EQ(get_addr_op.value, MAGIC);
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	/*
> +	 * Change EPCM permissions to read-only. Kernel still considers
> +	 * the page writable.
> +	 */
> +	memset(&restrict_ioc, 0, sizeof(restrict_ioc));
> +	memset(&secinfo, 0, sizeof(secinfo));
> +
> +	secinfo.flags = PROT_READ;
> +	restrict_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
> +	restrict_ioc.length = PAGE_SIZE;
> +	restrict_ioc.secinfo = (unsigned long)&secinfo;
> +
> +	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS,
> +		    &restrict_ioc);
> +	errno_save = ret == -1 ? errno : 0;
> +
> +	EXPECT_EQ(ret, 0);
> +	EXPECT_EQ(errno_save, 0);
> +	EXPECT_EQ(restrict_ioc.result, 0);
> +	EXPECT_EQ(restrict_ioc.count, 4096);
> +
> +	/*
> +	 * EPCM permissions changed from kernel, need to EACCEPT from enclave.
> +	 */
> +	eaccept_op.epc_addr = data_start;
> +	eaccept_op.flags = PROT_READ | SGX_SECINFO_REG | SGX_SECINFO_PR;
> +	eaccept_op.ret = 0;
> +	eaccept_op.header.type = ENCL_OP_EACCEPT;
> +
> +	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +	EXPECT_EQ(eaccept_op.ret, 0);
> +
> +	/*
> +	 * EPCM permissions of page is now read-only, expect #PF
> +	 * on EPCM when attempting to write to page from within enclave.
> +	 */
> +	put_addr_op.value = MAGIC2;
> +
> +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EQ(self->run.function, ERESUME);
> +	EXPECT_EQ(self->run.exception_vector, 14);
> +	EXPECT_EQ(self->run.exception_error_code, 0x8007);
> +	EXPECT_EQ(self->run.exception_addr, data_start);
> +
> +	self->run.exception_vector = 0;
> +	self->run.exception_error_code = 0;
> +	self->run.exception_addr = 0;
> +
> +	/*
> +	 * Received AEX but cannot return to enclave at same entrypoint,
> +	 * need different TCS from where EPCM permission can be made writable
> +	 * again.
> +	 */
> +	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
> +
> +	/*
> +	 * Enter enclave at new TCS to change EPCM permissions to be
> +	 * writable again and thus fix the page fault that triggered the
> +	 * AEX.
> +	 */
> +
> +	emodpe_op.epc_addr = data_start;
> +	emodpe_op.flags = PROT_READ | PROT_WRITE;
> +	emodpe_op.header.type = ENCL_OP_EMODPE;
> +
> +	EXPECT_EQ(ENCL_CALL(&emodpe_op, &self->run, true), 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	/*
> +	 * Attempt to return to main TCS to resume execution at faulting
> +	 * instruction, PTE should continue to allow writing to the page.
> +	 */
> +	self->run.tcs = self->encl.encl_base;
> +
> +	/*
> +	 * Wrong page permissions that caused original fault has
> +	 * now been fixed via EPCM permissions.
> +	 * Resume execution in main TCS to re-attempt the memory access.
> +	 */
> +	self->run.tcs = self->encl.encl_base;
> +
> +	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&put_addr_op, 0, 0,
> +					 ERESUME, 0, 0,
> +					 &self->run),
> +		  0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	get_addr_op.value = 0;
> +
> +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EQ(get_addr_op.value, MAGIC2);
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.user_data, 0);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +}
> +
>  TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
> index 4fca01cfd898..5b6c65331527 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -11,6 +11,42 @@
>   */
>  static uint8_t encl_buffer[8192] = { 1 };
>  
> +enum sgx_enclu_function {
> +	EACCEPT = 0x5,
> +	EMODPE = 0x6,
> +};
> +
> +static void do_encl_emodpe(void *_op)
> +{
> +	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
> +	struct encl_op_emodpe *op = _op;
> +
> +	secinfo.flags = op->flags;
> +
> +	asm volatile(".byte 0x0f, 0x01, 0xd7"
> +				:
> +				: "a" (EMODPE),
> +				  "b" (&secinfo),
> +				  "c" (op->epc_addr));
> +}
> +
> +static void do_encl_eaccept(void *_op)
> +{
> +	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
> +	struct encl_op_eaccept *op = _op;
> +	int rax;
> +
> +	secinfo.flags = op->flags;
> +
> +	asm volatile(".byte 0x0f, 0x01, 0xd7"
> +				: "=a" (rax)
> +				: "a" (EACCEPT),
> +				  "b" (&secinfo),
> +				  "c" (op->epc_addr));
> +
> +	op->ret = rax;
> +}
> +
>  static void *memcpy(void *dest, const void *src, size_t n)
>  {
>  	size_t i;
> @@ -62,6 +98,8 @@ void encl_body(void *rdi,  void *rsi)
>  		do_encl_op_put_to_addr,
>  		do_encl_op_get_from_addr,
>  		do_encl_op_nop,
> +		do_encl_eaccept,
> +		do_encl_emodpe,
>  	};
>  
>  	struct encl_op_header *op = (struct encl_op_header *)rdi;
> -- 
> 2.25.1
> 

Lacking:

KERNEL SELFTEST FRAMEWORK
M:	Shuah Khan <shuah@kernel.org>
M:	Shuah Khan <skhan@linuxfoundation.org>
L:	linux-kselftest@vger.kernel.org
S:	Maintained
Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
F:	Documentation/dev-tools/kselftest*
F:	tools/testing/selftests/

BR, Jarkko
