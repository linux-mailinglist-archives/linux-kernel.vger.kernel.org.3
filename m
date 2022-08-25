Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5EA5A1033
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbiHYMTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiHYMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:19:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28770B08AF
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAA54B8291C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B46C433C1;
        Thu, 25 Aug 2022 12:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661429966;
        bh=KYwCMLWWp0i6wCdI3DiH1RLoOwUUovYPXZkfK9Fxk3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUkNnws8cgbCpG4vbpDxY5Dsk8o7OBPdY+j2Wdc3mqJDypYvxuroUdBWPGLycPbBl
         5/pv7vzVlhg39BWmRXXN+xD5KB2rVIJXC5OYf8qdk9b93LB4DqMrcE9meBA/3y7Ia/
         5BCKeJJgEVgzlgoNHQo7eU+eyp7JkB6rnAsXBjuQ=
Date:   Thu, 25 Aug 2022 14:19:23 +0200
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
Message-ID: <YwdoyzTriZNr/qN1@kroah.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwclcEJDf/POuHw5@kroah.com>
 <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdBMIgSzEiFjc4D@kroah.com>
 <PAXPR02MB7310694F20F95CA446FFF22481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdN3vJ1Z+1yKfma@kroah.com>
 <PAXPR02MB73108383655C1FB4B98C3C2281729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdhF6r0egBc3w1m@kroah.com>
 <PAXPR02MB73109BEB7197DAEEAFE929F781729@PAXPR02MB7310.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR02MB73109BEB7197DAEEAFE929F781729@PAXPR02MB7310.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:02:12PM +0000, Czerwacki, Eial wrote:
> >On Thu, Aug 25, 2022 at 10:41:28AM +0000, Czerwacki, Eial wrote:
> >> >On Thu, Aug 25, 2022 at 10:16:59AM +0000, Czerwacki, Eial wrote:
> >> >> >> >And why is your version file a binary file?  It should just be a small
> >> >> >> >text string, right?
> >> >> >> not so small, it can reach up to 512kb.
> >> >> >
> >> >> >That was not obvious at all.  Please document this.
> >> >> where should the document be?
> >> >> in the code as a comment or in another file?
> >> >
> >> >In the Documentation/ABI/ file that describes this file.
> >> ok, will place it there
> >> 
> >> >
> >> >> >And how in the world is a "version" that big?  What exactly does this
> >> >> >contain?
> >> >> it 's size depends on the number of resources it uses.
> >> >> here is an example:
> >> >> :~> cat /sys/hypervisor/vsmp/version  
> >> >> SAP vSMP Foundation: 10.6.2862.0 (Aug 22 2022 15:21:02)
> >> >> System configuration:
> >> >>    Boards:      2
> >> >>       1 x Proc. + I/O + Memory
> >> >>       1 x NVM devices (Amazon.com Amazon EC2 NVMe Instance Storage)
> >> >>    Processors:  1, Cores: 2, Threads: 4
> >> >>        Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz Stepping 04
> >> >>    Memory (MB): 30976 (of 103192), Cache: 7527, Private: 64689
> >> >>       1 x  6400MB    [ 7825/ 321/ 1104]      
> >> >>       1 x 24576MB    [95367/7206/63585]       00:1f.0#1
> >> >>    Boot device: [HDD] NVMe: Amazon Elastic Block Store        
> >> >> Supported until: Aug 22 2024
> >> >
> >> >That is crazy, and is not a version.  It's a "configuration".
> >> it is called version for history reasons...
> >
> >There is no "history" here, you can create whatever sane interface you
> >want right now, there is no backwards compatible issues involved at all.
> you are correct, however, it depends on how much change the hypervisor code requires
> if any (latter is preferable)

I do not understand, again, what tool consumes this today?

> >> >See above, make it text only for the version.  If you want to export
> >> >other things, be explicit and make them "one value per sysfs file" or
> >> >use debugfs for debugging things that no one relies on.
> >> so you suggest braking the summery into files, e.g. one for cpus, one for ram and etcetera?
> >
> >Again, who uses this information and what is it used for?
> >
> >thanks,
> >
> >greg k-h
> 
> both user who uses the product and the development team.
> it is used to provide a summery of the system. for example, which devices are used
> by the hypervisor.

That's a very odd way to display this as a free-flowing, impossible to
parse, file.  Please use something that will be able to be maintained
over time.

thanks,

greg k-h
