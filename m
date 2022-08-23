Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AEB59EC11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiHWTSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiHWTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:17:57 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3661B02
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:55:11 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3A3306C2493;
        Tue, 23 Aug 2022 17:23:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a303.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 893F96C2697;
        Tue, 23 Aug 2022 17:23:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661275395; a=rsa-sha256;
        cv=none;
        b=mpsS8KvqU0nQfBJoyP0g2umtbt+nXHT9l68sysUdR99PI2YkonkTgUqv9kAYxq/+RPZO5O
        fEge4iGZ6PbzbW/mzXLwowUPgbDlKnCjSdvn5OrL7931Mo06PL47k2LR/1Dm/IGgglxFxf
        GFBKwRfUS7N8/I7XvqwHCk+T3WiWIklHky3yc7CrVv5i62SsssQ9iDVJi3o1QIXVlYZsXE
        4oWUH8MC8cBJa4s5qYCu28ZpluEO+AkwSMSMwmVb0YDP5XMyUVUVxRJMZcH/gZokLWpb7n
        1q+tn1baBthbv6tMrvSPj4SqalKcDydwS1Qt5wCabunEsd52dNtu/8Wm0OW1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661275395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=F5nzL9HfH568Np4uVuhylp3hUXCFOrFrBrP6TfqMYZo=;
        b=AUDzN3mn1Huz3AJL0xbR6ov/IUG466jbrVQpjtFfZKujn4p5nGZDULyFEsiE1IDCYJ+Ocn
        p3OalnkQE10RMkUhjla2Og7zsyvwRPiog1kcBejkSrxTdrQMjA9AxckHDe00AvU6A01ikc
        aDDf/+YNWvq9XmA6oRlCA1yeO8dsDmEcFdHp8xSIkxcGnYSyq520BDWWM0ClWDaIluEybU
        8n2wRXsz/5hHOhscsfFhZgaSMwchrfFB5fJ0sAf++ZxJCjZ34sxwogFoBzDM/3MitkYogk
        sUbh4voRWUYAZ77btcV5kdunJFb4PaYrSs6xI1Im8NFAjwdzQR+4KGV2NGMNxg==
ARC-Authentication-Results: i=1;
        rspamd-79945fd77c-b4gsd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Abortive: 2d0ee27f58a1717d_1661275396794_967258746
X-MC-Loop-Signature: 1661275396794:3782772838
X-MC-Ingress-Time: 1661275396793
Received: from pdx1-sub0-mail-a303.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.28.247 (trex/6.7.1);
        Tue, 23 Aug 2022 17:23:16 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a303.dreamhost.com (Postfix) with ESMTPSA id 4MBwzk10Lwz1X7;
        Tue, 23 Aug 2022 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661275394;
        bh=F5nzL9HfH568Np4uVuhylp3hUXCFOrFrBrP6TfqMYZo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=CMx/rfJRs4gbDbItd9+fPdQ8IYhAMBbWg5Dle1ABlQhbBOqSEYGl20erhJckC1xzV
         ZBWc9sU612LHlbg7ivtnqxvJ8eIZcH58GTitskLeSaKO0oECtEE6sqY1WdtckYJou9
         ZQCTAwtXNTF6f/HdmFofMLi1hnRXUNoLWIfXdPLJtmZqRA65fHfCr0zhr597x+QM0i
         FazP0+952qwG+bpgKE1X8R98Pm/RxvFev9jgAqGFzVByZLBMMCve5BYkAVAyBLjyc+
         GSkKbKkuNcdfpoQzEOJPoQym2T7fwrOn5GJ9FIQ26nHKJwC9SBE45mXWlpj8QGAXyc
         l/jL5vedkrTpQ==
Date:   Tue, 23 Aug 2022 10:05:10 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v13 9/70] mm: add VMA iterator
Message-ID: <20220823170510.iurgltzinbw4ta33@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-10-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-10-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
>This thin layer of abstraction over the maple tree state is for iterating
>over VMAs.  You can go forwards, go backwards or ask where the iterator
>is.  Rename the existing vma_next() to __vma_next() -- it will be removed
>by the end of this series.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>
>Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
