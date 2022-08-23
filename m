Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC359ECEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiHWT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiHWTzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:55:06 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5B218A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:02:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 41068200828;
        Tue, 23 Aug 2022 19:02:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 43203200F1B;
        Tue, 23 Aug 2022 19:02:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661281352; a=rsa-sha256;
        cv=none;
        b=pohZ/5FGdOh5o38XxIwB546V2RaOw/0tbVgnKfgE8UhbhI3kfHyFa0UKnWHG5007lYHVLR
        fUfDbwRBlFqdTqiOslssj9P5bbVWMfwywRhZbiBiFInlIP5fw0UnO5nMbWIAstzyFXhX+J
        bhNnOBw5lzKk4rGlEc83W71tXOk9WtwHOSPLDlMp7t0ldYVIJb39DW9eb/XWblaLqWhY08
        4zX9OClTS3xIGPh1hy59QgO9HvnMm6GRUAazkReZYHQ08N/C4HZhYUE6G4eaXqTUARGgOe
        r+1rtkIuN8WvuOfRYS26pfL/hZsFXqspOXFb14jM8z+HLPZNokAgDlD3TK9xwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661281352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KA64pA0DH1EGqcQRpI8y0V/oDzrbveA11q1ujgABL90=;
        b=NY1D0o2fNYaaHUHlHRGq9j7R5gYSS7Ds3sCCmgwc5B49bUqStC9QbLAVyr3GlsQZwl2Vqh
        Emo0E8T9YbIFLfR4D3B1Z8TYug+Yafnn2Jox9D6pFwvBD1DsgSGajFtsWvS/pFhodH1p3A
        eLUcF3XCp5DVg2gT2jP3cJi7NPvWf1xLS0bg/slzFq0/ty6G4HWHnzveqPj5jpDVwrycds
        aKuPA6NhCZIGMlXTcfhU0Mjpq1lriDwPuQehZ4pIB2N3r8gJIqimnSrrxgjxjsnLQRgzG4
        b2p4fp94Exfwucoskcqg92DO/fwxNUqe31td/kAv7IMeJB0D4wz2WbPJw4FCfg==
ARC-Authentication-Results: i=1;
        rspamd-76867cc9c5-9h98h;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Well-Made: 7dfe35ae4c357fbf_1661281352664_2202564067
X-MC-Loop-Signature: 1661281352664:568867792
X-MC-Ingress-Time: 1661281352664
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.98.142.74 (trex/6.7.1);
        Tue, 23 Aug 2022 19:02:32 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MBzBH3fRZz1Pc;
        Tue, 23 Aug 2022 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661281352;
        bh=KA64pA0DH1EGqcQRpI8y0V/oDzrbveA11q1ujgABL90=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RRW0YKjY1Gy3XjXUmeZeFyXsMrRHda8OMpH4DNAc2U0AISc//0a/kZYvCNIV02Ew3
         w5hldtALtTTNIcn4IQWkjkn4wdrVqQbVWLfDGb1rP6CGSi5IwgOGh3gJowUiuv7nVS
         AqNMDe02yLjmSoX4XzhC4uJiDSqKmS7TNqC8xt2DZIfK8YehyHBKhGIrrf8e+80C7O
         s/ih14fyeMf0rweiQukST6xyJ5mcRgxUerbFtZhoyCK5p52PBfPis/erWSaXzMZfby
         dhuuaeIZnRTsMBXKqKBrakjbPV07owBn1oSYBIh5dFWh1GNu73FiZlLOQwEx6faa6+
         wwkd6LWPX7/IA==
Date:   Tue, 23 Aug 2022 11:44:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 30/70] arm64: remove mmap linked list from vdso
Message-ID: <20220823184428.vb5pcca4zlimyoh5@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-31-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-31-Liam.Howlett@oracle.com>
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
