Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7374B1E83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiBKGWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:22:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiBKGWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:22:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF254BFD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mIhB8UNxdTZinwWJSzuc3lzOHI2eL3UpSdF4CpL6P00=; b=KSfIozQyCADDpWSEoxajTPFd8F
        lkkwqvDZx6PjOiTogo1teGmEhDjgPh3v7843+DU4rMq+GtLJm/XOF2z72MIRS5hdikUSNKF8zJ97/
        SjcOTH8Z0gpVQk6zOl60k4R/YJByKjglgmOiIkCOMvz9nRCnwMr+KNDRBoTTbOt2E3TevGnVNmhbK
        LgkVfHT1WGnWZfq437Oof2j2eYtyx/wF6Gm5pjKtMPCXyO3FOMl3jHUDtbYPzszdfaeQpm6Y3QDEL
        gCNyrRQHv+X9QDrVAVXBSVduI+4zFgZ/1IWSeRPPhqGkvFijiW9WszEaMwpx/kuqLdOrA4kKZXMUc
        T2bdXzXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPKN-005yhB-49; Fri, 11 Feb 2022 06:22:43 +0000
Date:   Thu, 10 Feb 2022 22:22:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <YgYAs7R/1G2Y2kpz@infradead.org>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
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

On Fri, Feb 11, 2022 at 02:23:28AM +0530, Nitin Rawat wrote:
> Enable quick suspend quirks for Sc7280 platform, where power
> to nvme device is removed during suspend-resume process. This
> is done to avoid the failure dring resume.

You need to sort this out in the PCI and PM layers.  The broken platform
will also affect all other PCIe drivers and not just nvme.
