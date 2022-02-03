Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115444A90F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355917AbiBCXAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiBCXAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:00:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1DBC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eWl/5uuKYJVtYEvPeHsPKUjpJ01J9ZAluyOS78lvnbM=; b=0qJlVXX4N2thHrGKKZLoIIQA9T
        oYFeY4ztX1FOLoHOYfVQQYclewnzajflCJeDprFhTF507nG/BJ0LcKUSatu3dsWXkNfSpUCPw2crR
        nedVOuQFOJWMxf9nL8CjnGARCAjmrAOuHojpuKs3ybTXxhpXFE+qyFGhex4ouYnNT2H+eX/RapzXI
        XSUwlfkRH2jUExx3akaVaZhbC0AGu8UXMdcE86jX5E36OM6F0Ulqy9GZ/YZhxy7dRTZJGmoOhOvK+
        KyC5Jq19rG/UT1OOtx2Rl3SZ510TVhwl9Uqm78QoW2Tr03vsr9ylvcCvzzHlGRbX7DNqtM9vQiP4n
        /ibt2VbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFl5n-0033sS-Dt; Thu, 03 Feb 2022 23:00:43 +0000
Date:   Thu, 3 Feb 2022 15:00:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [RFC PATCH 0/5] Extend FW framework for user FW uploads
Message-ID: <Yfxem+AF9lroota0@bombadil.infradead.org>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203213053.360190-1-russell.h.weight@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:30:47PM -0700, Russ Weight wrote:
> Extend the firmware loader subsystem to support a persistent sysfs
> interface that userspace may use to initiate a firmware update. For
> example, FPGA based PCIe cards automatically load firmware and FPGA images
> from local FLASH when the card boots. The images in FLASH may be updated
> with new images that are uploaded by the user.
> 
> A device driver may call fw_upload_register() to expose persistent
> "loading" and "data" sysfs files at /sys/class/firmare/<NAME>/*. These
> files are used in the same way as the fallback sysfs "loading" and "data"
> files. However, when 0 is written to "loading" to complete the write of
> firmware data, the data is also transferred to the lower-level driver
> using pre-registered call-back functions. The data transfer is done in
> the context of a kernel worker thread.
> 
> Additional sysfs nodes are added in the same location as "loading" and
> "data" to monitor the transfer of the image data to the device using
> callback functions provided by the lower-level device driver and to allow
> the data transfer to be cancelled.
> 
> Example usage:
> 
> $ pwd
> /sys/class/firmware/n3000bmc-sec-update.8
> $ ls
> cancel  device  loading  remaining_size  subsystem
> data    error   power    status          uevent
> $ echo 1 > loading
> $ cat /tmp/firmware.bin > data
> $ echo 0 > loading
> $ while :; do cat status; cat remaining_size ; sleep 3; done
> preparing
> 44590080
> <--snip-->
> transferring
> 44459008
> transferring
> 44311552
> <--snip-->
> <snip>
> transferring
> 173056
> <--snip-->
> programming
> 0
> <--snip-->
> idle
> 0
> ^C

Nice. Please extend lib/test_firmware.c while at it and try to break
and ensure your stuff is not regressed with future changes.

  Luis
