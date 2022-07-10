Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804EE56D04A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGJRAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiGJRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB23E0F0;
        Sun, 10 Jul 2022 10:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02F9560B0B;
        Sun, 10 Jul 2022 17:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B801C341CB;
        Sun, 10 Jul 2022 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657472444;
        bh=RXJPWzKEvNojmH6onaoi2IawBje3FDYFyUPoyxcvX3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vo3v6YBmJb/xIPtHLys+IlTgkyML3/SX7IM0k0SQShVMSCC9ZbGsXYY68Ao39DoBS
         QWCGs2RLyOXNp/jIJR5JUBRcFQGhSFwRrNtxR1usoSfSEB+hOJfYTUzwSt+IZQ+6ia
         KUztzlfWfxGrZAi4QVfRNF1KtYFxIGYGwcIGF4iI=
Date:   Sun, 10 Jul 2022 19:00:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, ashok.raj@intel.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Message-ID: <YssFueUGqzq2WLHa@kroah.com>
References: <20220710160011.995800-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710160011.995800-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 09:00:11AM -0700, Jithu Joseph wrote:
> Existing implementation limits IFS images to be loaded only from
> a default file-name /lib/firmware/intel/ifs/ff-mm-ss.scan.
> 
> But there are situations where there may be multiple scan files
> that can be run on a particular system stored in /lib/firmware/intel/ifs
> 
> E.g.
> 1. Because test contents are larger than the memory reserved for IFS by BIOS
> 2. To provide increased test coverage
> 3. Custom test files to debug certain specific issues in the field
> 
> Renaming each of these to ff-mm-ss.scan and then loading might be
> possible in some environments. But on systems where /lib is read-only
> this is not a practical solution.
> 
> Modify the semantics of the driver file
> /sys/devices/virtual/misc/intel_ifs_0/reload such that,
> it interprets the input as the filename to be loaded.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---

Also note that this does not follow the required Intel rules for
submitting kernel patches.  Why the rush and circumventing of the normal
process that we have in place for good reasons?

greg k-h
