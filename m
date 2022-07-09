Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4487156CB71
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 22:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGIUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGIUu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 16:50:56 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74251C11A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 13:50:54 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 952DAC01E; Sat,  9 Jul 2022 22:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657399851; bh=IZYKQZ0SgUrjhwiiWYrMW2KFbfL/cbLmW34yba21SVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeWMN8gsxQTP3CL1U/HqqEfGrLDpSq/nGdG5QqcAEIyiyY2MIirtosmlSp/s0LnZH
         STcxa01waMyR5GpGnytW+UofZGjyuvUFb5ahtFFfUv12xiKCYF1jKhwJcRhyOdmXSU
         BCn5hL5XlPyQrIxyJHDWWhvcPtCahQUZ41iWLjDBsP2qRpzvUX+Ji5yI7VahcnsrBO
         Cwgrwqj0pZXt4e4cA3X6Qt7VuS+Z9EF7tznwzgbpr4oC2XGXeVvV1H8s0J+pwt161I
         L7PcE8yNFkQjQjMgNG/Pmv2mImRtPrLGV4m2jD3bsQfHsJKZ0tXXUEwaYw5i3XQD1S
         tJtZT35CWrmGg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C5D4AC009;
        Sat,  9 Jul 2022 22:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657399850; bh=IZYKQZ0SgUrjhwiiWYrMW2KFbfL/cbLmW34yba21SVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vyYDFbfPd4pYJVDwVN2bH+shV/fnUCBC88bNsahNxWJvGo+ejGX9c5VnWkMU3qMdc
         DjOAhYqe2ZPk0Oo/UKsy1mJmOdYK7AlKaMquRWVGZLckKLPok7z7toeIN9JvPti648
         PMzC+j4C1GdHy0v24Ktb7YxtKP06Uzy/rZUrt8bUqr0FhrjI6mK6/OLvHfDvIHbje7
         J4SYOd1568VbQGmtn4bOK0J3waAOcmyWsvjwgDvyl5Nr+oiXBAaUiviu3INTlR669A
         E7wHid4G+gdeYN3fGi5g8Hnwo0SdCa7q/ctOjVxJiRZzmX3UXS+LxSgMjFrd04COxw
         kibhraAA+ywJQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id d7408ffe;
        Sat, 9 Jul 2022 20:50:45 +0000 (UTC)
Date:   Sun, 10 Jul 2022 05:50:30 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <YsnqFqQodj9khp3Q@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <1690934.P4sCSNuWZQ@silver>
 <YsmT7WHDh9NXZ/nV@codewreck.org>
 <2211309.MyIe47cYEz@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2211309.MyIe47cYEz@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Sat, Jul 09, 2022 at 08:08:41PM +0200:
> Mmm, I "think" that wouldn't be something new. There is no guarantee that 
> client would not get a late response delivery by server of a request that 
> client has already thrown away.

No. Well, it shouldn't -- responding to tflush should guarantee that the
associated request is thrown away by the server

https://9fans.github.io/plan9port/man/man9/flush.html

Order is not explicit, but I read this:
> If it recognizes oldtag as the tag of a pending transaction, it should
> abort any pending response and discard that tag.

late replies to the oldtag are no longer allowed once rflush has been
sent.

But I guess that also depends on the transport being sequential -- that
is the case for TCP but is it true for virtio as well? e.g. if a server
replies something and immediately replies rflush are we guaranteed
rflush is received second by the client?


There's also this bit:
> When the client sends a Tflush, it must wait to receive the
> corresponding Rflush before reusing oldtag for subsequent messages

if we free the request at this point we'd reuse the tag immediately,
which definitely lead to troubles.


> What happens on server side is: requests come in sequentially, and are started 
> to be processed exactly in that order. But then they are actually running in 
> parallel on worker threads, dispatched back and forth between threads several 
> times. And Tflush itself is really just another request. So there is no 
> guarantee that the response order corresponds to the order of requests 
> originally sent by client, and if client sent a Tflush, it might still get a 
> response to its causal, abolished "normal" request.

yes and processing flush ought to get a lock or something and look for
oldtag.
Looking at qemu code it does it right: processing flush find the old
request and marks it as cancelled, then it waits for the request to
finish (and possibly get discarded) during which (pdu_complete) it'll
wake the flush up; so spurrious replies of a tag after flush should not
be possible.

--
Dominique
