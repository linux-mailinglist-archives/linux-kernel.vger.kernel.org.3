Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9C56C487
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbiGHVgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbiGHVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:36:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A68A2396;
        Fri,  8 Jul 2022 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657316160; x=1688852160;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6FNRfINwjCBhXzxRBDNlrAGOF4VTM1y+XTMActF2Sg=;
  b=m8l9F4PVNXI9iJDwLDaen1Ki1EBwUu9vVENkxFptw2TUkVV/TmCqkdHE
   L4AMq8kVfdUEqTJGCNYWjYOrx8a58Io/NtUvjP3Z0wNmhLSjtQ51ld7p1
   clKLIof1NCxkDSvky2Mt0GiHCub/AJwdPq4YVdncx9YBFFqTE+deqquYX
   ieFKRwEzHV1spG336whZejH/b79WBlRfeu9wPUxfaiasMzfWJ4Yj7S8sB
   P73WiSqmnETdmj9paPfnZ9EQgJCrl26e+Nto/46tbXhgfabXCGecDIUTE
   q6H12gKnTBL0fpFyl3t9L4DrPFYsBP9aeHk47xJLMoAvcRKEGNDibhido
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="267410273"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="267410273"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="736473055"
Received: from wopr.jf.intel.com ([10.54.75.125])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2022 14:35:59 -0700
Message-ID: <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     John Ogness <john.ogness@linutronix.de>, pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org
Date:   Fri, 08 Jul 2022 14:35:59 -0700
In-Reply-To: <87czegxccb.fsf@jogness.linutronix.de>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
         <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
         <87czegxccb.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 10:07 +0206, John Ogness wrote:
> Hi Todd,
> 
> Thanks for reporting this.
> 
> On 2022-07-07, Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> > Ever since 5.19.0-rc1 the serial device has taken almost a second
> > longer in both suspend and resume. This effect is witnessed in half
> > the machines in our lab (~10 machines). It occurs on dell, asus,
> > gigabyte and other machines so it's not hardware specific.
> 
> Please provide a full dmesg log if you can. The important parts of
> the
> log would be:
> 
> - boot arguments
> - any lines with "printk" in it
> - timing information
> - messages during suspend and resume
> 
> pr_flush() uses a timeout of 1 second. I assume your console driver
> is
> not printing and therefore not making any forward progress.
> 
> John Ogness

The dmesg logs are in the html timelines themselves, just click the
"dmesg" button in the upper right hand corner. The log button shows all
kinds of system info as well.

