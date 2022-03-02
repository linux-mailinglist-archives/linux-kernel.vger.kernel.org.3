Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94F4CB12C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiCBVWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiCBVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:22:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D7C48E42;
        Wed,  2 Mar 2022 13:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:References;
        bh=QGQwHCQX3j+TcKKZtmw4Nue4CTnQRxDyxtp3O3ZauA8=; b=lYcaijEmRslYq3x6eyRWtLcAQq
        wgJKfe0IUb0dX0eXRFwcI6S944b3Z5XXManZwwaU0TDGnbXOGosC5c7Nu4I9eC5zC8TbwlHSvFGEg
        wSAI45wlWP0NsAInVV5SjB4H/HtpONAc0AUA7hTtXdbayCwIbPdvWj/m3HrPsLfTv/GH10RACIqi4
        7csgyH7+04vAD1fd4l9ef23dhGfG7l2qPzm/+yURq3r8Ly8FOw8gX63GWTBnQCoT8PMvEuBzd7zIf
        +v5tpjWY4p7SDs+rgxj/+LqQ1HVMqSRcKh1t7TgAdTLSBkni4sGEcpSBwsF4dnCUkyTKfOaYcMVAc
        Sk/hxRBA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPWPt-004Gph-Mq; Wed, 02 Mar 2022 21:21:49 +0000
Date:   Wed, 2 Mar 2022 13:21:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 1/3] mm: hugetlb: disable freeing vmemmap pages when
 struct page crosses page boundaries
Message-ID: <Yh/f7YpP0Oc2Nkun@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302083758.32528-2-songmuchun@bytedance.com>
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

On Wed, Mar 02, 2022 at 04:37:56PM +0800, Muchun Song wrote:
> If CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is enabled and the size
> of "struct page" is not power of two, we cannot optimize vmemmap pages
> of HugeTLB pages. We should disable this feature in this case.

The commit log does not descrie what happens if this is left enabled in
that case? Is this a fix? Why would it be a fix? Was something failing?
How did you spot this issue? What are the consequences of not applying
this patch?

  Luis
