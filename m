Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D428466E93
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377707AbhLCAmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:42:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:25271 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343847AbhLCAmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:42:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="323130998"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="323130998"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 16:39:01 -0800
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="513454594"
Received: from msdenney-mobl.amr.corp.intel.com (HELO [10.209.114.233]) ([10.209.114.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 16:39:01 -0800
Subject: Re: [PATCH 13/25] x86/sgx: Support adding of pages to initialized
 enclave
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzShEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gPGRhdmVAc3I3MS5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCTo3k0QIZAQAKCRBoNZUwcMmSsMO2D/421Xg8pimb9mPzM5N7khT0
 2MCnaGssU1T59YPE25kYdx2HntwdO0JA27Wn9xx5zYijOe6B21ufrvsyv42auCO85+oFJWfE
 K2R/IpLle09GDx5tcEmMAHX6KSxpHmGuJmUPibHVbfep2aCh9lKaDqQR07gXXWK5/yU1Dx0r
 VVFRaHTasp9fZ9AmY4K9/BSA3VkQ8v3OrxNty3OdsrmTTzO91YszpdbjjEFZK53zXy6tUD2d
 e1i0kBBS6NLAAsqEtneplz88T/v7MpLmpY30N9gQU3QyRC50jJ7LU9RazMjUQY1WohVsR56d
 ORqFxS8ChhyJs7BI34vQusYHDTp6PnZHUppb9WIzjeWlC7Jc8lSBDlEWodmqQQgp5+6AfhTD
 kDv1a+W5+ncq+Uo63WHRiCPuyt4di4/0zo28RVcjtzlGBZtmz2EIC3vUfmoZbO/Gn6EKbYAn
 rzz3iU/JWV8DwQ+sZSGu0HmvYMt6t5SmqWQo/hyHtA7uF5Wxtu1lCgolSQw4t49ZuOyOnQi5
 f8R3nE7lpVCSF1TT+h8kMvFPv3VG7KunyjHr3sEptYxQs4VRxqeirSuyBv1TyxT+LdTm6j4a
 mulOWf+YtFRAgIYyyN5YOepDEBv4LUM8Tz98lZiNMlFyRMNrsLV6Pv6SxhrMxbT6TNVS5D+6
 UorTLotDZKp5+M7BTQRUY85qARAAsgMW71BIXRgxjYNCYQ3Xs8k3TfAvQRbHccky50h99TUY
 sqdULbsb3KhmY29raw1bgmyM0a4DGS1YKN7qazCDsdQlxIJp9t2YYdBKXVRzPCCsfWe1dK/q
 66UVhRPP8EGZ4CmFYuPTxqGY+dGRInxCeap/xzbKdvmPm01Iw3YFjAE4PQ4hTMr/H76KoDbD
 cq62U50oKC83ca/PRRh2QqEqACvIH4BR7jueAZSPEDnzwxvVgzyeuhwqHY05QRK/wsKuhq7s
 UuYtmN92Fasbxbw2tbVLZfoidklikvZAmotg0dwcFTjSRGEg0Gr3p/xBzJWNavFZZ95Rj7Et
 db0lCt0HDSY5q4GMR+SrFbH+jzUY/ZqfGdZCBqo0cdPPp58krVgtIGR+ja2Mkva6ah94/oQN
 lnCOw3udS+Eb/aRcM6detZr7XOngvxsWolBrhwTQFT9D2NH6ryAuvKd6yyAFt3/e7r+HHtkU
 kOy27D7IpjngqP+b4EumELI/NxPgIqT69PQmo9IZaI/oRaKorYnDaZrMXViqDrFdD37XELwQ
 gmLoSm2VfbOYY7fap/AhPOgOYOSqg3/Nxcapv71yoBzRRxOc4FxmZ65mn+q3rEM27yRztBW9
 AnCKIc66T2i92HqXCw6AgoBJRjBkI3QnEkPgohQkZdAb8o9WGVKpfmZKbYBo4pEAEQEAAcLB
 XwQYAQIACQUCVGPOagIbDAAKCRBoNZUwcMmSsJeCEACCh7P/aaOLKWQxcnw47p4phIVR6pVL
 e4IEdR7Jf7ZL00s3vKSNT+nRqdl1ugJx9Ymsp8kXKMk9GSfmZpuMQB9c6io1qZc6nW/3TtvK
 pNGz7KPPtaDzvKA4S5tfrWPnDr7n15AU5vsIZvgMjU42gkbemkjJwP0B1RkifIK60yQqAAlT
 YZ14P0dIPdIPIlfEPiAWcg5BtLQU4Wg3cNQdpWrCJ1E3m/RIlXy/2Y3YOVVohfSy+4kvvYU3
 lXUdPb04UPw4VWwjcVZPg7cgR7Izion61bGHqVqURgSALt2yvHl7cr68NYoFkzbNsGsye9ft
 M9ozM23JSgMkRylPSXTeh5JIK9pz2+etco3AfLCKtaRVysjvpysukmWMTrx8QnI5Nn5MOlJj
 1Ov4/50JY9pXzgIDVSrgy6LYSMc4vKZ3QfCY7ipLRORyalFDF3j5AGCMRENJjHPD6O7bl3Xo
 4DzMID+8eucbXxKiNEbs21IqBZbbKdY1GkcEGTE7AnkA3Y6YB7I/j9mQ3hCgm5muJuhM/2Fr
 OPsw5tV/LmQ5GXH0JQ/TZXWygyRFyyI2FqNTx4WHqUn3yFj8rwTAU1tluRUYyeLy0ayUlKBH
 ybj0N71vWO936MqP6haFERzuPAIpxj2ezwu0xb1GjTk4ynna6h5GjnKgdfOWoRtoWndMZxbA
 z5cecg==
Message-ID: <1669c1b8-2d68-0d2b-931d-bdbfd9085b0c@intel.com>
Date:   Thu, 2 Dec 2021 16:38:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 11:23 AM, Reinette Chatre wrote:
> +static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> +				     struct sgx_encl *encl, unsigned long addr)
> +{
> +	struct sgx_pageinfo pginfo = {0};
> +	struct sgx_encl_page *encl_page;
> +	struct sgx_epc_page *epc_page;
> +	struct sgx_va_page *va_page;
> +	unsigned long phys_addr;
> +	unsigned long prot;
> +	vm_fault_t vmret;
> +	int ret;
> +
> +	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
> +		return VM_FAULT_SIGBUS;
> +
> +	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
> +	if (!encl_page)
> +		return VM_FAULT_OOM;
> +
> +	encl_page->desc = addr;
> +	encl_page->encl = encl;
> +
> +	/*
> +	 * Adding a regular page that is architecturally allowed to only
> +	 * be created with RW permissions.
> +	 * TBD: Interface with user space policy to support max permissions
> +	 * of RWX.
> +	 */
> +	prot = PROT_READ | PROT_WRITE;
> +	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> +	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
> +
> +	epc_page = sgx_alloc_epc_page(encl_page, true);
> +	if (IS_ERR(epc_page)) {
> +		kfree(encl_page);
> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	va_page = sgx_encl_grow(encl);
> +	if (IS_ERR(va_page)) {
> +		ret = PTR_ERR(va_page);
> +		goto err_out_free;
> +	}
> +
> +	mutex_lock(&encl->lock);
> +
> +	/*
> +	 * Copy comment from sgx_encl_add_page() to maintain guidance in
> +	 * this similar flow:
> +	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
> +	 * deleting (via sgx_encl_shrink()) in the error path.
> +	 */
> +	if (va_page)
> +		list_add(&va_page->list, &encl->va_pages);
> +
> +	ret = xa_insert(&encl->page_array, PFN_DOWN(encl_page->desc),
> +			encl_page, GFP_KERNEL);
> +	/*
> +	 * If ret == -EBUSY then page was created in another flow while
> +	 * running without encl->lock
> +	 */
> +	if (ret)
> +		goto err_out_unlock;
> +
> +	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
> +	pginfo.addr = encl_page->desc & PAGE_MASK;
> +	pginfo.metadata = 0;
> +
> +	ret = __eaug(&pginfo, sgx_get_epc_virt_addr(epc_page));
> +	if (ret)
> +		goto err_out;
> +
> +	encl_page->encl = encl;
> +	encl_page->epc_page = epc_page;
> +	encl_page->type = SGX_PAGE_TYPE_REG;
> +	encl->secs_child_cnt++;
> +
> +	sgx_mark_page_reclaimable(encl_page->epc_page);
> +
> +	phys_addr = sgx_get_epc_phys_addr(epc_page);
> +	/*
> +	 * Do not undo everything when creating PTE entry fails - next #PF
> +	 * would find page ready for a PTE.
> +	 * PAGE_SHARED because protection is forced to be RW above and COW
> +	 * is not supported.
> +	 */
> +	vmret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
> +				    PAGE_SHARED);
> +	if (vmret != VM_FAULT_NOPAGE) {
> +		mutex_unlock(&encl->lock);
> +		return VM_FAULT_SIGBUS;
> +	}
> +	mutex_unlock(&encl->lock);
> +	return VM_FAULT_NOPAGE;
> +
> +err_out:
> +	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
> +
> +err_out_unlock:
> +	sgx_encl_shrink(encl, va_page);
> +	mutex_unlock(&encl->lock);
> +
> +err_out_free:
> +	sgx_encl_free_epc_page(epc_page);
> +	kfree(encl_page);
> +
> +	return VM_FAULT_SIGBUS;
> +}

There seems to be very little code sharing between this and the existing
page addition.  Are we confident that no refactoring here is in order?
