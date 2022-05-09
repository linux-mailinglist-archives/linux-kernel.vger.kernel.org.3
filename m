Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2E51FBC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiEIL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiEIL6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:58:25 -0400
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 04:54:31 PDT
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE81BDADC
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-67-ed;
 t=1652096721; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : content-transfer-encoding :
 in-reply-to : from; bh=A7VZnkOooDmMVt0zmVkAt2c4XohtDtf3/DK9V1jJLOM=;
 b=6NIYylgjhPZog+yLwPODPJcIfvcr2ocFDpkqISi70tNxjI7/Rel1tXmowCuX+rKmvyQ0t
 U5XYZcoyTYbdnViCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-67-rsa; t=1652096721; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : content-transfer-encoding : in-reply-to : from;
 bh=A7VZnkOooDmMVt0zmVkAt2c4XohtDtf3/DK9V1jJLOM=;
 b=QqIDruEzcYTOkudQdoZ/epVo8dv8ZoFkhL3ztjpET6S2nM91npiPlvF4tBDb2OrJ9Zlqf
 4gfNS9L6uVA9/dFOQw2eL/CnoRcplDDly4lIDHp6oGZ7oglzlelpg/9fZaYmFHuKCDuI3rS
 AN+WY15QcCV1Io2u9sjbqv9xOaSI53TwnmZGB4/RiGqxOHkMLCzUVrfiFknVF0rKZE5ikWx
 6Ynasu07e15ty34sCnZI0ejeYOf5XaT/ptwLTnxBZ0oybifX/2JPjA4UDiZ9hE1/zVSOiKj
 R253BT8DQBBh764iBmuw7+zSmw3GGes4T6fXtv2XPuSVDau7gRDm+7UUGIlw==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 5C500160B4E; Mon,  9 May 2022 04:45:21 -0700 (PDT)
Date:   Mon, 9 May 2022 04:45:21 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>
Cc:     akpm <akpm@linux-foundation.org>, michel <michel@lespinasse.org>,
        hughd <hughd@google.com>, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        zhangshiming <zhangshiming@oppo.com>,
        peifengl55 <peifengl55@gmail.com>
Subject: Re: Re: [PATCH] mm: fix align-error when get_addr in
 unmapped_area_topdown
Message-ID: <20220509114521.GA9512@lespinasse.org>
References: <20220412081014.399-1-lipeifeng@oppo.com>
 <20220412142238.93e36cc4095e4e0b362db348@linux-foundation.org>
 <2022041310411426044561@oppo.com>
 <2022050110235766139218@oppo.com>
 <20220501181041.6d53cb9ed54bf697840e36cc@linux-foundation.org>
 <2022050211305415626916@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2022050211305415626916@oppo.com>
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

On Mon, May 02, 2022 at 11:33:18AM +0800, lipeifeng@oppo.com wrote:
> Hi Andrew：
> 
> Thanks for your quick response.
> 
> > They caused me some merge issues against mapletree, which I had
> > resolved.  Mapletree is dropped at present so I set these patches aside
> > until the next version of the mapletree patches are available.
> 
> Do we have a definite time for the next available version of the mapletree patches?
> Excuse me, is it possible for our patch to be independent of mapletree and brought in separately?

I think it's unavoidable that there will be a conflict with maple tree
because they are changing the way we track gaps between vmas.

> > I've been holding your patches until Michel Lespinasse has had time to
> > review them (and hopefully explain them to me ;)).  Please review
> > earlier comments which Michel has provided and ensure that those
> > comments have been fully addressed so we can hopefully move forward on
> > this.
> 
> We will reply soon if Mr.Lespinasse provideds any advices or question.
> And I haven't received any reply from Mr.Lespinasse yet, pls let me know
> if I missed the reply.

This previous thread is very relevant here:
https://lore.kernel.org/lkml/CANN689G6mGLSOkyj31ympGgnqxnJosPVc4EakW5gYGtA_45L7g@mail.gmail.com/

I am sorry that I had confused you with the original poster on that
thread - your proposed changes are very similar. That said, I still
have the exact same concerns that I had at the time. The current
search algorithm is guaranteed to find a gap in O(log N) time, if there
is an available gap of size (requested_size + alignment - page_size).
The modified search only requires an available gap of the requested
size and alignment, but it can take O(N) time which might be too slow.
Maybe we could afford the slow search if it's only used as a fallback
when the fast search fails, but very few people would ever execute
that fallback and that makes it hard to test / easy for bugs to hide in.

If I understand your message at
https://lore.kernel.org/lkml/202204241833454848958@oppo.com/ ,
it seems like some andoid apps such as wechat are filling up
a 32-bit address space such as there is no 13MB gap available anymore
(as would be required by the current search), but there are still some
12MB gaps aligned on a 1MB boundary, which they are then trying to
allocate from. It seems very odd to me that one would find themselves
in that situation, could you give us some details as to how that happened ?
Do you know what the app is trying to do to fill the address space that way ?
Also, why is this odd behavior considered to be a kernel issue - was the
app previously running on a (quite old !) kernel that didn't have the fast
vma gap search, and is now failing when ported to a more recent kernel ?

> Thank you very much indeed.
> 
> lipeifeng@oppo.com
>  
> From: Andrew Morton
> Date: 2022-05-02 09:10
> To: lipeifeng@oppo.com
> CC: michel; hughd; linux-mm; linux-kernel; Barry Song; zhangshiming; peifengl55
> Subject: Re: [PATCH] mm: fix align-error when get_addr in unmapped_area_topdown
> On Sun, 1 May 2022 10:26:35 +0800 "lipeifeng@oppo.com" <lipeifeng@oppo.com> wrote:
>  
> > Why did the two patches suddenly disappear without any email or notice for us?
> > And they had been merged in linux-next.git on April 5 and 13.
>  
> They caused me some merge issues against mapletree, which I had
> resolved.  Mapletree is dropped at present so I set these patches aside
> until the next version of the mapletree patches are available.
>  
>  
> I've been holding your patches until Michel Lespinasse has had time to
> review them (and hopefully explain them to me ;)).  Please review
> earlier comments which Michel has provided and ensure that those
> comments have been fully addressed so we can hopefully move forward on
> this.
>  
>  
