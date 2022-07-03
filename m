Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC8564581
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiGCHM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiGCHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:12:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012EF6242;
        Sun,  3 Jul 2022 00:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zEPta8a4kO4M2oOgAWC9+IxxiKqCShbd1Nc4YNMmNnM=; b=LcBIb7GZtLVAwyR7lzyvnEI2qM
        XNVu5o5ZG2Imbsx8F2LP5t4ZeDoHZ3MANMBXtLWB+OzLafhr5j4nvfGKwUUiwpKM9GELUdFEdRjM1
        wECa4VbvDtFEzlKt6wASi9JmjOhVndTzcOPMzJpDk/wAVM7enl4hsAB45vT+5+T/2V6p/3bSmcXbW
        /7E/Eyca9EZp3AYIwOaHwBhkQlA/uwVAgjZaHDYIkLynVueIZ7ak+06UwcWLxC6vZ2gNPgv/pQVd7
        NnUSPMWGkP0gfbTjaxJzM9Tu36hDOaXu7/CJpEFSPzdoA+Ubr24VJwYQ/AFXkSS033Ub8xhX2tzaz
        ntKbrsEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7tmF-00EDWr-Fn; Sun, 03 Jul 2022 07:12:19 +0000
Date:   Sun, 3 Jul 2022 00:12:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: INFO: task hung in blk_trace_remove
Message-ID: <YsFBU1ZzeTy1lVu4@infradead.org>
References: <YsEhsEvhZyoJFtSO@archdragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsEhsEvhZyoJFtSO@archdragon>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 01:57:20PM +0900, Dae R. Jeong wrote:
> Hello,
> 
> We observed an issue "INFO: task hung in blk_trace_remove" during
> fuzzing.
> 
> Unfortunately, we have not found a reproducer for the crash yet. We
> will inform you if we have any update on this crash.
> 
> The crash information is attached at the end of this email.

This looks like it is due to locking an on the /dev/sg node instead
of the more usual (and more tested) block device node.

It might make sense to run with lockdep enabled to get a better
grip on potential locking issues here.
