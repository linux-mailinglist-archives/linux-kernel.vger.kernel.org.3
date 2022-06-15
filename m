Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831E354C755
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbiFOLXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbiFOLWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:22:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFDBDECB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=FVOq6VwUFB6uFGq2mjk/V+n5h8ZD55Qbyk92hCokle4=; b=x516N7q+S0IoRntqx03R881c4L
        aUG+uFkvQ2ZlReI5wNvc3O80OwY0bHH/Osdpk+MWHqf7L63nQRiXo2EB1VMhezaoXeiTgFhHWNt3l
        yXaJIiZxCiccJ2PMKZxsADdC98aBEj9YWBXFPZlVhenBNO1bd/bYR+0KSgRznX/okKIfkjpW4MF/7
        glQ64v59zGHQI2ESvlEk8pPQI4RRfnhRl+ExqjqgtKeaDDVcyWDmBXt/ta8YxblMZuthaANolD81f
        jIZJiqrZdO0GdFNG68XLUjEfeykpZLcoFEtdcO1rsQzWa6AwI6Z9Gduqytf26S9XofgafjQXlpBoE
        xTElzBnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1R6Y-00E9Kf-OK; Wed, 15 Jun 2022 11:22:34 +0000
Date:   Wed, 15 Jun 2022 04:22:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     liubo <liubo254@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        willy@infradead.org, vbabka@suse.cz, surenb@google.com,
        peterx@redhat.com, neilb@suse.de, naoya.horiguchi@nec.com,
        minchan@kernel.org, linmiaohe@huawei.com, louhongxiang@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH v2 2/2] mm/swapfile: release swap info when swap device
 is unpluged
Message-ID: <YqnA+nZzkPYsw6CI@infradead.org>
References: <20220615070228.2858170-1-liubo254@huawei.com>
 <20220615070228.2858170-3-liubo254@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615070228.2858170-3-liubo254@huawei.com>
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

Sorry, but this is simply broken.  We can't just do d_path magic
here.  That being said the problem is real, and I think the right
answer is to offer a swapoff variant that doesn't need to open the
underlying device or file, but useѕ some kind of handle.  I'm just
not sure what would be a good handle here.
