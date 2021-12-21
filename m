Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAA47BC35
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbhLUIwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhLUIwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:52:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6FC061574;
        Tue, 21 Dec 2021 00:52:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80255B81211;
        Tue, 21 Dec 2021 08:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4600C36AE2;
        Tue, 21 Dec 2021 08:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640076751;
        bh=cTgfH3Chgz3SzxHPSaXVcyqObWYtBCdFtEJiZmv4+6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJA5ZlLczUqRya8BJ1+xQhKgfZ6m96GMzlSjxW5/+Kwc3ydaF4yBiX2HzVkSvlibI
         AowwJvtt+0iDSeyVsynxir9x+Ts75PWPcnkhvU6P1m73XyhWQyEAnnAOMWkwRdJV4L
         9J8Qi/fa4mHqxwy37saqNcskcn+Zj9t2jnX8sCZJozrHQVNcKCldu56/7+dpl6XBx+
         3xdQaBTVBjXy3Q3n972MpSA9hxQ0Oibq2hRb/qZz/2nqqQdqUIdqBhORhRoLYt9mwl
         gDNivYxrgTz1n9wvL6OUfJ26ATnMCr3NOCTzOGjma7pMC/n7h9cxDyp0WSLdQMI/b5
         DN7R08AGGIyxw==
Date:   Tue, 21 Dec 2021 10:52:30 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/25] x86/sgx: Support modifying SGX page type
Message-ID: <YcGVzsXmHrijKaFz@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <c0f04a8f7e1afd9e9319bb9f283db9a3187f7abc.1638381245.git.reinette.chatre@intel.com>
 <Yav9g4+L8zg48DRf@iki.fi>
 <dc74a876-54fe-5caa-6602-8887cfe34315@intel.com>
 <2a269a4dde2976f7aaf17de9c4a7fca3552e9c7a.camel@kernel.org>
 <0fb14185-5cc3-a963-253d-2e119b4a52bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb14185-5cc3-a963-253d-2e119b4a52bb@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:43:38AM -0800, Dave Hansen wrote:
> On 12/11/21 12:02 AM, Jarkko Sakkinen wrote:
> > On Mon, 2021-12-06 at 13:48 -0800, Reinette Chatre wrote:
> >>> I'd suggest to change this as SGX_IOC_ENCLAVE_MODIFY_TYPE.
> >> How about SGX_IOC_ENCLAVE_MOD_TYPE to be consistent with your earlier 
> >> suggestion of SGX_IOC_ENCLAVE_MOD_PROTECTIONS ?
> > I think it would be best to introduce only one new ioctl that would
> > be capable of doing either operation (and use secinfo as a vessel
> > for additional data).
> 
> Why?
> 
> I don't think we should try to multiplex within an ioctl().  Just create
> a second ioctl().

I'm fine with 2 ioctls.

/Jarkko
