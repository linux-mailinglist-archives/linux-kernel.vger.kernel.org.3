Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9957487B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbiGNJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiGNJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:19:16 -0400
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36F724BD9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:16:32 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id ED319B0028E; Thu, 14 Jul 2022 11:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1657790159; bh=32hwBy0u3/431+faOWAMGVXWX8xeJyN/BOQ9pzsMuOc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=xDw5deeaOdaaXyFY5w2uRpXZqhwlePLrMk4hMaLuuhKWpFcjV947IocSt5ERy3Tdx
         k/XbxvqYbjcn7QgQuWL5mZJoyOmk8BZBDc/FpXsJmyWyZzj+BLH72+eZOK7NkBw0Ty
         W8RkBVNsoVA07SxBEMUzERVAuK89CxFBVwF7gv+58r3jVa5/cL8pLnQFVS/cYzn1KX
         CQ3xqb+vCzIAOS7FQksZX7h8PB9PoipmKYvnvLwEDFepUWb2d8Ud4D5/0MTINSBr+u
         cEuMOLN1xu1E3e0qlX0Mly4sNdgDn4gb0lz7280QQlzc9kePgcgrDx04QAmiFTdWhA
         x91A2HD/88V+A==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id EBC0AB00266;
        Thu, 14 Jul 2022 11:15:59 +0200 (CEST)
Date:   Thu, 14 Jul 2022 11:15:59 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marco Elver <elver@google.com>
cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 16/16] mm/sl[au]b: check if large object is valid in
 __ksize()
In-Reply-To: <CANpmjNPbbugrbCFADy1C7PgaU-4PMd9UK90QiHKS-Md0ocqa3w@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2207141115050.184626@gentwo.de>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com> <20220712133946.307181-17-42.hyeyoo@gmail.com> <alpine.DEB.2.22.394.2207121701070.57893@gentwo.de> <Ys6Pp6ZPwJTdJvpk@ip-172-31-24-42.ap-northeast-1.compute.internal> <alpine.DEB.2.22.394.2207131205590.112646@gentwo.de>
 <CANpmjNPbbugrbCFADy1C7PgaU-4PMd9UK90QiHKS-Md0ocqa3w@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022, Marco Elver wrote:

> We shouldn't crash, so it should be WARN(), but also returning
> PAGE_SIZE is bad. The intuition behind returning 0 is to try and make
> the buggy code cause less harm to the rest of the kernel.
>
> >From [1]:
>
> > Similarly, if you are able to tell if the passed pointer is not a
> > valid object some other way, you can do something better - namely,
> > return 0. The intuition here is that the caller has a pointer to an
> > invalid object, and wants to use ksize() to determine its size, and
> > most likely access all those bytes. Arguably, at that point the kernel
> > is already in a degrading state. But we can try to not let things get
> > worse by having ksize() return 0, in the hopes that it will stop
> > corrupting more memory. It won't work in all cases, but should avoid
> > things like "s = ksize(obj); touch_all_bytes(obj, s)" where the size
> > bounds the memory accessed corrupting random memory.

"in the hopes that it will stop corrupting memory"!!!???

Do a BUG() then and definitely stop all chances of memory corruption.

