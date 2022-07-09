Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2497856CB04
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 20:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGISJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGISJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 14:09:01 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90413F76
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=46f1t+u0Kq4NcI1QZkVhp45Lm1NWYmJTdVTOjGrUrNk=; b=S18EurgJ6GxPICZKWQJwIYB8WT
        ZNfXm1YICRPZTCNC5Gi0SkJLxZzKJOjFkHd6AXmtsRnuzItENrFUKzyQ6K1qR/YVwVdL1gLB/dgPl
        zGrsCzeMUjfty0kCTqncwJXHgfVxUuTmf4G5TmgDWqcyTH4Kb6WEPKomwMkaxkT1H3w76yF0zuz1O
        NSMYYtm/SLHRDlIuoUNrrYnvjSaTFZPLDOcKOhs5wLl5oiI/auUJJVuS1OevEI+M7cfLGOFEtDyLZ
        YefcHBYPf8qS2+LYJ1JHzPDdp4oEIQjgxsQizA1t9OUy+YqxY1z3GdrVFsNwwPduEadDcIg2eeWmH
        pT93f3x0kcDzbzspf1YaVw09SsQCIrurIIPyT7Afc/pDI28TwGNT1Ir0Ph/vibcDHM9yEVgfg/ZgB
        aUkkdaqlChzFVDzaEDLVe1WPyBJjS1NY1bGi9F4xtPxfum+Ijse/hQqTqRLBGHOpOsrZpEcbtbmWo
        OlCaLsesecYmjpKRyIL/U7F/rlrgVUJ7M+ZrtiCjRxmq9pw6ftmV0SQpJJGB1+/+y3+dno3BRqzN8
        i792Kp0D4tG4WoUWqNxlA60NI/ezCDyGvNKR4vQxrSt9zHSnOnghUcnwAbRzM87GINoSzxUTVSWow
        BCw8DzQYa04eqXB3s97fgVY0J0bgDmmbVsFYyKvxc=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Sat, 09 Jul 2022 20:08:41 +0200
Message-ID: <2211309.MyIe47cYEz@silver>
In-Reply-To: <YsmT7WHDh9NXZ/nV@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org> <1690934.P4sCSNuWZQ@silver>
 <YsmT7WHDh9NXZ/nV@codewreck.org>
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

On Samstag, 9. Juli 2022 16:42:53 CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Sat, Jul 09, 2022 at 04:21:46PM +0200:
> > > The best thing to do would probably to just tell the client it can't use
> > > the mempools for flushes -- the flushes are rare and will use small
> > > buffers with your smaller allocations patch; I bet I wouldn't be able to
> > > reproduce that anymore but it should probably just forbid the mempool
> > > just in case.
> > 
> > So the problem is that one task ends up with more than 1 request at a
> > time,
> > and the buffer is allocated and associated per request, not per task. If I
> > am not missing something, then this scenario (>1 request simultaniously
> > per task) currently may actually only happen with p9_client_flush()
> > calls. Which simplifies the problem.
> 
> Yes that should be the only case where this happens.
> 
> > So probably the best way would be to simply flip the call order such that
> > p9_tag_remove() is called before p9_client_flush(), similar to how it's
> > already done with p9_client_clunk() calls?
> 
> I don't think we can do that safely without some extra work - because
> until we get the reply from the flush, the legitimate reply to the
> original request can still come. It's perfectly possible that by the
> time we sent the flush the server will have sent the normal reply to our
> original request -- actually with flush stuck there it's actually almost
> certain it has...

Mmm, I "think" that wouldn't be something new. There is no guarantee that 
client would not get a late response delivery by server of a request that 
client has already thrown away.

What happens on server side is: requests come in sequentially, and are started 
to be processed exactly in that order. But then they are actually running in 
parallel on worker threads, dispatched back and forth between threads several 
times. And Tflush itself is really just another request. So there is no 
guarantee that the response order corresponds to the order of requests 
originally sent by client, and if client sent a Tflush, it might still get a 
response to its causal, abolished "normal" request.

Best regards,
Christian Schoenebeck


