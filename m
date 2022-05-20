Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54B052F081
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351583AbiETQYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351574AbiETQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:24:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACF017D3BA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:24:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id z3so6654964pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Up48slLLXklbScKjS7/klG/4sx3wupJAFkj4Y/FraRs=;
        b=KPHAmma9oKN1ewvN1W6iAV8SGt3iITADLc/ZUOTV723rXPR+SmD+N7JjGaI6Xsg1NK
         PoAlymoTFt9amGl5099Dvl61Z+E0wRR0/UAwha4i1Jor1wp0xe/7T6/QCY/LSl9NZXun
         o2vWbkFQ0Zp2pId8y3c/y/XuEZzekP/QQrmZ/VDwmOAqWW3h+Pydlr+Uc8pdu6ZAoEbV
         dsK2FQM2v2XMQ7SezECWga9/pMvN0+zl9Uu4nIyw6kht7YalkNMnM5lSRSLJ3o4IXhAE
         RCvMFmAnJCD9cPnSoj8X9xxmIMrCPUW1cps+0njiflhaYAWPQtbxODH8TBN0KR1+JguK
         5Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Up48slLLXklbScKjS7/klG/4sx3wupJAFkj4Y/FraRs=;
        b=jzOtCcfxMOmuU1o1mJ2cpI4gQ2IDOfV0yoVwlbVmG31wIE/FUWw1TjXIlvHlRfPiL3
         R9z+hR/eFHkzLK5symAUL5xsEQq4MJqqKzhb0AQ634xIAuazAp4awH0gPNLoUjYulnlC
         f5DqQ7gMNlkx3328wVJA1xHg5/XASXZ28c9rlY8BINDvNNgPPQdWzJHqjY8h4UnFfo3a
         1PE7HquOA9lH43feUJC1Roy2c7YgReVZbHclxS0FwDZ0bshnPrdSEmHi61LY64vKYgYJ
         7VLtFkrVf/F/KRec8PX0MIupAnbUmsBS+gO7azbqjr8f5bU8CxnZNHsS02yHn4yQEBRu
         i+Iw==
X-Gm-Message-State: AOAM5337mF/ZhJOPRGe4YFAMwWbNiWi/wbbCz+VE9XOn21KsbRfz5RiT
        g8m1YyhLzRUOSZwj68zbZbxeWA==
X-Google-Smtp-Source: ABdhPJyTPXaqMY1JFIjzJUGFo8ngpNYspWSF8+MvJBYmEtntWWAKiEbzT+mM67rzFYg80BSxBR+JHg==
X-Received: by 2002:a63:350c:0:b0:3c6:bf88:1509 with SMTP id c12-20020a63350c000000b003c6bf881509mr9111619pga.144.1653063879002;
        Fri, 20 May 2022 09:24:39 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902b40700b0015e8d4eb254sm5762558plr.158.2022.05.20.09.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 09:24:38 -0700 (PDT)
Message-ID: <69bd18e6-d216-dfb3-201b-f6a285deb0e7@kernel.dk>
Date:   Fri, 20 May 2022 10:24:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com> <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe4HP9iTA6l/For@zeniv-ca.linux.org.uk>
 <7e78d6a7-1cc3-2408-fe91-0329f5020e77@kernel.dk>
 <Yoe+lK8RIRbK6lDZ@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoe+lK8RIRbK6lDZ@zeniv-ca.linux.org.uk>
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

On 5/20/22 10:15 AM, Al Viro wrote:
> On Fri, May 20, 2022 at 09:53:30AM -0600, Jens Axboe wrote:
>> On 5/20/22 9:47 AM, Al Viro wrote:
>>> On Fri, May 20, 2022 at 09:34:46AM -0600, Jens Axboe wrote:
>>>
>>>> I'm very sure, otherwise we're just accepting that we're breaking real
>>>> world applications.
>>>
>>> "Breaking" as in "it used to work with earlier kernels, doesn't work with
>>> recent ones"?  Details, please...
>>
>> Yes, as in exactly that. This is what drove this addition of
>> ->read_iter() for urandom. See commit:
>>
>> ommit 36e2c7421f02a22f71c9283e55fdb672a9eb58e7
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Thu Sep 3 16:22:34 2020 +0200
>>
>>     fs: don't allow splice read/write without explicit ops
>>
>> related to the set_fs() changes, and now go look for any commit that
>> has:
>>
>> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
>>
>> in it and see that this isn't an isolated incident at all.
>>
>> tldr - splice from /dev/urandom used to work, and I recently got a
>> report internally on an application that broke on upgrade from 5.6 to
>> 5.12 exactly because it now just just -EINVAL's instead.
> 
> IIRC, Linus' position at the time had been along the lines of
> "splice is not so good ABI anyway, so let's do it and fix up
> the places that do get real-world complaints once such appear".
> So /dev/urandom is one such place...

That's what Christoph said too. Honestly that's a very odd way to
attempt to justify breakage like this, even if it is tempting to
facilitate the set_fs() removal. But then be honest about it and say
it like it is, rather than some hand wavy explanation that frankly
doesn't make any sense.

The referenced change doesn't change the splice ABI at all, hence the
justification seems very random to me. It kept what we already have,
except we randomly break some use cases.

-- 
Jens Axboe

