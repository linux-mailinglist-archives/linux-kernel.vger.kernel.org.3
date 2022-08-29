Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D295E5A4F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiH2OVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiH2OVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:21:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432126CF43
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:21:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5FEF220F0;
        Mon, 29 Aug 2022 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661782867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqxMa1HBJ0+cGOogi0JdL8WYldDRadh4OFmol9texAQ=;
        b=VG+DHFcicKks5ebQV7XOTDPUERxlHNDH0SVdiTkGLHb+fFIAAWV0Zv1oRAC2qTA1T+Q7UA
        hJ/tYEFzaNaRf3nLXomDYyM42RuEX3Pzcwky7dVwZyz8EhaUyvc9lk1/0AUO3l0hb0AMq6
        jyIqtcUKM222nKn+tsmgsalshI9CndA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661782867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqxMa1HBJ0+cGOogi0JdL8WYldDRadh4OFmol9texAQ=;
        b=u57++SwFNz0+yP3FfdqhJSANUV5+nwH03ePx6bkJLBGUaVbALZo1pN0ba1ceOiwtvs/W0u
        W3MHLyIlGwIeG2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2502133A6;
        Mon, 29 Aug 2022 14:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 46ddJlPLDGNCaQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 29 Aug 2022 14:21:07 +0000
Message-ID: <1188aeeb-3949-b561-bec0-512ed763d857@suse.cz>
Date:   Mon, 29 Aug 2022 16:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Dawei Li <set_pte_at@outlook.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <YwwuSBAreqUk/jFq@casper.infradead.org> <Yww0NV54DXTzPG+R@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yww0NV54DXTzPG+R@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 05:36, Hyeonggon Yoo wrote:
> On Mon, Aug 29, 2022 at 04:11:04AM +0100, Matthew Wilcox wrote:
>> On Sun, Aug 28, 2022 at 11:14:48PM +0800, Dawei Li wrote:
>> > Current size2index is implemented by one to one hardcode mapping,
>> > which can be improved by order_base_2().
>> > Must be careful to not violate compile-time optimization rule.
>> 
>> This patch has been NACKed before (when submitted by other people).
> 
> 
> Hmm right.
> https://lkml.iu.edu/hypermail/linux/kernel/1606.2/05402.html
> 
> Christoph Lameter wrote:
>> On Wed, 22 Jun 2016, Yury Norov wrote:
>> > There will be no fls() for constant at runtime because ilog2() calculates
>> > constant values at compile-time as well. From this point of view,
>> > this patch removes code duplication, as we already have compile-time
>> > log() calculation in kernel, and should re-use it whenever possible.\
> 
>> The reason not to use ilog there was that the constant folding did not
>> work correctly with one or the other architectures/compilers. If you want
>> to do this then please verify that all arches reliably do produce a
>> constant there.
> 
> Can we re-evaluate this?

Is there a way to turn inability of compile-time calculation to a
compile-time error? (when size_is_constant=true etc). Then we could try and
see if anything breaks in -next.

