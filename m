Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB94B4C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348715AbiBNKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:43:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349037AbiBNKkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:40:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508F42EE2;
        Mon, 14 Feb 2022 02:04:39 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E7eeWF030208;
        Mon, 14 Feb 2022 10:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H/9V7x1ZnZWaBWUZmASBuNft3H+rs6EGMwkO3WizELk=;
 b=ZmtdkDPRv8affIG8FW0VQIf2IqfUqGWgia2G5+8HclpnTFewQ7x/iRPzY7XfKN9Q9YJa
 G3A2Phf6MupJxhg9+wB5II5CvOb6h8xiTNVjK/wufvNUNJhhMJi9js2js0WhLHgF0u6M
 uyNm74EVinsUCxvzGgurXJ5qkQZA77zPuB8jqoitaBoN57eWKWxksKzEVTibIEJQSWzx
 gWunR3EL860fRgkF7gGlKH++jW4Mc5P3t9aJgQi9fAafSIvAb60uI8+MNHvc9tJONBgt
 BR9qNiMrEIKe7tJgxMVbPNX/cqMa89I+76G6r7eBoyp0u2vc5RkEd1Td0BxO61PjfLL/ Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e6thxfe6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:04:17 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21E9uIZT027181;
        Mon, 14 Feb 2022 10:04:16 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e6thxfe5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:04:16 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EA1gpH004684;
        Mon, 14 Feb 2022 10:04:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3e645jb02d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:04:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EA49Aw42336548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:04:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 914FE11C058;
        Mon, 14 Feb 2022 10:04:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 531CF11C05C;
        Mon, 14 Feb 2022 10:04:08 +0000 (GMT)
Received: from sig-9-145-84-135.uk.ibm.com (unknown [9.145.84.135])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:04:08 +0000 (GMT)
Message-ID: <624931c5da90387324a97be57745b13af4738bda.camel@linux.ibm.com>
Subject: Re: [PATCH] parport_pc: Also enable driver for PCI systems
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 14 Feb 2022 11:04:07 +0100
In-Reply-To: <alpine.DEB.2.21.2202140833290.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202122313460.34636@angie.orcam.me.uk>
         <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>
         <alpine.DEB.2.21.2202140833290.34636@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BLLBx_0NHR9GmFF7PjWSU-YqRZQlDig3
