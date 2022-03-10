Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8354D4824
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiCJNhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbiCJNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:37:36 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE9514E96E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:36:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso6611317pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RcI1OUfcDqqYEbFBrtQzgD2/BopOVHxvwvLjQ5j7Gz4=;
        b=j4BpGdL/G3c6X9v+GkAuzLfVmSS5YCs63Tw2Y0DY3Dg4Fq2TH3/cCg19eoOrI4GYMS
         PEUTXqSkESYNQVVuiRMaWKE1pLntDv+9XMVpUZVW4LIq5KOMd+J7S782fGwed/Tpfl7t
         QVtRHsra/bBnloQ7bc91a2OdnpeeNR9cGeiQm+WeAPO+p0c/9hIqx3cwkmDUFYa9vIsU
         YtL9GrUqkDtwNtHJUbF47df1WWwgXhFHkgaj5huyfmWUL5gs6vIxkLjosI7Z4iOAWJ6x
         jLRGAzt3jwYr0+m0wUkyNZt78X1k1B2iU8JWKTUbUcuZa+4S0hnPFlz8e0/G+okkDAkM
         cF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RcI1OUfcDqqYEbFBrtQzgD2/BopOVHxvwvLjQ5j7Gz4=;
        b=Tt95QSgDlYLDIHJ6TxxvjezfyHFUZA61HxNjDgFUzL5gTN7R0S1lRJkMjaYM4rCf4p
         s2//Byk7ooRZVqcVXnwzIDkTRFvm14DaoaP5tlZDwXxLiuwJ1Jt8TQkCDc+9nXYW8PMe
         uv4Nw6WMZ7lzJd14JsWpSA/tiYYTB+NR+wtpJ9NutjMRgpdc/Kz3zM5OhJe8MfggzAxk
         9AvxjyyFwjj5C8Twed6UjxoVV7JX7O/ZYQlgizEXNVuwK0ztpzsW+4u8ck6fSz0617zb
         XOQGaW6WDlS+MtWnM7LFwSnHR1L3ipi9WGQo8P70Sp4C8egjKJPFzEb0scNOUAsDehg8
         rCPg==
X-Gm-Message-State: AOAM532vlkIfoy0aqkV6vpQx7KlM9hSdAVmO4eKLK+gM23ufEAG05fCg
        20SBwxqtYj0+vWDVio4o57c0jJFYAJOzd9EJ
X-Google-Smtp-Source: ABdhPJyvBWEPfF8m9OnRWSSpjf0tQExCWDRH8S4xPRLG6HbVLbXtEwDaTV4Kn2O3JOGvRTdekWY/nA==
X-Received: by 2002:a17:902:e88e:b0:151:ffdf:5692 with SMTP id w14-20020a170902e88e00b00151ffdf5692mr4915692plg.17.1646919395842;
        Thu, 10 Mar 2022 05:36:35 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00231200b004f72b290994sm7115059pfh.180.2022.03.10.05.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 05:36:34 -0800 (PST)
Message-ID: <47d2c632-b2c2-9736-01a6-bf1659be5299@kernel.dk>
Date:   Thu, 10 Mar 2022 06:36:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/2] io_uring: Add support for napi_busy_poll
Content-Language: en-US
To:     Olivier Langlois <olivier@trillion01.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Hao Xu <haoxu@linux.alibaba.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <cover.1646777484.git.olivier@trillion01.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1646777484.git.olivier@trillion01.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 3:17 PM, Olivier Langlois wrote:
> The sqpoll thread can be used for performing the napi busy poll in a
> similar way that it does io polling for file systems supporting direct
> access bypassing the page cache.
> 
> The other way that io_uring can be used for napi busy poll is by
> calling io_uring_enter() to get events.
> 
> If the user specify a timeout value, it is distributed between polling
> and sleeping by using the systemwide setting
> /proc/sys/net/core/busy_poll.
> 
> The changes have been tested with this program:
> https://github.com/lano1106/io_uring_udp_ping
> 
> and the result is:
> Without sqpoll:
> NAPI busy loop disabled:
> rtt min/avg/max/mdev = 40.631/42.050/58.667/1.547 us
> NAPI busy loop enabled:
> rtt min/avg/max/mdev = 30.619/31.753/61.433/1.456 us
> 
> With sqpoll:
> NAPI busy loop disabled:
> rtt min/avg/max/mdev = 42.087/44.438/59.508/1.533 us
> NAPI busy loop enabled:
> rtt min/avg/max/mdev = 35.779/37.347/52.201/0.924 us

Applied, thanks.

-- 
Jens Axboe

