Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7D5A0CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbiHYJan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbiHYJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:30:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21F74354
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89C47B827DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51A1C433D6;
        Thu, 25 Aug 2022 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661419827;
        bh=UFn/gif7qLDNI3Shym15nrnwi/rayAoHECqqK1eBNTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ywcnqeXXUfBnt9e4rWNHeb+hrSb92XPT+Czk+aZvzufKXbnYUoTbKD0x4YI8XRRCC
         ocrq/ZG+BvKxU34PtDtfxzcuQsD2+kuWV3MYYVPTeid1g1lePIdbGBXb5NvPRwJljv
         2uzS6ZNuJJHCUS83fLylnOj9+Z/ClUhz77fdJPas=
Date:   Thu, 25 Aug 2022 11:30:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Czerwacki, Eial" <eial.czerwacki@sap.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Message-ID: <YwdBMIgSzEiFjc4D@kroah.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwclcEJDf/POuHw5@kroah.com>
 <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:17:57AM +0000, Czerwacki, Eial wrote:
> Greetings Greg,
> 
> thank you for the comments, see my comment below.
> >On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:
> >> Introducing the vSMP guest driver which allows interaction with the
> >> vSMP control device when running a Linux OS atop of the vSMP hypervisor.
> >> vSMP is a resource aggregation hypervisor from SAP.
> >> 
> >> The driver comprises of api part which facilitates communication with
> >> the hypervisor and version which displays the hypervisor's version.
> >> 
> >> This patch s based on previous patches sent to the staging tree mailing
> >> lists
> >> 
> >> Signed-off-by: Eial Czerwacki <eial.czerwacki@sap.com>
> >> Acked-by: Leonid Arsh <leonid.arsh@sap.com>
> >> Acked-by: Oren Twaig <oren.twaig@sap.com>
> >> CC: SAP vSMP Linux Maintainer <linux.vsmp@sap.com>
> >> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> CC: Arnd Bergmann <arnd@arndb.de>
> >> CC: Dan Carpenter <dan.carpenter@oracle.com>
> >> CC: Andra Paraschiv <andraprs@amazon.com>
> >> CC: Borislav Petkov <bp@suse.de>
> >> CC: Brijesh Singh <brijesh.singh@amd.com>
> >> CC: Eric Biggers <ebiggers@google.com>
> >> CC: Fei Li <fei1.li@intel.com>
> >> CC: Hans de Goede <hdegoede@redhat.com>
> >> CC: Jens Axboe <axboe@kernel.dk>
> >> CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> 
> >> v1 -> v2:
> >>        - fix -0 var init in add_sysfs_entries (pointed out by Dan Carpenter)
> >> ---
> >>  Documentation/ABI/stable/sysfs-driver-vsmp |   5 +
> >>  MAINTAINERS                                |   6 +
> >>  drivers/virt/Kconfig                       |   2 +
> >>  drivers/virt/Makefile                      |   2 +
> >>  drivers/virt/vsmp/Kconfig                  |  11 +
> >>  drivers/virt/vsmp/Makefile                 |   7 +
> >>  drivers/virt/vsmp/api/api.c                | 249 +++++++++++++++++++++
> >>  drivers/virt/vsmp/api/api.h                |  69 ++++++
> >>  drivers/virt/vsmp/include/registers.h      |  12 +
> >>  drivers/virt/vsmp/version/version.c        | 118 ++++++++++
> >>  drivers/virt/vsmp/version/version.h        |  14 ++
> >>  drivers/virt/vsmp/vsmp_main.c              | 110 +++++++++
> >>  12 files changed, 605 insertions(+)
> >
> >Why do you have all of these different .c and .h files for only 600
> >lines of code?  Shouldn't this all just be in a single .c file?  Why
> >have a subdir for just 300 lines?
> >
> >Please mush this all into a single .c file going forward, speading it
> >out like this makes no sense.
> the current driver has two modules, version and api, in later versions of the
> driver support for additional features will be added.
> at that time, this might cause the single file to inflate, so we thought to split it
> to several files to make it more organized.
> is there any way to keep it in different code files?

Keep it small and together now.  If you need to change it in the future,
wonderful, do it then.  Don't do things that we never know will happen
or not.

One file, and one module, is great to start with.  Please do that for
now.


