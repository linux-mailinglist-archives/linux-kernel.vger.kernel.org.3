Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317F4F16D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbiDDOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDDOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:22:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417C26576
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:20:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BCD21F381;
        Mon,  4 Apr 2022 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649082024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5lbE76B/EZHwPu2k7A6I8RReLpOp0Y/jNzFdV3g1S4=;
        b=wUJfCU6U9aEFMd7I2PlH7XU/X4oZ10X3cwSWjwI7LepxZwjQJG+tZohyp88Q845oq422CX
        URrCxehthNYfuNbAO98G+ZPJxR1b+wFyOUf9J+MRXLhBXseQ7qFMhyavzy1Jyp63uNdS/v
        pKSOrxaTEiqp9bqyS3uevf3s9AnN+KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649082024;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5lbE76B/EZHwPu2k7A6I8RReLpOp0Y/jNzFdV3g1S4=;
        b=4rdUhyBqjuGgSR3ltLnLq8pBH8pUj6kqVuVTnDYQxGv3Bw+qXKXhm3ja0q8lXLTnZtmONy
        3JlFPAkCUCvqcXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D39912FC5;
        Mon,  4 Apr 2022 14:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wftkAqj+SmLzOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Apr 2022 14:20:24 +0000
Message-ID: <8368021e-86c3-a93f-b29d-efed02135c41@suse.cz>
Date:   Mon, 4 Apr 2022 16:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Marco Elver <elver@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zqiang <qiang.zhang@windriver.com>, linux-mm@kvack.org
References: <20220323090520.GG16885@xsang-OptiPlex-9020>
 <20220324095218.GA2108184@odroid> <YkcfNjZJSXNsAlLt@hyeyoo>
 <YkpgjgM/aSXd29uj@hyeyoo> <Ykqn2z9UVfxFwiU+@elver.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [mm/slub] 555b8c8cb3:
 WARNING:at_lib/stackdepot.c:#stack_depot_fetch
In-Reply-To: <Ykqn2z9UVfxFwiU+@elver.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 10:10, Marco Elver wrote:
> On Mon, Apr 04, 2022 at 12:05PM +0900, Hyeonggon Yoo wrote:
> (Maybe CONFIG_KCSAN_STRICT=y is going to yield something? I still doubt
> it thought, this bug is related to corrupted stackdepot handle
> somewhere...)
> 
>> I noticed that it is not reproduced when KASAN=y and KFENCE=n (reproduced 0 of 181).
>> and it was reproduced 56 of 196 when KASAN=n and KFENCE=y
>> 
>> maybe this issue is related to kfence?

Hmm kfence seems to be a good lead. If I understand kfence_guarded_alloc()
correctly, it tries to set up something that really looks like a normal slab
page? Especially the part with comment /* Set required slab fields. */
But it doesn't seem to cover the debugging parts that SLUB sets up with
alloc_debug_processing(). This includes alloc stack saving, thus, after
commit 555b8c8cb3, a stackdepot handle setting. It probably normally doesn't
matter as is_kfence_address() redirects processing of kfence-allocated
objects so we don't hit any slub code that expects the debugging parts to be
properly initialized.

But here we are in mem_dump_obj() -> kmem_dump_obj() -> kmem_obj_info().
Because kmem_valid_obj() returned true, fooled by folio_test_slab()
returning true because of the /* Set required slab fields. */ code.
Yet the illusion is not perfect and we read garbage instead of a valid
stackdepot handle.

IMHO we should e.g. add the appropriate is_kfence_address() test into
kmem_valid_obj(), to exclude kfence-allocated objects? Sounds much simpler
than trying to extend the illusion further to make kmem_dump_obj() work?
Instead kfence could add its own specific handler to mem_dump_obj() to print
its debugging data?

> What about KASAN=n and KFENCE=n?
> 
> Thanks,
> -- Marco