X-Proofpoint-ORIG-GUID: leMO3OhfT25_kzu64y3xEqTH8k3Gn8D8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-14 at 09:16 +0000, Maciej W. Rozycki wrote:
> On Mon, 14 Feb 2022, Geert Uytterhoeven wrote:
> 
> > > The only PCI platforms that actually can't make use of PC-style parallel
> > > port hardware are those newer PCIe systems that have no support for I/O
> > > cycles in the host bridge, required by such parallel ports.  An example
> > > of such a host bridge is the POWER9 PHB4 device, but it is an exception
> > > rather than the norm.  Also it is not clear whether the serial port side
> > 
> > Note that this hardware dependency is being addressed in
> > "[RFC 00/32] Kconfig: Introduce HAS_IOPORT and LEGACY_PCI options"
> > https://lore.kernel.org/all/20211227164317.4146918-1-schnelle@linux.ibm.com/
> 
>  Thanks for the pointer, I have missed the series in the LKML flood!
> 
>  The idea sounds good, although it's not clear to me if a config option is 
> enough to get it properly covered as I don't know offhand if a single say 
> ppc64le kernel can't run on systems that do and do not have support for 
> port I/O over PCIe.  I got hit with that the hard way with a distribution 
> kernel where a driver tried to do port I/O and poked at a random location 
> in the address space causing weird errors to be reported by the system 
> firmware.
> 
>  Also I have skimmed over the series and there appears to be confusion 
> between legacy PCI and conventional PCI, which are obviously not the same.  
> For example this piece:
> 
> diff --git a/drivers/net/fddi/Kconfig b/drivers/net/fddi/Kconfig
> index 846bf41c2717..1753c08d6423 100644
> --- a/drivers/net/fddi/Kconfig
> +++ b/drivers/net/fddi/Kconfig
> @@ -5,7 +5,7 @@
>  
>  config FDDI
>  	tristate "FDDI driver support"
> -	depends on PCI || EISA || TC
> +	depends on LEGACY_PCI || EISA || TC
>  	help
>  	  Fiber Distributed Data Interface is a high speed local area network
>  	  design; essentially a replacement for high speed Ethernet. FDDI can
> @@ -29,7 +29,7 @@ config DEFZA
>  
>  config DEFXX
>  	tristate "Digital DEFTA/DEFEA/DEFPA adapter support"
> -	depends on FDDI && (PCI || EISA || TC)
> +	depends on FDDI && (LEGACY_PCI || EISA || TC)
>  	help
>  	  This is support for the DIGITAL series of TURBOchannel (DEFTA),
>  	  EISA (DEFEA) and PCI (DEFPA) controllers which can connect you
> 
> is clearly wrong.  While the DEFPA card is a conventional PCI option it 
> does support MMIO and does run with my legacy-free POWER9 system just 
> fine (with a suitable PCIe-to-PCI bridge installed at 0031:01:00.0):
> 
> # lspci
> 0000:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0001:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0001:01:00.0 Serial controller: Oxford Semiconductor Ltd OXPCIe952 Dual Native 950 UART
> 0002:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0002:01:00.0 Serial Attached SCSI controller: Adaptec Series 8 12G SAS/PCIe 3 (rev 01)
> 0003:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0003:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
> 0004:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0004:01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
> 0004:01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
> 0005:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0005:01:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 04)
> 0005:02:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 41)
> 0030:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0030:01:00.0 PCI bridge: PMC-Sierra Inc. PM8562 Switchtec PFX-L 32xG3 Fanout-Lite PCIe Gen3 Switch
> 0030:02:00.0 PCI bridge: PMC-Sierra Inc. PM8562 Switchtec PFX-L 32xG3 Fanout-Lite PCIe Gen3 Switch
> 0030:02:01.0 PCI bridge: PMC-Sierra Inc. PM8562 Switchtec PFX-L 32xG3 Fanout-Lite PCIe Gen3 Switch
> 0030:02:02.0 PCI bridge: PMC-Sierra Inc. PM8562 Switchtec PFX-L 32xG3 Fanout-Lite PCIe Gen3 Switch
> 0030:02:03.0 PCI bridge: PMC-Sierra Inc. PM8562 Switchtec PFX-L 32xG3 Fanout-Lite PCIe Gen3 Switch
> 0030:03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 0030:04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 0030:05:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 0030:06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 0031:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0031:01:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge (rev 03)
> 0031:02:04.0 FDDI network controller: Digital Equipment Corporation PCI-to-PDQ Interface Chip [PFI] FDDI (DEFPA) (rev 02)
> 0031:02:05.0 ATM network controller: Microsemi / PMC / IDT IDT77201/77211 155Mbps ATM SAR Controller [NICStAR] (rev 03)
> 0032:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> 0033:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
> # dmesg | grep 0031:02:04.0 | cut -c16-
> pci 0031:02:04.0: [1011:000f] type 00 class 0x020200
> pci 0031:02:04.0: reg 0x10: [mem 0x620c080020000-0x620c08002007f]
> pci 0031:02:04.0: reg 0x14: [io  0x0000-0x007f]
> pci 0031:02:04.0: reg 0x18: [mem 0x620c080030000-0x620c08003ffff]
> pci 0031:02:04.0: BAR0 [mem size 0x00000080]: requesting alignment to 0x10000
> pci 0031:02:04.0: BAR 0: assigned [mem 0x620c080020000-0x620c08002007f]
> pci 0031:02:04.0: BAR 2: assigned [mem 0x620c080030000-0x620c08003ffff]
> pci 0031:02:04.0: BAR 1: no space for [io  size 0x0080]
> pci 0031:02:04.0: BAR 1: failed to assign [io  size 0x0080]
> pci 0031:02:04.0: Configured PE#fc
> pci 0031:02:04.0: Adding to iommu group 9
> defxx 0031:02:04.0: enabling device (0140 -> 0142)
> 0031:02:04.0: DEFPA at MMIO addr = 0x620c080020000, IRQ = 57, Hardware addr = 00-60-6d-93-91-98
> 0031:02:04.0: registered as fddi0
> $ ip link show dev fddi0
> 4: fddi0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4470 qdisc pfifo_fast 
> state UNKNOWN mode DEFAULT group default qlen 100
>     link/fddi 00:60:6d:93:91:98 brd ff:ff:ff:ff:ff:ff
> $
> 
> While older versions of the driver did have to be explicitly configured 
> for MMIO rather than port I/O, a feature added with commit e89a2cfb7d7b 
> ("[TC] defxx: TURBOchannel support"), the driver has been improved with 
> commit 795e272e5474 ("FDDI: defxx: Implement dynamic CSR I/O address space 
> selection") and the selection of the I/O space to use now fully automatic.

Very interesting and thanks for the input! On s390 we really only have
very few different PCI devices and I can only test another hand full
with my private x86 and ARM systems.

> 
>  Then what about the other FDDI driver there, SKFP?  It's not marked as
> LEGACY_PCI, although it's not selectable anyway due to the dependency of 
> FDDI on LEGACY_PCI.
> 
>  Niklas, what was the criterion for placing the LEGACY_PCI dependency?

Hmm, honestly I haven't really worked on this recently. There were some
open questions from Bjorn towards Arnd and I was waiting for his reply
but I guess he missed those. I think what you noticed was the main
problem, there wasn't really a clear set of criteria for LEGACY_PCI and
even for HAS_IOPORT we missed some uses if they were not compiled on
s390's allyesconfig due to other dependencies.

> 
>  Also do you plan to post an updated series anytime soon?  I'm asking 
> because like with the m68k port also the MIPS one needs a more finegrained 
> approach and I suspect there may be other corner cases and I'd rather look 
> at the most recent version of your series.  Otherwise I'll have a look 
> through your original submission, but it may have to wait until the next 
> weekend due to my other commitments.
> 
>   Maciej

That sounds like you do see a need for something like HAS_IOPORT too,
correct? Maybe with some input what you need and possibly stripping the
LEGACY_PCI option it might make sense to do a new version. Rather than
possibly getting in your way could directly work in your input.


