Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5184C6CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiB1MmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiB1MmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:42:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8C45045D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2wm+MmG2cPgiiSEaSxGBLWYbjfx227Rcvabg3xmOl9U=; b=AbTcmXoENSVi3aonK55lvDOH5L
        iOi9R8EjBtuMiSb+8fCuot7hQXo4ksAz77imunjAf7NTR/2iqYZ8X/nGzE/SGXNuPo6s5gUsB+k9c
        3V3WTwpw71BMVqF+kFssi01HprkMmlDGVcqRrWRVPx+mCQfEtPSZL2WkQBFSRPXabaVorguoO2x3q
        2Z0oQPHYldeDnsZ9gzn1dwvx8LUy9sDqSWb02mt1m5RodGeFri1d+7af3cUaBqZLwPZbZVEpaNCl4
        pusHRtQ+dN7fEU+TginTDI4LePFFnR2dt4kGjg4Oy9extslJNWNZEK0fbk806u0EDnDhVMzR6Wx/L
        zsrf2rrA==;
Received: from [2.53.163.181] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOfLC-00CHap-VO; Mon, 28 Feb 2022 12:41:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: fully convert f2fs to the new bio allocation interface
Date:   Mon, 28 Feb 2022 14:41:21 +0200
Message-Id: <20220228124123.856027-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk and Chao,

as of the for-5.18/block tree, the bio allocation interfaces expect the
block_device and operation passed.  This fixes f2fs up to match that
scheme.

It could go into Jens' alloc-cleanups branch if there are no conflicts
in the f2fs tree.
