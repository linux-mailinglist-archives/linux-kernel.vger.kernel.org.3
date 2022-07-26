Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A158193E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiGZRzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbiGZRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:55:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5C3120B;
        Tue, 26 Jul 2022 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2MrgM9crsVUK7d7TyylckBEhCPVqAFUH8gFYQW4jo/w=; b=KLxm3pkecdbPtD6wd8X2Cb6ruz
        cu0Gm3T/R23+/6s4V7cBaW5HIctp/LvNkVcy0FZJ18AVtpaOLaRjFAbnk+JOvaN+37t8Af5Ebkv2A
        q3mklP5DPy/SiMoPTcjwRO+YOuP+9Sof1/mtikbITe4Ztk0hjbDYgsL6/6PwidTzaPcvP0SCCM7W7
        lmjJrDqjRSTHKEj7GNUcxKAoYJd4c2Nees3FQXrkENcuPGVOPWyCXIUXRkPl+gvo/DPtc+47DQvPb
        azgg2l+G5eVHJmNQk4Kl7gJS3BbvksR7TAyGT9nswsKvoLoIOoaGmLH168INEdSNaIMxE3pqHQbuf
        RmaQKDBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGOm9-001qFs-CY; Tue, 26 Jul 2022 17:55:21 +0000
Date:   Tue, 26 Jul 2022 10:55:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ata: libata-scsi: Refactor scsi_6_lba_len() with
 use of get_unaligned_be24()
Message-ID: <YuAqiUcsR5R3uhJ1@infradead.org>
References: <20220726154518.73248-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726154518.73248-1-andriy.shevchenko@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 06:45:18PM +0300, Andy Shevchenko wrote:
>  static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
>  {
> +	*plba = get_unaligned_be24(cdb[1]) & 0x1fffff;
> +	*plen = cdb[4];

I think just pen coding this in the caller would be a lot cleaner.

Same for scsi_10_lba_len and scsi_16_lba_len in their two callers each.
