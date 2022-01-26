Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6DD49D00C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbiAZQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:52:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37556 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiAZQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:52:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A19EC6193B;
        Wed, 26 Jan 2022 16:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E20C340E3;
        Wed, 26 Jan 2022 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643215937;
        bh=NX4Hlz3e3ASOAcsOzjd8Irwr9rnJ14JnxiTx/r4AofM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNrcBhHhPbrxWEvOmXY+ZOy1754JLA/j+krUWiDKJEyt0GlUtdKUqT2IHEWzUt8ic
         UTUy/4GOz4QQT9eeMY5s5wDYi5mCddNWpV2DraqitYfX1TKsI4jpTX6mHDI+kTf15l
         z797R1DCSshahywdXqa4wKxatf6ji+IQTzWsHppnt7VbmlUJUwEA3eYaaeroU85dsL
         GfTbETtIygJL0Ez9B3lX/ordSuHCPotbHCh2DMqGxoUSVnzTnDHA+C7QDcmd6Pq2Me
         LgpxyhslMdpa7FdxrXVU3tubSMTDrUNITUVZRc1RYcJryzkagjLIHmaF8I1VZAS4QN
         5SlQqlM/rwHLQ==
Date:   Wed, 26 Jan 2022 08:52:14 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Klaus Jensen <its@irrelevant.dk>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de, arnd@arndb.de
Subject: Re: [RFC 0/7] 64-bit data integrity field support
Message-ID: <20220126165214.GA1782352@dhcp-10-100-145-180.wdc.com>
References: <20220124160107.1683901-1-kbusch@kernel.org>
 <YfFc1f2MoSQzyxZ4@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFc1f2MoSQzyxZ4@apples>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:38:13PM +0100, Klaus Jensen wrote:
> On Jan 24 08:01, Keith Busch wrote:
> > The NVM Express protocol added enhancements to the data integrity field
> > formats beyond the T10 defined protection information. A detailed
> > description of the new formats can be found in the NVMe's NVM Command
> > Set Specification, section 5.2, available at:
> > 
> >   https://nvmexpress.org/wp-content/uploads/NVM-Command-Set-Specification-1.0b-2021.12.18-Ratified.pdf
> > 
> > This series implements one possible new format: the CRC64 guard with
> > 48-bit reference tags. This does not add support for the variable
> > "storage tag" field.
> > 
> > The NVMe CRC64 parameters (from Rocksoft) were not implemented in the
> > kernel, so a software implementation is included in this series based on
> > the generated table. This series does not include any possible hardware
> > excelleration (ex: x86's pclmulqdq), so it's not very high performant
> > right now.
> > 
> 
> Hi Keith,
> 
> Tested this on QEMU and (assuming we didnt implement the same bugs) it
> looks good functionally for separate metadata. However, it should also
> be able to support PRACT (i.e. pi strip/insert device-side) if
> nvme_ns_has_pi() is updated to also match on the 16 byte pi tuple. I
> made it work by just hitting it with a hammer and changing the
> comparison to hard-coded 16 bytes, but it should of course handle both
> cases.

Thanks for checking with the qemu device!

I'll add the PRACT support for the next version, but will wait till next
week to post it in case there's more feedback to consider.

> Naveen and I will post the emulated implementation (that certainly isnt
> very high performant either) on qemu-block ASAP if others are interested
> in giving this a spin without having hardware available.

There are more features with this TP than are implemented here. I'm just
enabling a product that only supports the 64-bit CRC with 0 STS, but I'm
assuming your QEMU implementation may be more feature complete. If
anyone is interested in 32-bit CRC or >0 STS, there's more work to
follow on from here, but I currently don't have such a target to test
against.
