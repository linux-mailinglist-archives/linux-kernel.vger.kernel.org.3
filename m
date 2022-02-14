Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A9A4B445E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiBNIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:38:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiBNIie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:38:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A313E01;
        Mon, 14 Feb 2022 00:38:26 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E5Um39007645;
        Mon, 14 Feb 2022 08:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PV1Ah7wybhb+po6pDcZcuKJuHgirBmZN9KGQ/Ir+Azk=;
 b=kTxeVqkZSLV6hLj5rdW4yAVQvMzbtf0bKECQz34mhLjlSuedbRgAhH/yOpEMxhIfzrab
 OeEf0e0GyAcIdMtNzNW1SdPC/Xvwtlxc+dH6Q+NGRoNF76X5uKbxtGVIdkHrQY9MDMjI
 xGddhjdSpxAlQuFUzn8MQ/aBZaV1sipO7HlB4nkgztyhdX9KOOHA9ghA71k693seA0LK
 W+KuDlWjX4b4odo5i3U2r4NL+htVVOXoZJrTQfsFeP0jlRoCwDcHmp13kuoiHW8xgEfC
 lv7+cERfa2nLnqdMdZsHuSpF7N0CWQsK3BSmEX1dvOisUtCaUZQP2KINFmbDDVyU47g6 bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7dehf242-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 08:37:52 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21E8EV2d021184;
        Mon, 14 Feb 2022 08:37:51 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7dehf22x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 08:37:51 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21E8XfoT018557;
        Mon, 14 Feb 2022 08:37:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3e645ja9v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 08:37:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21E8bjkX40043002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 08:37:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D205AE045;
        Mon, 14 Feb 2022 08:37:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B711AE04D;
        Mon, 14 Feb 2022 08:37:44 +0000 (GMT)
Received: from sig-9-145-84-135.uk.ibm.com (unknown [9.145.84.135])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 08:37:44 +0000 (GMT)
Message-ID: <e5ec2e3be2e70e690bd9112bd23297d05a2993e6.camel@linux.ibm.com>
Subject: Re: [PATCH] parport_pc: Also enable driver for PCI systems
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
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
Date:   Mon, 14 Feb 2022 09:37:43 +0100
In-Reply-To: <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>
References: <alpine.DEB.2.21.2202122313460.34636@angie.orcam.me.uk>
         <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cj_hGZEn7CrbAL8bX6nY71tGP9Hf619O
X-Proofpoint-ORIG-GUID: 7--hie3AmYyMErFK3wRLOvpBa0hqckt4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_01,2022-02-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=941 priorityscore=1501 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140052
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-14 at 09:20 +0100, Geert Uytterhoeven wrote:
> Hi Maciej,
> 
> CC Niklas
> 
> On Sun, Feb 13, 2022 at 1:45 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> > Nowadays PC-style parallel ports come in the form of PCI and PCIe option
> > cards and there are some combined parallel/serial option cards as well
> > that we handle in the parport subsystem.  There is nothing in particular
> > that would prevent them from being used in any system equipped with PCI
> > or PCIe connectivity, except that we do not permit the PARPORT_PC config
> > option to be selected for platforms for which ARCH_MIGHT_HAVE_PC_PARPORT
> > has not been set for.
> > 
> > The only PCI platforms that actually can't make use of PC-style parallel
> > port hardware are those newer PCIe systems that have no support for I/O
> > cycles in the host bridge, required by such parallel ports.  An example
> > of such a host bridge is the POWER9 PHB4 device, but it is an exception
> > rather than the norm.  Also it is not clear whether the serial port side
> 
> Note that this hardware dependency is being addressed in
> "[RFC 00/32] Kconfig: Introduce HAS_IOPORT and LEGACY_PCI options"
> https://lore.kernel.org/all/20211227164317.4146918-1-schnelle@linux.ibm.com/

Thanks, for Cc'ing me. Note that this series is currently in kind of a
hold as we haven't yet found a clear direction yet. There was some
clear opposition for the LEGACY_PCI option introduced in that series
and only little support for HAS_IOPORT.

> 
> > --- linux-macro.orig/drivers/parport/Kconfig
> > +++ linux-macro/drivers/parport/Kconfig
> > @@ -42,7 +42,7 @@ if PARPORT
> > 
> >  config PARPORT_PC
> >         tristate "PC-style hardware"
> > -       depends on ARCH_MIGHT_HAVE_PC_PARPORT
> > +       depends on ARCH_MIGHT_HAVE_PC_PARPORT || PCI

This would allow selecting PARPORT_PC on s390 e.g. for allyesconfig and
randconfig and like POWER9 we definitely do not support I/O port
access.

We will also get warnings when compiling with clang. A problem my
series was originally started to address. So I'd really like to see a
better solution here for such a change. With the HAS_IOPORT option from
my series this would be simple but we don't currently have that though
maybe this is also an argument for introducing HAS_IOPORT even if we
don't add the LEGACY_PCI option.

> >         help
> >           You should say Y here if you have a PC-style parallel port. All
> >           IBM PC compatible computers and some Alphas have PC-style
> > @@ -77,7 +77,7 @@ config PARPORT_PC_FIFO
> > 
> >  config PARPORT_PC_SUPERIO
> >         bool "SuperIO chipset support"
> > -       depends on PARPORT_PC && !PARISC
> > +       depends on ARCH_MIGHT_HAVE_PC_PARPORT && PARPORT_PC && !PARISC
> >         help
> >           Saying Y here enables some probes for Super-IO chipsets in order to
> >           find out things like base addresses, IRQ lines and DMA channels.  It
> > 
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


