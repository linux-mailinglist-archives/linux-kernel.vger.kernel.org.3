Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA651CECB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388164AbiEFBzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388159AbiEFBzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E82B1A9
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 18:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C99BB6203E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B82C385A4;
        Fri,  6 May 2022 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651801881;
        bh=wgozsDONlpDNBdP9RVy4PIr+sdc8JpyMNa9VEuVsNtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scQmvht4GF2Wj8QVzgN1ywXEk6bLMBf078JycOj/eUxtVd1tVp76VgPa23U7N2ExJ
         d8p7fcUqSzPbQowKiH8MBggHslJeKbq94106XM0ZzDtMc8Y8Gy4WP7Eo0bluI4Tizo
         YfNHztMK8CKBBe/8sQc0KHnBGCpd7TlIfjkkhiY69RQP6Plrr3CE0ETcSZn12/6QOj
         Olo3e6+E3Azx3Q6+FYAZSkb0MioT8Fl6/uEU5gwtbJGMTrVZ7n5HyrHb4eLrj2ix9f
         j58Bne1zLx3GBxFkcltBmUV3OmvRVwyY6RYEwLsNmGv/xAPbqy2C3k4yFd6NmvHPig
         K1GBRtfsAdCQg==
Date:   Thu, 5 May 2022 19:51:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     linux@leemhuis.info,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, luto@kernel.org
Subject: Re: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
Message-ID: <YnR/FiWbErNGXIx+@kbusch-mbp>
References: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
 <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
 <CABXGCsNaV_BZ7sm8MOXEOGGJGNS=TX7=7azZTM3Ky5z15bMN3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsNaV_BZ7sm8MOXEOGGJGNS=TX7=7azZTM3Ky5z15bMN3Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:02:12PM +0500, Mikhail Gavrilov wrote:
> On Thu, May 5, 2022 at 10:19 AM Keith Busch <kbusch@kernel.org> wrote:
> > I think you did misinterpret the results. The max latency just says which power
> > state is the deepest it will request APST, and your controller's reported
> > values will allow the deepest low power state your controller supports, which
> > is known to cause problems with some platform/controller combinations.
> >
> > The troubleshooting steps for your observation is to:
> >
> >   1. Turn off APST (nvme_core.default_ps_max_latency_us=0)
> >   2. Turn off APSM (pcie_aspm=off)
> >   3. Turn off both
> >
> > Typically one of those resolves the issue.
> 
> Thanks.
> To make it easier for everyone to diagnose such problems, it would be
> great if every switching between power save modes would be written to
> the kernel log (when console_loglevel is KERN_DEBUG)
> If APST is culprit, we would have seen the change in the power state
> in the kernel logs before the message "nvme nvme0: controller is
> down;".

The "A" in "APST" stands for "Autonomous", as in the kernel doesn't participate
in the power state transitions, so we don't have an opportunity to log such
things. We could perhaps add a kernel message like the classic "Dazed and
confused" power mode strangeness since this spec compliant feature problem
seems to be bizarrely common.
