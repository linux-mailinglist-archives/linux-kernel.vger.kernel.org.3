Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469B74E4D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiCWHP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242091AbiCWHPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:15:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C826E8C6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:14:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B511D68B05; Wed, 23 Mar 2022 08:14:10 +0100 (CET)
Date:   Wed, 23 Mar 2022 08:14:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Kees Cook <keescook@chromium.org>
Subject: Re: [scsi]  6aded12b10: kernel_BUG_at_mm/usercopy.c
Message-ID: <20220323071409.GA25480@lst.de>
References: <20220320143453.GD6208@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320143453.GD6208@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual warning is;

[   34.496096][  T331] usercopy: Kernel memory overwrite attempt detected to spans multiple pages (off set 0, size 6)!

This is for the cmnd field in struct scsi_cmnd, which is allocated by
the block layer as part of the request allocator.  So with a specific
packing it can legitimately span pages.

Kees: how can we annotate that this is ok?
