Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3124CAA06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbiCBQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbiCBQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:21:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667297D01D;
        Wed,  2 Mar 2022 08:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C175B81F51;
        Wed,  2 Mar 2022 16:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8D8C004E1;
        Wed,  2 Mar 2022 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646238015;
        bh=XNeX32660m2tVj90WpPs9Can/L/FmgVh79u8e7ojpKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AoU+nU+YqqvJSnaT8yDbv2jky19r3fSFdyBOTmY/9L7i5GSmg/XiGmnv7e7wWKIPq
         hZ47SBXIvruM/TqMWGfmOpOENgy+oNLuGgr/Kn7z8+tIQdYaS0ai5CprR11K42mHDN
         HdEu0/4+zvxOUzWTubQU957FZvRfgpdakNdzpJgo=
Date:   Wed, 2 Mar 2022 17:20:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, andriy.shevchenko@linux.intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Message-ID: <Yh+ZPa0y0aVLimU2@kroah.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <Yh59rOIH24X+6GyI@kroah.com>
 <20220302103313.3bacd10b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302103313.3bacd10b@gandalf.local.home>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:33:13AM -0500, Steven Rostedt wrote:
> On Tue, 1 Mar 2022 21:10:20 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > "RFC" means you are not comfortable submitting the changes yet, so you
> > don't need my review at this point in time.  Become confident in your
> > changes before asking for others to review the code please.
> 
> I guess you and I have a different understanding of RFC (Request for
> Comments). As to me, comments are a form of review.
> 
> In other words, RFC to me means the review is "does this design look like
> it will work", and we should be reviewing the design and overview of the
> patches. Not the nitty gritty details (like missed error handling, unless
> the design will prevent it). Although, you could add those comments in a
> review.
> 
> When I post RFCs, it's not that I'm not comfortable submitting the change,
> it's because I want to know if what I'm doing makes sense, and I might be
> missing something that will make this effort in vain.
> 
> What ever happen to the "Submit early, submit often" mantra?

For patches from "experienced" submitters like this, with reviews from
other experienced reviewers already (look at the s-o-b chain here),
there's no excuse for it to be a RFC unless something is really odd as
the experienced reviewers should have already handled the "comments"
portion already.  Otherwise their review was kind of pointless, right?

I'm all for submitting early, but be confident!

Also, I have way too many non-RFC patches to review in my queue, so that
means any RFC patches fall to the bottom so I like to give people a
reason why I'm not reviewing them, like I did here.

thanks,

greg k-h
