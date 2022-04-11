Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B74FBFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347630AbiDKPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiDKPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:10:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2ADEE8;
        Mon, 11 Apr 2022 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kaOYbB7BPRuQaA6MSo+ry7RpxuhRfvVv8fz/JnNUxz8=; b=fjLiTm+vkn8ToPkhqxJ9r/2JHE
        6PU6Us8m6sMsugih5LHYR/OmBND3Ay1ajeJE260aTCfKQvwHxemQNuMnvqQxCkCWKArY4fn5FA2hR
        yWtB7EpN10msubpx9aFTZByz6VTehNutR3ZeLzOMHvsSgZVAC/qmbgYR3wNq6pwFS3TMTzSCbyQZL
        AS98yxFPTUj6ehFKyE6VXPo2J1KacTIokYLZ/kTpsG3pD9SSU5MSHao55JfuLhiotMh6s52wcvFhC
        oTisq+Mly46j02oPIv01FBg+El5Nee+170jKpTzvIO0huA/7xzC/jKNZMvjMFzGJVQ7f67NdnpV4S
        qjqfMrFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndvdR-009UOP-4a; Mon, 11 Apr 2022 15:07:21 +0000
Date:   Mon, 11 Apr 2022 08:07:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     tim@cyberelk.net, axboe@kernel.dk, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] security: do not leak information in ioctl
Message-ID: <YlREKRb/xgAFsi97@infradead.org>
References: <20220409145137.67592-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409145137.67592-1-trix@redhat.com>
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

Wrong subject prefix, and this really should be split into one patch for
pcd and one for sr.

The sr prt looks sensible to me.  But for pcd why can't you just
initialize buffer using

	char buffer[32] = { };

and be done with it?

