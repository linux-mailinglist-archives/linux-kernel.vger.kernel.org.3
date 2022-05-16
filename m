Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6D527EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbiEPHpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241241AbiEPHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:45:26 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6742495C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-68-ed;
 t=1652687124; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : content-transfer-encoding :
 in-reply-to : from; bh=pw3SQmitQZih51+UiGS5tizm1ZvzDcl0PRQC+JGIjCM=;
 b=XMiPrSOfwdfmHpqwPDiHQ5kwPpaT/PRqvzXgXk5VLI1AHwQkW4UkJ0VyzARjYPT7sJ/ZK
 VLbsUG4ljRofBY3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-68-rsa; t=1652687124; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : content-transfer-encoding : in-reply-to : from;
 bh=pw3SQmitQZih51+UiGS5tizm1ZvzDcl0PRQC+JGIjCM=;
 b=MPb39cPFMsmI2rj1zj+Pb9gyBKGgoODiK4tJuDS5g3kU6SPPoHbK9J2Vi8PiOrQqcmBWH
 YnqFj+i0LEczNHtfZVtKNfNqR3UdteLAV/EMqgllLHV0DGrGJwa0XtXbfcJl36JiM6D6skC
 HryP9WrMzduqE542Yd5cVOb/b/E/y7rx1wPFhKNnnIOb0o3rWwrqHOYlE3/S8A+ECdnwbNh
 qiuGS0uQ4Qn+dzjPnxfcR8IKK0JY876iPYoXicmLKwUH/DhoD6ej3yfPE+vpkaezBmrvfz8
 Q8c1gjNMwPRmd5SL0HtuQVkSuEYlsTDVvG02jIp84bViTY7fXy5NUOTLQQpA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 36A6E160B7F; Mon, 16 May 2022 00:45:24 -0700 (PDT)
Date:   Mon, 16 May 2022 00:45:24 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>
Cc:     michel <michel@lespinasse.org>, akpm <akpm@linux-foundation.org>,
        hughd <hughd@google.com>, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        zhangshiming <zhangshiming@oppo.com>,
        peifengl55 <peifengl55@gmail.com>
Subject: Re: Re: [PATCH] mm: fix align-error when get_addr in
 unmapped_area_topdown
Message-ID: <20220516074524.GA27455@lespinasse.org>
References: <20220412081014.399-1-lipeifeng@oppo.com>
 <20220412142238.93e36cc4095e4e0b362db348@linux-foundation.org>
 <2022041310411426044561@oppo.com>
 <2022050110235766139218@oppo.com>
 <20220501181041.6d53cb9ed54bf697840e36cc@linux-foundation.org>
 <2022050211305415626916@oppo.com>
 <20220509114521.GA9512@lespinasse.org>
 <2022051610294089439420@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2022051610294089439420@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:43:39AM +0800, lipeifeng@oppo.com wrote:
> Thank you for your reply.
> I am sorry for my late reply.

I understand, I was pretty slow to answer myself.
Let's stop it there with the apologies :)

> > This previous thread is very relevant here:
> > https://lore.kernel.org/lkml/CANN689G6mGLSOkyj31ympGgnqxnJosPVc4EakW5gYGtA_45L7g@mail.gmail.com/
>
> > I am sorry that I had confused you with the original poster on that
> > thread - your proposed changes are very similar. That said, I still
> > have the exact same concerns that I had at the time. The current
> > search algorithm is guaranteed to find a gap in O(log N) time, if there
> > is an available gap of size (requested_size + alignment - page_size).
> > The modified search only requires an available gap of the requested
> > size and alignment, but it can take O(N) time which might be too slow.
> > Maybe we could afford the slow search if it's only used as a fallback
> > when the fast search fails, but very few people would ever execute
> > that fallback and that makes it hard to test / easy for bugs to hide in.
> 
> In my opions, my new methods to search addr take O(log N) time too,
> is it right? i will only add more action to judge if the space is available
> at the same time.

Candidate gaps, large enough for an unaligned allocation of the
desired size, can still be found in O(log N) time. The problem with
your proposal, is that it might inspect and reject many candidates due
to being too small for an aligned allocation. In the worst case, there
might be candidate gaps (again, large enough for an unaligned
allocation) between every VMA, and every one of them might be too
small for an aligned allocation. That worst case then becomes O(N) as
it has to inspect and reject every vma gap.

The current allocation code avoids that issue by only looking for gaps
of size (requested + alignment - page_size), which are guaranteed to
be large enough to satisfy an aligned allocation. By being more restrictive
in the gaps it is looking for, it guarantees that the first gap returned by
the O(log N) search will always work, thus keeping the overall complexity
at O(log N). Of course, the issue is if it is so restrictive that it won't
find any gaps - the design assumption was that virtual address space
shouldn't be so saturated to make this an issue, but that doesn't seem to
hold in the use case you are trying to address....

> > If I understand your message at
> > https://lore.kernel.org/lkml/202204241833454848958@oppo.com/ ,
> > it seems like some andoid apps such as wechat are filling up
> > a 32-bit address space such as there is no 13MB gap available anymore
> > (as would be required by the current search), but there are still some
> > 12MB gaps aligned on a 1MB boundary, which they are then trying to
> > allocate from. It seems very odd to me that one would find themselves
> > in that situation, could you give us some details as to how that happened ?
> > Do you know what the app is trying to do to fill the address space that way ?
> > Also, why is this odd behavior considered to be a kernel issue - was the
> > app previously running on a (quite old !) kernel that didn't have the fast
> > vma gap search, and is now failing when ported to a more recent kernel ?
> 
> 1. Wechat just one of the case we found to space unsuccessfully by the old way,
> others app, like sgame、taobao and so on， which have been found the same
> issue(The allocated size is 1M~12M). Unfortunately, we can not see how the 
> above apps operate.

Are such apps running on current android devices ? If so, how ? Do these
devices ship with kernel patches similar to what you are proposing ?
Or, are they based on a kernel that is so old (we are talking 8+ years now)
that it doesn't have the current fast gap search algorithm ?

--
Michel "walken" Lespinasse
