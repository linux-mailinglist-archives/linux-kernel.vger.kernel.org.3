Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68A852EF4E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350893AbiETPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiETPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:34:50 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A93179084
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:34:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r71so8066736pgr.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=e3zRTRtgvILEICGPiLa/WYEa5fM29ZCSz7EUFRvdtTU=;
        b=oGkNhLX3ZdPbv/FoolRZwwzMYLvSflVnMKZndrubwwVxefDL/TJsFcwA7PHv3NPmop
         1AjRtWBBvEnjh5/Hz5IT6vr880lfZw2A02pAcAcrssPEWPQm+BfkFrNZgqPu+pOgqZNI
         5//sCsv6kGtH1fLbFATDm0TD4qVmx936MlA8s+V9XKNR72F5kWuYpZAskohh3Ll9URu0
         5wAIPJ6ZsufyrR/wE7C3HSYq74VRIRgH8Mlrv3yercHpUNtj7yt5kexMM5Pd12uPcLv8
         oxQiynEUoCRcvOF84+EE8T46bpi5LD2PvABqt1I3iezIB50wrHQW2uHMYWqrFEzgtXSh
         Z6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e3zRTRtgvILEICGPiLa/WYEa5fM29ZCSz7EUFRvdtTU=;
        b=whtJ3/NfnYPa1JBV6UsQ6suBip3Co9+YvaH1Mys2tLN2ljD+4peLrLq4rw5MVqb1UX
         I4Gc7gZ5JsdXH9TfXYuE+j0R1LyhUCY78LAqBa8gmeZmAxqAjh1HBOQpKuqaQVHjx//5
         H8OSZ1Ikg3GAiK4Oh0NlpCOYFLQ7x09PqhJ8/N7MkfP9e8r0bcgCKwQSGUs6/qSMOpy1
         mq1Cmr1rpe7FZ4cmtOwMuJ5+74ZWDvgILSDvIyzcKFXiV++odeNorsHNqThTCm3bFThl
         i1YKkbIbdLgggt8xyYBKqZixys9Cl86a0HQY84Xf5IfRL+klhS/hXrY/69KrNGQsuQMN
         NYZw==
X-Gm-Message-State: AOAM532aZzS4vJkgpYeQslR+Y62pIrZ+besFHKa3WE6d0FTsm5ED27+Y
        e+QIkUxyTZo3WYkDz6w2F4uceQ==
X-Google-Smtp-Source: ABdhPJye3iSjVZVnCNjKkjVoudazo5xjF4r6gxTAf/5wgpCjyoSqMp8Kyzng+oax8HnxSmv5B37mqA==
X-Received: by 2002:a63:115b:0:b0:3c1:eb46:6f5 with SMTP id 27-20020a63115b000000b003c1eb4606f5mr9021128pgr.277.1653060888405;
        Fri, 20 May 2022 08:34:48 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090af8cd00b001cd4989ff42sm2029545pjd.9.2022.05.20.08.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:34:47 -0700 (PDT)
Message-ID: <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
Date:   Fri, 20 May 2022 09:34:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoey+FOYO69lS5qP@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 9:25 AM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 11:44:56AM +0200, Jason A. Donenfeld wrote:
>> Jens Axboe (3):
>>   random: convert to using fops->read_iter()
>>   random: convert to using fops->write_iter()
>>   random: wire up fops->splice_{read,write}_iter()
> 
> FYI, this series makes reads from /dev/urandom slower, from around 616
> MiB/s to 598 MiB/s on my system. That seems rather unfortunate.

How reproducible is that? That seems like a huge difference for the
change. How big are the reads?

> Are we sure we really want to do this and need to do this?

I'm very sure, otherwise we're just accepting that we're breaking real
world applications. Alternatively, you can keep the ->read() and add the
->read_iter() as well, but I'm a bit skeptical at your initial results
there.

-- 
Jens Axboe

