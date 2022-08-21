Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81F759B268
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiHUHAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiHUHAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:00:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3383026106;
        Sun, 21 Aug 2022 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ySj9j9saW2yCa8c+yJi3tbjUYdMOCd4L5+lUeBFBlw=; b=CFKmVhJoVtkiach+yo+gcT08D1
        laKEfLo/oILc9TSGonwru5FCVANzuvnFwQ/3crz8lAV/BpWfSnILYuE//AXjRNbmM8YrOQlJEupHS
        Gg8fYZxHLqsSTkyzOfq/EHNVynE+0A/ZdKOEdoNdxRiFyWN1/o9Uww9lfjerTMmvne5StBJhBMIaV
        8WqTlefjPr0wdF/b287jk6bBPSMrzgTblxlXRYz4yoYNKXM/9Nu+Fn0dZVmthfQBTUengXF73Q1fg
        m0z9GnXcdPuIH8jU84zUdx2pguBjgU1Fwag/Z98gSY8N1BWQsn1OfHUp+IEUTmwLWqV+/AzQKZTsj
        zpBdgLuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPewJ-0073Ye-1x; Sun, 21 Aug 2022 07:00:07 +0000
Date:   Sun, 21 Aug 2022 00:00:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwHX98KBEnZw9t6e@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-6-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 08:31:19AM +0800, Baoquan He wrote:
> With it, the old ioremap() and iounmap() can be perfectly removed
> since they are duplicated with the standard functions.

Can you write a somewhat better commit message explaining that it
switches to the generic code that has equivalent functionality?

> +#define ioremap_uc(addr, size) ioremap((addr), (size))

This is wrong and hexagon should use the asm-generic version of
ioremap_uc that returns NULL.
