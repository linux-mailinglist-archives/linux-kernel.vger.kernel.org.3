Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0376556CFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGJPRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGJPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:17:04 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C8DCE25
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=N0rqnDTrHAjPRGrAyMQmskD/2xe+zwWD0acZaTVuWqg=; b=uzP+h+7p/LPKqky6+oL+o9lJCW
        gNsBo1+ZVbzTfTzJnAMimxbKk51ZOdKi243xGClR5xNl5/7DTpXWu2xVH6f25q3uXzR8ZIqekZchz
        VNEvnpEG+RHh4mY+b/aDxq6sfSkK524/hQe5sQX1nxk4gX2/kI7mtNEMIX0JoTQZW7B+kqergTg+J
        UyKkAs9TOg806l73tUL7xyxle5AQeXuRcreik+5WPCOrKpuLnpvXUMytM3HBxTaQ68ekUr0tPscnZ
        AKwouTjNjtsCqONpvVcC1TF5fkCimTfr4QlY2U1wMJx1kl3EnKQMnDfmBALrCDhNepQioemd4/d/4
        P8MkF9DS0ll1G+SmzH3hXMokCHXwmMXJp4cxbeesVBhldDx419dZIQRzT/r3EOJJRNWmwNGvM8vQy
        CCROas6fEwTy17Z8emdpWwg8N4lMIb668Dydwo8l6QO0I55w1+pU4P9WuWhDDzffjJLjibhO7P2k1
        40ds9zkCtPkk82GPWjrudPRVK/jbpQNgE9QN7T8oPKI/ihrhDCVA2vUw65IclrRKRIcNaNUl+HoR2
        z7VLXUhLV6hDZtuA2Lgvqjh1u2MXP+F43FgDStuLu5Sj1AQUvdY8m+luePiHA1aqxJ/vuXEiPkeCw
        xmfTJcJITnVhJYvhlOwsqjIS28bMl65e7NjYjW3Jg=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Sun, 10 Jul 2022 17:16:45 +0200
Message-ID: <12950409.o0bIpVV1Ut@silver>
In-Reply-To: <YsrR/M+fna44trHm@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org> <13813647.qg49PginWZ@silver>
 <YsrR/M+fna44trHm@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 10. Juli 2022 15:19:56 CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Sun, Jul 10, 2022 at 02:57:58PM +0200:
> > On Samstag, 9. Juli 2022 22:50:30 CEST Dominique Martinet wrote:
> > > Christian Schoenebeck wrote on Sat, Jul 09, 2022 at 08:08:41PM +0200:
[...]
> > > late replies to the oldtag are no longer allowed once rflush has been
> > > sent.
> > 
> > That's not quite correct, it also explicitly says this:
> > 
> > "The server may respond to the pending request before responding to the
> > Tflush."
> > 
> > And independent of what the 9p2000 spec says, consider this:
> > 
> > 1. client sends a huge Twrite request
> > 2. server starts to perform that write but it takes very long
> > 3.A impatient client sends a Tflush to abort it
> > 3.B server finally responds to Twrite with a normal Rwrite
> > 
> > These last two actions 3.A and 3.B may happen concurrently within the same
> > transport time frame, or "at the same time" if you will. There is no way
> > to
> > prevent that from happening.
> 
> Yes, and that is precisely why we cannot free the buffers from the
> Twrite until we got the Rflush.
> Until the Rflush comes, a Rwrite can still come at any time so we cannot
> just free these resources.

With current client version, agreed, as it might potentially incorrectly 
lookup a wrong (new) request with the already recycled tag number then. With 
consecutive tag numbers this would not happen. Client lookup with the old tag 
number would fail -> ignore reply. However ...

> In theory it'd be possible to free the buffers for some protocol and
> throw the data with the bathwater, but the man page says that in this
> case we should ignore the flush and behave as if the request behaved
> properly because of side-effects e.g. even if you try to interrupt an
> unlink() call if the server says it removed it, well, it's removed so we
> should tell userspace that.

... good point! I was probably too much thinking about Twrite/Tread examples, 
so I haven't considered that case indeed.

> > > > When the client sends a Tflush, it must wait to receive the
> > > > corresponding Rflush before reusing oldtag for subsequent messages
> > > 
> > > if we free the request at this point we'd reuse the tag immediately,
> > > which definitely lead to troubles.
> > 
> > Yes, that's the point I never understood why this is done by Linux client.
> > I find it problematic to recycle IDs in a distributed system within a
> > short time window. Additionally it also makes 9p protocol debugging more
> > difficult, as you often look at tag numbers in logs and think, "does this
> > reference the previous request, or is it about a new one now?"
> 
> I can definitely agree with that.
> We need to keep track of used tags, but we don't need to pick the lowest
> tag available -- maybe the IDR code that allocates tag can be configured
> to endlessly increment and loop around, only avoiding duplicates?
> 
> Ah, here it is, from Documentation/core-api/idr.rst:
> 
>   If you need to allocate IDs sequentially, you can use
>   idr_alloc_cyclic().  The IDR becomes less efficient when dealing
>   with larger IDs, so using this function comes at a slight cost.
> 
> 
> That would be another "easy change", if you'd like to check that cost at
> some point...

Nice! I'll definitely give this a whirl and will report back!

> (until we notice that some server has a static array for tags and stop
> working once you use a tag > 64 or something...)

That would be an incorrect server implementation then, a.k.a. bug. The spec is 
clear that tag numbers are generated by client and does not mandate any 
sequential structure.

> Anyway, this is getting off-topic -- the point is that we need to keep
> resources around for the original reply when we send a tflush, so we
> can't just free that buffer first unless you're really good with it.
> 
> It'd be tempting to just steal its buffers but these might still be
> useful, if e.g. both replies come in parallel.
> (speaking of which, why do we need two buffers? Do we ever re-use the
> sent buffer once the reply comes?... this all looks sequential to me...)

Yep, I was thinking the exact same, but for now I would leave it this way.

> So instead of arguing here I'd say let's first finish your smaller reqs
> patches and make mempool again on top of that with a failsafe just for
> flush buffers to never fallback on mempool; I think that'll be easier to
> do in this order.

OK then, fine with me!

No time today, but I hope to post a new version next week.

Best regards,
Christian Schoenebeck


