Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB03572F61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiGMHkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiGMHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:40:14 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455939749B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:40:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f14so8100797qkm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f8LMtVTNpLm99mphGsEODrdfaZdyJZiyR5/bZD+IxFc=;
        b=Ce2G/CgloTyx3KJeqJbLG6cM814F7ZoMy//mdEpAuNfsFGLZctjxAwOc565n4tXFyZ
         jE95WbZMWPK2fMHz5fudJplbKLiXeKjoOyJZHmRGCweyeWetQU9U5eJcFC9wOQmCV2Y4
         bRI6EZ+OdnDrk1yfdDNKF4hVRStwRdmmjHpRiCjVePkKQvKQaJmaaddVaPz8KJRSMfXq
         m0Z0Aw+UNFVffGCikt3/04SBu5UpX8Tpfrrn8ursvGbpQxGI2nDTSWUiAyr+ac/fjgs4
         utgR9EaIC0MxbpktVv0CQzoOA8hxRrDKKCI7KKBSBctpynR1n0NKZUkXQWcWLQwIUqyx
         kh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f8LMtVTNpLm99mphGsEODrdfaZdyJZiyR5/bZD+IxFc=;
        b=U0AI3acSGkNrNIs5A8U9UskCzfVIEHR8rIXePRCw6G1IpqVWXnSY2dFEsUC82YEynA
         IKFBu++GQ9BDXxfcUUhzOyfX+DKdrVW9+jz7hTwFUfmEagNIF5wizLextXvsgw8s7pci
         gzOU5TLlUux6xPXbqZY8ZA+xfnIxivrOqPT1r5F6Y3IR3+PG1j7ZnS8zANP+xRgbsgxO
         VsX7tSAoZ1DcLeHVmxleRBd2jLzh9NW/2OPIFcSxOMz8L3vMSHeIQ7Rb1C5BpxlCznTt
         oOkRqiRsMAec66MmIIaWuKkCt90/s54jlvpUOlTL/XA3TUBLqtWVTHb0O1Y0AtVSRjDa
         GguA==
X-Gm-Message-State: AJIora90q/FT9yq0owfcb9mlfiWWM2/RNoI0oqhR9sCSKBI8pmHvupnN
        5EVgVEOHOU7VWE76ibRCPQ==
X-Google-Smtp-Source: AGRyM1s6c45gwft70lFlXJ2Z8ydYkPXE++6fKCShXnhvjkuZcSssCeTYHkI5BOj3yQdIO8ZJoojEeQ==
X-Received: by 2002:a05:620a:2681:b0:6b5:b547:40d with SMTP id c1-20020a05620a268100b006b5b547040dmr1461969qkp.34.1657698012391;
        Wed, 13 Jul 2022 00:40:12 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a424400b006aedb35d8a1sm11724945qko.74.2022.07.13.00.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 00:40:11 -0700 (PDT)
Message-ID: <a4d7f359-c430-6487-ec38-009bc2af2e97@gmail.com>
Date:   Wed, 13 Jul 2022 03:40:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH] 9p: forbid use of mempool for TFLUSH
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Greg Kurz <groug@kaod.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Suren Baghdasaryan <surenb@google.com>
References: <12950409.o0bIpVV1Ut@silver>
 <20220713041700.2502404-1-asmadeus@codewreck.org>
 <0aa8323d-9461-a861-ac35-6952e7aeaf93@gmail.com>
 <Ys5wRdSwtTeLF6nc@codewreck.org>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <Ys5wRdSwtTeLF6nc@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 03:12, Dominique Martinet wrote:
> Kent Overstreet wrote on Wed, Jul 13, 2022 at 02:39:06AM -0400:
>> On 7/13/22 00:17, Dominique Martinet wrote:
>>> TFLUSH is called while the thread still holds memory for the
>>> request we're trying to flush, so mempool alloc can deadlock
>>> there. With p9_msg_buf_size() rework the flush allocation is
>>> small so just make it fail if allocation failed; all that does
>>> is potentially leak the request we're flushing until its reply
>>> finally does come.. or if it never does until umount.
>>
>> Why not just add separate mempools for flushes? We don't have to allocate
>> memory for big payloads so they won't cost much, and then the IO paths will
>> be fully mempool-ified :)
> 
> I don't think it really matters either way -- I'm much more worried
> about the two points I gave in the commit comment section: mempools not
> being shared leading to increased memory usage when many mostly-idle
> mounts (I know users who need that), and more importantly that the
> mempool waiting is uninterruptible/non-failible might be "nice" from the
> using mempool side but I'd really prefer users to be able to ^C out of
> a mount made on a bad server getting stuck in mempool_alloc at least.

We should never get stuck allocating memory - if that happens, game 
over, system can no longer make forward progress.

(oh, that does give me an idea: Suren just implemented a code tagging 
mechanism for tracking memory allocations by callsite, and I was talking 
about using it for tracking latency. Memory allocation latency would be 
a great thing to measure, it's something we care about and we haven't 
had a good way of measuring it before).

> It looked good before I realized all the ways this could hang, but now I
> just think for something like 9p it makes more sense to fail the
> allocation and the IO than to bounce forever trying to allocate memory
> we don't have.

A filesystem that randomly fails IOs is, fundamentally, not a filesystem 
that _works_. This whole thing started because 9pfs failing IOs has been 
breaking my xfstests runs - and 9pfs isn't the thing I'm trying to test!

Local filesystems and the local IO stack have always had this 
understanding - that IO needs to _just work_ and be able to make forward 
progress without allocating additional memory, otherwise everything 
falls over because memory reclaim requires doing IO. It's fundamentally 
no different with network filesystems, the cultural expectation just 
hasn't been there historically and not for any good technical reason - 
it's just that in -net land dropping packets is generally a fine thing 
to do when you have to - but it's really not in filesystem land, not if 
you want to make something that's reliable under memory pressure!

> Let's first see if you still see if you still see high order allocation
> failures when these are made much less likely with Chritisan's patch.

Which patch is that? Unless you're talking about my mempool patch?

> What I intend to push this cycle is in
> https://github.com/martinetd/linux/commits/9p-test
> up to 'net/9p: allocate appropriate reduced message buffers'; if you can
> easily produce them I'd appreciate if you could confirm if it helps.
> 
> (just waiting for Chritian's confirmation + adjusting the strcmp for
> rdma before I push it to 9p-next)
> --
> Dominique
> 

