Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF4503127
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356380AbiDOW5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356402AbiDOW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:57:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEC245787
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WhP+G9PDWTuAjFH9mhE+5r69lxk1gIRuAvXBKRJBWDs=; b=B6wXEYyL8IW4eAfeT29r9PasG0
        xMgi4rdu4+9pn3jOiDTO0v0+DZtdUD3AmOHBER2dOrX2pYYTHtaGrQcvVBWzE+Hlwkr7EcsMFmCKj
        oWCu9gF25DA/52rUovYjF58+PMYrU2zPOzLWsQb7dU5XBGmWIheThveH7wGedyYuuIpBZxhaQwVYF
        Qg9Z/N+ss53I0BlPRyPpvVWBvOQabN0H98foSSHw2ugmxBZc0bWFgfhRYwISa+TbLiPFmdKPBLiha
        wSOLntZ/oLp8vubsrQsO/+ac8PwgOHsoqm2a7+hO0oE/4uM58Pj4YxAjhFT+guQlxaKIqK9k3wOza
        T/caStdQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfUqG-00Bcev-St; Fri, 15 Apr 2022 22:55:04 +0000
Date:   Fri, 15 Apr 2022 15:55:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, basheer.ahmed.muddebihal@intel.com,
        tianfei.zhang@intel.com
Subject: Re: [PATCH v2 4/8] firmware_loader: Add firmware-upload support
Message-ID: <Yln3yCsPK9Za2jbu@bombadil.infradead.org>
References: <20220415200805.610339-1-russell.h.weight@intel.com>
 <20220415200805.610339-5-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415200805.610339-5-russell.h.weight@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 01:08:01PM -0700, Russ Weight wrote:
> +EXPORT_SYMBOL_GPL(firmware_upload_unregister);
> diff --git a/drivers/base/firmware_loader/sysfs_upload.h b/drivers/base/firmware_loader/sysfs_upload.h
> new file mode 100644
> index 000000000000..a72d0e82e107
> --- /dev/null
> +++ b/drivers/base/firmware_loader/sysfs_upload.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __FIRMWARE_UPLOAD_H
> +#define __FIRMWARE_UPLOAD_H
> +
> +#include <linux/device.h>
> +
> +/* Update progress codes */
> +enum fw_upload_prog {
> +	FW_UPLOAD_PROG_IDLE,
> +	FW_UPLOAD_PROG_RECEIVING,
> +	FW_UPLOAD_PROG_PREPARING,
> +	FW_UPLOAD_PROG_TRANSFERRING,
> +	FW_UPLOAD_PROG_PROGRAMMING,
> +	FW_UPLOAD_PROG_MAX
> +};

This is all looking good to me, thanks for all the work and testing!
Can you just add kdoc entries for the above as well?

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
