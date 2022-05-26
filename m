Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0655F53555F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347642AbiEZVT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiEZVT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:19:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA799D04E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97103B8220C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ADCC385B8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:19:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jjydjG5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653599989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aeAvJmSvFUWJrZOlMiU0mmnHMiaZt9VEnhhq5hvVRHE=;
        b=jjydjG5F5KSgIh4SAfFncFRVTIhL0GQkLAO2A3IoY71IVa8UbW5oOglzsUUi6Avy8LR0OD
        3YuDPZOkLikaXCL8tgQWmNrwd1unt6QYMwiuVfQmilovZOCyr4hwUWo5Ek5FYn3tbtBNQ0
        4XeELS9EHjBMzvbvWSgQWDh1s8EPuRw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 04b943b0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 26 May 2022 21:19:49 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2fee010f509so28575257b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:19:48 -0700 (PDT)
X-Gm-Message-State: AOAM533CdcfzfH9IPht4kzK2OTyXqAvPVM5gAoXCKTyS7h6y46KWyaq/
        7+Hz4lYL1oJ4CSlv1kmKa6cexxgD+zLxbiJa9HA=
X-Google-Smtp-Source: ABdhPJwDvcjeCn7xjccrAFPbptfsz809iXBfmkXuceGJhqYcU2jRrAGM1p0iJ7EWZ0TWlT32BtKNLplm80IoemCZf6Y=
X-Received: by 2002:a0d:ea14:0:b0:300:4bc2:ee31 with SMTP id
 t20-20020a0dea14000000b003004bc2ee31mr10698325ywe.396.1653599988272; Thu, 26
 May 2022 14:19:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6403:b0:17b:2ce3:1329 with HTTP; Thu, 26 May 2022
 14:19:46 -0700 (PDT)
In-Reply-To: <938111ca-d3c7-9888-24f8-0017a989002b@kernel.dk>
References: <20220520095747.123748-1-Jason@zx2c4.com> <938111ca-d3c7-9888-24f8-0017a989002b@kernel.dk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 26 May 2022 23:19:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9pSZYZSz3YLRK7onO0E6zq9_B1GNwoTOkEQy_kws200Fw@mail.gmail.com>
Message-ID: <CAHmME9pSZYZSz3YLRK7onO0E6zq9_B1GNwoTOkEQy_kws200Fw@mail.gmail.com>
Subject: Re: [PATCH] splice: allow direct splicing with chardevs
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Al,

On 5/20/22, Jens Axboe <axboe@kernel.dk> wrote:
> On 5/20/22 3:57 AM, Jason A. Donenfeld wrote:
>> The original direct splicing mechanism from Jens required the input to
>> be a regular file because it was avoiding the special socket case. It
>> also recognized blkdevs as being close enough to a regular file. But it
>> forgot about chardevs, which behave the same way and work fine here.
>>
>> This commit adds the missing S_ISCHR condition so that chardevs such as
>> /dev/urandom can be directly spliced without strangely returning
>> -EINVAL.
>
> Should be fine to turn this on for char devices:
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>

Was wondering if this would make 5.19. That'd be nice, as it's the
release in which we switch to read_iter().

Jason
