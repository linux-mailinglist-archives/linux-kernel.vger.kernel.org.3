Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D159ED1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiHWUI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiHWUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:08:37 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB7B72A2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:26:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B73C9760992;
        Tue, 23 Aug 2022 19:26:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F34E7760990;
        Tue, 23 Aug 2022 19:26:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661282765; a=rsa-sha256;
        cv=none;
        b=v3SjIk+7BTTK2x3QunsdQKweLzerC1rkGrPcX0rqe/MX9R9FJZP00DsurjiEtLLtkKZ5la
        um5KXmP4OtzQbDHwaraHhO5M8d5LG1+vPkxz6qHqsCbSmzfpUMopIWeoZLNeDXd27r3ngj
        xOS2WN+7auj/fRGA9FxTbo7VLadndBwyP89RLLBaLVphP34kPH4+DDMw6Y5hlgVAl2yh1K
        U1936FBB4P06SQ/ytpNut0bgLx/dGms0FXRSU9IaYMT+qsf3A8MnXT5oazQl6ghJHaRN+P
        rTG7jbUPHZro0DMF1E1U15l8Qpt5dTXbffX5N5n3nV2FJCi8bFj0rNszTZ2hyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661282765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KA64pA0DH1EGqcQRpI8y0V/oDzrbveA11q1ujgABL90=;
        b=8JeJc8grHC834yW2AbLXazj12OKKw00onhq0pcvUgJu237Nx3GlNtFyBtjJbbgfo8ixgs9
        KK8lTZxU/TKggG7xh0Wji31yTqT4kPTu/68ey6vqp7A32Tb8HUZlxCPaJ9ejsxLLd5vumn
        eENwao6SCOL7hfaG+Bqs8ondVAuav6yEvw00Y8YFPSu1XBE/pqgvHWmwMptm7qfTch7F1X
        +JNHGpaR14bFghziFuXcStfRESyqdBbNyz9uJu96O+Y+6kYFyf9Udf8QLRJGBqb0+/ANaN
        ugU+Yl4waypCrEybJX1dy1oJSCwmjO3QKu8LIsIyoHaNbZMSm/uMPlJjDHOmhg==
ARC-Authentication-Results: i=1;
        rspamd-5bc49f8989-45qtk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Continue: 4a69d02274ba9850_1661282765505_3289755232
X-MC-Loop-Signature: 1661282765505:4250622656
X-MC-Ingress-Time: 1661282765505
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.95.100 (trex/6.7.1);
        Tue, 23 Aug 2022 19:26:05 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MBzjH4Z8mz1Pg;
        Tue, 23 Aug 2022 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661282756;
        bh=KA64pA0DH1EGqcQRpI8y0V/oDzrbveA11q1ujgABL90=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=AFjXoczX7kZdNXlNM2j+L8htj9RGOINSq/bAHXkiM8/1aBOh44OF7LdMzpUFg5AHG
         /l6ckv1u2gM9UGz5CxUL7gf/q8dScr3o8c4EkVAXgPFFSXtqR3njqUj3v5FjDS5UEL
         tB++k4KcHj25wc1JiHaPHHGKfmXOQ1tQRyHpbU8HdPifjab4/xE/aR7iG3VLk04Pzf
         gWbYwyJkK9VlVaqQENsRXuPRGZStuSmenw48X3LBmtmbUpo3bomdcch6N4gG6oqLdy
         KjOPe7i2/GbI325eApKuJ8IERngrajrhZz8zW1NWhJV5in4owSUPbE6iAJDEir4vnE
         REQVt2z/tRuHQ==
Date:   Tue, 23 Aug 2022 12:07:51 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 32/70] parisc: remove mmap linked list from cache
 handling
Message-ID: <20220823190751.aafh755d7stfvlb6@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-33-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-33-Liam.Howlett@oracle.com>
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
>Use the VMA iterator instead.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
