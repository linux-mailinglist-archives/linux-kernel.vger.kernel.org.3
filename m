Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802335AF2F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIFRn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIFRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:43:20 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C64114F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:43:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D1E2E3C1653;
        Tue,  6 Sep 2022 17:43:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a308 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 47DF93C1E5C;
        Tue,  6 Sep 2022 17:43:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662486192; a=rsa-sha256;
        cv=none;
        b=XNXjWQyUCsfRcBeKmLXo2E+aWNHepczrNRxD+a7ldWwQOZmnCqH21SGhUQ5ZEjHw5vpdAc
        PqD+qorzHq/Bg3LbhMBqZUrCyL6eerxZdQiNJhllYN4/0i+/Uav6k0xog++f4QDiiuvLzQ
        u3sabx8wKMNn8giOtEH92rVRQUlyYFcnZOWnFo7NuEvmrpzRg2F0M6vc6y3S7cbdX9XqWP
        0Yljhg9PXeI1HFVQQMz/2b7fWSIV9jIP++NTYyvZIQ++yc3g551UxaAhjcg6SBHbG/8QGn
        vs+3frXEfbqLMdsVhA+uRzc+hotfgcKJNQn895FpUCs38RHDOS1ZPQ96CJjpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662486192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4uM3JXI/NdczShkImHVmVVGhBk4bgJhdwPT9IbSXbSc=;
        b=TT9RpertFUEQ8Pp3P811JCKxQCtfy8CrxYRPUW6ZImHgxBmWKsEofECGA2HTwaD8MMTFIK
        pLX9BRT6S7p0cfJDQsIeWj3r5iB6aBmfTP5tGWOcrKOC0XmYqZK43/B7I9QJaDXG1tP3zK
        1AQwHGGH4BTTYzZcLxNkPa0RCWpXeRe3YIBUNcUKTw5vVtYC9w5c4/laV2w0KF3yQvVWyr
        xzA575OXaxNDaOr99ZoGfacBxQKyLiTbY8/lP+WZDcZfF2sRn6TmDEdk08BgOjPax0N+UW
        dBfJcrkcxgbi3/FDKG/NK8orQGYPc10zqnkfdBT5e4WYZkwXIpLEIR5md6NviQ==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-dcrf6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Left: 204c72a30266a690_1662486192591_2528582307
X-MC-Loop-Signature: 1662486192591:2062758897
X-MC-Ingress-Time: 1662486192591
Received: from pdx1-sub0-mail-a308 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.76.153 (trex/6.7.1);
        Tue, 06 Sep 2022 17:43:12 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a308 (Postfix) with ESMTPSA id 4MMXmH1s6gz2M;
        Tue,  6 Sep 2022 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662486191;
        bh=4uM3JXI/NdczShkImHVmVVGhBk4bgJhdwPT9IbSXbSc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=piQa9UHl7u1/pkzLJujfNFsDk5GuOCfNL39ObzwFY43T2l5B6xgA2gn1taHetRO1a
         pXfZwdwknV0U9sS+vmZPfKfZvSDWbl2AuZsd5Mk1oL/oaB+u5fkjfft86xfFcXlGI9
         nbW4I2TAp60EreW31SStoCqW1v6EXJ6i2W5A4Ll8HK7xONyedQcr+tWZCDpzOt9xb+
         +jM4W4RwolmTGKXGnEAJXCdrDEqFr31gKms0MuoufdITYPJ939eEFDg4nDgPM8E8Nx
         hLEeiV6CVhe6jU2sITvd12eMPd+S061S2BxzUcl5xXsamQipemnnQtJgL0zi01EfNN
         hgy+y0CoiIMRw==
Date:   Tue, 6 Sep 2022 10:24:19 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v13 53/70] mm/ksm: use vma iterators instead of vma
 linked list
Message-ID: <20220906172419.alglribva5ud36my@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-54-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-54-Liam.Howlett@oracle.com>
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
>Remove the use of the linked list for eventual removal.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
