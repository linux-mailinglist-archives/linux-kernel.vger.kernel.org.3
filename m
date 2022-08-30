Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC55A646C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiH3NNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3NNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:13:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548527CC3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:13:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 815F221DA3;
        Tue, 30 Aug 2022 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661865200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxUZBeXFInIAIyAazEhw9pfeNC75QI0RoFacILGcz9U=;
        b=vZbDpC6p/fLANmCpNiQk/64btY7OaAiY49Xy03S/p2Ejzx3QRo5u8h0oCFOVzBdXWgHaeZ
        tcTkwSGo69V79nMozI67Zi9qL8O6UPjdPegGtWbJXFsOqHPs2p8egbDHW+RFexw0pumG28
        5cnsFq08RcT9bMMjfyRhyaRTr0KDxYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661865200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxUZBeXFInIAIyAazEhw9pfeNC75QI0RoFacILGcz9U=;
        b=GGYXRXD2e5kawitKu7aU44cxW98/6ey5dbY9kRoF6LB9fURfJc9dNw+vejmPIDVXQtTHuM
        p5bpus3eg0m9aFDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2864513B0C;
        Tue, 30 Aug 2022 13:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UKLLCPAMDmOYegAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 Aug 2022 13:13:20 +0000
Message-ID: <c313410e-bfca-0fe0-c6a8-9f98e5c21f69@suse.cz>
Date:   Tue, 30 Aug 2022 15:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Dawei Li <set_pte_at@outlook.com>, "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <YwwuSBAreqUk/jFq@casper.infradead.org> <Yww0NV54DXTzPG+R@hyeyoo>
 <1188aeeb-3949-b561-bec0-512ed763d857@suse.cz>
 <f02b862f-8e8c-0ec9-7b83-c9e26831c242@csgroup.eu>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f02b862f-8e8c-0ec9-7b83-c9e26831c242@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 07:51, Christophe Leroy wrote:
> 
> 
> Le 29/08/2022 à 16:21, Vlastimil Babka a écrit :
>> On 8/29/22 05:36, Hyeonggon Yoo wrote:
>>> On Mon, Aug 29, 2022 at 04:11:04AM +0100, Matthew Wilcox wrote:
>>>> On Sun, Aug 28, 2022 at 11:14:48PM +0800, Dawei Li wrote:
>>>>> Current size2index is implemented by one to one hardcode mapping,
>>>>> which can be improved by order_base_2().
>>>>> Must be careful to not violate compile-time optimization rule.
>>>>
>>>> This patch has been NACKed before (when submitted by other people).
>>>
>>>
>>> Hmm right.
>>> https://lkml.iu.edu/hypermail/linux/kernel/1606.2/05402.html
>>>
>>> Christoph Lameter wrote:
>>>> On Wed, 22 Jun 2016, Yury Norov wrote:
>>>>> There will be no fls() for constant at runtime because ilog2() calculates
>>>>> constant values at compile-time as well. From this point of view,
>>>>> this patch removes code duplication, as we already have compile-time
>>>>> log() calculation in kernel, and should re-use it whenever possible.\
>>>
>>>> The reason not to use ilog there was that the constant folding did not
>>>> work correctly with one or the other architectures/compilers. If you want
>>>> to do this then please verify that all arches reliably do produce a
>>>> constant there.
>>>
>>> Can we re-evaluate this?
>>
>> Is there a way to turn inability of compile-time calculation to a
>> compile-time error? (when size_is_constant=true etc). Then we could try and
>> see if anything breaks in -next.
>>
>>
> 
> The following will generate a build error if the function
> constant_check() is not called with a buildtime constant argument.
> 
> static void __always_inline constant_check(unsigned long val)
> {
> 	BUILD_BUG_ON(!__builtin_constant_p(val));
> }
> 
> Is that what you are looking for ?
Maybe, if we can rely on these two being equivalent:
- __kmalloc_index(x) is evaluated compile-time
- __builtin_constant_p(__kmalloc_index(x)) is true

Logically such equivalency should be expected, and a quick attempt 
locally with recent gcc seems to work fine, but I guess we'll have to 
try in -next for a bit and see if anything comes out.

