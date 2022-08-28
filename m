Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC8A5A3E0D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiH1Obu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH1Obq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:31:46 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0690B32D89
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:31:42 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id e20so7203197wri.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3Gg6tzbKc65ckqG5OAj2t3ODeKa0AQd2dV33mY+3sOw=;
        b=bgeSGWp5l8wzi8ItHghS33xbM9lOTcTE7gBH4ziu4VWvtj4nFfCfQ2sIMDVJhKubj6
         ST8H2CWmBPNYtYerrH3lj/D3x9sXw8yrOzbC9U4Tb9PO+vE/puELv0IlEnHThq/YdHyK
         17cjVB6OxZ9veRuAviLurZPBeghY/WhIOgWqks41xd4Mo6L83V78db7N+yJ3IvaVVqIP
         B/b+Y8N0EfOaGxazrKihGpJJiTAtGBLkvKao3XwaLVxY+IP1pvUNp/yXX83L8ifSEJ/j
         rO7nYjdFCmQPb2mceswXIusF+ZmV/tMm/0/sI5KPwp+wZt6JYnD4rjr8cQYNchZvrUzl
         jiFw==
X-Gm-Message-State: ACgBeo0B116kAjIU2oIrVQqY/wUjA5bj2tIT8wBYrQRyHLxk+O5ZpwmI
        sTzMF+aNEd10JIly3EK8QOM=
X-Google-Smtp-Source: AA6agR4VmWA6eXg/sR0Azf+jnUrZYFRCVf+Jec0+Ho/bl41h0YpKPeo7moPq9j1tqd4zVeT8wNMYsA==
X-Received: by 2002:adf:9d91:0:b0:226:d001:6e27 with SMTP id p17-20020adf9d91000000b00226d0016e27mr4058125wre.366.1661697101152;
        Sun, 28 Aug 2022 07:31:41 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b0021e8d205705sm4582637wru.51.2022.08.28.07.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:31:28 -0700 (PDT)
Message-ID: <3e08c8b9-805b-eec9-9a54-467735a27fc5@grimberg.me>
Date:   Sun, 28 Aug 2022 17:31:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com> <YwVjpTW6vWvdVQTK@ZenIV>
 <2887364.VdNmn5OnKV@opensuse> <Ywkf3NJQ7/8SSV+e@ZenIV>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Ywkf3NJQ7/8SSV+e@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> As you may have already read, I'm so new to kernel development that I still
>> know very little about many subsystems and drivers. I am not currently
>> able to tell the difference between BVEC and KVEC. I could probably try to
>> switch from one to the other (after learning from other code), however I won't
>> be able to explain in the commit message why users should better use BVEC in
>> this case.
> 
> struct kvec: pairs of form <kernel address, length>
> struct bio_vec: triples of form <page, offset, length>
> 
> Either is a way to refer to a chunk of memory; the former obviously has it
> already mapped (you don't get kernel addresses otherwise), the latter doesn't
> need to.
> 
> iov_iter instances might be backed by different things, including
> arrays of kvec (iov_iter_kvec() constructs such) and arrays of
> bio_vec (iov_iter_bvec() is the constructor for those).
> 
> iov_iter primitives (copy_to_iter/copy_from_iter/copy_page_to_iter/etc.)
> work with either variant - they look at the flavour and act accordingly.
> 
> ITER_BVEC ones tend to do that kmap_local_page() + copy + kunmap_local().
> ITER_KVEC obviously use memcpy() for copying and that's it.
> 
> If you need e.g. to send some subranges of some pages you could kmap them,
> form kvec array, make msg.msg_iter a KVEC-backed iterator over those and
> feed it to sendmsg().  Or you could take a bio_vec array instead, make
> msg.msg_iter a BVEC-backed iterator over that and feed to sendmsg().
> 
> The difference is, in the latter case kmap_local() will be done on demand
> *inside* ->sendmsg() instance, when it gets around to copying some data
> from the source and calls something like csum_and_copy_from_iter() or
> whichever primitive it chooses to use.
> 
> Why bother with mapping the damn thing in the caller and having it pinned
> all along whatever ->sendmsg() you end up calling?  Just give it
> page/offset/length instead of address/length and let lib/iov_iter.c
> do the right thing...

Thanks for the info Al. IIRC, I think that the original goal of this
code was to avoid the kmap/kunmap overhead on every copy as the buffers
lifetime matches the request itself, However as noted in this thread,
the buffers are always highmem, and hence don't have an associated
overhead.

I agree that this can be converted to use bio_vec, I'll give it a try.
