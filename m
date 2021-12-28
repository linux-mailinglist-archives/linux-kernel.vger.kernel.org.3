Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B29480A99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhL1O4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhL1O43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:56:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F336CC061574;
        Tue, 28 Dec 2021 06:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE8CBB8121D;
        Tue, 28 Dec 2021 14:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57EFC36AE7;
        Tue, 28 Dec 2021 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640703386;
        bh=68SW6igvPac0oGZ2kyZiUl7boukGMKxOfU08sgJpOQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbHPsAh6D52WeCzvedsBFfmcDF5zt7Odg2SjiB/N7nfqsnchElooP6egi2VdNnq91
         cRgCa3zz+B0PhorGfyqoj9lzaR1RFLqTxwyG0bDO/m6o1ZEA01lKeNbTEZZ/wGAoWK
         KrlMmWeXtaU2F8CPU/9+hscyrFJOG8fsdu2+/jka5ilKO06s8lkkAfj2Vfk/5fU9Rg
         8puTNw3H/PjQ8JHE2TmqX+jvFKypfObpGDIC8mArNnT1W8sSWBlPOcKY62+SOh/uYT
         K5jr54Snu7U+4Hd5bUOLkSpnj/1WyAsjLRPmELETHtduLnGENpGRhUE7Arwo3lGo5h
         eQirB661zq8nw==
Date:   Tue, 28 Dec 2021 16:56:29 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
Message-ID: <YcslnVA0lU0G0oYm@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
 <Yav0/3jeJsuT3yEq@iki.fi>
 <fff63bde-94a4-6c0c-3333-4cf392bee50b@intel.com>
 <407c12ed28b105a055c6ab6152c0458a31052963.camel@kernel.org>
 <8fc271bf-548f-969d-96db-ca78b21578f4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc271bf-548f-969d-96db-ca78b21578f4@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:12:44PM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 12/10/2021 11:57 PM, Jarkko Sakkinen wrote:
> > On Mon, 2021-12-06 at 13:42 -0800, Reinette Chatre wrote:
> > > Hi Jarkko,
> > > 
> > > On 12/4/2021 3:08 PM, Jarkko Sakkinen wrote:
> > > > On Wed, Dec 01, 2021 at 11:23:08AM -0800, Reinette Chatre wrote:
> > > > > In the initial (SGX1) version of SGX, pages in an enclave need to be
> > > > > created with permissions that support all usages of the pages, from the
> > > > > time the enclave is initialized until it is unloaded. For example,
> > > > > pages used by a JIT compiler or when code needs to otherwise be
> > > > > relocated need to always have RWX permissions.
> > > > > 
> > > > > SGX2 includes two functions that can be used to modify the enclave page
> > > > > permissions of regular enclave pages within an initialized enclave.
> > > > > ENCLS[EMODPR] is run from the OS and used to restrict enclave page
> > > > > permissions while ENCLU[EMODPE] is run from within the enclave to
> > > > > extend enclave page permissions.
> > > > > 
> > > > > Enclave page permission changes need to be approached with care and
> > > > > for this reason this initial support is to allow enclave page
> > > > > permission changes _only_ if the new permissions are the same or
> > > > > more restrictive that the permissions originally vetted at the time the
> > > > > pages were added to the enclave. Support for extending enclave page
> > > > > permissions beyond what was originally vetted is deferred.
> > > > 
> > > > This paragraph is out-of-scope for a commit message. You could have
> > > > this in the cover letter but not here. I would just remove it.
> > > 
> > > I think this is essential information that is mentioned in the cover
> > > letter _and_ in this changelog. I will follow Dave's guidance and avoid
> > > "deferred" by just removing that last sentence.
> > > 
> > > > 
> > > > > Whether enclave page permissions are restricted or extended it
> > > > > is necessary to ensure that the page table entries and enclave page
> > > > > permissions are in sync. Introduce a new ioctl, SGX_IOC_PAGE_MODP, to
> > > > 
> > > > SGX_IOC_PAGE_MODP does not match the naming convetion of these:
> > > > 
> > > > * SGX_IOC_ENCLAVE_CREATE
> > > > * SGX_IOC_ENCLAVE_ADD_PAGES
> > > > * SGX_IOC_ENCLAVE_INIT
> > > 
> > > ah - my understanding was that the SGX_IOC_ENCLAVE prefix related to
> > > operations related to the entire enclave and thus I introduced the
> > > prefix SGX_IOC_PAGE to relate to operations on pages within an enclave.
> > 
> > SGX_IOC_ENCLAVE_ADD_PAGES is also operation working on pages within an
> > enclave.
> > 
> > Also, to be aligned with SGX_IOC_ENCLAVE_ADD_PAGES, the new operations
> > should also take secinfo as input.
> 
> ok, will do.
> 
> > 
> > > 
> > > > 
> > > > A better name would be SGX_IOC_ENCLAVE_MOD_PROTECTIONS. It doesn't
> > > > do harm to be a more verbose.
> > > 
> > > Will do. I see later you propose SGX_IOC_ENCLAVE_MODIFY_TYPE - would you
> > > like them to be consistent wrt MOD/MODIFY?
> > 
> > I would considering introducing just one new ioctl:
> > 
> >    SGX_IOC_ENCLAVE_MODIFY_PAGES
> > 
> > and choose either operations based on e.g. a flag
> > (see flags field SGX_IOC_ENCLAVE_ADD_PAGES).
> > 
> 
> There seems to be different opinion about the single ioctl() as per:https://lore.kernel.org/lkml/0fb14185-5cc3-a963-253d-2e119b4a52bb@intel.com/
> 
> I thus plan to proceed with the two ioctls, both taking secinfo as input.
> Would that be ok with you?

Yeah, let's continue with two ioctls for now, I agree.

/Jarkko