> 
> >
> >>  create mode 100644 Documentation/ABI/stable/sysfs-driver-vsmp
> >>  create mode 100644 drivers/virt/vsmp/Kconfig
> >>  create mode 100644 drivers/virt/vsmp/Makefile
> >>  create mode 100644 drivers/virt/vsmp/api/api.c
> >>  create mode 100644 drivers/virt/vsmp/api/api.h
> >>  create mode 100644 drivers/virt/vsmp/include/registers.h
> >>  create mode 100644 drivers/virt/vsmp/version/version.c
> >>  create mode 100644 drivers/virt/vsmp/version/version.h
> >>  create mode 100644 drivers/virt/vsmp/vsmp_main.c
> >> 
> >> diff --git a/Documentation/ABI/stable/sysfs-driver-vsmp b/Documentation/ABI/stable/sysfs-driver-vsmp
> >> new file mode 100644
> >> index 000000000000..18a0a62f40ed
> >> --- /dev/null
> >> +++ b/Documentation/ABI/stable/sysfs-driver-vsmp
> >> @@ -0,0 +1,5 @@
> >> +What:           /sys/hypervisor/vsmp/version
> >> +Date:           Aug 2022
> >
> >August is almost over :(
> will fix, thank!
> 
> >
> >> +Contact:        Eial Czerwacki <eial.czerwacki@sap.com>
> >> +             linux-vsmp@sap.com
> >
> >No need for an alias here.
> it's not an alias, it is a shard mailbox for the team so others can
> view the mails history.
> I saw that the same methodology is done with mailing lists.

That's a mailing list?  Ah, didn't realize that, sorry, was not obvious.

> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index f512b430c7cb..cf74089c4d19 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -21783,6 +21783,12 @@ F:   lib/test_printf.c
> >>  F:   lib/test_scanf.c
> >>  F:   lib/vsprintf.c
> >> 
> >> +VSMP GUEST DRIVER
> >> +M:   Eial Czerwacki <eial.czerwacki@sap.com>
> >> +M:   linux-vsmp@sap.com
> >
> >Again, no random aliases please, stick to a person as a contact.
> see above comment

If this is a mailing list, mark it as such, you did not do so.


> >> +/*
> >> + * Register the vSMP sysfs object for user space interaction
> >> + */
> >> +int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr)
> >> +{
> >> +     int error = -EINVAL;
> >> +
> >> +     if (vsmp_sysfs_kobj && bin_attr) {
> >> +             error = sysfs_create_bin_file(vsmp_sysfs_kobj, bin_attr);
> >
> >You raced userspace and lost :(
> not sure I understand, can you elaborate more please?

Fix up your sysfs usage first, and then we can revisit this.


> >
> >And why is your version file a binary file?  It should just be a small
> >text string, right?
> not so small, it can reach up to 512kb.

That was not obvious at all.  Please document this.

And how in the world is a "version" that big?  What exactly does this
contain?

> that is why I decided to go with binary, I understood that the text is rather limited.

That is true, sysfs is "one value per file", this can not be a file that
you parse.


> >> +int open_cfg_addr(struct pci_dev *pdev)
> >> +{
> >> +     u64 cfg_start;
> >> +     u32 cfg_len;
> >> +
> >> +     vsmp_dev_obj = pdev;
> >> +     cfg_start = pci_resource_start(vsmp_dev_obj, 0);
> >> +     cfg_len = pci_resource_len(vsmp_dev_obj, 0);
> >> +
> >> +     dev_dbg(get_dev(), "Mapping bar 0: [0x%llx,0x%llx]\n",
> >> +             cfg_start, cfg_start + cfg_len);
> >
> >Again, you have a device, use that.  Goes for the whole driver.
> I think I've missed something, please correct me if I'm wrong,
> I don't need to save the pdev because there is an existing framework
> that provides it?

You have pdev, use that in your dev_dbg() call.

> >> +#define FILE_PREM 0444
> >
> >File permission of what?  And shouldn't it be "PERM", not "PREM"?  And
> >why do you need it at all?  Just use the proper sysfs macros and you
> >never need it.  See below.
> all the sysfs files (1 for now) should be read for all users.

Then use the proper sysfs macros for that, do not set it yourself.

> I'll submit a new version after a proper file structure will be decided
> thanks again for you comments.

Again, stick with one file to start with.  You can always change that
later once it is merged if you really need it.

thanks,

greg k-h
