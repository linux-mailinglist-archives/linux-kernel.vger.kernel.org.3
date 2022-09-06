Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318285AF25A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiIFRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiIFRXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:23:53 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B3E1174
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:13:26 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9BD61244D9;
        Tue,  6 Sep 2022 17:03:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a211 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 06010243F8;
        Tue,  6 Sep 2022 17:03:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662483801; a=rsa-sha256;
        cv=none;
        b=E2y03BNxBwAqPGD9j/klRrUhOLRg1DHMmgcpXfZvxtUFgB3wtLSssnE5/E4lsllXqpQdxS
        RXfjrnSukVejqKIdfDxKU/RXntj8i4zjKBrMctmOxqBiSyiAGVPx97GUkAF5nXUq8N7jiN
        pLmGv9ZqfJ7Q3JareoYQns8YJ2/YSSYPmPFnXaayuQslwcfshsG2Jjce1ep/wuTcs7Vox/
        BzEkMc7+v1bgmDXx01R+mGec69eGTNqYEro/6L+LOKyYET8mtkmCgtArHTguz4fNhuhQ6U
        l2WRmlOfg1uvNf4DsTmFNEFRLKdw3qCVCirFszYkkF+J9iqVVhEsZ29DZer2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662483801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=N32HfuhhnfeHarM18aMVEJqc8JufvAgUqbvlbBuKwoc=;
        b=xqBBi2hT57+VL57ovpngNvxL5A1rpRv/Zl5tXZjSbcPQaPMBxXSRY6PL/5cS/EvW4xy9+S
        1LsFLuobbmD4brr9H3v00AUsf2+5H7+M80WefDgsksKkGEVCPbcGeRkm6djUVj7/SyfBpo
        tcgvfAiSGCxzFh/zwLWFJS2Ip9MQ8y+vekefPSNEmvL2vBwjyPSCNwrnpr/4QC6/f3bq5i
        F1q76YK4dp+Dr42wbQXsjxu4Bn63V9FCKpZ7/h/X1Iwwa/s4gwyu+1/Fc+1guouEzHQZWN
        OheQZhJBn5yCW0uI+pOsZOqZ590PnTEnbU/hM+BTtLiS/93i4//Qd2I16ku6bg==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-rh7xz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Print: 6c9d91311b786575_1662483801304_2823308170
X-MC-Loop-Signature: 1662483801303:2346365659
X-MC-Ingress-Time: 1662483801303
Received: from pdx1-sub0-mail-a211 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.199 (trex/6.7.1);
        Tue, 06 Sep 2022 17:03:21 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a211 (Postfix) with ESMTPSA id 4MMWtJ26D7z36;
        Tue,  6 Sep 2022 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662483800;
        bh=N32HfuhhnfeHarM18aMVEJqc8JufvAgUqbvlbBuKwoc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Ehl6zWD+Zkxi1JdYmgeFf0x9uHkIIsKZIgKadeFd14Wrl0WWcyGTXeN0h60qL5ddJ
         xo9SsnVtpPZLM3oYjQRv2idAP34kSx+Pvg+2+kdy0W/MHXHTOcPZeYNriB5KKS43kk
         IkcKRWyyXCLXF37mQ6dDoh1aihyaiwYt6HwqwX0BDDTd4kwFZDI1bQxZ3m7lEWxgre
         +FvoHF5JrxiQ7Y7vK7dnDWTwZHvbIM3PFw2U+i2kNv9m5MtNPoTOsVPYoSDBU62TCZ
         XDz4rGsHUwZLqT3bJcoj7iBlxhDwiK0HCJpH6R1SBPXbewbUwJSWL1tIboOUuuWFvY
         Z2+DL9v2NBQSw==
Date:   Tue, 6 Sep 2022 09:44:29 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 51/70] mm/gup: use maple tree navigation instead of
 linked list
Message-ID: <20220906164429.jvjkkjnj6ciyovvq@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-52-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-52-Liam.Howlett@oracle.com>
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

>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
>Use find_vma_intersection() to locate the VMAs in __mm_populate() instead
>of using find_vma() and the linked list.
>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
