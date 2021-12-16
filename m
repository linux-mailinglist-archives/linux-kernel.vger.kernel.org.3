Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6F3477F98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhLPVw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbhLPVv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:51:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864BC06173F;
        Thu, 16 Dec 2021 13:51:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 007FBB8258A;
        Thu, 16 Dec 2021 21:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3DDC36AE7;
        Thu, 16 Dec 2021 21:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639691515;
        bh=bk75P97h4nWD6jek//UN5pHtK2Op57RnCQgGYyF+oTw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=npjXcb/pbjuFvIu3l0WqxOakxucYPCJx8fZD3vZyqVptasTKuJOfXgxq+1j7IoFB7
         2ZD+vCp+8zu4L5lVLr7rqdwABN5MvVIL+Ax39qtMnM14Re3pV7aStFrjraTREd/0CC
         rDcGqkT0zHdADDowlNaRYYll2wRZFH3ksm+VUDVYTeLk8ww+IMXZMN8dAntbwM03hG
         FpUn3LpeqS82d5wlbSYpHHp3OcHIez3jT2jUHgJzKrZUVx4nxTRA/fvhaP7QQjwRCD
         AooNNwJ9OKRTVFLZXO+WGTLZOk90ARoVw3RTkjwkyKOGkPknMNyEHQnQ++di1s1sre
         PwIAEUL5b7u+Q==
Date:   Thu, 16 Dec 2021 13:51:55 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: Re: [PATCH V4 6/6] dt-bindings: xen: Clarify "reg" purpose
In-Reply-To: <1639136201-27530-1-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112161351470.3376@ubuntu-linux-20-04-desktop>
References: <35ee3534-9e24-5a11-0bf1-a5dd0b640186@gmail.com> <1639136201-27530-1-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Xen on Arm has gained new support recently to calculate and report
> extended regions (unused address space) safe to use for external
> mappings. These regions are reported via "reg" property under
> "hypervisor" node in the guest device-tree. As region 0 is reserved
> for grant table space (always present), the indexes for extended
> regions are 1...N.
> 
> No device-tree bindings update is needed (except clarifying the text)
> as guest infers the presence of extended regions from the number
> of regions in "reg" property.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Changes V2 -> V3:
>    - new patch
> 
> Changes V3 -> V4:
>    - add Stefano's R-b and Rob's A-b
>    - remove sentence about ACPI for "reg" and "interrupts"
>      properties
> 
> Changes V4 -> V4.1
>    - bring the mentioning of ACPI back which, as was pointed out by Julien,
>      fits in the context:
>      https://lore.kernel.org/xen-devel/9602b019-6c20-cdc7-23f3-9e4f8fd720f6@xen.org/T/#t
>      so technically restore V3 state
>    - remove Stefano's R-b and Rob's A-b as I am not 100% sure they are
>      happy with that
> ---
>  Documentation/devicetree/bindings/arm/xen.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> index db5c56d..156fe10b 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -7,10 +7,14 @@ the following properties:
>  	compatible = "xen,xen-<version>", "xen,xen";
>    where <version> is the version of the Xen ABI of the platform.
>  
> -- reg: specifies the base physical address and size of a region in
> -  memory where the grant table should be mapped to, using an
> -  HYPERVISOR_memory_op hypercall. The memory region is large enough to map
> -  the whole grant table (it is larger or equal to gnttab_max_grant_frames()).
> +- reg: specifies the base physical address and size of the regions in memory
> +  where the special resources should be mapped to, using an HYPERVISOR_memory_op
> +  hypercall.
> +  Region 0 is reserved for mapping grant table, it must be always present.
> +  The memory region is large enough to map the whole grant table (it is larger
> +  or equal to gnttab_max_grant_frames()).
> +  Regions 1...N are extended regions (unused address space) for mapping foreign
> +  GFNs and grants, they might be absent if there is nothing to expose.
>    This property is unnecessary when booting Dom0 using ACPI.
>  
>  - interrupts: the interrupt used by Xen to inject event notifications.
> -- 
> 2.7.4
> 
