Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE08B52EFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351141AbiETPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351136AbiETPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:53:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B952166D7E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:53:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so7707968plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1ap+LN9xt8LVjDA6xeK3vWW8HvYkM4PsGmSQ2e/Kij0=;
        b=MugzJCkNjEQi0l6ih/P87UjZTcQUC/C1joaA+SjZDTpH/pYJB0Zh7vIU+k/9xb/7ZJ
         +9KT4tZgkLdq6OWRm92jC7M6jfNHeZTzZokLLM/saqP2xU5RODpljfuYNbH1YeVZexhH
         HsX+zFlPKvMnwzazJzc3DZ59x5rhgCU5SzTE56YZfqiaUnKv9LEy/P8ouHNFibhJpuLz
         LAAGbAT9TJiVSHSVOznyaC9ZvbcvhY/TXt7qje1eizJUM/K9qAZ7Zrv4L8V/EDzfwo13
         as+4Q6zL8zqplnfZG7E/+HXoM2PeR4e23wWUpDCZ1BraX3lRsjeO+ZORZzcy43qoRkfA
         e2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1ap+LN9xt8LVjDA6xeK3vWW8HvYkM4PsGmSQ2e/Kij0=;
        b=bHmwiCQPZk9MSXbukDyY3GTt8v8y8pO2spdKGCe0igiclelyC0lpr1qe0XqnNEzYfq
         DHt+H53tADUhzfu3xtIpGOcOgEHDaqgbSgW21SO7x4K6xS42VYFP7ecNqxDAAy/lRnuS
         jBDcOsdaLv2Iw3NXod132Ori5WtaCgU+r93UdsDO2njaJfxTfVf9K3Ss/JFeTYt7oMYe
         UZfIugMv3LQai6R2rT7R/QRU9a70a1Nped1zXG8c47YoCE1zFD7X8+hY4e4K6etDK+Gy
         sSeL2iAsm5pqlcTSoVTQiUv+cfHtxuY+KrUDZIsirpZHGsvcXjpHl+v7dPGIIdnQdijv
         4Usg==
X-Gm-Message-State: AOAM532KcfTgTdQJE4GZxUOz9DhAye32hblQ0l7dBi5YLnqMyr72bIm7
        w84/qTlT6QV+G9rhtMJNVBhVVA==
X-Google-Smtp-Source: ABdhPJwabxwPi8iNQy6HWxOrXPm+3cPn1tnBFJXUzMLocq2K/pMJt+MjbmSnwbVh2NIDFH7knNIp8w==
X-Received: by 2002:a17:902:7048:b0:15f:34c1:bae0 with SMTP id h8-20020a170902704800b0015f34c1bae0mr10242169plt.71.1653062012098;
        Fri, 20 May 2022 08:53:32 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v62-20020a622f41000000b0051835ccc008sm1940166pfv.115.2022.05.20.08.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:53:31 -0700 (PDT)
Message-ID: <7e78d6a7-1cc3-2408-fe91-0329f5020e77@kernel.dk>
Date:   Fri, 20 May 2022 09:53:30 -0600
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoe4HP9iTA6l/For@zeniv-ca.linux.org.uk>
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

On 5/20/22 9:47 AM, Al Viro wrote:
> On Fri, May 20, 2022 at 09:34:46AM -0600, Jens Axboe wrote:
> 
>> I'm very sure, otherwise we're just accepting that we're breaking real
>> world applications.
> 
> "Breaking" as in "it used to work with earlier kernels, doesn't work with
> recent ones"?  Details, please...

Yes, as in exactly that. This is what drove this addition of
->read_iter() for urandom. See commit:

ommit 36e2c7421f02a22f71c9283e55fdb672a9eb58e7
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Sep 3 16:22:34 2020 +0200

    fs: don't allow splice read/write without explicit ops

related to the set_fs() changes, and now go look for any commit that
has:

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")

in it and see that this isn't an isolated incident at all.

tldr - splice from /dev/urandom used to work, and I recently got a
report internally on an application that broke on upgrade from 5.6 to
5.12 exactly because it now just just -EINVAL's instead.

-- 
Jens Axboe

