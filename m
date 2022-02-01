Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A424A5E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiBAOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:23:44 -0500
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156]:51183 "EHLO
        3.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbiBAOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:23:42 -0500
X-Greylist: delayed 2700 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Feb 2022 09:23:42 EST
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.188])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id A45B120B2A;
        Tue,  1 Feb 2022 13:28:30 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Feb
 2022 14:28:29 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-97G002ded4642f-2264-41dd-88eb-91ec928a76b3,
                    FC28BB27814F05D37416E671BAFA2F1ED858982E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ebf35275-cfb3-567d-97ba-ec81a6b40cb5@kaod.org>
Date:   Tue, 1 Feb 2022 14:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] powerpc/xive: Add some error handling code to
 'xive_spapr_init()'
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <christophe.leroy@csgroup.eu>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>, <allison@lohutok.net>,
        <tglx@linutronix.de>, <groug@kaod.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
References: <564998101804886b151235c8a9f93020923bfd2c.1643718324.git.christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <564998101804886b151235c8a9f93020923bfd2c.1643718324.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 4ec3683f-a038-485c-ad83-90f117bf23d3
X-Ovh-Tracer-Id: 3854518332830878709
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeefgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuveelvdejteegteefieevfeetffefvddvieekteevleefgeelgfeutedvfedvfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehgrhhouhhgsehkrghougdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 13:31, Christophe JAILLET wrote:
> 'xive_irq_bitmap_add()' can return -ENOMEM.
> In this case, we should free the memory already allocated and return
> 'false' to the caller.
> 
> Also add an error path which undoes the 'tima = ioremap(...)'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
> NOT compile tested (I don't have a cross compiler and won't install one).
> So if some correction or improvement are needed, feel free to propose and
> commit it directly.


A cross compiler takes a couple of seconds to install on any distro.
It takes a little more to compile the pseries defconfig. To test with
QEMU, grab the disk image here :

   https://github.com/legoater/qemu-ppc-boot/blob/main/buildroot/qemu_ppc64le_pseries-2021.11-7-g3058e75456-20211206

run :

   qemu-system-ppc64 -M pseries -cpu POWER9 -kernel vmlinux -append "console=hvc0 rootwait root=/dev/sda" -drive file=rootfs.ext2,if=scsi,index=0,format=raw -nographic -net nic -net user -serial mon:stdio

and you will have a pseries machine with network and disk using the
XIVE interrupt controller.

To get more info on the genirq layer and the XIVE driver, simply
append :

   dyndbg="file arch/powerpc/sysdev/xive/* +p; file kernel/irq/* +p"

Thanks,

C.
