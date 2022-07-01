Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387F562E53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiGAIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiGAIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:33:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA4B677D3;
        Fri,  1 Jul 2022 01:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E606B82E4F;
        Fri,  1 Jul 2022 08:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A961C341C6;
        Fri,  1 Jul 2022 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656664419;
        bh=OvGAcIxhYOa5JbVDHlKxCT9h2qhKMwiLkryX0yjrQdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yj3f8GKfE/qs0EnDllsntBK0+g/GsTebNwxx69W+K1dpfRPxBQykrYEFzZC+4nHD3
         7NrQRNiEHrMW3JHpsebD5zrI18nsjwbTanmZg9VDpUTPPZDA5PxZUUKaGDYTooD3tF
         XuCgiO7y1g4NBKY01xK9/F7QX1WeyexYqT5Mxnxc=
Date:   Fri, 1 Jul 2022 10:33:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Wang <peter.wang@mediatek.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] PM: runtime: Fix supplier device management during
 consumer probe
Message-ID: <Yr6xYX1vyIS3pQiX@kroah.com>
References: <4748074.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4748074.GXAFRqVoOG@kreacher>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:16:41PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because pm_runtime_get_suppliers() bumps up the rpm_active counter
> of each device link to a supplier of the given device in addition
> to bumping up the supplier's PM-runtime usage counter, a runtime
> suspend of the consumer device may case the latter to go down to 0
> when pm_runtime_put_suppliers() is running on a remote CPU.  If that
> happens after pm_runtime_put_suppliers() has released power.lock for
> the consumer device, and a runtime resume of that device takes place
> immediately after it, before pm_runtime_put() is called for the
> supplier, that pm_runtime_put() call may cause the supplier to be
> suspended even though the consumer is active.
> 
> To prevent that from happening, modify pm_runtime_get_suppliers() to
> call pm_runtime_get_sync() for the given device's suppliers without
> touching the rpm_active counters of the involved device links
> Accordingly, modify pm_runtime_put_suppliers() to call pm_runtime_put()
> for the given device's suppliers without looking at the rpm_active
> counters of the device links at hand.  [This is analogous to what
> happened before commit 4c06c4e6cf63 ("driver core: Fix possible
> supplier PM-usage counter imbalance").]
> 
> Since pm_runtime_get_suppliers() sets supplier_preactivated for each
> device link where the supplier's PM-runtime usage counter has been
> incremented and pm_runtime_put_suppliers() calls pm_runtime_put() for
> the suppliers whose device links have supplier_preactivated set, the
> PM-runtime usage counter is balanced for each supplier and this is
> independent of the runtime suspend and resume of the consumer device.
> 
> However, in case a device link with DL_FLAG_PM_RUNTIME set is dropped
> during the consumer device probe, so pm_runtime_get_suppliers() bumps
> up the supplier's PM-runtime usage counter, but it cannot be dropped by
> pm_runtime_put_suppliers(), make device_link_release_fn() take care of
> that.
> 
> Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
> Reported-by: Peter Wang <peter.wang@mediatek.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/core.c          |   10 ++++++++++
>  drivers/base/power/runtime.c |   14 +-------------
>  2 files changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
