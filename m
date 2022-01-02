Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B50482D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiABXcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:32:53 -0500
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Jan 2022 15:32:53 PST
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BBC9C061785;
        Sun,  2 Jan 2022 15:32:53 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8CA9A92009C; Mon,  3 Jan 2022 00:23:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8598892009B;
        Sun,  2 Jan 2022 23:23:36 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:23:36 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Bring the BusLogic host bus adapter driver up to
 Y2021
Message-ID: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Or was it Y2022?

 Anyway, here's v3 of the series, with original patches 1/5 and 2/5 
removed as they have since gone in (thanks!).  No code or description 
change with the remaining patches, just a mechanical regeneration, except 
for Nick's Tested-by annotation for 3/3 (thanks!).  Parts of the original 
cover letter follow that are still relevant, for reference.

 So we are here owing to Christoph's recent ISA bounce buffering sweep: 
<https://lore.kernel.org/linux-scsi/20210331073001.46776-1-hch@lst.de/T/#m981284e74e93216626a0728ce1601ca18fca92e8> 
which has prompted me to verify the current version of Linux with my old 
server, which has been long equipped with venerable Linux 2.6.18 and which 
I now have available for general experimenting, and the BusLogic BT-958 
PCI SCSI host bus adapter the server has used for 20-something years now. 
This revealed an issue with the BusLogic driver.

 It has become obvious the BusLogic driver would have been non-functional, 
should I have upgraded the kernel, at least with this configuration for 
some 8 years now, and the underlying cause has been a long-known issue 
with the MultiMaster firmware I have dealt with already, back in 2003.  
To put it short the firmware cannot cope with commands that request an 
allocation length exceeding the length of actual data returned.

 I have originally observed it with a LOG SENSE command in the course of 
investigating why smartmontools bring the system to a death, and worked it 
around: <https://sourceforge.net/p/smartmontools/mailman/message/4993087/> 
by issuing the command twice, first just to obtain the allocation length 
required.  As it turns out we need a similar workaround in the kernel now.

 But in the course of investigating this issue I have discovered there is 
a second bottom to it and hence I have prepared follow-up changes to 
address problems with our handling of Vital Product Data INQUIRY pages.

 See individual change descriptions for further details.

 Any questions, comments, concerns still?  Otherwise please apply.

  Maciej
