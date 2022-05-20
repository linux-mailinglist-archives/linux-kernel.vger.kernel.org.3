Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083AA52EC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbiETMvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349606AbiETMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:51:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82F2CDCD
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:51:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z3so6165127pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HXsrmplgOrprs0PtpqiiiUWXK74aqpxbkjyx6LZmgws=;
        b=WaBsCqpLETrpMOkGHxrgigcH3VMrJ4Ws5UWrTEmQAmszHktg/XNenEzfoZGMWNMFaB
         VixH/VNdU8nhaq4RF7fBiIZ2aljlQLzl6rnaSYop5TO7BPs1nu423Khs78jz4Zf5vuGS
         SNJGegyFOfoHSR/zhg+PNBGjLySFbusFsE6X7mFk1eDC8sElT5C1IoSvYbDajtwkdimB
         EbD2gnInJeDTp75j/iPUBwUPKLR2yPlKLtP61UnoE29jzAuNgzIWhF8xjtU4FJkjeel8
         vuPtok81xtSiEd9bIEO4IWMIhb83DI+rcA2bu2bCkCh/6MARh/DXViVtGY8uHeBlU/bZ
         knBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HXsrmplgOrprs0PtpqiiiUWXK74aqpxbkjyx6LZmgws=;
        b=A5sX+6y7rR8zEH5QOmh+TLB5VaWEsqrdICbvG8WrtWQtXLFdtApRFkpAD5QzI7h3DY
         sg1MwFnEYIEmxH4iMPj6cUSkBQ58Qg7Q7IgRInpf+97HRggPNMIw5WGI0Xqj9eL/vgdu
         vaNQjiblUq8k6jgYEbACynZwLqy4sv/jLsjSfwWaUnR5a7nfQsJkJG/rGIKE42clSFsI
         vE0SF+aI29KCxFJBrrI4sFtjOgHYn3AZNLwjltNttRsHQJ000ICP2x4uoVBkCr8lLRyO
         ADkWzuVsAs0Rqd+hm9a9XaNUK5lBOE5KPtCLlw4k0uEkKDEpPXefZ0fexPAk8JFu7dci
         KlCw==
X-Gm-Message-State: AOAM531/sQ193PRB7hFyNb4QX3bLMOg245cOzP5QaHxb0l5Mtus/yjOb
        1phX4JHusxmh2o0gjDPmmeJDBA==
X-Google-Smtp-Source: ABdhPJwr3nSldJUaenKW6kIUCgivj37LBLKkDgPkbKLd1RKLiBvq+8yMhe7JcJKKxVyrvbZMzVpFtg==
X-Received: by 2002:a05:6a00:194b:b0:518:512a:268d with SMTP id s11-20020a056a00194b00b00518512a268dmr4952011pfk.73.1653051070421;
        Fri, 20 May 2022 05:51:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902680e00b0015e8d4eb207sm5449083plk.81.2022.05.20.05.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:51:09 -0700 (PDT)
Message-ID: <2680f8ed-471d-4420-9395-70599b0f36cd@kernel.dk>
Date:   Fri, 20 May 2022 06:51:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     tytso@mit.edu, Jason@zx2c4.com, linux-kernel@vger.kernel.org
References: <20220519193133.194138-1-axboe@kernel.dk>
 <20220519194838.GA6361@lst.de>
 <83183894-155a-efe7-ea0d-a3d88ebeadb1@kernel.dk>
 <20220520060244.GA16503@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220520060244.GA16503@lst.de>
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

On 5/20/22 12:02 AM, Christoph Hellwig wrote:
> On Thu, May 19, 2022 at 01:55:26PM -0600, Jens Axboe wrote:
>> I'm a bit torn on this one, because I _really_ want us to get rid of
>> read/write and make everything use read_iter/write_iter. Firstly because
>> it's really stupid to have two interfaces, and secondly because even
>> basic things like "can we block here" doesn't work in the older
>> interface without fiddling with file flags which is a non-starter for
>> certain things.
> 
> Converting everything was my initial plan, but Linus said no and just
> fix whatever breaks.  And compared to my initial fears the fallout
> actually isn't that bad.

That's a real shame, and very unlike Linus to advocate for just breaking
applications willy nilly. It would be a considerable amount of work
though, but it would really be great to not have ->read/->write anymore
and solely use the iter variants.

Not sure if I agree with "that bad" though looking at the number of
fixups, and we'll keep finding these going forward as well...

-- 
Jens Axboe

