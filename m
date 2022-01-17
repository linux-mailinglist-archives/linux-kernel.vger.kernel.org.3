Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD766490FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbiAQRdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiAQRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:33:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B91C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:33:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v123so22054266wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fZgWPWOX9Mc6FibI4zRymEqtmZX2ottHTayO6iuSsq0=;
        b=OyzcBB+qy5rvsCZSRU/KkaPmbiHFhhrAtEzXEnoLEjKYvIWrJbt/DrsVNf5Z1udWOv
         PSad0frh2KtmWQkbt1/rDEfOhb3RaB0rMZ1kJZKXZ6/YDx5+9O+5lDpgPaPz82EFm9Cw
         +mSZuEhsmXaE6uZ1AI3nwGfVI2sPMZ3TDGHlMzEcMEX1bxBMCcvcAJZdU4L2ugw05agX
         ycMVOidCPnZLVBjLoCbG6RL/IjBrjuvV0YB33RQscWORkd9yZM1rqCOKATLkRMuWLOYj
         YWpuuJoS7kqqNfpCQNysX9au6OUkpuGzS149cxyNE/taSa8BU8E4D1/0jxqMI75I3ZTt
         +0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fZgWPWOX9Mc6FibI4zRymEqtmZX2ottHTayO6iuSsq0=;
        b=OisIS8+CAwLRfNqVwgj/H9/z1eH0X3eubGXQJFFaOQ9SATmjr9mCayXCpZnITLyuiF
         ClBx0CV7UHwJlSuIC2GsLKbQ+yMK6bhHqYN5RUbxA4yzTrKvxWliWgT5rWcRmN6IK4Vl
         whm98EMZN14HFCQWbVgXpehyoCPp53VhsL0CFbywnb67xYKEOAvDiWS7TZToD7ZxR0d8
         NRInIFsVQw1QUXBTxKKDnCVsiQ2TaWaXjmH1UpzpgT0kCViOy0t7LmpUbEPWDFQYASyg
         YT8HlI2VpvPMgZCHoFGt7/2w69HTVexjyL/3njFzTbt7NsednpxnbEQBrUSZJKHecGvh
         dGJg==
X-Gm-Message-State: AOAM531LcJ1feEtXtQEWv1tsDJwBlrNkHKbNXHmbG14fgRqCQUCVtRS+
        r/hDYL9RgpYwENKe7bJYP5rtKg==
X-Google-Smtp-Source: ABdhPJxqZx/+3nE4cUA+kCqTXZsj9eDyMdS0Rfo/QUBoPTF7miKiD/tyX72lD3xc48L8hcmTZg3B/A==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr20330024wrw.706.1642440821028;
        Mon, 17 Jan 2022 09:33:41 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id b6sm8184682wri.108.2022.01.17.09.33.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:33:40 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220117154433.3124-1-changbin.du@gmail.com>
Date:   Mon, 17 Jan 2022 17:33:40 +0000
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C2470F2D-9E45-49D7-A03B-E6A7BB4B9738@jrtc27.com>
References: <20220117154433.3124-1-changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2022, at 15:44, Changbin Du <changbin.du@gmail.com> wrote:
> 
> I tried different pieces of code which uses __builtin_frame_address(1)
> (with both gcc version 7.5.0 and 10.3.0) to verify whether it works as
> expected on riscv64. The result is negative.
> 
> What the compiler had generated is as below:
> 31                      fp = (unsigned long)__builtin_frame_address(1);
>   0xffffffff80006024 <+200>:   ld      s1,0(s0)
> 
> It takes '0(s0)' as the address of frame 1 (caller), but the actual address
> should be '-16(s0)'.
> 
>          |       ...       | <-+
>          +-----------------+   |
>          | return address  |   |
>          | previous fp     |   |
>          | saved registers |   |
>          | local variables |   |
>  $fp --> |       ...       |   |
>          +-----------------+   |
>          | return address  |   |
>          | previous fp --------+
>          | saved registers |
>  $sp --> | local variables |
>          +-----------------+
> 
> This leads the kernel can not dump the full stack trace on riscv.
> 
> [    7.222126][    T1] Call Trace:
> [    7.222804][    T1] [<ffffffff80006058>] dump_backtrace+0x2c/0x3a
> 
> This problem is not exposed on most riscv builds just because the '0(s0)'
> occasionally is the address frame 2 (caller's caller), if only ra and fp
> are stored in frame 1 (caller).
> 
>          |       ...       | <-+
>          +-----------------+   |
>          | return address  |   |
>  $fp --> | previous fp     |   |
>          +-----------------+   |
>          | return address  |   |
>          | previous fp --------+
>          | saved registers |
>  $sp --> | local variables |
>          +-----------------+
> 
> This could be a *bug* of gcc that should be fixed. But as noted in gcc
> manual "Calling this function with a nonzero argument can have
> unpredictable effects, including crashing the calling program.", let's
> remove the '__builtin_frame_address(1)' in backtrace code.

Yes, this is a bug, that is always wrong. LLVM gets this right.

https://godbolt.org/z/MrhsoPPM6

Jess

