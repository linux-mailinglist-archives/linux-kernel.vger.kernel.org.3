Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D77851FB9D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiEILsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiEILr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:47:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E10B1312AA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:43:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EBA221AA9;
        Mon,  9 May 2022 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652096607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROU9Hy4V7hBvs8b+/r+npPjSPJAc6xQLxvLIhkwIRwU=;
        b=lnHRuTwYLHY5UtCrFvZBOjAeXYsXu1iBqvBHmZ31j+27YD1UhJM3/TBPkFwHzRn/JlgSL5
        +N5rKoducg45ky6b8wYT2R60K/YirgzPyxBzyUgz0QD5icOPuNf5j/aWbV7o7Gu+Qwlwi2
        CJ79pIcDOrjLnl+WIIlJATJ3+WF9cpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652096607;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROU9Hy4V7hBvs8b+/r+npPjSPJAc6xQLxvLIhkwIRwU=;
        b=NIkEHd4ZaowPBVWZwASFNzv4W6WTjyYRXXAmZ6lhIsP0X75cS3PIfEKeTfqVb/cF80RQcI
        Yn/uvkLLFVmtI9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D71BA13AA5;
        Mon,  9 May 2022 11:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7xq0M17+eGJFLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 11:43:26 +0000
Message-ID: <43933b3e-0770-897b-309d-a9a5d4cadb4f@suse.cz>
Date:   Mon, 9 May 2022 13:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v3] mm/slub: Remove repeated action in calculate_order()
Content-Language: en-US
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220430002555.3881-1-vvghjk1234@gmail.com>
 <49b0d611-e116-c78d-cf14-6d5f96ae500e@suse.cz>
 <CAEcHRTo3keiv0Xjr_7CG-kiD+Y6ENbdf9fKZzW9zgRd9OrV03g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAEcHRTo3keiv0Xjr_7CG-kiD+Y6ENbdf9fKZzW9zgRd9OrV03g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 11:42, Wonhyuk Yang wrote:

>> > +     if (unlikely(order_objects(slub_min_order, size) > MAX_OBJS_PER_PAGE)) {
>> > +             order = get_order(size * MAX_OBJS_PER_PAGE) - 1;
>> > +             goto out;
>> > +     }
>>
>> Hm interestingly, both before and after your patch, MAX_OBJS_PER_PAGE might
>> be theoretically overflowed not by slub_min_order, but then with higher
>> orders. Seems to be prevented only as a side-effect of fragmentation close
>> to none, thus higher orders not attempted. Would be maybe less confusing to
>> check that explicitly. Even if that's wasteful, but this is not really perf
>> critical code.
> 
> Yes, I agree that checking the overflow of object number explicitly is
> better even if
> it is almost impossible. But it checked repeatedly by calling
> calc_slab_order(). It
> seems to me that is unnecessary doesn't it?

Yeah I'm OK with the goal of your patch.

