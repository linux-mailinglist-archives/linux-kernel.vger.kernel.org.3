Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3901555E7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiF1PTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347777AbiF1PTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:19:06 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489E326F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:19:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k15so13181362iok.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a1Ksi7uoSY1JktZzHg4pt0ZHeEa7vD/csR/m9sBS+O4=;
        b=XvPRbsz8PTdoOG/YWBDPIE6YrMu9muBd8uqCBsmqWbUMyex1MTUkTu/cRRUHIj/Wwl
         WjA0TkGz147N81Sxk428uRmVmu5w5ibq4j7xJCeijTDAoSnLSH7jlSgwCqlCKo+CQ2jD
         vJOhiOtA8+WUFW5J9mDjTc00X4qb4Q2cwmJv6ZW87F6YCQ9IyGwdUOUwLXHMAx82Dp5H
         kjwZZCtCd6dVBSEo+ZdPs1iNk18oq7mNI96jr9szhbbXco3oOf6kbXJlG7Y8VOcTXm2W
         JZulHL075AXsTHvM6Kjn6bDptpRDfbm6UJwwQMCUZRFSr+Z7nsRBapd8HHnbe9KYqvzu
         OsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a1Ksi7uoSY1JktZzHg4pt0ZHeEa7vD/csR/m9sBS+O4=;
        b=Lysbf6EuDrrp+ZMEwGEuTJhJoh4s6xSpbrq9snOQgG1wV6TykPG1Hhvf0JN941i2xQ
         Hy+wT1+7Sj957PVOG5BQ57Fi+DKupYhAV1e2seHFij5WQ0d77CA8/W0xJzdhPNjfbPbW
         W9ICW6C9tlx1+zu3+QcUCv9oGwy5hDtC8SQvUEqJEgKXUFIaUFN9AoTbYXa1/sQ+nET1
         FnrUjP8hF+cO2P7oQkCCR+vFr3Hftr2xWj2qc20dtpa0DAbQktxwf2NhW05nzSp7FKFY
         1WPoRUL3qaklGeZn42IHNhZL47ulgdRw1vTPCUyNXizU66CXw03ziqW++mqqL1JX0I04
         aZhw==
X-Gm-Message-State: AJIora/UjlnyFOFSj7G82NOsap8azC2Zti0c9SYBx1ggWmPK5bsUZJjO
        AjqLW5Hz2PAjAQRjkLRCGrxNWw==
X-Google-Smtp-Source: AGRyM1vdsEcaBTjd07LlEM7hR+UbrDeebOcS7ca/e497cKkTBEkTpMDOMT2dSq2iOJmeZZbz4wSJmA==
X-Received: by 2002:a05:6638:160d:b0:331:a523:aea3 with SMTP id x13-20020a056638160d00b00331a523aea3mr12311876jas.144.1656429545374;
        Tue, 28 Jun 2022 08:19:05 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g8-20020a92cda8000000b002cc20b48163sm5936962ild.3.2022.06.28.08.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:19:04 -0700 (PDT)
Message-ID: <c1cb95f8-66be-e929-c26c-74d27e4ec498@kernel.dk>
Date:   Tue, 28 Jun 2022 09:19:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH for-next 0/8] io_uring: multishot recv
Content-Language: en-US
To:     Dylan Yudaken <dylany@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     Kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20220628150228.1379645-1-dylany@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220628150228.1379645-1-dylany@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 9:02 AM, Dylan Yudaken wrote:
> This series adds support for multishot recv/recvmsg to io_uring.
> 
> The idea is that generally socket applications will be continually
> enqueuing a new recv() when the previous one completes. This can be
> improved on by allowing the application to queue a multishot receive,
> which will post completions as and when data is available. It uses the
> provided buffers feature to receive new data into a pool provided by
> the application.
> 
> This is more performant in a few ways:
> * Subsequent receives are queued up straight away without requiring the
>   application to finish a processing loop.
> * If there are more data in the socket (sat the provided buffer
>   size is smaller than the socket buffer) then the data is immediately
>   returned, improving batching.
> *  Poll is only armed once and reused, saving CPU cycles

The latter is really a big deal, it saves a substantial amount of wait
queue locking and manipulation.

In general this looks good to me. I agree on allowing length of 0, we
strictly don't need a length as that is implicit from the provided
buffer anyway (and capped by that, ultimately). Nice cleanups leading
into the real change too.

Added some individual comments on select patches.

-- 
Jens Axboe

