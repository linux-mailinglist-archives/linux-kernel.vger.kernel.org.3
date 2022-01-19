Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2146A4936C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352768AbiASJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:00:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59532 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiASJAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:00:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2793B81910;
        Wed, 19 Jan 2022 09:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C44C340E6;
        Wed, 19 Jan 2022 09:00:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c3dQq4AT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642582833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2dOFJ+UpcJtVObG5xI+XoGYifJptafHjJhs8HGfwX1w=;
        b=c3dQq4ATbm3F/187EqTQn/DEc2+TVz5Z6Leei8F10Yf3ixE2Uu6PJW8ci1EnHZrfZM0tzK
        HOkeqMqMuOacinhQ2L5LbbQObXWehm5LhxLXbvyOgx2P8gpomIxL5mz6xFs3X39Twpe18H
        6UV6m97d9dMYHbb/v+7tKMp5de21ePo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 421036da (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 09:00:32 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id h14so5248579ybe.12;
        Wed, 19 Jan 2022 01:00:32 -0800 (PST)
X-Gm-Message-State: AOAM530BhqfR3QltI3Z7G0ouie/zAHliCS+NY/St1793O9Xz0eMhzuTM
        GtHe7NGb1D1BfdzgEVAsDpWx6R8yivZkteqdB/M=
X-Google-Smtp-Source: ABdhPJx4RyuigxoTOZs8Or8CkU4hkibFalbgQMbYzSXkFlEEIcgX6zw0oBRh/W5vLkIRmue8eoXzbhHlni3UQuAdKpE=
X-Received: by 2002:a25:e7c7:: with SMTP id e190mr12418681ybh.457.1642582830614;
 Wed, 19 Jan 2022 01:00:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Wed, 19 Jan 2022
 01:00:30 -0800 (PST)
In-Reply-To: <20220119082447.1675-1-miles.chen@mediatek.com>
References: <20220119082447.1675-1-miles.chen@mediatek.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 10:00:30 +0100
X-Gmail-Original-Message-ID: <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
Message-ID: <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     miles.chen@mediatek.com
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

Thanks for the patch. Could you let me know which architecture and
compiler this was broken on? If I had to guess, I'd wager arm32, and
you hit this by enabling optimized blake2s?

If so, I'm not sure the problem is with weak symbols. Why should CFI
break weak symbols? Rather, perhaps the issue is that the function is
defined in blake2s-core.S? Are there some CFI macros we need for that
definition?

Jason
