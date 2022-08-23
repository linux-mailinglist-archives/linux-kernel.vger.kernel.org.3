Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7594459ECE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiHWTxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiHWTwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:52:42 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DF79ED6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:57:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C9265226A9;
        Tue, 23 Aug 2022 18:57:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3453A21C18;
        Tue, 23 Aug 2022 18:57:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661281064; a=rsa-sha256;
        cv=none;
        b=uKzT+YRXK/dRjQaQh4N83Ow1hQo8dDNjn0rfDvBGDg+xHFYKukgx+QxEZxMo4rrbImy97G
        Iu4oY996VZ4BdGJR212hNRkp+MtduzrGjOkJRt5ugJq9Tc7NjAgf906CsI5eVEX4KZUhbT
        FfHUNwPEoFI8zKcia35KUceH61XQzRNaTCNxry7Y9wF0VhshC/ylL22+cYYmHE6DevCoWZ
        ZZxhWSPVXxeSJJ+FUh3ZuYAWKMi6nHQiDdR7cr/OnrsFI246qd7T2FWUuHE9YNRQpw+JUP
        vPFfltPvpwurue07D+Z5aTd4kWSSiS3S8gNyGmESyx538PA/SH3Vjm4ATpMKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661281064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Tc3VDzBu61uAW3rO1cP+4NifjWG9bDMEkByxydyrgbE=;
        b=AgnA58XldV7BHVJQ4mU/EyyxrmY32KrxIjXz1G1PugkdOIGMP51TJ8X0EwWsrSi1xePBQa
        ZlmrtFsYErjQNt7R3dWwrzfT32S+3U7g0SGfwwy7gv/VKiCMowqDMeZ2U3jvWtFsqZUh5m
        e62iLawKUCCx75U7MfNyhU0JUwUYF5agds6Vy7zePN//3KJRzyrFoMxSalqTI7IkNA8h0d
        dZCLhF059EyFY+nog2Ic6kNkfm4BqD9vMI8aFaTkSuMKGYeKl0mNr8pRnxUAqb/HvuYnJR
        +GT9ppMW6Vrf/+XRVUo3J7xGufiA6X/2cD/fLZFoLkcjP6EZj8TwED+JpkmQQA==
ARC-Authentication-Results: i=1;
        rspamd-647d8dd55-nplfz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Callous: 77d87d6b3812293c_1661281064688_3672234468
X-MC-Loop-Signature: 1661281064688:1146447862
X-MC-Ingress-Time: 1661281064688
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.95 (trex/6.7.1);
        Tue, 23 Aug 2022 18:57:44 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MBz4l0c6Nz23;
        Tue, 23 Aug 2022 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661281063;
        bh=Tc3VDzBu61uAW3rO1cP+4NifjWG9bDMEkByxydyrgbE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=o+TtfmboYWA8xe4M6eBwPVA6txqwUnAfp/dlPE6tQ2QPZEwwQ6HiPKIVdwdRDWk/K
         d/fLSvwkZKJNstMtEYzwol010UzMiDn89IC2Up0siDSXLCFQA3AcDUXipi8iJ1s1E2
         PoRmUYPTmkuPJrMsDZrNoXNlttKEa1pHOY3kptizyv1ITZaExxfitnrjdBWeyVa3Zf
         DauydQFBsqs1PjA9/BFE2dCxzG84umLF6PZ/cYxnlaOxX7L4b4aHlsklkxqbnJRGBj
         /4gPh9vINBoxFG7LGUyzDKZySG55J9m0yeCQgBELXGieqI7mMoNi5YfLOo5oBhUzU1
         oKY4imCpOGPXA==
Date:   Tue, 23 Aug 2022 11:39:40 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 46/70] acct: use VMA iterator instead of linked list
Message-ID: <20220823183940.oct42fjqptqever3@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-47-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-47-Liam.Howlett@oracle.com>
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
>The VMA iterator is faster than the linked list.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
