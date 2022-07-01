Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F87562E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiGAIfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiGAIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD89BCB6;
        Fri,  1 Jul 2022 01:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 938E362066;
        Fri,  1 Jul 2022 08:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94419C341C6;
        Fri,  1 Jul 2022 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656664499;
        bh=LLt8c3rqeMX8qdkQ+TsxWoZE+pxIfMpkrg04XFEYbNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkKNsshm94FxoLTk9gePIVNMSUAleKhLFWAoVFOOxCxlufu9pWf1IcWA85gsP29eZ
         IJ5TO3fo5f/k97Ctnwv4TN07QtBbJriVQZOHaOFX+ra20ykAbBVZd0YnrWySrBdOVZ
         nW0mqGovklNz0csbZFQJpZZ+KggttA0+DmFbKT20=
Date:   Fri, 1 Jul 2022 10:34:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
Message-ID: <Yr6xsKbZSMWywUKo@kroah.com>
References: <12026357.O9o76ZdvQC@kreacher>
 <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5606189.DvuYhMxLoT@kreacher>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:13:52PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] hisi_lpc: Use acpi_dev_for_each_child()
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.
> 
> This will help to eliminate the children list head from struct
> acpi_device as it is redundant and it is used in questionable ways
> in some places (in particular, locking is needed for walking the
> list pointed to it safely, but it is often missing).
> 
> While at it, simplify hisi_lpc_acpi_set_io_res() by making it accept
> a struct acpi_device pointer from the caller, instead of going to
> struct device and back to get the same result, and clean up confusion
> regarding hostdev and its ACPI companion in that function.
> 
> Also remove a redundant check from it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
