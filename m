Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B525D48C55D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353842AbiALOAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241880AbiALOAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:00:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C1C06173F;
        Wed, 12 Jan 2022 06:00:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E55CB81ECF;
        Wed, 12 Jan 2022 14:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFB6C36AE5;
        Wed, 12 Jan 2022 14:00:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lerXnrWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641996005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOhOlEgBVQgPhb9Gboy64A9N5irkuSNKKiRZlGvn4hU=;
        b=lerXnrWJfOef9pHG0Gm+Mkpl+9rKeG1cri1sZ3SoglkpbK7uTSiQS0qVLJ8LSZ6f6wfC/x
        kmFkvnXfCY1TE1xEB4zJXiJpzX0MZRXuK1Zj5vJ3NGvs8hnIUAI//3aw2/Nq4nCb77kfvG
        ExlR/oseWy2V/xHfUFrFiLCA2rt6/YU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff84fd9e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:00:05 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id n68so6612791ybg.6;
        Wed, 12 Jan 2022 06:00:05 -0800 (PST)
X-Gm-Message-State: AOAM533Loed4DvQsXQMWT8RUfNanV0qBRM5wEMcMiDO+mmtdJFJIN2ln
        WEiSd1maDgSOWyIjwTmZNa3oTKnf4427bo6F8Q4=
X-Google-Smtp-Source: ABdhPJwmFfc5osGtSgQpTGuoXvRFWRdgo+l9VSprn/iHu3mU05gCdUitgcvhRLF3gi5snlZk835+s2qQcttfkIaasgA=
X-Received: by 2002:a5b:10:: with SMTP id a16mr13169741ybp.115.1641996005255;
 Wed, 12 Jan 2022 06:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20220111195309.634965-1-jforbes@fedoraproject.org>
 <CAHmME9pi1Y7urg1VQeCi7L6MxHRUk5g4wc6VKDywo4yPh9h_6w@mail.gmail.com>
 <CAMj1kXH24ubv7yAqmbnzqe22cGh1L0-N8J6fiCT2NgU2HmeBJw@mail.gmail.com>
 <CAHmME9qXg3_HdnDwN-LOBJQhxz4acYCjgQhXRovQ6-9TWwHwWQ@mail.gmail.com>
 <CAMj1kXFybcnneHwpvKYNnK0F3t48kqDpV-RKLgR1A+w4QbUxTg@mail.gmail.com> <CAFxkdAoC_Ap7YWqE5PLXczfk9YivuWPk5K303DuTuj9B8keERg@mail.gmail.com>
In-Reply-To: <CAFxkdAoC_Ap7YWqE5PLXczfk9YivuWPk5K303DuTuj9B8keERg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 14:59:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9o+J_xPWBXAmFPAubO08Un-7vhXf5uJn2Zj8hoYu9NyfQ@mail.gmail.com>
Message-ID: <CAHmME9o+J_xPWBXAmFPAubO08Un-7vhXf5uJn2Zj8hoYu9NyfQ@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: add prompts back to crypto libraries
To:     Justin Forbes <jmforbes@linuxtx.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've actually got a patch for the root problem here. Testing
now and it should be out shortly.
