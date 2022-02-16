Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3004B8EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiBPRNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:13:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiBPRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:13:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2612295FDF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z6ZkAKcGAc8HyB5DxrQiZvs7DK8Ja5ViwJAo9ydHrpY=; b=Rgsq98c6WGs2LqT1JGVNIAde//
        RPC/84/4iocorVIrrcAozJtzUx+5t9GeR6jle2pHDISY+9r27YIp7buNKvFf+zvp8bwQRGoM1maHX
        nGHQMUqnvJyfBrlGZi9Q7E8uByXC95F/DV7kzwXN8gx4PscGmi+FhZmPW0X2WfxJW6I8p7fG93eRX
        KWXOSjoJFuRCsB3sMBZYMxGYUqZgzFjeKz0QFKhN7eQVE55hBDhi13cSiMHs1nx4YaJSud2TrhqPC
        OLSweRU3PbYKl4Rg44Vqn7qnb1boKo8lC4NiMiGPwVqSjofs9gQzLZTPxDXF0dsUe5Jqg47moYdsA
        i0aBv7eg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKNrG-007rwX-6k; Wed, 16 Feb 2022 17:12:50 +0000
Date:   Wed, 16 Feb 2022 09:12:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <Yg0wklcJ3ed76Jbk@infradead.org>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
 <YgYAs7R/1G2Y2kpz@infradead.org>
 <9b291987cf914f119788c42b32a08a12@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b291987cf914f119788c42b32a08a12@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 04:07:05PM +0000, Nitin Rawat (QUIC) wrote:
> Hi Christoph/Keith/Rafael
> 
> Since we are giving control to PCIe (NVMe power rails control), it can vary from platform to platform.
> More over, PCIe driver doesn't control these power rails directly from PCIe driver, they tie nvme supply with one of the pcie supply and control them together. 
> So i think it would be better to either have quirk based on platform or always setting simple suspend and platform which needs full suspend can update it through some means. 
> 
> Based on below link, Looks like this can be across platform ...vidya also mention similar concern for tegra platform.  

Here is the thing:  nothing here is really NVMe specific.  We do have
a bunch of drivers including nvme that would love to not do a full
firmware shutdown on a suspend.  For storage devices this is especially
important as each shutdown reduces media life time.  Until very recently
this has been perfectly fine, but now various platforms show up that
want to completely disable power to PCIe slots on a system suspend.

The drivers need information from the PCI / PM core when a ->suspend
call requires the device to got into D3 and when not, and we can't just
do that with quirks in the various drivers.
