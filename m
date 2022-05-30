Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2139537524
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiE3GB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiE3GBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:01:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92B7090B;
        Sun, 29 May 2022 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DKRkj/xqttsImUIpAfot1EAes2QVwyvbLRzEMdKGtM8=; b=ENQI6uQqOs+houccJ/3lgsGW2P
        UhEA4W3dOhWEdaNQypSeW6OHZu1+9fhwJy/ptJvShOOhbMk8Kchxt0DP1faNviHtpQDIPugRsel/K
        1u4lM+sqymbxwr4eAQbH5lrzfSq1+/80RupEUNO1blXzgJl/scfT99Xqw1RLPox4wRXdFdPJjN9M0
        Cs69GzE93bofDCbnucZF28P2cQaFBUmJsWfvlSMANIkusQXu075ag3Y2rgaB+3bsknESg+Sy7UaE4
        4B+KWPiGcBzO19apaK5y1Vf8E8BKyynJQyoGwyU0K5bQ9AR5CoLr/vXWl6VZ/9mKckwdGdQN+PMxe
        2q5UgHjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvYSt-005UUM-3L; Mon, 30 May 2022 06:01:19 +0000
Date:   Sun, 29 May 2022 23:01:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 13/17] md/raid5-cache: Add RCU protection to conf->log
 accesses
Message-ID: <YpRdrytEQkw/0vMH@infradead.org>
References: <20220526163604.32736-1-logang@deltatee.com>
 <20220526163604.32736-14-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526163604.32736-14-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:36:00AM -0600, Logan Gunthorpe wrote:
> The mdadm test 21raid5cache randomly fails with NULL pointer accesses
> of conf->log when run repeatedly. conf->log was sort of protected with
> RCU, but most dereferences were not done with the correct functions.
> 
> Add rcu_read_locks(), rcu_dereference_protected() and rcu_access_pointers()
> calls to the appropriate places and mark the pointer with __rcu.

Looking at the code a bit more, is this really enough?  Calls to
r5c_is_writeback / r5c_confi_is_writeback are sprinkled all over the
code, and my gut feeling is the value is not expected to change over
way longer critical sections than this.  So maybe the answer here is to
fix up the release to be properly locked as it only affects the non-I/O
slow path anyway.
