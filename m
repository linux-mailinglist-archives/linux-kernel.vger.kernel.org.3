Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3C59BDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiHVK4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHVK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:56:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6FF31EDC;
        Mon, 22 Aug 2022 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661165802; x=1692701802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sJN5WeBsvGXOKHDiMc4Ct+sVwyokaJcZFdngtgXZnI8=;
  b=hTS4gtAA8Rpp/MUzUewua/vLimdIGNLldSB6eGrh0dnlk1hnRGzNlO/j
   gRYBcjrH3hpZNveDQhjLFWfU4SYD9JEFBLST9Mt/Vy2OkoY5ii52tpRCc
   QWuPst6qnWJey6jrwQeMatMFLgux9Z7NLsPJGnikr+1cv08HixbOGBLJq
   O21zX2RDZWNfk6h+xSZDpROVdpfIp7mikjCCqNq4MP9U4AptdOD8BFtvS
   xPoP1elkSk59in6D/cfiRu+w5G45zFyH7ktb/gXKBJDc0hBhBF0vcWhpb
   BVIclPLrMcL+eNMuPUt7FqKz5z0qQE8E1UX7HE1Bn7W/b1LDIWJP9wJ0g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="292125783"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="292125783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 03:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="751243026"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Aug 2022 03:56:37 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Aug 2022 13:56:36 +0300
Date:   Mon, 22 Aug 2022 13:56:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Dell XPS 13 9370: ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0
 bytes
Message-ID: <YwNg5L7ymdSgHUrJ@kuha.fi.intel.com>
References: <726661bf-b95f-02fc-e7c5-c222820ee257@molgen.mpg.de>
 <Yv+sqa8wdqiuSUZ3@kroah.com>
 <ab679efe-df85-d2d2-2a4e-842ff9b59b6d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab679efe-df85-d2d2-2a4e-842ff9b59b6d@molgen.mpg.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Aug 19, 2022 at 05:59:54PM +0200, Paul Menzel wrote:
> Am 19.08.22 um 17:30 schrieb Greg KH:
> > On Fri, Aug 19, 2022 at 03:37:00PM +0200, Paul Menzel wrote:
> 
> > > On the Dell XPS 13 9370 with Debian sid/unstable, connecting a Dell DA300
> > > port replicator Linux 5.18.16 logs a warning:
> > > 
> > > ```
> > > $ dmesg
> > > [    0.000000] Linux version 5.18.0-4-amd64 (debian-kernel@lists.debian.org)
> > > (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian)
> > > 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
> > > [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64
> > > root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> > > […]
> > > [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
> > > […]
> > > [   13.900028] ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0 bytes
> > > ```
> > 
> > What warning?
> 
> `ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0 bytes` has log level
> warning.

Thanks for the report.

That warning is meant to indicate that the underlying firmware (most
likely the Embedded Controller firmware) is buggy and unable to tell
us the Power Data Objects (PDO) that the partner device advertised.

However, you will also see the warning if the firmware has notified
our driver about a contract with the partner simply before making
those objects available for the operating system. That problem is
known, and it has actually already been worked around in the driver -
the PDOs are now "polled" for a while after the firmware notification.

I'll see if I can reproduce the problem so I understand exactly what's
going on in this case - I should have access to one of those XPS 13
9370 laptops.

But I'll in any case clean up this part of the driver, so the warning
should go away - one way or the other.

thanks,

-- 
heikki
