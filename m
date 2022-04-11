Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228A4FBE60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346944AbiDKOMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiDKOMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:12:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDFA1A8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pE/+SrYqL1g08VsHJNSz74TfceZwdGwwEWicZS/GD8M=; b=ZLfrUuTdHdrXz4S9W6SMCyeWxq
        3wxcSW1LUfl16020ojYqUSj3OWn/iVNr3GkzrEGJ52Xqbvjm3asVm3jt5OMYefPr7npqxNYaPwoMw
        4aEXNZB/WgMnToizp2YXhvsbRUW5C69PqTqdpR5ZJpn8fXmeXY4X4qcuE3KXmMCTD1a0ymNqu5TDV
        cvvy1sK0UL/ddGVNvzi5YZvfoUSYoV0avqYtfHnB+RAQXXrmxJHVtNEfITpQt9vB34xzXy+VuC1zz
        8oc7R/+PBrZ3VmkCm7Ohdu8zalIIICu1dLlPcLrhCyXynJLMIC/5gBZAAs5XIxi03SexodoieLmK/
        LdpuUJ1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndujX-009JBp-KC; Mon, 11 Apr 2022 14:09:35 +0000
Date:   Mon, 11 Apr 2022 07:09:35 -0700
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
Subject: Re: [PATCH 1/4] mm/migration: reduce the rcu lock duration
Message-ID: <YlQ2n2wrhqpgF3Ow@infradead.org>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
 <20220409073846.22286-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409073846.22286-2-linmiaohe@huawei.com>
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

On Sat, Apr 09, 2022 at 03:38:43PM +0800, Miaohe Lin wrote:
> rcu_read_lock is required by grabbing the task refcount but it's not
> needed for ptrace_may_access. So we could release the rcu lock after
> task refcount is successfully grabbed to reduce the rcu holding time.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
