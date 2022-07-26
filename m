Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7E58118A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiGZLC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiGZLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:02:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360D62DA9C;
        Tue, 26 Jul 2022 04:02:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsYsC27Jjz4x1Y;
        Tue, 26 Jul 2022 21:02:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658833343;
        bh=Z49lCisQT1XGo/W63rwonF77hiwakcBinHGr63WmR34=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VIqiqukvv7kNj6LxEW2+NpOztZFjRnVc1oTOXVSlIjng1+/SCGGHTSo1KD1P8NNoX
         g8fn0YgV4CCHgiDXxG9MPnVvkalfY/REjBuVc3HJ0QZ7PpBaMU4RPYu+c/g9iTzamS
         UdqWiARKxEz0VE4wITkHbNPrtxoE4e2iuYDCnOVoqj+1AWVxacZDnMRe0+T/o3tK0v
         uRxwkwDIHGahnKILz4upboHU+K4wSZn+le7zTf+HfilopsllFI+Cw51t80JSwKHTf6
         cT9hCkygPwgV7DsLwYv/oINpPSTQZAG7D0EEdbH25mixqRv+qxulEZYHmfs0DwfGcp
         IgzCS3IakIyPw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Nick Child <nick.child@ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] powerpc/pci: Add config option for using all 256
 PCI buses
In-Reply-To: <20220721222145.rzgthbwoselx2l43@pali>
References: <20220706104308.5390-1-pali@kernel.org>
 <20220706104308.5390-6-pali@kernel.org>
 <20220721222145.rzgthbwoselx2l43@pali>
Date:   Tue, 26 Jul 2022 21:02:22 +1000
Message-ID: <875yjkb0ht.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> On Wednesday 06 July 2022 12:43:08 Pali Roh=C3=A1r wrote:
>> By default on PPC32 are PCI bus numbers unique across all PCI domains.
>> So system could have only 256 PCI buses independently of available
>> PCI domains.
>>
>> This is due to filling DT property pci-OF-bus-map which does not reflect
>> multi-domain setup.
>>
>> On all powerpc platforms except chrp and powermac there is no DT property
>> pci-OF-bus-map anymore and therefore it is possible on non-chrp/powermac
>> platforms to avoid this limitation of maximal number of 256 PCI buses in
>> system even on multi-domain setup.
>>
>> But avoiding this limitation would mean that all PCI and PCIe devices wo=
uld
>> be present on completely different BDF addresses as every PCI domain sta=
rts
>> numbering PCI bueses from zero (instead of the last bus number of previo=
us
>> enumerated PCI domain). Such change could break existing software which
>> expects fixed PCI bus numbers.
>>
>> So add a new config option CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT which
>> enables this change. By default it is disabled. It cause that initial va=
lue
>> of hose->first_busno is zero.
>>
>> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>> ---
>>  arch/powerpc/Kconfig         | 11 +++++++++++
>>  arch/powerpc/kernel/pci_32.c |  6 ++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index be68c1f02b79..f66084bc1dfe 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -370,6 +370,17 @@ config PPC_DCR
>>  	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
>>  	default y
>>
>> +config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
>> +	depends on PPC32
>> +	depends on !PPC_PMAC && !PPC_CHRP
>> +	bool "Assign PCI bus numbers from zero individually for each PCI domai=
n"
>> +	help
>> +	  By default on PPC32 were PCI bus numbers unique across all PCI domai=
ns.
>> +	  So system could have only 256 PCI buses independently of available
>> +	  PCI domains. When this option is enabled then PCI bus numbers are
>> +	  PCI domain dependent and each PCI controller on own domain can have
>> +	  256 PCI buses, like it is on other Linux architectures.
>> +
>
> What do you think, would it be possible to set default value of this
> option to enabled?

My preference would be to not have the option at all, just make it the
default behaviour. Every new CONFIG option adds more combinations that
need testing, or more likely don't get well tested.

But I don't have a good feel for what could break if we turn it on, so
honestly I don't really know.

Also I do most of my 32-bit testing on pmacs, which are not affected by
the change.

So I'll probably take the series as-is, and then we can do some more
widespread testing and possibly flip the default to enabled, and then
maybe remove the option entirely in future.

cheers
