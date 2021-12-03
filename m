Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD98467AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352741AbhLCQDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhLCQDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:03:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DFBC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6AB2B82603
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFEEC53FCD;
        Fri,  3 Dec 2021 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638547216;
        bh=pPtSJeCyzuiCr16NQbZNhSrMqCUYV9xdXobe+ja8HsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWV1zqkGkNvYkeIp8MRSK+3ZcDtauwm3ovUIGrQAzV4XO57s/hNiTIt9sYvP9bBy5
         3RmjGQIWoTOf8SNW9zgRCN/sFcCd6jcXEazMJmFxy05G4jVErwGll8TV9gXNU2cOYU
         i6LdOrls27lXymreOJOF6kID2KPzvFkh/nXxZqNhTlhtzmQmlVLoqfDxNf924++dz/
         YjYMvlWwH0qgJNmIY7RCQ1tqOnDKWntKnk0Cd+2nRTmAoLfUHVZa+GdWY5u/5n+KPC
         iZ4W5NBPoSvxQ9ApxpB05OTPuzMzTQlzyuAdJL0Xty0y4LA55M/XT4C41bKTMfCgjZ
         phfigUeTGhs/A==
Date:   Fri, 3 Dec 2021 08:00:14 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Message-ID: <20211203160014.GD3839336@dhcp-10-100-145-180.wdc.com>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:42:44AM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The write pointer in NVMe ZNS is invalid for a zone in zone state full.
> The same also holds true for ZAC/ZBC.
> 
> The current behavior for NVMe is to simply propagate the wp reported by
> the drive, even for full zones. Since the wp is invalid for a full zone,
> the wp reported by the drive may be any value.
> 
> The way that the sd_zbc driver handles a full zone is to always report
> the wp as zone start + zone len, regardless of what the drive reported.
> null_blk also follows this convention.
> 
> Do the same for NVMe, so that a BLKREPORTZONE ioctl reports the write
> pointer for a full zone in a consistent way, regardless of the interface
> of the underlying zoned block device.
> 
> blkzone report before patch:
> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0xfffffffffffbfff8
> reset:0 non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> blkzone report after patch:
> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0x040000 reset:0
> non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
