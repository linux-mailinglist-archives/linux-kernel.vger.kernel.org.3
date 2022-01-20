Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70411494CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiATLXC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jan 2022 06:23:02 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:56815 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiATLW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:22:57 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 317FC200009;
        Thu, 20 Jan 2022 11:22:54 +0000 (UTC)
Date:   Thu, 20 Jan 2022 12:22:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Trevor Woerner <twoerner@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
Message-ID: <20220120122253.31594cc4@xps13>
In-Reply-To: <CAAEAJfCy2WvOrZ==eVTS2mYjkd3_Vj8ysDbP3L_aU0cE8S4ceg@mail.gmail.com>
References: <20210801234509.18774-1-ezequiel@collabora.com>
        <20211026150350.GA5136@localhost>
        <CAAEAJfD0ctKon7onbj5cCgN9OUnXpQ-gxG=DF6hXD9hW+Pw83A@mail.gmail.com>
        <20220120103946.3a18aee7@xps13>
        <CAAEAJfCy2WvOrZ==eVTS2mYjkd3_Vj8ysDbP3L_aU0cE8S4ceg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

ezequiel@vanguardiasur.com.ar wrote on Thu, 20 Jan 2022 07:26:09 -0300:

> On Thu, 20 Jan 2022 at 06:39, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Ezequiel,
> >
> > ezequiel@vanguardiasur.com.ar wrote on Fri, 12 Nov 2021 10:54:36 -0300:
> >  
> > > Hi Trevor,
> > >
> > > I am not reachable at ezequiel at collabora.com, so I missed this
> > > thread. Sorry about the delay, replying.
> > >
> > > On Tue, 26 Oct 2021 at 12:05, Trevor Woerner <twoerner@gmail.com> wrote:  
> > > >
> > > > On Sun 2021-08-01 @ 08:45:02 PM, Ezequiel Garcia wrote:  
> > > > > Hi Richard, and everyone else:
> > > > >
> > > > > Browsing the internet for "JFFS2 mtd" results in tutorials, articles
> > > > > and github.gists0 that point to mtdblock.
> > > > >
> > > > > In fact, even the MTD wiki mentions that JFFS2
> > > > > needs mtdblock to mount a rootfs:
> > > > >
> > > > >   http://www.linux-mtd.infradead.org/faq/jffs2.html
> > > > >
> > > > > Moreover, I suspect there may be lots of users
> > > > > that still believe mtdblock is somehow needed to
> > > > > mount SquashFS.
> > > > >
> > > > > I've taken a verbose route and added a pr_warn
> > > > > warning if the devices are NAND. I don't think using
> > > > > NAND without UBI is too wise, and given the amount
> > > > > of outdated tutorials I believe some advertising
> > > > > will help.  
> > > >
> > > > Not all NAND partitions on a device will contain linux root filesystems. For a
> > > > linux root filesystem perhaps using UBI/UBIFS is preferred, yet these messages
> > > > print out for each and every NAND partition:
> > > >
> > > >         [    0.900827] Creating 8 MTD partitions on "nxp_lpc3220_slc":
> > > >         [    0.906431] 0x000000000000-0x000000020000 : "bootrom"
> > > >         [    0.913523] mtdblock: MTD device 'bootrom' is NAND, please consider using UBI block devices instead.
> > > >         [    0.933334] 0x000000020000-0x000000080000 : "uboot"
> > > >         [    0.940439] mtdblock: MTD device 'uboot' is NAND, please consider using UBI block devices instead.
> > > >         [    0.963322] 0x000000080000-0x000000440000 : "fbkernel"
> > > >         [    0.970655] mtdblock: MTD device 'fbkernel' is NAND, please consider using UBI block devices instead.
> > > >         [    0.993361] 0x000000440000-0x000000920000 : "fbrootfs"
> > > >         [    1.000725] mtdblock: MTD device 'fbrootfs' is NAND, please consider using UBI block devices instead.
> > > >         [    1.023315] 0x000000920000-0x000000ce0000 : "c_kernel"
> > > >         [    1.030722] mtdblock: MTD device 'c_kernel' is NAND, please consider using UBI block devices instead.
> > > >         [    1.053444] 0x000000ce0000-0x000000d00000 : "c__atags"
> > > >         [    1.060742] mtdblock: MTD device 'c__atags' is NAND, please consider using UBI block devices instead.
> > > >         [    1.083349] 0x000000d00000-0x000001000000 : "c_rootfs"
> > > >         [    1.090702] mtdblock: MTD device 'c_rootfs' is NAND, please consider using UBI block devices instead.
> > > >         [    1.113335] 0x000001000000-0x000020000000 : "mender"
> > > >         [    1.131627] mtdblock: MTD device 'mender' is NAND, please consider using UBI block devices instead.
> > > >
> > > > NAND tends to be something found on older devices, the firmware/bootloaders
> > > > of older devices couldn't possibly understand UBI/UBIFS so many of these
> > > > partitions need be "raw" partitions, or use something that predates UBI.
> > > >
> > > > Ironically my "mender" partition contains a UBI (with multiple UBIFSes inside)
> > > > yet I got the same "please use UBI" message as all the others (lol)
> > > >
> > > > I'm specifying my partitions in DT with:
> > > >
> > > > partitions {
> > > >         compatible = "fixed-partitions";
> > > >         #address-cells = <1>;
> > > >         #size-cells = <1>;
> > > >
> > > >         mtd0@0       { label = "bootrom";   reg = <0x00000000 0x00020000>; };
> > > >         mtd1@20000   { label = "uboot";     reg = <0x00020000 0x00060000>; };
> > > >         mtd2@80000   { label = "fbkernel";  reg = <0x00080000 0x003c0000>; };
> > > >         mtd3@440000  { label = "fbrootfs";  reg = <0x00440000 0x004e0000>; };
> > > >         mtd4@920000  { label = "c_kernel";  reg = <0x00920000 0x003c0000>; };
> > > >         mtd5@ce0000  { label = "c__atags";  reg = <0x00ce0000 0x00020000>; };
> > > >         mtd6@d00000  { label = "c_rootfs";  reg = <0x00d00000 0x00300000>; };
> > > >         mtd7@1000000 { label = "mender";    reg = <0x01000000 0x1f000000>; };
> > > > };
> > > >
> > > > which is why, I assume, I'm getting these messages. Is there a UBI-friendly
> > > > way to define them to avoid these messages?
> > > >  
> > >
> > > I feel the messages are actually helping you. You should not have mtdblock
> > > on any of these MTD devices, if I understood correctly, since you are not
> > > mounting a filesystem on any of them.
> > >
> > > Just disable MTDBLOCK on your build and you will be good to go.
> > >
> > > I am inclined to just leave the warnings, although they look spammy,
> > > precisely to help catch this mis-setups.  
> >
> > I keep getting complaints about these messages because they are
> > spawned several times in a boot (each device or partition, I don't
> > recall) while mtdblock is not even used. I understand it would be best
> > to have it disabled in this case but could we find a way to be less
> > invasive?
> >  
> 
> If we still want to keep the warning, I suppose that moving these warnings
> to blktrans_open should help ... unless the block device open ends
> up being called anyway, and still gets spammy.

This solution is my favorite, unless as you say it's opened anyway. 

> The alternative is removing them, perhaps adding a message to config MTD_BLOCK
> about UBI blocks?

That's a fallback solution indeed.

Thanks,
Miquèl
