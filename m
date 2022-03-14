Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA804D7B43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiCNHJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCNHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:09:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BCA40908
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:08:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DCF768AFE; Mon, 14 Mar 2022 08:08:08 +0100 (CET)
Date:   Mon, 14 Mar 2022 08:08:08 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Sungup Moon <sungup.moon@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver/nvme/host: Support duplicated nsid for the
 private
Message-ID: <20220314070808.GB3806@lst.de>
References: <CGME20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2> <20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 04:05:05PM +0900, Sungup Moon wrote:
> When the multi-controller, managed by a special admin command, has private
> namespace with same nsid, current linux driver raise "Duplicate unshared
> namespace" error. But, NVMe Specification defines the NSID usage like this:
> 
> If Namespace Management, ANA Reporting, or NVM Sets are supported, the
> NSIDs shall be unique within the NVM subsystem. If the Namespace
> Management, ANA Reporting, and NVM Sets are not supported, then NSIDs:
> a) for shared namespace shall be unique; and
> b) for private namespace are not required to be unique.
> (reference: 6.1.6 NSID and Namespace Usage; NVM Express 1.4c spec)
> 
> So, if a multi-controller, which is not managed by Namespace Management
> function, creates some private namespaces without ANA and NVM Sets, the
> duplicated NSID should be allowed because that is not a NVMe specification
> violation.
> 
> But, current nvme driver checks only namespace is shared or not, so I
> propose following patch:
> 1. nvme_ctrl has unique_nsid field to identify that controller should
>    assign unique nsid.
> 2. nvme_init_ns_head function creates new nvme_ns_head instance not only
>    head is null but controller's unique_nsid is false (no flagged
>    attribute) and namespace is not shared.
> 3. for creating bdev device file, nvme_mpath_set_disk_name will return
>    false when unique_nsid is false and namespace is not shared.
> 4. also, nvme_mpath_alloc_disk alto return 0 with same manner.

From a very quick glance this looks good.  But please make sure you don't
spill over 80 charactes per line.  Also I think instead of adding the
unique_nsid field a little helper that checks the relevant flags might
be a lіttle nicer.  It is not checked in a fast path anywere and the
checks are pretty trivial.
