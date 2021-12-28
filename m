Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A2480A98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhL1Ozx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:55:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40094 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhL1Ozw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:55:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D07E61233;
        Tue, 28 Dec 2021 14:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17F8C36AE7;
        Tue, 28 Dec 2021 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640703351;
        bh=Cji7SzNJh4009FJyVX9GTWH/NZeXoeot9/2R77gPY+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6FEn9WgfXuuQRGaxrtt5F/yywCGDmqZEP8AAo3bIlUvv3I/MtrFsR8Ju0tMUDlDe
         iTPb7wfQLt/sRNwonr0sfUnKa1rIkUHQl3F6IgK8jpsz0lYqPJTRdb7cXmIyDJHXur
         2Am7yYB+Gr89FHn4XqJ2um1BibpH266Zef067baPe61qDy4zkHHlVh8ITY5MEV8wEP
         8hH5vY7AxpEIg34aynStPadTaAOIrzHc8jU06/wdj9f+AhbghXyp5J6dSu+lH8zMOC
         iv716n90EAz3lDg0/cvG6LBAdCihpBpxVe/yL700ZOuF2fn0J8g3OVYX9TVRpI4oUd
         TAe/Xx0QxfDtg==
Date:   Tue, 28 Dec 2021 16:55:53 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/25] x86/sgx: Move PTE zap code to separate function
Message-ID: <YcsleU6ExUbpN51r@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <bd228c90c139437bb4fcc4b7b99063bfd3eb1439.1638381245.git.reinette.chatre@intel.com>
 <Yavy5JTYAkdZjnK2@iki.fi>
 <66151f3a-0e32-fc57-cb54-5b714588389b@intel.com>
 <917c53ff755d9a20e1f4bcb48c70add8364d1065.camel@kernel.org>
 <192e252a-653f-2221-73dd-99894c134a37@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192e252a-653f-2221-73dd-99894c134a37@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:11:26PM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 12/10/2021 11:52 PM, Jarkko Sakkinen wrote:
> > On Mon, 2021-12-06 at 13:30 -0800, Reinette Chatre wrote:
> > > Hi Jarkko,
> > > 
> > > On 12/4/2021 2:59 PM, Jarkko Sakkinen wrote:
> > > > On Wed, Dec 01, 2021 at 11:23:05AM -0800, Reinette Chatre wrote:
> > > > > The SGX reclaimer removes page table entries pointing to pages that are
> > > > > moved to swap. SGX2 enables changes to pages belonging to an initialized
> > > > > enclave, for example changing page permissions. Supporting SGX2 requires
> > > > > this ability to remove page table entries that is available in the
> > > > > SGX reclaimer code.
> > > > 
> > > > Missing: why SGX2 requirest this?
> > > 
> > > The above paragraph states that SGX2 needs to remove page table entries
> > > because it modifies page permissions. Could you please elaborate what is
> > > missing?
> > 
> > It does not say why SGX2 requires an ability to remove page table entries.
> 
> Are you saying that modification of EPCM page permissions is not a reason to
> remove page table entries pointing to those pages?

So you have:

"Supporting SGX2 requires this ability to remove page table entries that is
available in the SGX reclaimer code"

Just write down where you need this ability (briefly).

/Jarkko
