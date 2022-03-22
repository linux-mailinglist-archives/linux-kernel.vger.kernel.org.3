Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B094E378A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiCVDaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiCVD3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:29:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E91557CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PmzPsSEKYvhyhANMX4sguPg6Lgk0mR2MoyENFqhEmKw=; b=mk/1gfNMyD8Tbu45EN0gijuV2K
        qk8T4dUfPkMENKDrupG+/GfXWOowOd0HTyBG4Uzy2UAf2hhyZZaEk1m1S3S3m8ff1OWwZTD2mMEiZ
        3rZNLgp9BBSeikPTKE9xDu1GuQZamXSdnXVpF2THB275OapMj5NU66adFsU4V+zk0YvqKaoDP+7Gn
        YSFRbLycxi0MKWykLCx9MqFildpP1A3+T+94FPEIgyCvBFw+CPA9olkXh+fiYocgV3f6gBwfd4lDL
        DCIdRWFQGe0+ZGMr8GaY8hhWEKRo1HcgdOGkVNHktNOuCTFpI6LzLooO0AiCv3Idm5orpcv0e6DoF
        dp9G6NcA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWVBs-00BDz7-I6; Tue, 22 Mar 2022 03:28:12 +0000
Date:   Tue, 22 Mar 2022 03:28:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        william.kucharski@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yejiajian2018@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn, caoyixuan2019@email.szu.edu.cn,
        zhaochongxi2019@email.szu.edu.cn, yuhongf@szu.edu.cn
Subject: Re: [PATCH 1/2] mm/page_owner.c: introduce vmalloc allocator for
 page_owner
Message-ID: <YjlCTOrCUHnVxIqj@casper.infradead.org>
References: <20220322032225.1402992-1-zhangyinan2019@email.szu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322032225.1402992-1-zhangyinan2019@email.szu.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:22:24AM +0800, Yinan Zhang wrote:
> An application's memory consumption is high and keeps increasing,
> then it is suspected of having memory leak. There are several
> commonly used memory allocators: slab, cma, vmalloc, etc. The memory
> leak identification can be speed up if page information allocated
> by an individual allocator are analyzed individually. This patch
> introduce vmalloc allocator for page_owner.

Why is /proc/vmallocinfo not enough?
