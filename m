Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD94A90E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 23:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355895AbiBCWv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 17:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiBCWv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:51:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5301C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZcWmCjftMje6QUzmfxLgopEqLhjGvW7/TE+Stk0ikcA=; b=hbswCc/puNjCQD9dPyW5LfyrwC
        OZJU5ivfVNcqoKdwI2EtnH7R18DUjYwr+NtmWAGtdsX8/hErXhLvIJ0nBeN/B9L4BrSTNLXbF0Ko6
        uYAth3Pja9q+PVCnRxqypfn6W0BISkfE9GLapzz+slJCKmjYpXibcJOLFq2jRHNnlfpPjuoRzuhh6
        sUk8Fox1UV8KyMtSu+mV1uW5M2aTXDNXutv13Z8sgi7+8mSu1petFrXie11I5VBRfB+vibN1OTPbn
        1dxtR5bf3CkLy/hLZdP1s7l5Iuw/nw1lXLEH+MDtnj66ptFlFSaRrmlhJCg0G8uD9PFlSGtYkQuDC
        nyK0HBpQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFkwm-0033I0-Hl; Thu, 03 Feb 2022 22:51:24 +0000
Date:   Thu, 3 Feb 2022 14:51:24 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [RFC PATCH 3/5] firmware_loader: Split fw_sysfs support from
 fallback
Message-ID: <YfxcbHuFjL3xem/0@bombadil.infradead.org>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
 <20220203213053.360190-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203213053.360190-4-russell.h.weight@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:30:50PM -0700, Russ Weight wrote:
> In preparation for sharing the "loading" and "data" sysfs nodes with the
> new firmware upload support, split out sysfs functionality from fallback.c
> and fallback.h into fw_sysfs.c and fw_sysfs.h. This includes the firmware
> class driver code that is associated with the sysfs files and the
> fw_fallback_config support for the timeout sysfs node.
> 
> CONFIG_FW_LOADER_SYSFS is created and is selected by
> CONFIG_FW_LOADER_USER_HELPER in order to include fw_sysfs.o in
> firmware_class-objs.
> 
> This is mostly just a code reorganization. There are a few symbols that
> change in scope, and these can be identified by looking at the header
> file changes. A few white-space warnings from checkpatch are also
> addressed in this patch.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/base/firmware_loader/Kconfig    |   4 +
>  drivers/base/firmware_loader/Makefile   |   1 +
>  drivers/base/firmware_loader/fallback.c | 430 ------------------------
>  drivers/base/firmware_loader/fallback.h |  46 +--
>  drivers/base/firmware_loader/fw_sysfs.c | 413 +++++++++++++++++++++++
>  drivers/base/firmware_loader/fw_sysfs.h |  94 ++++++

Nit: please just use sysfs.[ch]. The directory already implies its for
firmware.

  Luis
