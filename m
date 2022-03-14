Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609084D88ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiCNQTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbiCNQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:19:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20635F75
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dwLf6RzOeFuliLX0ooOtLy5ua6UBRGxTFPEUWQAzNJQ=; b=Pr7f3PvG+NbM0IYBxGkd1YzIir
        jdNMYdBSaaM0cbshTydJt2sFfwwx+ieJB3mXnoqvDQX+4zE35YjCF4l9qKUyBFyO7OVsRceSUIaBc
        x33Uhn4HzmuZ6LUdngR6jn1/s0hnAoHp9n8brEc80WGbNPVP5VhZwjWtgGOz0f0VyYyE4pndFFJiw
        0po3+c4818Zqf3nNx96XSUL5GWX1NlO0DEQrjLm2jKVC3jb2tKgjQzB3Qlyx/BMCNqRw1EfE3oUwA
        zchMrCY7GErAryhJ3RWjZ/gTGJpP1XH8T6gVpcL5RLZHatS5EaHC5J0NRhh6Z6U+wZFiKSnQc4//Z
        NGnlmKtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTnOF-004CZY-WC; Mon, 14 Mar 2022 16:17:48 +0000
Date:   Mon, 14 Mar 2022 16:17:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mlock: remove unneeded start >= vma->vm_end check
Message-ID: <Yi9qq9hVloDXcW4b@casper.infradead.org>
References: <20220314153223.53753-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314153223.53753-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:32:23PM +0800, Miaohe Lin wrote:
> If find_vma returns a vma, it must satisfies that start < vma->vm_end.
> Since vma list is sorted in the ascending order, so we will never see
> start >= vma->vm_end here. Remove this unneeded check.

faulty logic; vm_start + len might wrap.
