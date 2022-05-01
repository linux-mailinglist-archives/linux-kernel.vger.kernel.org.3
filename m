Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB475167CF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354705AbiEAUll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiEAUlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:41:39 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B63F49C9C
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 13:38:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C15446C0A3E;
        Sun,  1 May 2022 20:38:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3D0D66C08A7;
        Sun,  1 May 2022 20:38:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651437489; a=rsa-sha256;
        cv=none;
        b=hULsUQVft86mznR4tDpZFynazbDM5OaSjsOXlnH8wQin8ftD4B4/ccKJCcFqx+GiN1Qw6n
        brYHAIzrj2mUsXL8fbigy0H2Pf9ksvS2oflAbpHa1lk8LTKwvhaY1lKmlFu2uhOIYOyHVi
        oxYp0RuIoviib/yhvuS2BZBV3J7OQQcPnQtc30L4hRnJskWg0pA02U34RcmbOOao8odmZU
        Qf58BSZahTgmAyqCSAy9RoTKRwQzdBfMVKEMVXfiraiJhTNwtm+WQ28vWfq1BmLk+zLrtv
        pO30ifPN7jhrOK6EpqnXagbAUBjdoeOSl/Wy0pXtJxBZAofqkJJPkEs6Yfp4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651437489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=tCCVnocf3mgYD9VNhEdRpcvRc6dfJeJKHpburFD1alE=;
        b=VVtjkx8TnTok11Tnw2x0VLh7sByH7sTOkKM3+/AZGkZ/0ZCp09N47UWNGXKHccKUgPYJ/L
        GA4YTRZLSPG1KfomlolUfKDn1UCPV4KYzj6i1SyqgslFKfzGMB3R7Dm/cWbrIRhu5t0iD6
        BsI8OYLSfzlsycuPdntrtTN+01EUdzdVakeJfXnJ3GZWTv4CbyNUHGvcNQAwp1YoL1n4eX
        c9ecuRkY/YuAEfUPUYLbpiFhgtxbwduVseNO7k6O++aFlgJhj2pDfuwTKJxL5nPM4x+HSy
        ZxvBhzET6kHSXOiQHAjWZFNe8wh8X0BrO2r2QqZiZjqjXymBhPTHKkEvm7T4YQ==
ARC-Authentication-Results: i=1;
        rspamd-847dd8955c-v74k9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Average-Gusty: 3dc8d98f065d0d91_1651437489555_2285623474
X-MC-Loop-Signature: 1651437489555:4050904530
X-MC-Ingress-Time: 1651437489555
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.55 (trex/6.7.1);
        Sun, 01 May 2022 20:38:09 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4KryjD46VXz3N;
        Sun,  1 May 2022 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1651437489;
        bh=tCCVnocf3mgYD9VNhEdRpcvRc6dfJeJKHpburFD1alE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=UPvpLYfbJ2bOSCBFt/X2+o0JSM2pH3gHgWHgBQvOg/Rj9JvpyqL23UFh4uX4SLx/t
         QbPfYMKb6dmlZKoHpAmbrtfu3KUdlHWgTdHiaZoWWwJXS5Wj4ETxlthiPlqxfwAghj
         oFT9Sk4WbEYhYSy2fg8Jd7algK7jOYKA0BNtlP0qmeYWOx2a81azHmRb3KC2alPzso
         MjM70/+F/IHygPnXNBp4Dpf81weDDnvqRzQFlZ9s9aI32mg91UBQi5AEXe1EwAryyH
         JG9P2Yjq4Vr9zAYronRvGK74pNwCcs5/SVIvLCY8GrTp//i2IJTuFsCQtQiVNtUoiF
         Nmh/nsC8khXIw==
Date:   Sun, 1 May 2022 13:26:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Message-ID: <20220501202532.y6zmznzshbe33nwx@offworld>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
 <20220427140832.mpvnnkkhrbupk46i@revolver>
 <20220427103331.9876ad87626af0f50e9ced0d@linux-foundation.org>
 <YmmHqlR6lV84KDrO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YmmHqlR6lV84KDrO@casper.infradead.org>
User-Agent: NeoMutt/20220408
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022, Matthew Wilcox wrote:

>On Wed, Apr 27, 2022 at 10:33:31AM -0700, Andrew Morton wrote:
>> On Wed, 27 Apr 2022 14:08:39 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
>> > The benchmarks are around the same as they have always been.
>>
>> So it's presently a wash.
>>
>> That makes "the plan" (below) really critical, otherwise there seems
>> little point in merging this code at this time?
>>
>> Please send me many very soothing words about how confident we should
>> be that the plan will be implemented and that it shall be good?
>
>Yes, performance-wise it's a wash.  However, Davidlohr was very
>impressed that it was a wash because we're actually getting rid of three
>data structures here; the linked list, the rbtree and the vmacache.
>His opinion was that we should push the maple tree in now, in advance
>of the future RCU uses.

Yes I like the maple tree, and at this stage I don't think we can ask
for more from this series wrt the MM - albeit there seems to still be
some folks reporting breakage. Fundamentally I see Liam's work to (re)move
complexity out of the MM (not to say that the actual maple tree is not
complex) by consolidating the three complimentary data structures very
much worth it considering performance does not take a hit. This was
very much a turn off with the range locking approach, which worst case
scenario incurred in prohibitive overhead. Also as Liam and Matthew
have mentioned, RCU opens up a lot of nice performance opportunities,
and in addition academia[1] has shown outstanding scalability of address
spaces with the foundation of replacing the locked rbtree with RCU
aware trees.

[1] https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf

Thanks,
Davidlohr
