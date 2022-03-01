Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004D4C95A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiCAUPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiCAUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:15:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8329C3BFAD;
        Tue,  1 Mar 2022 12:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1336161713;
        Tue,  1 Mar 2022 20:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBDBC340EF;
        Tue,  1 Mar 2022 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646165669;
        bh=hafwu17uRhikdH2rke2Tn6mbfT8wORbeL9okzdEuuII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wkScooPhM3Fmf3bfroQnCr4dHpjk38eACrIrd11bmRmSi+YI84dXcc2f5Xmk0H79c
         GI4wfieobByW1LaQtcL+I96Duo2c+tXBrBo8kH5ck70EQbDpuikzqiQJuaa9YsBVMU
         00zbkQ47nd7Y2o7EY5FD1UOTa2dLMN3nkrRGCWK0=
Date:   Tue, 1 Mar 2022 21:14:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Message-ID: <Yh5+om/Nr06V0+Qj@kroah.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <Yh59rOIH24X+6GyI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh59rOIH24X+6GyI@kroah.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 09:10:20PM +0100, Greg KH wrote:
> On Tue, Mar 01, 2022 at 11:54:47AM -0800, Jithu Joseph wrote:
> > Note to Maintainers:
> > Requesting x86 Maintainers to take a look at patch01 as it
> > touches arch/x86 portion of the kernel. Also would like to guide them
> > to patch07 which sets up hotplug notifiers and creates kthreads.
> > 
> > Patch 2/10 - Adds Documentation. Requesting Documentation maintainer to review it.
> > 
> > Requesting Greg KH to review the sysfs changes added by patch08.
> 
> "RFC" means you are not comfortable submitting the changes yet, so you
> don't need my review at this point in time.  Become confident in your
> changes before asking for others to review the code please.

Hint, it needs work, sysfs_emit() for one thing, lack of reference
counting on your cpu objects is another...
