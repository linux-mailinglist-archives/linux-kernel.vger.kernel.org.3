Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3994D97E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346750AbiCOJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346742AbiCOJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:43:43 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767744EF62
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:42:31 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KHpNP6vFQz9sSm;
        Tue, 15 Mar 2022 10:42:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dF2zyDWcfBkw; Tue, 15 Mar 2022 10:42:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KHpNP5ySrz9sSj;
        Tue, 15 Mar 2022 10:42:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8C778B770;
        Tue, 15 Mar 2022 10:42:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LEBbleLzX4BU; Tue, 15 Mar 2022 10:42:29 +0100 (CET)
Received: from [192.168.202.50] (unknown [192.168.202.50])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0465E8B763;
        Tue, 15 Mar 2022 10:42:28 +0100 (CET)
Message-ID: <2f2cafaa-e1f3-7f75-10a5-b8edb6de26d7@csgroup.eu>
Date:   Tue, 15 Mar 2022 10:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH -next] powerpc/eeh: Add correct inline functions
Content-Language: fr-FR
To:     YueHaibing <yuehaibing@huawei.com>, ruscur@russell.cc,
        oohall@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, sbobroff@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210331125313.24036-1-yuehaibing@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20210331125313.24036-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/03/2021 à 14:53, YueHaibing a écrit :
> pseries_eeh_add_device_early()/pseries_eeh_add_device_tree_early() is
> never used since adding, however pseries_eeh_init_edev() and
> pseries_eeh_init_edev_recursive() need their inline versions.
> 
> Fixes: b6eebb093cad ("powerpc/eeh: Make early EEH init pseries specific")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Those inline are not needed at all:
- pseries_eeh_init_edev_recursive() is only called from files build wich 
CONFIG_HOTPLUG_PCI_RPA which depends on CONFIG_PSERIES and CONFIG_EEH
- pseries_eeh_init_edev() is used exclusively in
arch/powerpc/platforms/pseries/eeh_pseries.c and should be made static.

Can you update your patch ?

Thanks
Christophe

> ---
>   arch/powerpc/include/asm/eeh.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index b1a5bba2e0b9..0b6c2a6711d3 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -357,8 +357,8 @@ static inline int eeh_phb_pe_create(struct pci_controller *phb) { return 0; }
>   void pseries_eeh_init_edev(struct pci_dn *pdn);
>   void pseries_eeh_init_edev_recursive(struct pci_dn *pdn);
>   #else
> -static inline void pseries_eeh_add_device_early(struct pci_dn *pdn) { }
> -static inline void pseries_eeh_add_device_tree_early(struct pci_dn *pdn) { }
> +static inline void pseries_eeh_init_edev(struct pci_dn *pdn) { }
> +static inline void pseries_eeh_init_edev_recursive(struct pci_dn *pdn) { }
>   #endif
>   
>   #ifdef CONFIG_PPC64
