Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4510F59EC49
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiHWT3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiHWT2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:28:48 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9152656D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:16:41 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 83DAF8211C9;
        Tue, 23 Aug 2022 18:16:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 310AC8212CC;
        Tue, 23 Aug 2022 18:16:05 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Cellar: 5f1b862130e65e7d_1661278565317_288383550
X-MC-Loop-Signature: 1661278565317:4101689764
X-MC-Ingress-Time: 1661278565317
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.39.201 (trex/6.7.1);
        Tue, 23 Aug 2022 18:16:05 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MBy8g6lxHz1Ps;
        Tue, 23 Aug 2022 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661278564;
        bh=ka2UQRT5HOjSJbWMg7rgorjNdoSraGEbpYAlNimsWCc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=N/HrRMlaPWF6QfW0rnQTDBqxcWgRjtKIRGYW3jSojDKzREZuLdu6Z993iylP2sey9
         8Ntno27V0EZCOMyLnFgzjYdLXq23JvqOBVV6dOYSSrPWEbGPtwzVimWzgasG+55wgq
         +azWnBj0AnjS+X44e9mZtLpfEb7NzUhof4icYIpIZyhDb9/0f3Aym0t4fSo7UfE4Aa
         1CduIN/mYdaiUfYAobEd2rpQl1hA8Gs8X+gToUOmVhB/Nca/9XNiSvPEhRxyhX01e/
         whL8GFFyfsFBQsfuZH3IXi/iiROtPlC47LMaT9bBHkD3tgSA5Z24+NBIa6icuz1DZD
         7G+jW+GF/02KQ==
Date:   Tue, 23 Aug 2022 10:58:00 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 35/70] x86: remove vma linked list walks
Message-ID: <20220823175800.jcwptrlfi4gcjkuf@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-36-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-36-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Yeah all these are nice, I always hated the raw for-loop thing.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
