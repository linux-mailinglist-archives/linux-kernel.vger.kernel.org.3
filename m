Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0024B52322B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiEKLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiEKLu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A8056C09;
        Wed, 11 May 2022 04:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E3F61718;
        Wed, 11 May 2022 11:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ADFC340F2;
        Wed, 11 May 2022 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652269854;
        bh=pbTu1SyOmaMoBMug74Cs/J6drhmgKaLsBjPev0VWet4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBQw3J6kbqcWvUQHyx2hh13xUfDwIP/58AdyOtmKRjAbatz5H5HWDlte3eZbI1kV3
         vAkAh+j58tYbQAuZlSL2K8wUwXA8YtbdjA2VH82YJAGEcyRsvsyfKPFJndRgVUbSJv
         VWVqZwYwaq7f4RArduroU+JVpeAGfc+GOJmKUSIA=
Date:   Wed, 11 May 2022 13:50:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, Sean Paul <sean@poorly.run>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Adding CI results to the kernel tree was Re: [RFC v2] drm/msm:
 Add initial ci/ subdirectory
Message-ID: <YnujG0nkF0U6d5kd@kroah.com>
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com>
 <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
 <YntWQIXSqMCd6TYV@kroah.com>
 <1255a66a-121d-988a-19a7-316f703cb37d@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1255a66a-121d-988a-19a7-316f703cb37d@mailbox.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:26:05PM +0200, Michel Dänzer wrote:
> On 2022-05-11 08:22, Greg Kroah-Hartman wrote:
> > On Wed, May 11, 2022 at 03:06:47PM +1000, Dave Airlie wrote:
> >>> And use it to store expectations about what the drm/msm driver is
> >>> supposed to pass in the IGT test suite.
> >>
> >> I wanted to loop in Linus/Greg to see if there are any issues raised
> >> by adding CI results file to the tree in their minds, or if any other
> >> subsystem has done this already, and it's all fine.
> > 
> > Why does the results need to be added to the tree?  Shouldn't they be
> > either "all is good" or "constantly changing and a constant churn"?
> > 
> >> I think this is a good thing after our Mesa experience, but Mesa has a
> >> lot tighter integration here, so I want to get some more opinions
> >> outside the group.
> > 
> > For systems that have "tight integration" this might make sense as proof
> > that all is working for a specific commit, but I can't see how this will
> > help the kernel out much.
> > 
> > What are you going to do with these results being checked in all the
> > time?
> 
> Having the expected results in the tree keeps them consistent with the driver code itself, and allows putting in place gating CI to prevent merging driver changes which make any of the tests deviate from the expected result.

Shouldn't "expected result" always be "pass"?

If not, then the test should be changed to be "skipped" like we have
today in the kselftest tests.

And how about tieing this into the kselftest process as well, why would
this be somehow separate from the rest of the kernel tests?

> Keeping them separate inevitably results in divergence between the driver code and the expected test results, which would result in spurious failures of such CI.

Again, "pass" should be the expected results :)

> I expect the main complication for the kernel will be due to driver changes merged via different trees, e.g. for cross-subsystem reworks. Since those will not go through the same CI, they may accidentally introduce inconsistencies. The ideal solution for this IMO would be centralizing CI such that the same gating tests have to pass regardless of how the code is merged. But there's likely quite a long way to go until we get there. :)

We have in-kernel tests for the rest of the kernel, why can't you put
your testing stuff into there as well?

thanks,

greg k-h
