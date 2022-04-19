Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C25076A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355854AbiDSRiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355818AbiDSRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:38:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7011FA72;
        Tue, 19 Apr 2022 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650389720; x=1681925720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=triG9sStW3mhLDVpzsgT7KUGak7lE+Nmr/MDoWwbIcY=;
  b=MLGjNJopeXoweog+N+fvvvv72X5HSgzvns7eGpe1EW2+C3G+fK3rxkW2
   Wx+rRvnNYjLtlFRsaSJGyf9vR9uYSWjmwKSf5JBUHu7BnOK6COupN8Caq
   y3Q9ccPuRe/WhcKfw2JnMIiJnS72U6fAP4SeJriW3ZO4ZqFRm/xNObF/a
   N+AAct2VX+OyxoXhpqJNBLeTDnRIq1uXAq9RbAbVHx4bcxetklSzUwmnx
   tr1FQ7bNQkr2+qED0aHn9WAjZu5hb34fsB+F80MJQ2s8J8i2eiwHLsPQR
   kwW1r9m6OWjQs9qC6KxdY9nciHUSR+qpGYwliBA9ApSNId5rUuR3GdMD3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263287516"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263287516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:35:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="530532553"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:35:18 -0700
Date:   Tue, 19 Apr 2022 10:35:17 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v3 09/11] platform/x86/intel/ifs: Add IFS sysfs interface
Message-ID: <Yl7y1YDaNVxyDnKI@agluck-desk3.sc.intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-10-tony.luck@intel.com>
 <Yl7vdpJgKYRL1jeW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl7vdpJgKYRL1jeW@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:20:54PM +0200, Greg KH wrote:
> > +/*
> > + * Note there is no need for a ->remove() call back. There isn't an
> > + * "unload" operation to remove the scan binary from the BIOS reserved
> > + * area. Also ".dev_groups" removal order will guarantee that any in
> > + * flight tests have completed.
> > + */
> 
> So you are ok with the warning the kernel gives you when you unload the
> driver?  That feels wrong :(

What warning?

# dmesg | tail -5
[   38.084165] virbr0: port 1(virbr0-nic) entered listening state
[   38.149621] virbr0: port 1(virbr0-nic) entered disabled state
[   38.582054] broken atomic modeset userspace detected, disabling atomic
[   43.703321] igc 0000:01:00.0 enp1s0: NIC Link is Up 2500 Mbps Full Duplex, Flow Control: RX
[   43.703470] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
# modprobe intel_ifs
# ls /sys/devices/platform/intel_ifs.0/
details  driver_override  modalias  reload    status     uevent
driver   image_version    power     run_test  subsystem
# rmmod intel_ifs
# dmesg | tail -5
[   38.084165] virbr0: port 1(virbr0-nic) entered listening state
[   38.149621] virbr0: port 1(virbr0-nic) entered disabled state
[   38.582054] broken atomic modeset userspace detected, disabling atomic
[   43.703321] igc 0000:01:00.0 enp1s0: NIC Link is Up 2500 Mbps Full Duplex, Flow Control: RX
[   43.703470] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
#

-Tony
