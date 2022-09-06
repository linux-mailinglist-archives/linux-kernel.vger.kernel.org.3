Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4886C5AE388
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiIFIyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbiIFIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:53:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDF221B6;
        Tue,  6 Sep 2022 01:53:30 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMK0G5sQNz687YW;
        Tue,  6 Sep 2022 16:52:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 10:53:29 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Sep
 2022 09:53:28 +0100
Date:   Tue, 6 Sep 2022 09:53:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 05/15] cxl/acpi: Add probe function to detect restricted
 CXL hosts in RCD mode
Message-ID: <20220906095327.0000405b@huawei.com>
In-Reply-To: <Yxb0bequiQAkzj2Q@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-6-rrichter@amd.com>
        <20220831110804.00003812@huawei.com>
        <YxBKoT2zlUVgXIry@rric.localdomain>
        <20220901111038.00002e00@huawei.com>
        <Yxb0bequiQAkzj2Q@rric.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 09:19:49 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 01.09.22 11:10:38, Jonathan Cameron wrote:
> > On Thu, 1 Sep 2022 08:01:05 +0200
> > Robert Richter <rrichter@amd.com> wrote:  
> > > On 31.08.22 11:08:04, Jonathan Cameron wrote:  
> > > > On Wed, 31 Aug 2022 10:15:53 +0200  
> > > > Robert Richter <rrichter@amd.com> wrote:  
> 
> > > > > The probe function is triggered by adding an own root device for RCHs.
> > > > > This is different to CXL VH where an ACPI "ACPI0017" root device
> > > > > exists. Its detection starts the CXL host detection. In RCD mode such
> > > > > a device does not necessarily exists, so solve this by creating a
> > > > > plain platform device that is not an ACPI device and is root only for
> > > > > RCHs.    
> > > > 
> > > > If I read this correctly that platform device is created whether or not
> > > > there are any cxl devices in the system?
> > > > 
> > > > Can we create it only if we find some devices that will be placed
> > > > under it later?    
> > > 
> > > This would move the host detection from probe to init which I wanted
> > > to avoid to better control driver init order dependencies.  
> > 
> > It's a bit nasty either way.  I can see your reasoning, but
> > definitely not keen on it if there is a plausible way to avoid.  
> > > 
> > > I could add a put_device() at the end of a probe so that it will be
> > > released in case no other references use it. This implies the refcount
> > > is maintained for parent devices. Or this needs to be added to. So if
> > > there are no children (hosts) attached to the root device after probe,
> > > it will disappear.  
> > 
> > Unless there is precedence for that, it'll be weird enough to be
> > hard to maintain.  I guess I can live with the ugliness if we can't
> > add something new to ACPI to base this off.  
> 
> Let's stay with a put_device() for now. Then, we wont have a stale cxl
> root device in the system in case there are no RCD children.
> 
> -Robert
Kind of obvious, but...
Make sure to call that out as an unusual thing to do via cover letter / patch
description so we hopefully get more eyes on this detail..

Jonathan
