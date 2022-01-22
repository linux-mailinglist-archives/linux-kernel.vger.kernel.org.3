Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F587496A9C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiAVH3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:29:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54488 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiAVH3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:29:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E8560915
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 07:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2B9C004E1;
        Sat, 22 Jan 2022 07:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642836570;
        bh=cMWRKsI8TI2NHT84jTQS/VsDVS8oI5QJbf0MXIj7kt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pI1ceGoVu3CvLVt/6heTjt81u7y+XDx/Uw6BOOSObPJW4WPvVtM5NhbPo6poe2GPQ
         tdZKznbXRQN+CEn4N451Wc8DtVhEyKoAlz4/PwX2FXWc6KDagqwQgHn9TU7nRGlxrr
         UIb/aGYJKpTrwLWT6QFH4a5O2fl+WFVq49KXzpCM=
Date:   Sat, 22 Jan 2022 08:29:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        George Wilson <gcwilson@linux.ibm.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>, gjoyce@ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] powerpc/pseries: add support for local secure
 storage called Platform Keystore(PKS)
Message-ID: <YeuyUVVdFADCuDr4@kroah.com>
References: <20220122005637.28199-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122005637.28199-1-nayna@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 07:56:35PM -0500, Nayna Jain wrote:
> PowerVM provides an isolated Platform Keystore(PKS) storage allocation
> for each partition with individually managed access controls to store
> sensitive information securely. Linux Kernel can access this storage by
> interfacing with hypervisor using a new set of hypervisor calls. 
> 
> PowerVM guest secure boot intend to use Platform Keystore for the
> purpose of storing public keys. Secure boot requires public keys to
> be able to verify the grub and boot kernel. To allow authenticated
>  manipulation of keys, it supports variables to store key authorities
> - PK/KEK and code signing keys - db. It also supports denied list to
> disallow booting even if signed with valid key. This is done via
> denied list database - dbx or sbat. These variables would be stored in
> PKS, and are managed and controlled by firmware.
> 
> The purpose of this patchset is to add support for users to
> read/write/add/delete variables required for secure boot on PowerVM.

Ok, this is like the 3rd or 4th different platform-specific proposal for
this type of functionality.  I think we need to give up on
platform-specific user/kernel apis on this (random sysfs/securityfs
files scattered around the tree), and come up with a standard place for
all of this.

Please work with the other developers of the other drivers for this to
make this unified so that userspace has a chance to use this in a sane
manner.

thanks,

greg k-h
