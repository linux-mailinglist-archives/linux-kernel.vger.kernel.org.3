Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F84DAFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355695AbiCPM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355696AbiCPM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:26:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE766213
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bDzUiAE2yXW6bfjMYLO917qo5tShPrjiMEB/4GVBdHo=; b=IxGoF+ecYdmGtxiNwNM0V7D+ee
        a5TOdJTTU/zm4JxdO8FyyLwKsA+F82YJh61KaLgAulsSFUbdQIzuFfB1yYktkXEqVJPQ4zQrfujp2
        kD4l7k+i1PG+0exmDwYW2V2JbuhKfk6mOjiySTN8bAsG5jsUI7nw4tHTOwrwmvf795aJWEln6t/6e
        11lWnM51z5xvKAPJjHfzfum4R315EA8ZmfrZhxNYBLyYkJcg1A55gSV5TAg9HKtEf5qxafsRdsbKi
        80OgeJ4A1UH4G46P/qqFjjoF0IFFw/q5KNO36+9YAX/LmqKHB5I9Qff6LOxTBJsBBlCuZCKGOkEGt
        W0dqyYFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUSi6-005xWo-Jy; Wed, 16 Mar 2022 12:25:02 +0000
Date:   Wed, 16 Mar 2022 12:25:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: simplify the code of find_get_incore_page()
Message-ID: <YjHXHi6WGr9EA35D@casper.infradead.org>
References: <20220316075941.44816-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316075941.44816-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 03:59:41PM +0800, Miaohe Lin wrote:
> pagecache_get_page() can return subpage for us if we do not specify
> FGP_HEAD. No functional change intended.

No, I'm converting this to folios soon.
