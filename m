Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9169056856D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiGFKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiGFKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30023BF4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A4061DFE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66378C3411C;
        Wed,  6 Jul 2022 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657103026;
        bh=dLwzuTcTJxjrJx5KFBvSWF4B9fKuiLNpighCnwFB9SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3d8Sn60XaOmiKvgC3MOYMR7aJCPV9sa+ThJL4mLaoaZRDiqrd/YbPttsKHC/cFmP
         6Le00OLABS0eTmv+jKnGpO8i24euFEfypI3BW2XauGUgQs3prUv9Whh7a1/5kRP8Gf
         Kod7Y/M/7P+O3LDOJzpcoyh8JSdYgReYLEWgZHig90B+6lM5QYOqii9xT0BebwEKaG
         dhzVxVb9N3esvNMkxGqq3Fjnwm2sGpMDZNUt4rMGjzNbQ5rMZoHvXpD8VgqHkv1beg
         QscILbwGkbSDmdEOg7h3igFNJ1DAyB+GXG5oJMe+1eiuQ1abvvnUxZTUZ5xh3Rw0zQ
         Up2DHKItPM3EQ==
Received: by pali.im (Postfix)
        id D5C8A7BA; Wed,  6 Jul 2022 12:23:43 +0200 (CEST)
Date:   Wed, 6 Jul 2022 12:23:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Add config option for using OF 'reg' for
 PCI domain
Message-ID: <20220706102343.7vui5ymz5kr5sexi@pali>
References: <20220504175718.29011-1-pali@kernel.org>
 <87edzxc6r7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edzxc6r7.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 June 2022 17:33:32 Michael Ellerman wrote:
> Pali Rohár <pali@kernel.org> writes:
> > Since commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on
> > device-tree properties"), powerpc kernel always fallback to PCI domain
> > assignment from OF / Device Tree 'reg' property of the PCI controller.
> >
> > PCI code for other Linux architectures use increasing assignment of the PCI
> > domain for individual controllers (assign the first free number), like it
> > was also for powerpc prior mentioned commit.
> >
> > Upgrading powerpc kernels from LTS 4.4 version (which does not contain
> > mentioned commit) to new LTS versions brings a regression in domain
> > assignment.
> 
> I'm sorry this broke your system. But I don't really consider it a
> regression, the kernel provides no guarantee about the PCI domain
> numbering across LTS releases.
> 
> Prior to the change the numbering was just based on the order the PHBs
> were discovered in the device tree, which is not robust. A cosmetic
> refactor of the device tree source could cause PHBs to be discovered in
> a different order.
> 
> Similarly a change in firmware PCI discovery or device tree generation
> could cause the numbering to change.
> 
> If you have scripts that are looking for certain devices they can use
> the vendor/device fields in sysfs to find the actual devices they want,
> not just whatever happens to be at 0000:01:00.0.
> 
> > Fix this issue by introducing a new option CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG
> > When this options is disabled then powerpc kernel would assign PCI domains
> > in the similar way like it is doing kernel for other architectures and also
> > how it was done prior that commit.
> 
> I really don't want a config option for that.
> 
> There is a device tree property "linux,pci-domain", described in
> Documentation/devicetree/bindings/pci/pci.txt.
> 
> Can you try adding that to your device tree and updating
> get_phb_number() to look for it?
> 
> cheers

I sent another proposal in V2, now also with "linux,pci-domain" support.
