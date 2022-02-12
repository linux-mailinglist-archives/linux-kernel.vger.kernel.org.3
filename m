Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCCC4B380B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 21:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiBLUtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 15:49:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiBLUs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 15:48:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E24606E5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA9E860DFD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 20:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DEC340E7;
        Sat, 12 Feb 2022 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644698934;
        bh=VCwf/lTuTaKLroj3xGvCG7JEn5+S4JWuF4kVF8dbm0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDySsM7ArnhwpS/eHcz6JE3BXsiDv29llXtKgQO1juR8sp67w2cpaScpSDi2egtrX
         OLZi7zRhGuB88NO+XRRhYjxBegsGTy25jJopsMKDMy5CLfsEZqRk15EurGdKjoyeaK
         VJZwF2FKvCDlBnjnNeMV49gGL1XySbAFywcoj8c5OvBx3H16Dp/3SoJgqwTXz8No8F
         RIawQnlpBEfwGrJmWMN/uV7DnN0JOwqnpUthDUL25BOgvZy+sloztqUgTDICRG7Tsy
         emMh9R1HsQjqvC+X4yaiBVsTy7EtNKDIwVR8YT/T+qtHI9LjdFCYQUjDatP4qOjNKc
         7lJ4op9cUNZbw==
Date:   Sat, 12 Feb 2022 12:48:51 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Matthew Waltz <matthewwaltzis@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix prp list allocation
Message-ID: <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
References: <20220212200649.541061-1-matthewwaltzis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212200649.541061-1-matthewwaltzis@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:06:49PM -0700, Matthew Waltz wrote:
> Fixes kernel block errors originating from the hard-coded 256-byte
> alignment of dma_pool_create(). The NVMe specification requires a PRP
> List PBAO offset field of 0h, i.e. a PRP List must be aligned to the
> configured 4096-byte memory page size.
 
That is not correct. The spec (2.0a section 4.1.1) says:

   The first PRP List entry [...] shall be qword aligned and may also
   have a non-zero offset within the memory page.
