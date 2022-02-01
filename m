Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA0F4A5DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiBANt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:49:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42810 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiBANt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:49:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 583F561583
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306EDC340ED;
        Tue,  1 Feb 2022 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643723397;
        bh=/Hg8E9Pk4hej0EhFBXxNBNhhet6Vx2vqNwjmgDpTRT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IED3C+BcZFpGUJ6n5jyXgyP7/J2rum9VuGPj0zhpf00AMfFEFgDm0qqNj6jNinT0i
         ACxR7aryfmVWeWnN2QwtkFUap/gzab7t1c/Elv0ElIe7+adv7yHEBQhwbCGAsIMFJk
         zJW0ih3DwBlb5Q20OSCQhW4UYvDUoUbi4obnqG+M=
Date:   Tue, 1 Feb 2022 14:49:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        George Wilson <gcwilson@linux.ibm.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>, gjoyce@ibm.com,
        linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [RFC PATCH 0/2] powerpc/pseries: add support for local secure
 storage called Platform Keystore(PKS)
Message-ID: <Yfk6gucNmJuR/egi@kroah.com>
References: <20220122005637.28199-1-nayna@linux.ibm.com>
 <YeuyUVVdFADCuDr4@kroah.com>
 <87sftec74i.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sftec74i.fsf@dja-thinkpad.axtens.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:25:17AM +1100, Daniel Axtens wrote:
> Hi Greg,
> 
> > Ok, this is like the 3rd or 4th different platform-specific proposal for
> > this type of functionality.  I think we need to give up on
> > platform-specific user/kernel apis on this (random sysfs/securityfs
> > files scattered around the tree), and come up with a standard place for
> > all of this.
> 
> I agree that we do have a number of platforms exposing superficially
> similar functionality. Indeed, back in 2019 I had a crack at a unified
> approach: [1] [2].
> 
> Looking back at it now, I am not sure it ever would have worked because
> the semantics of the underlying firmware stores are quite
> different. Here are the ones I know about:
> 
>  - OpenPower/PowerNV Secure Variables:
>  
>    * Firmware semantics:
>      - flat variable space
>      - variables are fixed in firmware, can neither be created nor
>         destroyed
>      - variable names are ASCII
>      - no concept of policy/attributes
>      
>    * Current kernel interface semantics:
>      - names are case sensitive
>      - directory per variable     
> 
> 
>  - (U)EFI variables:
>  
>    * Firmware semantics:
>      - flat variable space
>      - variables can be created/destroyed but the semantics are fiddly
>         [3]
>      - variable names are UTF-16 + UUID
>      - variables have 32-bit attributes
> 
>    * efivarfs interface semantics:
>      - file per variable
>      - attributes are the first 4 bytes of the file
>      - names are partially case-insensitive (UUID part) and partially
>         case-sensitive ('name' part)
> 
>    * sysfs interface semantics (as used by CONFIG_GOOGLE_SMI)
>      - directory per variable
>      - attributes are a separate sysfs file
>      - to create a variable you write a serialised structure to
>         `/sys/firmware/efi/vars/new_var`, to delete a var you write
>         to `.../del_var`
>      - names are case-sensitive including the UUID
> 
> 
>  - PowerVM Partition Key Store Variables:
>  
>    * Firmware semantics:
>      - _not_ a flat space, there are 3 domains ("consumers"): firmware,
>         bootloader and OS (not yet supported by the patch set)
>      - variables can be created and destroyed but the semantics are
>         fiddly and fiddly in different ways to UEFI [4]
>      - variable names are arbitrary byte strings: the hypervisor permits
>         names to contain nul and /.
>      - variables have 32-bit attributes ("policy") that don't align with
>         UEFI attributes
> 
>    * No stable kernel interface yet
> 
> Even if we could come up with some stable kernel interface features
> (e.g. decide if we want file per variable vs directory per variable), I
> don't know how easy it would be to deal with the underlying semantic
> differences - I think userspace would still need substantial
> per-platform knowledge.
> 
> Or have I misunderstood what you're asking for? (If you want them all to
> live under /sys/firmware, these ones all already do...)

I want them to be unified in some way, right now there are lots of
proposals for the same type of thing, but in different places (sysfs,
securityfs, somewhere else), and with different names.

Please work together.

thanks,

greg k-h
