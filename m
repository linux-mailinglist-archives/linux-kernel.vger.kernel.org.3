Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E9A4936D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352768AbiASJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:09:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40064 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352786AbiASJJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:09:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 502A461455;
        Wed, 19 Jan 2022 09:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691A9C340E6;
        Wed, 19 Jan 2022 09:09:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GmDnD7qK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642583343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28KnNoVV1Kbl+7o1ojcz/PfZRpiIvLKDsWmtd4coQEU=;
        b=GmDnD7qKe49YACCFbopCGc5ngi0WzKrXjuC5UT1Klfqho6xXR4ydzgLY6nPyZnlRMUkLdq
        nXzZ/sfhNSonNQ37z41vcVLjwM1cAekWm0mhCGr9cMEn1nwaWMaTgMC+6QZYNX/WxDr5gP
        UCeMOfuDJT8kZL3dY6BhFMpVVjoqzrM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5baddba0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 09:09:03 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id 23so5373375ybf.7;
        Wed, 19 Jan 2022 01:09:03 -0800 (PST)
X-Gm-Message-State: AOAM532zNAMkrffr1ldRwhbA4TFl86uKDyI+vWm2QDg2kfZKzTfu4dZK
        uZHYJ4+VQq1ruUAXeVzC6D2eKRk7I+pNMGMqawA=
X-Google-Smtp-Source: ABdhPJzG6z2HP2Fpbnw/+p79pIz+HgBq3C/StXJgsTbO8ywBjYLt7mHo6tRFQLsHVGYNE2zEqTwfSOaO+0Qoz6xVLCs=
X-Received: by 2002:a25:e7c7:: with SMTP id e190mr12455559ybh.457.1642583340917;
 Wed, 19 Jan 2022 01:09:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Wed, 19 Jan 2022
 01:09:00 -0800 (PST)
In-Reply-To: <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
References: <20220119082447.1675-1-miles.chen@mediatek.com> <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 10:09:00 +0100
X-Gmail-Original-Message-ID: <CAHmME9rWs_w_dMfDLFuD-tr79cnVyuny4fLn9Wh0+bs76Nt0MA@mail.gmail.com>
Message-ID: <CAHmME9rWs_w_dMfDLFuD-tr79cnVyuny4fLn9Wh0+bs76Nt0MA@mail.gmail.com>
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

Hey again,

Actually... It looks like the issue is that in this file:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/crypto/internal/blake2s.h

this line

typedef void (*blake2s_compress_t)(struct blake2s_state *state,
				   const u8 *block, size_t nblocks, u32 inc);

should become

typedef void (*blake2s_compress_t)(struct blake2s_state *state,
				   const u8 *block, size_t nblocks, const u32 inc);

Does making that change fix things for you?

Thanks,
Jason
