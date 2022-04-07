Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35A54F80A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiDGNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbiDGNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:34:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC9C23ACAF;
        Thu,  7 Apr 2022 06:32:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AF3D68AFE; Thu,  7 Apr 2022 15:32:33 +0200 (CEST)
Date:   Thu, 7 Apr 2022 15:32:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     damien.lemoal@opensource.wdc.com, hch@lst.de,
        linux-doc@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] libata: Improve ATA queued command allocation
Message-ID: <20220407133232.GA7092@lst.de>
References: <1649333365-100672-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649333365-100672-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	qc = __ata_qc_from_tag(ap, tag);
> +	qc->tag = qc->hw_tag = tag;
> +	qc->scsicmd = NULL;
> +	qc->ap = ap;
> +	qc->dev = dev;
> +
> +	ata_qc_reinit(qc);
> +
> +	qc->scsicmd = cmd;

My fault, byt we can remove the first qc->scsicmd a nothing looks
at the field before this real initialization.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
