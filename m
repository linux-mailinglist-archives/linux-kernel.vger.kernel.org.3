Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3E4C277B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiBXJIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiBXJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:08:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E6113AF9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FFB60A5F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9B3C340F1;
        Thu, 24 Feb 2022 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645693663;
        bh=Ba3K+INmt5cfhireoxThid5W8f4jm5ojVyQ0VA52R8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdhjtUsqtKBHg97ioAKHhB5JzJfaPm4YVZXxI9CATxq+gPRw+uVpgNc/9unttgVCy
         gJ3MQc/PfVnfz09lWz0x1yGQgbYZ4whbHEBJIlaVy9Q14A+rLzqvjHAi1f/FLhzwOF
         6U9Qe9OZzws+mFVHAfbhZeeVLEH0h8smL+jalzeE=
Date:   Thu, 24 Feb 2022 10:07:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] driver core: Refactor sysfs and drv/bus remove hooks
Message-ID: <YhdK3NtkC0sgkNgO@kroah.com>
References: <20220223225257.1681968-1-robh@kernel.org>
 <20220223225257.1681968-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223225257.1681968-3-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 04:52:57PM -0600, Rob Herring wrote:
> There are 3 copies of the same device sysfs cleanup and drv/bus remove()
> hooks used for probe failure, testing re-probing, and device unbinding.
> 
> Let's refactor the code to its own function.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note that driver_sysfs_remove() remains a separate call because in
> __device_release_driver() it is called with a pm runtime get/put and
> before the unbind notifier. Browsing the history, it doesn't seem like
> there's any particular reason for this ordering. We also have other
> sysfs teardown done later. It would be more logical to do all the
> sysfs teardown at once. Thoughts?

I think it should be unified, so you can send a follow-on patch to do
that.

I'll go queue these changes up now, thanks for the cleanups!

greg k-h
