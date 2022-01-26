Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591C049C38F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiAZGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiAZGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:24:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C72C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:24:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j16so10944296plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QuCDEbB8VnKG+O/u6cSnPrAUN00GDPgykj1tDVaexNg=;
        b=emhTebH+L3SceKSlN0/s0R+jFS0dqDM9nW074SwctJVhaQAx3YcnNms4p5h4WXJdAX
         uKWxMgwAvbdFDqo61bpRvo3ScVAiWrElx6x4+THAK2c3MeBVbLEU4PqFhwebH09W9+cK
         sh+ds0QIfAGpof32EAKg+MwzFRLKmZ/eFY/22S2WCTNbJukUJrjyT7sxd0UWhm1SQd4X
         LJyLhjgGu4Nuh7tnEfOdDhmbbuowhXQtakzqs736azRMHZd78gckRlBV5EIinZUwxtdn
         bZuIL8BC3fWihyycP4XeEVi2PUvOyMJpM+r8oG+ka+sLeG8S6rWoh5ZstJltnYTLCnLt
         AA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QuCDEbB8VnKG+O/u6cSnPrAUN00GDPgykj1tDVaexNg=;
        b=3YrZKmqlxbFtQVuXWk7R5Kvy+Z+YXt1BOWtVdTIBu1JbIczWmvLxhQr9DvkipiR0zk
         7kwPHS6xNLEZzM6gVFxpZAou4B8P+3+L9XlZk5lz97eav4gDbcx+HSTQuEPgBjH2KR+/
         O/JIFEXiEeZ2obN1tqp9PRQwoojZOjSl8pBbI3sE1uapxDFgGTx+Zm8PCuPFqhZUOFj/
         371gxR//+f8S0rqTMxcq5AqikON9KEBJ0wSYLbm2exYCGaEndnw8BMxhb34/L8tz1YQP
         E3wvSS2w48EHwgdjvf3LnC8YufsA74SI5MEpnAR6m0lZOqs9vj4gVySm/JkalWFYwif9
         C0TQ==
X-Gm-Message-State: AOAM530dLBfU7kmQqita6+XWKThiZoX23Vob8I7YexdHvdeWJ6+d8pLt
        vatIJzdasKHD23NUfwm7gAeUUnD6WMUEvQ==
X-Google-Smtp-Source: ABdhPJxbOj7ueKhSROIz/lSYvIuD2y7myt2Mpf0F58ghYnH/ODBs0x2d08+/Cm5awJLilGQ/lQifLg==
X-Received: by 2002:a17:902:bb8c:b0:149:8f60:a529 with SMTP id m12-20020a170902bb8c00b001498f60a529mr22153649pls.144.1643178253641;
        Tue, 25 Jan 2022 22:24:13 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
        by smtp.gmail.com with ESMTPSA id f9sm913746pfj.155.2022.01.25.22.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:24:13 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:24:10 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Dustin Howett <dustin@howett.net>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 2/2] platform/chrome: reserve only the I/O ports required
 for the MEC EC
Message-ID: <YfDpCqffa+5Zypg4@google.com>
References: <20220105031242.287751-1-dustin@howett.net>
 <20220105031242.287751-3-dustin@howett.net>
 <CALtnz63d7utST13=S7UbExDzSE0GnoFA7JowQkkFSqrSUTmCdQ@mail.gmail.com>
 <Ye95vRREnbaLM+EJ@google.com>
 <CA+BfgNKRNXVxLhQ2mAxiq-c3ipkFPdYoZee6myO8djmXWnfrYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+BfgNKRNXVxLhQ2mAxiq-c3ipkFPdYoZee6myO8djmXWnfrYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 09:15:45AM -0600, Dustin Howett wrote:
> On Mon, Jan 24, 2022 at 10:17 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> >
> > The original code:
> > - devm_request_region(dev, EC_LPC_ADDR_MEMMAP, ...) and then
> > - cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, ...).
> >
> > After the patch:
> > - devm_request_region(dev, EC_HOST_CMD_REGION0, ...) and then
> > - cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, ...).
> >
> > Does it work if it reads out of request_region range?
> >
> >
> > The 2 request_region are now guarded by the first "if (buf[0] != 'E' || buf[1] != 'C')".  That is, only non-MEC will request the 2 regions.
> >
> > Doesn't other MECs (e.g. non-Framework Laptop) need the 2 regions?
> 
> So, in both cases this should be legal. Here's why:
> 
> The MEC protocol multiplexes memory-mapped reads through the same 8
> I/O ports (0x800 - 0x807)
> as it does host commands. It works by adjusting the base address,
> EC_LPC_ADDR_MEMMAP (0x900),
> to 0x100 before it initiates a standard MEC LPC xfer.
> See cros_ec_lpc_mec_read_bytes line ~101 (as of 881007522c8fcc3785).
> 
> Therefore, the adjusted flow in the patch is:
> 
> 0. Default cros_ec_lpc_ops to the MEC version of read/xfer [unchanged in patch]
> 1. Request 0x800 - 0x807 (MEC region)
> 2. read() using the MEC read function (using only the above ports)
> 3. if it succeeds, great! we have a MEC EC.
> --- if it failed ---
> 4. Map the non-MEC port range 0x900 - 0x9FF for memory-mapped reads
> 5. read() using the NON-MEC read function (using ports 0x900 - 0x9FF)
> 6. if it succeeds, map the remaining host command ports 0x808 - 0x8FF
> 
> In short, only non-MEC needs the 0x900 - 0x9FF mapping for "mapped
> memory". Therefore we can defer the
> port allocation until after we've failed to read mapped memory the MEC way. :)
> 
> Based on my understanding of the MEC protocol, non-Framework Laptop
> MECs hold this invariant true as well.
> They should only need ports 0x800 - 0x807.

Thanks for the detail explanation.  After reading cros_ec_lpc_mec_read_bytes() carefully, I guess I got it.

The patch actually fixes 2 issues:
1. The original code accesses the 8 IO ports (i.e. 0x800 - 0x807) via cros_ec_lpc_mec_read_bytes(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, ...) without requesting the region in advance.

2. MEC variants only need to request the 8 IO ports.  However, the rest of ports (i.e. 0x808 - 0x9ff) are for non-MECs.

> Want me to send a v2 with updated commit messages?

Yes, that would be helpful.
