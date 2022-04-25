Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014DE50E2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiDYOIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242346AbiDYOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:08:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE728E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:05:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E1F721107;
        Mon, 25 Apr 2022 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650895528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJObyA2VvNCOQ5pxhWXbi6DYpHUNpOCiaXo5mxpKTBY=;
        b=IiJbfz7FvTppiqEKbcNJnc+hdw/96k+xJnL1lbZHtiqD8d4xt7rEEbTMV8Pgh6G4B9cnEl
        YVVPmCiqjPf98nuoo8LtHkfDf6uXswd88bPtt8XeOrSZa+Sp5SbxkZik9qpfRh4/vhaIq8
        3RpuUUxiGlw9eu6XRrtf/aCbBATOeiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650895528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJObyA2VvNCOQ5pxhWXbi6DYpHUNpOCiaXo5mxpKTBY=;
        b=BMLozMliSyP605RXXjF71b8mw8N/15hTcG984/geD52UO9nx3u579qZV143iVShntNDoyo
        +SX17djlShzB7kAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61E0B13AE1;
        Mon, 25 Apr 2022 14:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xpo+F6iqZmKyGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 25 Apr 2022 14:05:28 +0000
Message-ID: <8da16456-83d4-39b6-aea0-ea1dd451538b@suse.cz>
Date:   Mon, 25 Apr 2022 16:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 02/23] mm/slab: cleanup slab_alloc() and
 slab_alloc_node()
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
 <20220414085727.643099-3-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-3-42.hyeyoo@gmail.com>
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
> Make slab_alloc_node() available even when CONFIG_NUMA=n and
> make slab_alloc() wrapper of slab_alloc_node().
> 
> This is necessary for further cleanup.

It also removes a lot of nearly-duplicite code.

> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
