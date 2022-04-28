Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4B9513F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353385AbiD1Xqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353323AbiD1Xqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:46:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D567521A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:43:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l16-20020a05600c1d1000b00394011013e8so2962415wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1zqOBnvsLw+MNZ+ZyZHPVshSBvejujp1MVA1u942JXs=;
        b=TZzMrrjtZx7GqJlI7FG3HSQOldV2b4S/GOStEV/C7suEDgb7wyL7PLm6fki/VAvZsA
         r4fDIDaWF/cjPyd2ik+Y4qjWH9tdjE7Jiey99TkFH3E/q1hHyGgluQSRd2AXyOpumyKI
         OKKt7ASF3sY7cMjeZmJQKFF9ETLzC8GomPe4fXNAIF8RqLCMVtXBN8ctS1T4opB7Mwhg
         wnuEgaqrM2DU2mk9ZbcAKHk/v7FckvsJg/i4iXP0pJ4N1HPkLVut0AtW380q8iWtny0q
         XMbQg8djRN/6odLVhqfEn5qZ6IX1hdDIaLU4/P2Je6teW62pzdHA8E3RyOqiE1WXkH7x
         bJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1zqOBnvsLw+MNZ+ZyZHPVshSBvejujp1MVA1u942JXs=;
        b=WF+95neAEgwHRS5icrGvf9I6pTba+VYdaOpNThXUGY9FE3qlF3j5JqoFPNi9Bgdozr
         ub344VWNBxzx8GnqagCjrCkShlRVeo8bzBFmR2BhuQ3Iz32aePFfFZARopuj3huaUPdk
         rNcyRho1tGYFwpIXugsVhOQgdAiUdwU+TAGQ9IBLLrytGWTqhzQQ4F0OXLtz3fmA/a3v
         62mELEMG9ecGz/FwlkShD9G2wTZMJtg3X5jC7Kp5wBxjhfqBzUGjfZOuwDF3DbmwSojt
         2KMwwRI9VFG19FuY5fxewbjdqJMX0P7WtrX1Ef5uu3qajv3lACm2aM7IeKOZGpwfdT8x
         dk6Q==
X-Gm-Message-State: AOAM533E+bpy2kNXVMf/Sy1K2G8wvgoixWXNDhTixRELoMJTWQ0QRAmu
        AyPMcIhT8z9wiqzfMRjlGFZ1LA==
X-Google-Smtp-Source: ABdhPJy6AyTLY+eAIJmYpPctsOQTwVUqxLxvAW+PAo1dUDS64WTqb1F/P1VeR9PrMzu8HkT/6Nd02g==
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id v189-20020a1cacc6000000b0038eb1847721mr526857wme.94.1651189407283;
        Thu, 28 Apr 2022 16:43:27 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id j29-20020a05600c1c1d00b0039419ad13a4sm1160344wms.2.2022.04.28.16.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 16:43:26 -0700 (PDT)
Date:   Fri, 29 Apr 2022 00:43:24 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <YmsmnGb3JNjH54Xb@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
 <20220427165917.GE12977@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427165917.GE12977@windriver.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:59:17PM -0400, Paul Gortmaker wrote:
