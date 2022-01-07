Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B991487796
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiAGM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiAGM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF65C061245;
        Fri,  7 Jan 2022 04:26:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD2B61E29;
        Fri,  7 Jan 2022 12:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C611CC36AE0;
        Fri,  7 Jan 2022 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641558377;
        bh=aKwLmZO6B2wjO3JzQbIVujH9UXKt1lKP5lgh1sDezbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bu97ErzTXbk7b3/b+UXvRAveEch1CwAFM1AS6DcOQY4z6AcAiPQ3VEB3fj6v4g4Ch
         fsE+HTAKyw81pppXnew33TYXVRiGRoMKQ+7BqjHf34+IzvBu9Ndf4WvjqgQ/ErL0wz
         BS8H3cpO8y8tQ8m48L+/m3LEiceRLt0niGRCadEaVD9DHyA/YOVMPsfqvHlIhU1yD9
         zH4MlfjF2Ld23DjTk9adZ1idXWL+NpfRmlXK6u3CB6I5clC+ODOINS8vP33nUh7gX3
         Y9hcg9xnySXwJpnLJsx9/zbuii9CZpSU6/CSrZF+szuZEJYdht/rI+pfC0lF3jGAeH
         k2QaZ3gdBmRnQ==
Date:   Fri, 7 Jan 2022 14:26:12 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/25] x86/sgx: Move PTE zap code to separate function
Message-ID: <YdgxZFvjrPQN2D8S@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <bd228c90c139437bb4fcc4b7b99063bfd3eb1439.1638381245.git.reinette.chatre@intel.com>
 <Yavy5JTYAkdZjnK2@iki.fi>
 <66151f3a-0e32-fc57-cb54-5b714588389b@intel.com>
 <917c53ff755d9a20e1f4bcb48c70add8364d1065.camel@kernel.org>
 <192e252a-653f-2221-73dd-99894c134a37@intel.com>
 <YcsleU6ExUbpN51r@iki.fi>
 <cf654da2-00b3-0c3c-57ad-bb669e60de92@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf654da2-00b3-0c3c-57ad-bb669e60de92@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:46:35AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 12/28/2021 6:55 AM, Jarkko Sakkinen wrote:
> > On Mon, Dec 13, 2021 at 02:11:26PM -0800, Reinette Chatre wrote:
> >> Hi Jarkko,
> >>
> >> On 12/10/2021 11:52 PM, Jarkko Sakkinen wrote:
> >>> On Mon, 2021-12-06 at 13:30 -0800, Reinette Chatre wrote:
> >>>> Hi Jarkko,
> >>>>
> >>>> On 12/4/2021 2:59 PM, Jarkko Sakkinen wrote:
> >>>>> On Wed, Dec 01, 2021 at 11:23:05AM -0800, Reinette Chatre wrote:
> >>>>>> The SGX reclaimer removes page table entries pointing to pages that are
> >>>>>> moved to swap. SGX2 enables changes to pages belonging to an initialized
> >>>>>> enclave, for example changing page permissions. Supporting SGX2 requires
> >>>>>> this ability to remove page table entries that is available in the
> >>>>>> SGX reclaimer code.
> >>>>>
> >>>>> Missing: why SGX2 requirest this?
> >>>>
> >>>> The above paragraph states that SGX2 needs to remove page table entries
> >>>> because it modifies page permissions. Could you please elaborate what is
> >>>> missing?
> >>>
> >>> It does not say why SGX2 requires an ability to remove page table entries.
> >>
> >> Are you saying that modification of EPCM page permissions is not a reason to
> >> remove page table entries pointing to those pages?
> > 
> > So you have:
> > 
> > "Supporting SGX2 requires this ability to remove page table entries that is
> > available in the SGX reclaimer code"
> > 
> > Just write down where you need this ability (briefly).
> 
> Will do. I will expand the current permission changing text and also add the need
> for this ability when regular pages are changed to TCS pages. TCS pages may not
> be accessed by enclave code so when a regular page becomes a TCS page any page
> table entries pointing to it should be removed.

Thank you, sounds good.

BR,
Jarkko
