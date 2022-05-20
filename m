Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6D52EFB6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351119AbiETPvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351150AbiETPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:51:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C651626AD3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:51:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h13so1819539pfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xfBgeP+UgAMyYfuiGkyqd7pK8/GplNN5B8Npca/gXrU=;
        b=VWDoik0uRyKjQxUY61C7iGAe6NewO9iV3x6sawu7TsoWZFNg0exUyQsQbZdkCShwGz
         +msUoQm+GBl3pOGflb6qYhg+63NIIpggONq3HuDEFsJcg+JiMxpHNzPRehtayeWt+Ppf
         RMZJ5RffTkSyQKogyK4R+a1uzOpn+zTsjArt50tDFzVVA7b2MenSopjmCxKRi9iGz0JY
         8YsCIotgZcYNdZWkM3mLU2IGuxfyMuoyk43kPLMfgQ7QbHydwWwLtmROtvX1BANjQ2aX
         pIWiVM13riwmh3RlHhgGJhYKGI3xaWyIAdnaX2mG9/440NSAOLmbOpJOdgbH3Nc3+APq
         tg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xfBgeP+UgAMyYfuiGkyqd7pK8/GplNN5B8Npca/gXrU=;
        b=Ia9e451fLp8/2B49gHOwl1DwjSZO39VjAdf1/kkn8K7oZMiaRBpGpISkrqctorwC1i
         0MfxEjwJevZEWTuPbu2LpbdzUijrGQa8DPSQyzazbsDpxX9MRKdpj14saMQtLjBjIjWw
         mTViSWFZL2Oxn5XyakPJbH23C9hODFYHyHtjw9Gb9acgOgDXeybaZLy9z3Ngyb3YATfe
         dNLl6YMsNbCB1l0bo5KOPvhtp9gVM1NQRj9vrAr2HaO97dVX4CXMLuZ1QFiuMHjNO42A
         OCrRdhsCHWFBpux4Ai1DqlNW5OwNZKJZgQk1q3Pd5Gmioz+89RdeyVoSRPpHD8E8Vqvy
         x4kg==
X-Gm-Message-State: AOAM532lzTQoK3/f5EhN9jMQav4C59bLRnQBk2H1CyqpzpK3e3v/Z2l8
        HY/l2kLEhpX0PWXsAhGOmJW4YA==
X-Google-Smtp-Source: ABdhPJx3PTR2xhaonRPQCr6GbY4WTfB4A1+3Dl+CYKrHRj16/9CxH8VvST9+T1AR1q+bGFE9OtVJ+A==
X-Received: by 2002:a63:1b49:0:b0:3f2:cf90:5ad4 with SMTP id b9-20020a631b49000000b003f2cf905ad4mr9019159pgm.450.1653061869174;
        Fri, 20 May 2022 08:51:09 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e21-20020aa79815000000b005104c6d7941sm1988370pfl.31.2022.05.20.08.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:51:07 -0700 (PDT)
Message-ID: <72344aad-b5ad-b317-d36d-385cb16d5204@kernel.dk>
Date:   Fri, 20 May 2022 09:51:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com> <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe3vFmqx4Yua0a1@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoe3vFmqx4Yua0a1@zx2c4.com>
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

On 5/20/22 9:46 AM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 09:34:46AM -0600, Jens Axboe wrote:
>> On 5/20/22 9:25 AM, Jason A. Donenfeld wrote:
>>> Are we sure we really want to do this and need to do this?
>>
>> I'm very sure, otherwise we're just accepting that we're breaking real
>> world applications.
> 
> Would we really? I always thought splice() and copy_file_range() and
> sendfile() were all kind of "special" in that they mostly do not work
> for many things, and so all userspaces need fallback code. And the state
> of "mostly not working" has always just been the norm. So broken today,
> working tomorrow, broken next week would be par for the course? I might
> be *super* wrong here, so feel free to say so, but this has been my
> general impression.

No, I think that is exactly the wrong impression. If you have an
application that is written using eg splice from /dev/urandom, then it
should indeed be safe to expect that it will indeed continue working. If
we have one core tenet in the kernel it's that you should ALWAYS be able
to upgrade your kernel and not have any breakage in terms of userspace
ABI. Obviously that can happen sometimes, but I think this one is
exactly the poster child of breakage that should NOT happen. We took
away a feature that someone depended on.

This situation of splice being flakily availably is new from when it was
decided that it was OK to only have it be available if ->read_iter() and
->splice_read() is set. And that is very unfortunate.

> Anyway, I do like the idea of supporting splice() and sendfile(). The
> performance hit is just kind of sad.

I like the idea too, but this is deeper than that. We simply cannot just
break existing use cases like that.

Thankfully we do have an option here as I outlined in the previous email
- keep the ->read() and just add ->read_iter() on the side so that
splice still works. Is that ideal? No, it needs more code to support.
But hopefully that can die at some point when the performance gap is
such that we no longer need to worry about having ->read() for those
cases.

-- 
Jens Axboe

