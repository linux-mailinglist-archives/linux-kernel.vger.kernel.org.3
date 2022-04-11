Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16F64FBE62
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346964AbiDKOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346986AbiDKOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:12:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02FF7649
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zSE3hyVO7DFjxq33qgn4/OBAbkzMg5A0QRViTX6+0XQ=; b=UOWQTw7zs/BDaXgkh9KjInv+NC
        E4AiAtGrvY9b/FNmtWco5EwBkUyi2yjkpnpFCMEmHsmgCGw51ABGXRtyL4ybPLg5WUm1s56tpBFlG
        /cRzRD15I7MkyRDWeb5+SLiY0SJJaA3+i6R4+p4YBXpTU+esdNDiu8hkOoaFB716WnYyF+/AQyEAs
        uuHKm22bVICD996LR/QyVemuZ2yvA332g+j64g4ESLz8vJB/CgqnuwdbDX5Mc6LoFxmU/366GjUd6
        k3a1ViBZNvR1qGhomBTZRphvvb+0oPXCmvJ/yEXGAKvzgaHYLoT+MQZyv9j3QdU20l2QIc5Tdmwy7
        jOONDsQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndujt-009JJB-4a; Mon, 11 Apr 2022 14:09:57 +0000
Date:   Mon, 11 Apr 2022 07:09:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        shy828301@gmail.com, willy@infradead.org, ying.huang@intel.com,
        ziy@nvidia.com, minchan@kernel.org, apopple@nvidia.com,
        dave.hansen@linux.intel.com, o451686892@gmail.com,
        jhubbard@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, osalvador@suse.de,
        david@redhat.com, sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
Message-ID: <YlQ2tb6U5+pn3Sgn@infradead.org>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
 <20220409073846.22286-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409073846.22286-3-linmiaohe@huawei.com>
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

On Sat, Apr 09, 2022 at 03:38:44PM +0800, Miaohe Lin wrote:
> When non-lru movable page was freed from under us, __ClearPageMovable must
> have been done. Even if it's not done, ClearPageIsolated here won't hurt
> as page will be freed anyway. So we can thus remove unneeded lock page and
> PageMovable check here.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
