Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3613E543F29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiFHW3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiFHW32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:29:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E035F80;
        Wed,  8 Jun 2022 15:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41AB6B82B93;
        Wed,  8 Jun 2022 22:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29D9C34116;
        Wed,  8 Jun 2022 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654727364;
        bh=agcIRd3Ma6/Gbes0Mw59QQ3rWGelpWxP5sS/f7LjAzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qse6DMM0V269L2s8KhcvlPBFOBnFW+3I+XCR1D5klSxxFO3oEOJIxDoKlwaR2at69
         kP+SRHRf5CBdmqg5KQpHxA3GvYDL0vHBnj+T4oQBCpwpUnIKqhX6i7fUtQTr+QbdtP
         RnFT67kjUJmafdNy57Pg9+Mb2XzjlQ61A9kh4i2HjpsduZc8SKgXhXfvOy6sumBLNS
         DI6+RktiKLYJI+DyJ/Ps1QYkx1t3sjfPMgqHksdFk5kw0bRTgM6B47ithqBQn1H8k6
         dkaxo+a4U8YPqgtzhkswikYzFwPI0j8MayfmLBEUYEThS36IwjyU6Yqi/etXlXC8y5
         hTuY0peeryJ4A==
Date:   Wed, 8 Jun 2022 17:29:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: PM: Drop pme_interrupt reference
Message-ID: <20220608222922.GA429328@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602163330.317-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:33:30AM -0500, Mario Limonciello wrote:
> `pme_interrupt` was dropped from `struct pci_dev` as part of commit
> 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev"),
> but the Documentation still includes this member.
> 
> Remove it from the documentation as well and update it to have the missing
> `pme_poll` member instead.
> 
> Fixes: 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/power/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index b04fb18cc4e2..a125544b4cb6 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -315,7 +315,7 @@ that these callbacks operate on::
>  					   configuration space */
>  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>  					   can be generated */
> -	unsigned int	pme_interrupt:1;/* Is native PCIe PME signaling used? */
> +	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
>  	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>  	unsigned int	d2_support:1;	/* Low power state D2 is supported */
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */

I'm OK with this patch if Rafael wants to take it.

But I'm not sure how much value this section of the doc really adds.
The doc basically says "the PCI PM callbacks operate on several of
these fields of the struct pci_dev" and goes on to quote part of the
struct pci_dev.

But "pm_cap" is the only one of those fields that is mentioned
elsewhere in the doc, and that one is only incidental.

For example, is it really useful to say "the PCI PM callbacks use
pci_dev.pme_poll" without any other details about pme_poll?

I think I would consider just removing everything from "The structure
representing a PCI device ..." to the end of the section, i.e., lines
308-329 at [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/power/pci.rst?id=v5.18#n308
