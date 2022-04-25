Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB51450E3F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiDYPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiDYPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:08:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD151CB39
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:05:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0ECA1F38C;
        Mon, 25 Apr 2022 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650899113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBEJde7HmMjpZPIKQmjCCQNUxa3QYK/CoOSg2fUy1tk=;
        b=XhhWM594h95ari0tdbBii/P1aAk/1YlBol6QC3key4ppSAKgIUwKbnIM+b707W27+P8zbc
        rBFP8zed+7jLfotZqDnBRzCORb/GVusJrzEL2tgmcz/ZSfOHv9I8sBPyjDYyucv5bAui1h
        oMvv3tuZxPDIPGBrZ1AxRmqjXJQYJW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650899113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBEJde7HmMjpZPIKQmjCCQNUxa3QYK/CoOSg2fUy1tk=;
        b=KW+mKznRaF0U4IZ11C6dpQPjko3ITyl0uWPORR7h7j4+DTLs5hBuAneC2QWG22X4FPwa8v
        k5i/TbHYHXvTcrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91BE313AED;
        Mon, 25 Apr 2022 15:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tSHzIqm4ZmLRNwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 25 Apr 2022 15:05:13 +0000
Message-ID: <0cce13c3-7ba4-0dce-6cf2-0483cfda9d70@suse.cz>
Date:   Mon, 25 Apr 2022 17:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 04/23] mm/slab_common: cleanup kmalloc_track_caller()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-5-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-5-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 10:57, Hyeonggon Yoo wrote:
> Make kmalloc_track_caller() wrapper of kmalloc_node_track_caller().

Looks like there's an immediate benefit of SLUB not throwing away the caller
pointer anymore in case of kmalloc_large().

> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

