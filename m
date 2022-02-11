Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038BA4B2E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353176AbiBKUVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:21:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiBKUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:21:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC1CFD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iw00k9jskvLMRelaK3vjuX4Ipw5ug91ZREDXkAHjsJM=; b=rP3f+QsPkPnztfOWsgAd/0RoSN
        Ki0gZ/I+JRYzwFbetWo6Vl9zPQjmckZ6ZYSm8MHuI1TCCrmSacqIs0mW35K4L5Ct6lhgzDzleN38O
        v3E9gm6YGz54q/gsc0PugERLfdxA07uEcYqA9KRx3LWhvUu7aA7yHFxNySsZ6pUJgKnzE+9yIR3vM
        tpeiUReXOq/RPrllcZkLVG2gE6g4DGi1oiZPAa3pnF9BUlVC2skbe5AobhFflYb75OUMlDJsB7Zzu
        fm8o7+ZAmxK8jyVuTuz9iZM0IJS8mUHTJ82rUQIZWAWIIuQPB5uPc5O+7zN4p2h9G/RcRHCwvtj4f
        qKaZi3Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIcPU-00AhuL-R4; Fri, 11 Feb 2022 20:20:52 +0000
Date:   Fri, 11 Feb 2022 20:20:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mark Hemment <markhemm@googlemail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 20/75] mm/gup: Convert gup_pte_range() to use a folio
Message-ID: <YgbFJCb/wwN+3+AV@casper.infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-21-willy@infradead.org>
 <CANe_+Ugjtu2zw8i3CyCU3mu71L7Gh_etuj_5t64Bx7y7+fj2jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANe_+Ugjtu2zw8i3CyCU3mu71L7Gh_etuj_5t64Bx7y7+fj2jA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 02:52:46PM +0000, Mark Hemment wrote:
> On Fri, 4 Feb 2022 at 20:21, Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> V. Minor/nit: Above the "goto pte_unmap;" is the code block;
>            if (flags & FOLL_PIN) {
>                         ret = arch_make_page_accessible(page);
>                         if (ret) {
>                                 unpin_user_page(page);
>                                 goto pte_unmap;
>                         }
>                 }
> Other conditions which goto pte_unmap, after successful
> try_grab_folio(), call gup_put_folio() (rather than
> unpin_user_page()).
> No change in functionality, but suggest calling gup_put_folio() here
> too for consistency.

Thanks!  Changed.
