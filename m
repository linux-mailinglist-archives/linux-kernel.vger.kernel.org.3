Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01FC5207E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiEIWlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiEIWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:41:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD11FE1F2;
        Mon,  9 May 2022 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5httqNTKNMbgjU3BIxtC2FF0M4AjcTdqhFqK/ZumpdE=; b=Cot2sF2iU+2/Xzl0/HW17+QR2z
        8NjKGCVRideD24WANl7NLhcfOJUE1q9B4j5hntw+Q69/CNsDefhqhU0+3kKwvQh3fXez99cBGFIQq
        hJ3bs+piT079Au9ZVsAIkQJMw0ei8L+mkcuKFo12FHwXjyPyf53FcDCwfcuUEwG80iY3YCrBdQ0fS
        zTHVPMp5HtWd4++jLVsv6oqcRPyKvzVLvVZMKMSW/N1L1Cv2TjA3h8m1IxB6vq3BLNGfuWWPigS1w
        suIn4t2sz/cNxoKEYzsal9KLhJMS+wr03abmEyYcAVH2ofXUXapwgu0Vkfnia7VQ087XEd48ArzwJ
        xmJy1Z7w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noC0Z-00Gb6D-5v; Mon, 09 May 2022 22:37:39 +0000
Date:   Mon, 9 May 2022 15:37:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] test_firmware: fix end of loop test in
 upload_read_show()
Message-ID: <YnmXs+QbA4PjMBCX@bombadil.infradead.org>
References: <YnTGU3UJOIA09I7e@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnTGU3UJOIA09I7e@kili>
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

On Fri, May 06, 2022 at 09:55:15AM +0300, Dan Carpenter wrote:
> If a list_for_each_entry() loop exits without hitting a break statement
> then the iterator points to invalid memory.  So in this code the
> "tst->name" dereference is an out bounds read.  It's an offset from the
> &test_upload_list pointer and it will likely work fine most of the time
> but it's not correct.
> 
> One alternative is to fix this this by changing the test to:
> 
> 	if (list_entry_is_head(tst, &test_upload_list, node)) {
> 
> But the simpler, trendy new way is just create a new variable and test
> for NULL.
> 
> Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
