Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0673255CA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiF0Jaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiF0Jaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:30:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E04125DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IokvEg/kIxjdCTozh/TqGPoHY64HoI20u+uoITAFI+4=; b=oV7q+l4Rua4HzPC6b1q5Btq6wY
        BI5So1sA7UW9Nn2pxg0Yja6EZdZH69RNGRVbk+rve17K9JyEaRJHpZabTCPOewiopvWKXJdThI8Jy
        tKwuxq2Zq7A8pHhAzHApV7F0WxT/FWnT2AIbn0pB7B+B3NfLOdSMv2ph1jp1iwqofgetvI0C4Nghd
        HgdvDH/K/2bgcJLVwvZCAiVVCgsLna9F8SpbWIO052Rry94x5fKBuJP00zaw9e/yNCxoGayknXwUT
        ruo01fc8FRSUvp1Ra3a78LGoWG9leNDfB7r6uaIX7cEqUTYklW4GPI7Z9B7PUKOTc4oSu9jqCqwds
        4qL0IpWA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5l4X-00BEZD-Hr; Mon, 27 Jun 2022 09:30:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F132F30045A;
        Mon, 27 Jun 2022 11:30:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB8F020C57C6B; Mon, 27 Jun 2022 11:30:18 +0200 (CEST)
Date:   Mon, 27 Jun 2022 11:30:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Hui <guohui@uniontech.com>
Cc:     longman@redhat.com, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        boqun.feng@gmail.com, virtualization@lists.linux-foundation.org,
        wangxiaohua@uniontech.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/paravirt: useless assignment instructions cause
 Unixbench full core performance degradation
Message-ID: <Yrl4qoXcVj9Y6Cpa@hirez.programming.kicks-ass.net>
References: <f6b68466-968c-4a91-655a-23970280a072@redhat.com>
 <20220627021350.25714-1-guohui@uniontech.com>
 <YrlhGqqce0NCQ6hi@hirez.programming.kicks-ass.net>
 <3c020577-2045-fa12-9e33-65ece10bda30@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c020577-2045-fa12-9e33-65ece10bda30@uniontech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 05:18:02PM +0800, Guo Hui wrote:
> Ok thanks Peter, your suggestion is very good, I will modify my patch as you
> suggested.

Because it messes up the order in which people normally read text.
Why is top-posting such a bad thing?
Top-posting.
What is the most annoying thing in e-mail?
