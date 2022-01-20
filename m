Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625CF494AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359622AbiATJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:44:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51762 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiATJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:44:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4539A604EF;
        Thu, 20 Jan 2022 09:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7B8C340E7;
        Thu, 20 Jan 2022 09:44:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fssD5vvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642671844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1vhBKyxUeexYoEpFA7C2RgBVPR3wFJ965AiyzZ7d1Y=;
        b=fssD5vvDonTjf+Ob+Bpl1G3vPKMhEseK8iREJoFAg6ynOzq+BSSo6lVquWfZvAcYlh6Lvu
        bkC7lhUCYYe16qmc0QIe3GrcAbiqnG1eqnXBufblVHz5zhcqCzPLluqfWpy6rtBhSxckFH
        s+P22Zx6skyLld3jyUnagQF/dm3ahQs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b2b4eba4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 20 Jan 2022 09:44:04 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id k31so14428811ybj.4;
        Thu, 20 Jan 2022 01:44:03 -0800 (PST)
X-Gm-Message-State: AOAM533MBGqBZGy49Epfeg2tbh5MtDXIxDtZPFOCerVwbIxk77sOKcT8
        TGTxj8a5ejcoskN2pHOkdp2sWGj9qtz0Zd5lE3w=
X-Google-Smtp-Source: ABdhPJzg1g/gym62qyvrV0DrQk1jKs3WkH/OEe7OV9zyQPzVSRgVDI0hITqpB3HjmG/WYqbbT3zIOQtxb62GLCP4W9k=
X-Received: by 2002:a25:854f:: with SMTP id f15mr45690101ybn.121.1642671843070;
 Thu, 20 Jan 2022 01:44:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Thu, 20 Jan 2022
 01:44:02 -0800 (PST)
In-Reply-To: <YeiPn8Mo1AM7X9Ud@archlinux-ax161>
References: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
 <20220119135450.564115-1-Jason@zx2c4.com> <YeiPn8Mo1AM7X9Ud@archlinux-ax161>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Jan 2022 10:44:02 +0100
X-Gmail-Original-Message-ID: <CAHmME9rPy=T=0Ddbw+01bFycXNPfuxgMm+U80DzDSLy0Cdh_Gg@mail.gmail.com>
Message-ID: <CAHmME9rPy=T=0Ddbw+01bFycXNPfuxgMm+U80DzDSLy0Cdh_Gg@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: avoid indirect calls to compression
 function for Clang CFI
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22, Nathan Chancellor <nathan@kernel.org> wrote:
> On Wed, Jan 19, 2022 at 02:54:50PM +0100, Jason A. Donenfeld wrote:
>> blake2s_compress_generic is weakly aliased to blake2s_generic. The
>
> Isn't it the other way around?

Thanks. Changed that 'to' to a 'by'.

Jason
