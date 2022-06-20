Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C3E550FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiFTFzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiFTFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:55:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A43DDE85
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OK5Lmq26Sjt+WwRVBGAaabVhvu5RcuOZ2N2C2m7lIww=; b=Uq4BRyYARS/afjWOVHN6grwCpy
        m72lpKaCKoybAL51mCxsT1Kp3sDmm2CoSesqrUbFzv5NytHehq9cXl6f0ynNXSDxsJnHcch1m2Ebe
        8dl/9X+0BnJSw5qRQBuXbEJ/hzJhNoMQDZN/DNW+1gjtkdwvwJxF6PSK5PYaiOhDAaJghBxCQM2cB
        cT09Ft064qBSblGoTeN9WIpbyB+OxY5UAzIJJl9+rCXJwKFqn8iT9hiorm219NhN3FsLtu5WD+un+
        4apUZcWQF1vo6UHX15U4qWqDLXRvaKnewqob+F8GlNmW87uwzfFvHOb/cv7mShHm1JEpwkEvg+zI1
        W96EPvoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3ANw-00GM3L-9x; Mon, 20 Jun 2022 05:55:40 +0000
Date:   Sun, 19 Jun 2022 22:55:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
        kbuild-all@lists.01.org, hch@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/2] mm/mmap: Restrict generic protection_map[] array
 visibility
Message-ID: <YrAL3CnuQCyReVe3@infradead.org>
References: <20220616040924.1022607-2-anshuman.khandual@arm.com>
 <202206162004.ak9KTfMD-lkp@intel.com>
 <da75a2d1-afc5-b6ff-dce0-ef0b20dbfde0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da75a2d1-afc5-b6ff-dce0-ef0b20dbfde0@arm.com>
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

On Mon, Jun 20, 2022 at 10:15:31AM +0530, Anshuman Khandual wrote:
> +extern pgprot_t protection_map[16];


externs in .c files are never a good idea.  I'd rather add a helper
function toadd pgprot_encrypted to protection_map to pgprot.c.
