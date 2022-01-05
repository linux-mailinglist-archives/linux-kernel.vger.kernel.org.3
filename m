Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA04F48513A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiAEKkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:40:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53858 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiAEKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:40:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD986165A;
        Wed,  5 Jan 2022 10:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E113C36AED;
        Wed,  5 Jan 2022 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641379215;
        bh=WvlWeAHjEBKkyHpibPVRvf1Q3nqJcxGTttZTvUUJmNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x+9wLrNg7iHkZCfk9/XPXdd1i2JDU9neXFhpD4wLgNQD62Ekrc2dnzq7yoqUGfAmL
         JblTmHUAK7iqgLZVuwyP/UaXOZYi182LcCgTfrQOrUVo/SCS/WU2BHjX9JeRmjOz0J
         JTTmHeURvmV6mV374AoF0cWgNxB+g9Al7SLFR5OQ=
Date:   Wed, 5 Jan 2022 11:40:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        nathan@kernel.org, jarkko@kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] [v3] x86/sgx: Fix NULL pointer dereference on non-SGX
 systems
Message-ID: <YdV1jFHkkLHEOcS5@kroah.com>
References: <20220104171527.5E8416A8@davehans-spike.ostc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104171527.5E8416A8@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 09:15:27AM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> == Problem ==
> 
> Nathan Chancellor reported an oops when aceessing the
> 'sgx_total_bytes' sysfs file:
> 
> 	https://lore.kernel.org/all/YbzhBrimHGGpddDM@archlinux-ax161/
> 
> The sysfs output code accesses the sgx_numa_nodes[] array
> unconditionally.  However, this array is allocated during SGX
> initialization, which only occurs on systems where SGX is
> supported.
> 
> If the sysfs file is accessed on systems without SGX support,
> sgx_numa_nodes[] is NULL and an oops occurs.
> 
> == Solution ==
> 
> To fix this, hide the entire nodeX/x86/ attribute group on
> systems without SGX support using the ->is_visible attribute
> group callback.
> 
> Unfortunately, SGX is initialized via a device_initcall() which
> occurs _after_ the ->is_visible() callback.  Instead of moving
> SGX initialization earlier, call sysfs_update_group() during
> SGX initialization to update the group visiblility.
> 
> This update requires moving the SGX sysfs code earlier in
> sgx/main.c.  There are no code changes other than the addition of
> arch_update_sysfs_visibility() and a minor whitespace fixup to
> arch_node_attr_is_visible() which checkpatch caught.
> 
> Fixes: 50468e431335 ("x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: linux-sgx@vger.kernel.org
> Cc: x86@kernel.org
> ---
> 
>  b/arch/x86/kernel/cpu/sgx/main.c |   65 ++++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 18 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
