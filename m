Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6947462D74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhK3H1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhK3H1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:27:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876CBC061574;
        Mon, 29 Nov 2021 23:23:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39B30B817CC;
        Tue, 30 Nov 2021 07:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC41C53FC1;
        Tue, 30 Nov 2021 07:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638257024;
        bh=F46x2qJNTqovpA/GqUsfypSWX4NyVFNu1IvSifRrJ1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZuzlWLxETXbThXuJ8MK8+XThHSqAhuXKZq+rY5fuZ7DDUeQELuyer4Fygnpn024f
         UXqELY7rGDt1m9wK1UBV5QGkTMo3K7mlZo2LFgh0iAgFfm1WajrCUrMQs8XBXxAVNx
         dJ0X3BDQUhu0A/o1SuL/oa7I67on/OK56Ajhjyo7pjPTNM/5co5C5ouMr8dKntD/6w
         ZNOHEFxusmFSR3m54Ylkd3pf37OxtzgT3hYtn0uF2XsHfRpneIuzTn5QAXqKQ8srBC
         fmSK6DHsuwZK7/zfL38EL0p/zKIUusPaOCAIUGSAyUbf5/D4ZeRjTB8ZL4g8QX2cwF
         lbqc+h/VeZH8w==
Date:   Mon, 29 Nov 2021 23:23:43 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 00/15] x86: Support Key Locker
Message-ID: <YaXRf2B+Gz6os3g5@sol.localdomain>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <YaWaGfwjLLbrBzHk@sol.localdomain>
 <6A743265-A298-435A-9D59-E3BDCFDCFD1D@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6A743265-A298-435A-9D59-E3BDCFDCFD1D@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:36:15AM +0000, Bae, Chang Seok wrote:
> On Nov 29, 2021, at 19:27, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Wed, Nov 24, 2021 at 12:06:45PM -0800, Chang S. Bae wrote:
> >> 
> >> == Non Use Cases ==
> >> 
> >> Bare metal disk encryption is the only use case intended by these patches.
> > 
> > If that's the case, why are so many encryption modes being added (ECB, CTR, CBC,
> > and XTS)?  Wouldn't just XTS be sufficient?
> 
> Right, it would reduce the crypt library changes significantly. But it is
> clueless whether XTS is sufficient to support DM-crypt, because a user may
> select the kernel’s crypto API via ‘capi:', [1].
> 

Just because dm-crypt allows you to create a ECB or CTR encrypted disk does not
mean that it is a good idea.

- Eric
