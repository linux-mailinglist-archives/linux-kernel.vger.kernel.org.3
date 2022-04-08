Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24ED4FA040
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiDHXuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 19:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiDHXuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:50:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623EC17A8D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 168AFB82DED
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 23:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E9CC385A3;
        Fri,  8 Apr 2022 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649461676;
        bh=sXI60kUyy7cxmz0gQG3mHItdRbMXp951tVN065m6Scs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yZkVyn2/lOsr2DycApXo2R05rB97eEYV089H4kZevrBe57CHf0GK1F5xl1zZPqugj
         GjXscV/7HnXh/DTnzH37WSNDRSr8yKVaMN3rKwLTGqwUhIONymaFPhib+D97MgcSo2
         iPa2e58EASvspLxVJdaHyz5qhoqXVyTpFNI2vjng=
Date:   Fri, 8 Apr 2022 16:47:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hwpoison: fix race between hugetlb
 free/demotion and memory_failure_hugetlb()
Message-Id: <20220408164755.3ef6536c1cdcb38955348a2c@linux-foundation.org>
In-Reply-To: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Apr 2022 22:53:20 +0900 Naoya Horiguchi <naoya.horiguchi@linux.dev> wrote:

> I updated v7 (https://lore.kernel.org/linux-mm/20220407112929.1344748-1-naoya.horiguchi@linux.dev/)
> based on the comment from Miaohe Lin.  Now I have a few additional patches.
> Any comments and suggestions are welcomed.

As [1/3] is cc:stable I queued that for 5.18-rcX and the other two
patches I queued for 5.19.

This plan means that [1/3] will be merged into mainline without the
other two patches yet present, which is a combination which you may not
have tested.  Please confirm that this will be OK?

