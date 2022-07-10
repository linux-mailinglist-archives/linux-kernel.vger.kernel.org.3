Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D676556CE84
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGJKQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJKQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 06:16:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725612600;
        Sun, 10 Jul 2022 03:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CFD1B80A29;
        Sun, 10 Jul 2022 10:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62459C3411E;
        Sun, 10 Jul 2022 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657448157;
        bh=GCv9XYzyLfxbuwZ58INX2UzxLUEVrBaQalSsByPr00A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Heck747PzToMtNCTo6wLiw5cuQotqiXzQlnPEP4x9f6O0cmeNKLtfQXUatET81NNP
         EPg0rkjW9J/EdH74osSwr9mzY/yRrcU2OL8NX+ZQF88HSEUgFMBt7wlJs1IYvhEsFS
         hdQ1UPx0T87AJORYHAz6yBJzBy/cBb9MTVHQD6lo=
Date:   Sun, 10 Jul 2022 12:15:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, ashok.raj@intel.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] platform/x86/intel/ifs: Allow non-default names for IFS
 image
Message-ID: <Ysqm1BRbCTtWfAcW@kroah.com>
References: <20220708151938.986530-1-jithu.joseph@intel.com>
 <YshNAh6awfPFmxzU@kroah.com>
 <33a6193e-1084-ae5f-1f80-232274f71bd0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a6193e-1084-ae5f-1f80-232274f71bd0@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:34:40AM -0700, Joseph, Jithu wrote:
> 
> 
> On 7/8/2022 8:28 AM, Greg KH wrote:
> > On Fri, Jul 08, 2022 at 08:19:38AM -0700, Jithu Joseph wrote:
> >> Existing implementation limits IFS image to be loaded only from
> >> a default file-name (ff-mm-ss.scan).
> >>
> 
> > 
> > Ick, but now what namespace are you saying that path is in?  If you need
> > debugging stuff, then put the api/interface in debugfs and use it there,
> > don't overload the existing sysfs api to do something different here.
> 
> The namespace related confusion could be because, the original commit message
> was not using full path-names. The below write-up tries to be more clear on this
> 
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
> Extend the semantics of the driver /sys/devices/virtual/misc/intel_ifs_0/reload
> file:
> 
>   Writing "1" remains the legacy behavior to load from the default
>   ff-mm-ss.scan file.
> 
>   Writing some other string is interpreted as a filename in
>   /lib/firmware/intel/ifs to be loaded instead of the default file.

Ick, you are overloading an existing sysfs file to do different things
based on random stuff.  This is a brand-new api that you are already
messing with in crazy ways.  Why not just revert the whole thing and
start over as obviously this was not tested well with real devices.

And what is wrong with a firmware file called '1'?  :)

thanks,

greg k-h
