Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5FD46885C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhLDXtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLDXtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:49:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35F2C061751;
        Sat,  4 Dec 2021 15:45:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6522B80DB3;
        Sat,  4 Dec 2021 23:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DF8C341C2;
        Sat,  4 Dec 2021 23:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638661551;
        bh=XKe8qZOtnZTZpb8XaKBay8/yu81Ozrp+KCGIgYbl+hI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7W1Hl1ZYh7LhzBZyzqFu3fjJD26O4tdo8/xveN+4EJAnfLPptidN7c5AK5rODGjP
         VsQ9Tpv2ijd0SfIQNK0hpCIO+PblnUUYDel0c2wbwkUOreCzee7mMUuBHJT/2IIAvV
         9MWs2zVEq88O5501h4X9Zr8e4fVEuGxM+yEBK8ApJ/Jnb9Ju7mmwMKLxyPbycHx2Jr
         ImNHfeA+rU3+i8dMWO+Z7VRJJB2BIxRk8pycBncMr0oHNafWrOoZIiXuRap/VNHVyD
         s+fQAS4oS7OZIm0c6qE4ZC0Pxfucw/+j+lgJcCefbkhiMD+SJi68GrIwBCMXF2cL4i
         /E+g58ZmJl7Dw==
Date:   Sun, 5 Dec 2021 01:45:47 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/25] x86/sgx: Support complete page removal
Message-ID: <Yav9q0ZfQfUIEQX3@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <737e651af6de9c0a7d43d2532047f20895d6c7d4.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737e651af6de9c0a7d43d2532047f20895d6c7d4.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:15AM -0800, Reinette Chatre wrote:
> The SGX2 page removal flow was introduced in previous patch and is
> as follows:
> 1) Change the type of the pages to be removed to SGX_PAGE_TYPE_TRIM
>    using the ioctl introduced in previous patch.
> 2) Approve the page removal by running ENCLU[EACCEPT] from within
>    the enclave.
> 3) Initiate actual page removal using the new ioctl introduced here.
> 
> Support the final step of the SGX2 page removal flow with a new ioctl.
> With this ioctl the user specifies a page range that should
> be removed. At this time all pages in the provided range should have
> the SGX_PAGE_TYPE_TRIM page type and the ioctl will fail with EPERM
> (Operation not permitted) when it encounters a page that does not have
> the correct type. Page removal can fail on any page within the
> provided range. Support partial success by returning the number of pages
> that were successfully removed.
> 
> Since actual page removal will succeed even if ENCLU[EACCEPT] was not
> run from within the enclave the ENCLU[EMODPR] instruction with RWX
> permissions is used as a no-op mechanism to ensure ENCLU[EACCEPT] was
> successfully run from within the enclave before the enclave page is
> removed.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/include/uapi/asm/sgx.h |  21 +++++
>  arch/x86/kernel/cpu/sgx/ioctl.c | 159 ++++++++++++++++++++++++++++++++
>  2 files changed, 180 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
> index f70caccd166c..6648ded960f8 100644
> --- a/arch/x86/include/uapi/asm/sgx.h
> +++ b/arch/x86/include/uapi/asm/sgx.h
> @@ -33,6 +33,8 @@ enum sgx_page_flags {
>  	_IOWR(SGX_MAGIC, 0x05, struct sgx_page_modp)
>  #define SGX_IOC_PAGE_MODT \
>  	_IOWR(SGX_MAGIC, 0x06, struct sgx_page_modt)
> +#define SGX_IOC_PAGE_REMOVE \
> +	_IOWR(SGX_MAGIC, 0x07, struct sgx_page_remove)

Should be SGX_IOC_ENCLAVE_REMOVE_PAGES.

/Jarkko
