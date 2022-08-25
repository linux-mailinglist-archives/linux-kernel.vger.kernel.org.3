Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BCE5A0DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiHYKYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiHYKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:24:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E42332
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32544B82832
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D95C433D6;
        Thu, 25 Aug 2022 10:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661423082;
        bh=RFfgdarMWGMA++FX+hYtwz3wXEzuMHPPtoLmXbI4ekQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7InVAKJszDVmQB48HHp1HEBbkyeAJxWHoaiDmINPRIKria+zFLSEccZhB7Jza7bh
         Mv9099WdzYX/CYLVhpDbQd3HIpCWPGLGMccgSll+xsYqqiqj0pAr+N1GeH9D0fc27G
         8S/bbHY7tE2vlYhd/yzFKCUgCvninBA2rBtk3oQc=
Date:   Thu, 25 Aug 2022 12:24:30 +0200
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
Message-ID: <YwdN3vJ1Z+1yKfma@kroah.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwclcEJDf/POuHw5@kroah.com>
 <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdBMIgSzEiFjc4D@kroah.com>
 <PAXPR02MB7310694F20F95CA446FFF22481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR02MB7310694F20F95CA446FFF22481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:16:59AM +0000, Czerwacki, Eial wrote:
> >> >And why is your version file a binary file?  It should just be a small
> >> >text string, right?
> >> not so small, it can reach up to 512kb.
> >
> >That was not obvious at all.  Please document this.
> where should the document be?
> in the code as a comment or in another file?

In the Documentation/ABI/ file that describes this file.

> >And how in the world is a "version" that big?  What exactly does this
> >contain?
> it 's size depends on the number of resources it uses.
> here is an example:
> :~> cat /sys/hypervisor/vsmp/version  
> SAP vSMP Foundation: 10.6.2862.0 (Aug 22 2022 15:21:02)
> System configuration:
>    Boards:      2
>       1 x Proc. + I/O + Memory
>       1 x NVM devices (Amazon.com Amazon EC2 NVMe Instance Storage)
>    Processors:  1, Cores: 2, Threads: 4
>        Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz Stepping 04
>    Memory (MB): 30976 (of 103192), Cache: 7527, Private: 64689
>       1 x  6400MB    [ 7825/ 321/ 1104]      
>       1 x 24576MB    [95367/7206/63585]       00:1f.0#1
>    Boot device: [HDD] NVMe: Amazon Elastic Block Store        
> Supported until: Aug 22 2024

That is crazy, and is not a version.  It's a "configuration".

You have a version up there, just export that as a simple string
"10.6.2862.0".  What is the rest of that stuff needed for?  Who will use
it?  Should it just be in a debugfs file for debugging things?

Oh, and I love the "Supported until" tag, that's funny :)

> >> that is why I decided to go with binary, I understood that the text is rather limited.
> >
> >That is true, sysfs is "one value per file", this can not be a file that
> >you parse.
> should I keep it as bin then?

See above, make it text only for the version.  If you want to export
other things, be explicit and make them "one value per sysfs file" or
use debugfs for debugging things that no one relies on.

> >You have pdev, use that in your dev_dbg() call.
> I have pdev when the probe cb is called, however in other funcs I
> don't have it.

That's for the other functions to fix up.  Pass in the device pointer to
them.  You are a driver, there is no reason to NOT have a device pointer
in your functions, otherwise you are operating on global state which a
driver should never do.  You will notice that quickly when you remove
the static variable at the top of the file like I asked you to :)

thanks,

greg k-h
