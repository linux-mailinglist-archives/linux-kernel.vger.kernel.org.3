Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894EE49B5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578044AbiAYOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578185AbiAYOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:15:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9032BC061776;
        Tue, 25 Jan 2022 06:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4xfA8wTIvQYDbPWoz4nyYEs/tAiP/v85UBHIi3yN4b4=; b=KqUU5wAlLQG3UKIBcaVwFEIuC3
        brO+yuSHJyXmCAd/VkS8FEPB6lBLR03VHAChehNZLHd9+aZ2O2NysgfMiAApGo+12aA8euXcSHl6e
        cUVlqBlo+IhUEcF5xI7kBy2eE4eg9BdBT8J5rGhKOV4WuSRblwNAOW1Pjr1nnaNameoNSd5Jq2EBu
        B2JYZ4reyMRAoRgqp8AfFtQMzFv8eXUPkfW7xGKnHZjfM7XfYrH9XjaP7HVgmnj2xwlfAlVUl5sGB
        vzV/SN/aIepRD2bo09q7oTW5tUGNoTDUZ31tM78ls+ZdU+/OJEzk9V3pFw/FYJE+aTryBjdXd+ea8
        r4TGA9MQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCMb8-002vNp-Ar; Tue, 25 Jan 2022 14:15:02 +0000
Date:   Tue, 25 Jan 2022 14:15:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 05/16] scsi: libsas: Add struct sas_tmf_task
Message-ID: <YfAF5nlRBtaA6IVK@casper.infradead.org>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-6-git-send-email-john.garry@huawei.com>
 <Ye/9Fs+JrtlMC+Mb@casper.infradead.org>
 <6b31b15c-98d9-ee07-0092-cbcc5f5c71fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b31b15c-98d9-ee07-0092-cbcc5f5c71fe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:05:11PM +0000, John Garry wrote:
> On 25/01/2022 13:37, Matthew Wilcox wrote:
> > > Also add an interim force phy id field for hisi_sas driver, which will be
> > > removed once the STP "TMF" code is factored out.
> > > 
> > > Even though some LLDDs (pm8001) use a u32 for the tag, u16 should be
> > > enough.
> > ... because pm8001 limits the number of tags to 1024.
> > .
> 
> Sure, but the pm8001 HW does has a 32b field, which is strange as the SAS
> spec defines a 16b field in the task management Function information unit
> "tag of task to be managed" field.

My point is that it's only safe because the pm8001 driver already limits
it to smaller than u16.  Seeing language like "should be enough" made
me think you'd just assumed that it would be.  Seeing a line like:
        u32 tag = 0xdeadbeef, rc = 0, n_elem = 0;
made me think it might not be; perhaps 0xdeadbeef was being used as
a flag value somewhere in the driver.

For example ...

drivers/scsi/pm8001/pm8001_hwi.c:       int rc, tag = 0xdeadbeef;
drivers/scsi/pm8001/pm8001_sas.c:       u32 tag = 0xdeadbeef, rc = 0, n_elem = 0;
drivers/scsi/pm8001/pm8001_sas.c:       u32 tag = 0xdeadbeef;
drivers/scsi/pm8001/pm80xx_hwi.c:                       if (ibutton0 == 0xdeadbeef && ibutton1 == 0xdeadbeef) {
drivers/scsi/pm8001/pm80xx_hwi.c:       int rc, tag = 0xdeadbeef;

That doesn't seem to be the case though; as far as I can tell the
tag value is never checked against 0xdeadbeef.