> [Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 27/04/2022 (Wed 08:50) Jonathan Corbet wrote:
> 
> > The Documentation/ide part of this is already dealt with in docs-next;
> > obviously there was more to do, though :)
> 
> Ah, I'd checked mainline master of today but not sfr's next.
> 
> Here is a delta diff against today's linux-next
> 
> Thanks,
> Paul.
> --
> 
> From ecb86eb357e5151ba5f7e7d172c65d07d88c4c39 Mon Sep 17 00:00:00 2001
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Wed, 27 Apr 2022 12:45:50 -0400
> Subject: [PATCH -next] Documentation: remove last remaining traces of IDE
>  information
> 
> The last traces of the IDE driver went away in commit b7fb14d3ac63
> ("ide: remove the legacy ide driver") but it left behind some traces
> of old documentation.
> 
> As luck would have it Randy and I would submit similar changes within
> a week of each other to address this.  As Randy's commit is in the doc
> tree already - this delta is just the stuff my removal contained that
> was not in Randy's IDE doc removal.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 308da668bbb1..47a83deebb3d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1797,27 +1797,6 @@
>  	icn=		[HW,ISDN]
>  			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
>  
> -	ide-core.nodma=	[HW] (E)IDE subsystem
> -			Format: =0.0 to prevent dma on hda, =0.1 hdb =1.0 hdc
> -			.vlb_clock .pci_clock .noflush .nohpa .noprobe .nowerr
> -			.cdrom .chs .ignore_cable are additional options
> -			See Documentation/ide/ide.rst.
> -
> -	ide-generic.probe-mask= [HW] (E)IDE subsystem
> -			Format: <int>
> -			Probe mask for legacy ISA IDE ports.  Depending on
> -			platform up to 6 ports are supported, enabled by
> -			setting corresponding bits in the mask to 1.  The
> -			default value is 0x0, which has a special meaning.
> -			On systems that have PCI, it triggers scanning the
> -			PCI bus for the first and the second port, which
> -			are then probed.  On systems without PCI the value
> -			of 0x0 enables probing the two first ports as if it
> -			was 0x3.
> -
> -	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
> -			Claim all unknown PCI IDE storage controllers.
> -
>  	idle=		[X86]
>  			Format: idle=poll, idle=halt, idle=nomwait
>  			Poll forces a polling idle loop that can slightly
> diff --git a/Documentation/cdrom/ide-cd.rst b/Documentation/cdrom/ide-cd.rst
> deleted file mode 100644
> index bdccb74fc92d..000000000000
> --- a/Documentation/cdrom/ide-cd.rst
> +++ /dev/null
> @@ -1,538 +0,0 @@
> -IDE-CD driver documentation
> -===========================
> -
> -:Originally by: scott snyder  <snyder@fnald0.fnal.gov> (19 May 1996)
> -:Carrying on the torch is: Erik Andersen <andersee@debian.org>
> -:New maintainers (19 Oct 1998): Jens Axboe <axboe@image.dk>
> -
> -1. Introduction
> ----------------
> -
> -The ide-cd driver should work with all ATAPI ver 1.2 to ATAPI 2.6 compliant
> -CDROM drives which attach to an IDE interface.  Note that some CDROM vendors
> -(including Mitsumi, Sony, Creative, Aztech, and Goldstar) have made
> -both ATAPI-compliant drives and drives which use a proprietary
> -interface.  If your drive uses one of those proprietary interfaces,
> -this driver will not work with it (but one of the other CDROM drivers
> -probably will).  This driver will not work with `ATAPI` drives which
> -attach to the parallel port.  In addition, there is at least one drive
> -(CyCDROM CR520ie) which attaches to the IDE port but is not ATAPI;
> -this driver will not work with drives like that either (but see the
> -aztcd driver).
> -
> -This driver provides the following features:
> -
> - - Reading from data tracks, and mounting ISO 9660 filesystems.
> -
> - - Playing audio tracks.  Most of the CDROM player programs floating
> -   around should work; I usually use Workman.
> -
> - - Multisession support.
> -
> - - On drives which support it, reading digital audio data directly
> -   from audio tracks.  The program cdda2wav can be used for this.
> -   Note, however, that only some drives actually support this.
> -
> - - There is now support for CDROM changers which comply with the
> -   ATAPI 2.6 draft standard (such as the NEC CDR-251).  This additional
> -   functionality includes a function call to query which slot is the
> -   currently selected slot, a function call to query which slots contain
> -   CDs, etc. A sample program which demonstrates this functionality is
> -   appended to the end of this file.  The Sanyo 3-disc changer
> -   (which does not conform to the standard) is also now supported.
> -   Please note the driver refers to the first CD as slot # 0.
> -
> -
> -2. Installation
> ----------------
> -
> -0. The ide-cd relies on the ide disk driver.  See
> -   Documentation/ide/ide.rst for up-to-date information on the ide
> -   driver.
> -
> -1. Make sure that the ide and ide-cd drivers are compiled into the
> -   kernel you're using.  When configuring the kernel, in the section
> -   entitled "Floppy, IDE, and other block devices", say either `Y`
> -   (which will compile the support directly into the kernel) or `M`
> -   (to compile support as a module which can be loaded and unloaded)
> -   to the options::
> -
> -      ATA/ATAPI/MFM/RLL support
> -      Include IDE/ATAPI CDROM support
> -
> -   Depending on what type of IDE interface you have, you may need to
> -   specify additional configuration options.  See
> -   Documentation/ide/ide.rst.
> -
> -2. You should also ensure that the iso9660 filesystem is either
> -   compiled into the kernel or available as a loadable module.  You
> -   can see if a filesystem is known to the kernel by catting
> -   /proc/filesystems.
> -
> -3. The CDROM drive should be connected to the host on an IDE
> -   interface.  Each interface on a system is defined by an I/O port
> -   address and an IRQ number, the standard assignments being
> -   0x1f0 and 14 for the primary interface and 0x170 and 15 for the
> -   secondary interface.  Each interface can control up to two devices,
> -   where each device can be a hard drive, a CDROM drive, a floppy drive,
> -   or a tape drive.  The two devices on an interface are called `master`
> -   and `slave`; this is usually selectable via a jumper on the drive.
> -
> -   Linux names these devices as follows.  The master and slave devices
> -   on the primary IDE interface are called `hda` and `hdb`,
> -   respectively.  The drives on the secondary interface are called
> -   `hdc` and `hdd`.  (Interfaces at other locations get other letters
> -   in the third position; see Documentation/ide/ide.rst.)
> -
> -   If you want your CDROM drive to be found automatically by the
> -   driver, you should make sure your IDE interface uses either the
> -   primary or secondary addresses mentioned above.  In addition, if
> -   the CDROM drive is the only device on the IDE interface, it should
> -   be jumpered as `master`.  (If for some reason you cannot configure
> -   your system in this manner, you can probably still use the driver.
> -   You may have to pass extra configuration information to the kernel
> -   when you boot, however.  See Documentation/ide/ide.rst for more
> -   information.)
> -
> -4. Boot the system.  If the drive is recognized, you should see a
> -   message which looks like::
> -
> -     hdb: NEC CD-ROM DRIVE:260, ATAPI CDROM drive
> -
> -   If you do not see this, see section 5 below.
> -
> -5. You may want to create a symbolic link /dev/cdrom pointing to the
> -   actual device.  You can do this with the command::
> -
> -     ln -s  /dev/hdX  /dev/cdrom
> -
> -   where X should be replaced by the letter indicating where your
> -   drive is installed.
> -
> -6. You should be able to see any error messages from the driver with
> -   the `dmesg` command.
> -
> -
> -3. Basic usage
> ---------------
> -
> -An ISO 9660 CDROM can be mounted by putting the disc in the drive and
> -typing (as root)::
> -
> -  mount -t iso9660 /dev/cdrom /mnt/cdrom
> -
> -where it is assumed that /dev/cdrom is a link pointing to the actual
> -device (as described in step 5 of the last section) and /mnt/cdrom is
> -an empty directory.  You should now be able to see the contents of the
> -CDROM under the /mnt/cdrom directory.  If you want to eject the CDROM,
> -you must first dismount it with a command like::
> -
> -  umount /mnt/cdrom
> -
> -Note that audio CDs cannot be mounted.
> -
> -Some distributions set up /etc/fstab to always try to mount a CDROM
> -filesystem on bootup.  It is not required to mount the CDROM in this
> -manner, though, and it may be a nuisance if you change CDROMs often.
> -You should feel free to remove the cdrom line from /etc/fstab and
> -mount CDROMs manually if that suits you better.
> -
> -Multisession and photocd discs should work with no special handling.
> -The hpcdtoppm package (ftp.gwdg.de:/pub/linux/hpcdtoppm/) may be
> -useful for reading photocds.
> -
> -To play an audio CD, you should first unmount and remove any data
> -CDROM.  Any of the CDROM player programs should then work (workman,
> -workbone, cdplayer, etc.).
> -
> -On a few drives, you can read digital audio directly using a program
> -such as cdda2wav.  The only types of drive which I've heard support
> -this are Sony and Toshiba drives.  You will get errors if you try to
> -use this function on a drive which does not support it.
> -
> -For supported changers, you can use the `cdchange` program (appended to
> -the end of this file) to switch between changer slots.  Note that the
> -drive should be unmounted before attempting this.  The program takes
> -two arguments:  the CDROM device, and the slot number to which you wish
> -to change.  If the slot number is -1, the drive is unloaded.
> -
> -
> -4. Common problems
> -------------------
> -
> -This section discusses some common problems encountered when trying to
> -use the driver, and some possible solutions.  Note that if you are
> -experiencing problems, you should probably also review
> -Documentation/ide/ide.rst for current information about the underlying
> -IDE support code.  Some of these items apply only to earlier versions
> -of the driver, but are mentioned here for completeness.
> -
> -In most cases, you should probably check with `dmesg` for any errors
> -from the driver.
> -
> -a. Drive is not detected during booting.
> -
> -   - Review the configuration instructions above and in
> -     Documentation/ide/ide.rst, and check how your hardware is
> -     configured.
> -
> -   - If your drive is the only device on an IDE interface, it should
> -     be jumpered as master, if at all possible.
> -
> -   - If your IDE interface is not at the standard addresses of 0x170
> -     or 0x1f0, you'll need to explicitly inform the driver using a
> -     lilo option.  See Documentation/ide/ide.rst.  (This feature was
> -     added around kernel version 1.3.30.)
> -
> -   - If the autoprobing is not finding your drive, you can tell the
> -     driver to assume that one exists by using a lilo option of the
> -     form `hdX=cdrom`, where X is the drive letter corresponding to
> -     where your drive is installed.  Note that if you do this and you
> -     see a boot message like::
> -
> -       hdX: ATAPI cdrom (?)
> -
> -     this does _not_ mean that the driver has successfully detected
> -     the drive; rather, it means that the driver has not detected a
> -     drive, but is assuming there's one there anyway because you told
> -     it so.  If you actually try to do I/O to a drive defined at a
> -     nonexistent or nonresponding I/O address, you'll probably get
> -     errors with a status value of 0xff.
> -
> -   - Some IDE adapters require a nonstandard initialization sequence
> -     before they'll function properly.  (If this is the case, there
> -     will often be a separate MS-DOS driver just for the controller.)
> -     IDE interfaces on sound cards often fall into this category.
> -
> -     Support for some interfaces needing extra initialization is
> -     provided in later 1.3.x kernels.  You may need to turn on
> -     additional kernel configuration options to get them to work;
> -     see Documentation/ide/ide.rst.
> -
> -     Even if support is not available for your interface, you may be
> -     able to get it to work with the following procedure.  First boot
> -     MS-DOS and load the appropriate drivers.  Then warm-boot linux
> -     (i.e., without powering off).  If this works, it can be automated
> -     by running loadlin from the MS-DOS autoexec.
> -
> -
> -b. Timeout/IRQ errors.
> -
> -  - If you always get timeout errors, interrupts from the drive are
> -    probably not making it to the host.
> -
> -  - IRQ problems may also be indicated by the message
> -    `IRQ probe failed (<n>)` while booting.  If <n> is zero, that
> -    means that the system did not see an interrupt from the drive when
> -    it was expecting one (on any feasible IRQ).  If <n> is negative,
> -    that means the system saw interrupts on multiple IRQ lines, when
> -    it was expecting to receive just one from the CDROM drive.
> -
> -  - Double-check your hardware configuration to make sure that the IRQ
> -    number of your IDE interface matches what the driver expects.
> -    (The usual assignments are 14 for the primary (0x1f0) interface
> -    and 15 for the secondary (0x170) interface.)  Also be sure that
> -    you don't have some other hardware which might be conflicting with
> -    the IRQ you're using.  Also check the BIOS setup for your system;
> -    some have the ability to disable individual IRQ levels, and I've
> -    had one report of a system which was shipped with IRQ 15 disabled
> -    by default.
> -
> -  - Note that many MS-DOS CDROM drivers will still function even if
> -    there are hardware problems with the interrupt setup; they
> -    apparently don't use interrupts.
> -
> -  - If you own a Pioneer DR-A24X, you _will_ get nasty error messages
> -    on boot such as "irq timeout: status=0x50 { DriveReady SeekComplete }"
> -    The Pioneer DR-A24X CDROM drives are fairly popular these days.
> -    Unfortunately, these drives seem to become very confused when we perform
> -    the standard Linux ATA disk drive probe. If you own one of these drives,
> -    you can bypass the ATA probing which confuses these CDROM drives, by
> -    adding `append="hdX=noprobe hdX=cdrom"` to your lilo.conf file and running
> -    lilo (again where X is the drive letter corresponding to where your drive
> -    is installed.)
> -
> -c. System hangups.
> -
> -  - If the system locks up when you try to access the CDROM, the most
> -    likely cause is that you have a buggy IDE adapter which doesn't
> -    properly handle simultaneous transactions on multiple interfaces.
> -    The most notorious of these is the CMD640B chip.  This problem can
> -    be worked around by specifying the `serialize` option when
> -    booting.  Recent kernels should be able to detect the need for
> -    this automatically in most cases, but the detection is not
> -    foolproof.  See Documentation/ide/ide.rst for more information
> -    about the `serialize` option and the CMD640B.
> -
> -  - Note that many MS-DOS CDROM drivers will work with such buggy
> -    hardware, apparently because they never attempt to overlap CDROM
> -    operations with other disk activity.
> -
> -
> -d. Can't mount a CDROM.
> -
> -  - If you get errors from mount, it may help to check `dmesg` to see
> -    if there are any more specific errors from the driver or from the
> -    filesystem.
> -
> -  - Make sure there's a CDROM loaded in the drive, and that's it's an
> -    ISO 9660 disc.  You can't mount an audio CD.
> -
> -  - With the CDROM in the drive and unmounted, try something like::
> -
> -      cat /dev/cdrom | od | more
> -
> -    If you see a dump, then the drive and driver are probably working
> -    OK, and the problem is at the filesystem level (i.e., the CDROM is
> -    not ISO 9660 or has errors in the filesystem structure).
> -
> -  - If you see `not a block device` errors, check that the definitions
> -    of the device special files are correct.  They should be as
> -    follows::
> -
> -      brw-rw----   1 root     disk       3,   0 Nov 11 18:48 /dev/hda
> -      brw-rw----   1 root     disk       3,  64 Nov 11 18:48 /dev/hdb
> -      brw-rw----   1 root     disk      22,   0 Nov 11 18:48 /dev/hdc
> -      brw-rw----   1 root     disk      22,  64 Nov 11 18:48 /dev/hdd
> -
> -    Some early Slackware releases had these defined incorrectly.  If
> -    these are wrong, you can remake them by running the script
> -    scripts/MAKEDEV.ide.  (You may have to make it executable
> -    with chmod first.)
> -
> -    If you have a /dev/cdrom symbolic link, check that it is pointing
> -    to the correct device file.
> -
> -    If you hear people talking of the devices `hd1a` and `hd1b`, these
> -    were old names for what are now called hdc and hdd.  Those names
> -    should be considered obsolete.
> -
> -  - If mount is complaining that the iso9660 filesystem is not
> -    available, but you know it is (check /proc/filesystems), you
> -    probably need a newer version of mount.  Early versions would not
> -    always give meaningful error messages.
> -
> -
> -e. Directory listings are unpredictably truncated, and `dmesg` shows
> -   `buffer botch` error messages from the driver.
> -
> -  - There was a bug in the version of the driver in 1.2.x kernels
> -    which could cause this.  It was fixed in 1.3.0.  If you can't
> -    upgrade, you can probably work around the problem by specifying a
> -    blocksize of 2048 when mounting.  (Note that you won't be able to
> -    directly execute binaries off the CDROM in that case.)
> -
> -    If you see this in kernels later than 1.3.0, please report it as a
> -    bug.
> -
> -
> -f. Data corruption.
> -
> -  - Random data corruption was occasionally observed with the Hitachi
> -    CDR-7730 CDROM. If you experience data corruption, using "hdx=slow"
> -    as a command line parameter may work around the problem, at the
> -    expense of low system performance.
> -
> -
> -5. cdchange.c
> --------------
> -
> -::
> -
> -  /*
> -   * cdchange.c  [-v]  <device>  [<slot>]
> -   *
> -   * This loads a CDROM from a specified slot in a changer, and displays
> -   * information about the changer status.  The drive should be unmounted before
> -   * using this program.
> -   *
> -   * Changer information is displayed if either the -v flag is specified
> -   * or no slot was specified.
> -   *
> -   * Based on code originally from Gerhard Zuber <zuber@berlin.snafu.de>.
> -   * Changer status information, and rewrite for the new Uniform CDROM driver
> -   * interface by Erik Andersen <andersee@debian.org>.
> -   */
> -
> -  #include <stdio.h>
> -  #include <stdlib.h>
> -  #include <errno.h>
> -  #include <string.h>
> -  #include <unistd.h>
> -  #include <fcntl.h>
> -  #include <sys/ioctl.h>
> -  #include <linux/cdrom.h>
> -
> -
> -  int
> -  main (int argc, char **argv)
> -  {
> -	char *program;
> -	char *device;
> -	int fd;           /* file descriptor for CD-ROM device */
> -	int status;       /* return status for system calls */
> -	int verbose = 0;
> -	int slot=-1, x_slot;
> -	int total_slots_available;
> -
> -	program = argv[0];
> -
> -	++argv;
> -	--argc;
> -
> -	if (argc < 1 || argc > 3) {
> -		fprintf (stderr, "usage: %s [-v] <device> [<slot>]\n",
> -			 program);
> -		fprintf (stderr, "       Slots are numbered 1 -- n.\n");
> -		exit (1);
> -	}
> -
> -       if (strcmp (argv[0], "-v") == 0) {
> -                verbose = 1;
> -                ++argv;
> -                --argc;
> -        }
> -
> -	device = argv[0];
> -
> -	if (argc == 2)
> -		slot = atoi (argv[1]) - 1;
> -
> -	/* open device */
> -	fd = open(device, O_RDONLY | O_NONBLOCK);
> -	if (fd < 0) {
> -		fprintf (stderr, "%s: open failed for `%s`: %s\n",
> -			 program, device, strerror (errno));
> -		exit (1);
> -	}
> -
> -	/* Check CD player status */
> -	total_slots_available = ioctl (fd, CDROM_CHANGER_NSLOTS);
> -	if (total_slots_available <= 1 ) {
> -		fprintf (stderr, "%s: Device `%s` is not an ATAPI "
> -			"compliant CD changer.\n", program, device);
> -		exit (1);
> -	}
> -
> -	if (slot >= 0) {
> -		if (slot >= total_slots_available) {
> -			fprintf (stderr, "Bad slot number.  "
> -				 "Should be 1 -- %d.\n",
> -				 total_slots_available);
> -			exit (1);
> -		}
> -
> -		/* load */
> -		slot=ioctl (fd, CDROM_SELECT_DISC, slot);
> -		if (slot<0) {
> -			fflush(stdout);
> -				perror ("CDROM_SELECT_DISC ");
> -			exit(1);
> -		}
> -	}
> -
> -	if (slot < 0 || verbose) {
> -
> -		status=ioctl (fd, CDROM_SELECT_DISC, CDSL_CURRENT);
> -		if (status<0) {
> -			fflush(stdout);
> -			perror (" CDROM_SELECT_DISC");
> -			exit(1);
> -		}
> -		slot=status;
> -
> -		printf ("Current slot: %d\n", slot+1);
> -		printf ("Total slots available: %d\n",
> -			total_slots_available);
> -
> -		printf ("Drive status: ");
> -                status = ioctl (fd, CDROM_DRIVE_STATUS, CDSL_CURRENT);
> -                if (status<0) {
> -                  perror(" CDROM_DRIVE_STATUS");
> -                } else switch(status) {
> -		case CDS_DISC_OK:
> -			printf ("Ready.\n");
> -			break;
> -		case CDS_TRAY_OPEN:
> -			printf ("Tray Open.\n");
> -			break;
> -		case CDS_DRIVE_NOT_READY:
> -			printf ("Drive Not Ready.\n");
> -			break;
> -		default:
> -			printf ("This Should not happen!\n");
> -			break;
> -		}
> -
> -		for (x_slot=0; x_slot<total_slots_available; x_slot++) {
> -			printf ("Slot %2d: ", x_slot+1);
> -			status = ioctl (fd, CDROM_DRIVE_STATUS, x_slot);
> -			if (status<0) {
> -			     perror(" CDROM_DRIVE_STATUS");
> -			} else switch(status) {
> -			case CDS_DISC_OK:
> -				printf ("Disc present.");
> -				break;
> -			case CDS_NO_DISC:
> -				printf ("Empty slot.");
> -				break;
> -			case CDS_TRAY_OPEN:
> -				printf ("CD-ROM tray open.\n");
> -				break;
> -			case CDS_DRIVE_NOT_READY:
> -				printf ("CD-ROM drive not ready.\n");
> -				break;
> -			case CDS_NO_INFO:
> -				printf ("No Information available.");
> -				break;
> -			default:
> -				printf ("This Should not happen!\n");
> -				break;
> -			}
> -		  if (slot == x_slot) {
> -                  status = ioctl (fd, CDROM_DISC_STATUS);
> -                  if (status<0) {
> -			perror(" CDROM_DISC_STATUS");
> -                  }
> -		  switch (status) {
> -			case CDS_AUDIO:
> -				printf ("\tAudio disc.\t");
> -				break;
> -			case CDS_DATA_1:
> -			case CDS_DATA_2:
> -				printf ("\tData disc type %d.\t", status-CDS_DATA_1+1);
> -				break;
> -			case CDS_XA_2_1:
> -			case CDS_XA_2_2:
> -				printf ("\tXA data disc type %d.\t", status-CDS_XA_2_1+1);
> -				break;
> -			default:
> -				printf ("\tUnknown disc type 0x%x!\t", status);
> -				break;
> -			}
> -			}
> -			status = ioctl (fd, CDROM_MEDIA_CHANGED, x_slot);
> -			if (status<0) {
> -				perror(" CDROM_MEDIA_CHANGED");
> -			}
> -			switch (status) {
> -			case 1:
> -				printf ("Changed.\n");
> -				break;
> -			default:
> -				printf ("\n");
> -				break;
> -			}
> -		}
> -	}
> -
> -	/* close device */
> -	status = close (fd);
> -	if (status != 0) {
> -		fprintf (stderr, "%s: close failed for `%s`: %s\n",
> -			 program, device, strerror (errno));
> -		exit (1);
> -	}
> -
> -	exit (0);
> -  }
> diff --git a/Documentation/cdrom/index.rst b/Documentation/cdrom/index.rst
> index 338ad5f94e7c..e87a8785bc1a 100644
> --- a/Documentation/cdrom/index.rst
> +++ b/Documentation/cdrom/index.rst
> @@ -8,7 +8,6 @@ cdrom
>      :maxdepth: 1
>  
>      cdrom-standard
> -    ide-cd
>      packet-writing
>  
>  .. only::  subproject and html
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 061744c436d9..6a0dd99786f9 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1183,85 +1183,7 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
>      HRTIMER:         0          0          0          0
>  	RCU:      1678       1769       2178       2250
>  
> -
> -1.3 IDE devices in /proc/ide
> -----------------------------
> -
> -The subdirectory /proc/ide contains information about all IDE devices of which
> -the kernel  is  aware.  There is one subdirectory for each IDE controller, the
> -file drivers  and a link for each IDE device, pointing to the device directory
> -in the controller specific subtree.
> -
> -The file 'drivers' contains general information about the drivers used for the
> -IDE devices::
> -
> -  > cat /proc/ide/drivers
> -  ide-cdrom version 4.53
> -  ide-disk version 1.08
> -
> -More detailed  information  can  be  found  in  the  controller  specific
> -subdirectories. These  are  named  ide0,  ide1  and  so  on.  Each  of  these
> -directories contains the files shown in table 1-6.
> -
> -
> -.. table:: Table 1-6: IDE controller info in  /proc/ide/ide?
> -
> - ======= =======================================
> - File    Content
> - ======= =======================================
> - channel IDE channel (0 or 1)
> - config  Configuration (only for PCI/IDE bridge)
> - mate    Mate name
> - model   Type/Chipset of IDE controller
> - ======= =======================================
> -
> -Each device  connected  to  a  controller  has  a separate subdirectory in the
> -controllers directory.  The  files  listed in table 1-7 are contained in these
> -directories.
> -
> -
> -.. table:: Table 1-7: IDE device information
> -
> - ================ ==========================================
> - File             Content
> - ================ ==========================================
> - cache            The cache
> - capacity         Capacity of the medium (in 512Byte blocks)
> - driver           driver and version
> - geometry         physical and logical geometry
> - identify         device identify block
> - media            media type
> - model            device identifier
> - settings         device setup
> - smart_thresholds IDE disk management thresholds
> - smart_values     IDE disk management values
> - ================ ==========================================
> -
> -The most  interesting  file is ``settings``. This file contains a nice
> -overview of the drive parameters::
> -
> -  # cat /proc/ide/ide0/hda/settings
> -  name                    value           min             max             mode
> -  ----                    -----           ---             ---             ----
> -  bios_cyl                526             0               65535           rw
> -  bios_head               255             0               255             rw
> -  bios_sect               63              0               63              rw
> -  breada_readahead        4               0               127             rw
> -  bswap                   0               0               1               r
> -  file_readahead          72              0               2097151         rw
> -  io_32bit                0               0               3               rw
> -  keepsettings            0               0               1               rw
> -  max_kb_per_request      122             1               127             rw
> -  multcount               0               0               8               rw
> -  nice1                   1               0               1               rw
> -  nowerr                  0               0               1               rw
> -  pio_mode                write-only      0               255             w
> -  slow                    0               0               1               rw
> -  unmaskirq               0               0               1               rw
> -  using_dma               0               0               1               rw
> -
> -
> -1.4 Networking info in /proc/net
> +1.3 Networking info in /proc/net
>  --------------------------------
>  
>  The subdirectory  /proc/net  follows  the  usual  pattern. Table 1-8 shows the
> @@ -1340,7 +1262,7 @@ It will contain information that is specific to that bond, such as the
>  current slaves of the bond, the link status of the slaves, and how
>  many times the slaves link has failed.
>  
> -1.5 SCSI info
> +1.4 SCSI info
>  -------------
>  
>  If you  have  a  SCSI  host adapter in your system, you'll find a subdirectory
> @@ -1403,7 +1325,7 @@ AHA-2940 SCSI adapter::
>      Total transfers 0 (0 reads and 0 writes)
>  
>  
> -1.6 Parallel port info in /proc/parport
> +1.5 Parallel port info in /proc/parport
>  ---------------------------------------
>  
>  The directory  /proc/parport  contains information about the parallel ports of
> @@ -1428,7 +1350,7 @@ These directories contain the four files shown in Table 1-10.
>             number or none).
>   ========= ====================================================================
>  
> -1.7 TTY info in /proc/tty
> +1.6 TTY info in /proc/tty
>  -------------------------
>  
>  Information about  the  available  and actually used tty's can be found in the
> @@ -1463,7 +1385,7 @@ To see  which  tty's  are  currently in use, you can simply look into the file
>    unknown              /dev/tty        4    1-63 console
>  
>  
> -1.8 Miscellaneous kernel statistics in /proc/stat
> +1.7 Miscellaneous kernel statistics in /proc/stat
>  -------------------------------------------------
>  
>  Various pieces   of  information about  kernel activity  are  available in the
> @@ -1536,7 +1458,7 @@ softirqs serviced; each subsequent column is the total for that particular
>  softirq.
>  
>  
> -1.9 Ext4 file system parameters
> +1.8 Ext4 file system parameters
>  -------------------------------
>  
>  Information about mounted ext4 file systems can be found in
> @@ -1552,7 +1474,7 @@ in Table 1-12, below.
>   mb_groups       details of multiblock allocator buddy cache of free blocks
>   ==============  ==========================================================
>  
> -1.10 /proc/consoles
> +1.9 /proc/consoles
>  -------------------
>  Shows registered system console lines.
>  
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 35d90903242a..018b3d921f63 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -104,6 +104,7 @@ needed).
>     block/index
>     cdrom/index
>     cpu-freq/index
> +   ide/index
>     fb/index
>     fpga/index
>     hid/index
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index f270080f1478..789093375344 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -12,7 +12,7 @@
>   * Theory of operation:
>   *
>   * At the lowest level, there is the standard driver for the CD/DVD device,
> - * typically ide-cd.c or sr.c. This driver can handle read and write requests,
> + * such as drivers/scsi/sr.c. This driver can handle read and write requests,
>   * but it doesn't know anything about the special restrictions that apply to
>   * packet writing. One restriction is that write requests must be aligned to
>   * packet boundaries on the physical media, and the size of a write request
> -- 
> 2.33.0
> 

Hi Paul,

Apologies if I'm missing something, but this updated diff still seems to
conflict with Randy's earlier one. As cdrom doesn't get a lot of churn,
I agreed with Jens that I would usually just send on all accepted
patches at once to him and he would take them via his tree (I currently
have four accepted patches, including your two others and Randy's patch,
plus one other).

Anyhow, please could this be corrected? Or me shown the error of my ways
(always possible I'm making a mistake) :-) Many thanks.

Regards,
Phil
