Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AC148623E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiAFJlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbiAFJlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:41:00 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93944C0611FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 01:41:00 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p15so5688320ybk.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 01:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fR7IIRArFMGHGL4Y7ewnLWhKofR0hpOY8//Mz/xfJMI=;
        b=FmZciMLM970aw+DX6FViM/xRrFSOBMQ7FUR64UFUi8YJUNTymxPnHTQjAK6EYVGz6O
         693w1Fe1IofdWBdhm7W4LI4y55Qp5kU7qBezVxmZfHkD+/yAGfQXJ7zSpS1a7CZZflKD
         n7wA1/NgFjNvi51nfKQXjlSok3FEWCUA211IhAbBMbl9BDiSNCMGcXa16mox607M+QbW
         YS0TTIS+ce3rHykgFwdeVPZIyQCcxcKWULn95ogo1Tk+8EEC+WHBYquTTmmV1/nMLSd+
         6RQ/is1ePANxltHky/p5oDKG13Z+SOnzdFA3b0YvPYnNflFSBNQlAK03fRUPTpBcS9P0
         L7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fR7IIRArFMGHGL4Y7ewnLWhKofR0hpOY8//Mz/xfJMI=;
        b=Y0IX+B4UB5xVCtwJaVg8o/Nvxi/4MIoDzHxyUE57kNf/rlSt4ihgP/m+CR2M1QQvSL
         wScHlFTmHdrfeExXv0XW2a+I5J2K/i7kZuwo6fhREYV7IA63DxggXbCV9pbm2TY8nqPs
         xUVSvHPKtnbKswe/2nJXC9qcDtXsHQDdOtrkP2Lt3nJmxeW5Z0Ca9lLyL9HUlcJ4vFO6
         OFC4pAcXsAL5blCw7nmM1lFgkYtf2kdbC6TgxkrotPzLi/8aaK7sa4UVsRYI9hUUVMNh
         qBsKW15Snp0HblgwKfjEwE0vK2TXvdlKdbE+yF+SWtYOIyoLOajbnlK9Jf0W5dSz3i6h
         kaIA==
X-Gm-Message-State: AOAM531pwb478gapvdcPkAcuZfe4irJdFy/KdmH/T0NIB6GNvjKCfh3i
        qeRPgA/IyYlNmkOytFAtaefq4EADNMm1uNH+y/inCg==
X-Google-Smtp-Source: ABdhPJywhRECp7C5vpSBVpBMwqj4puOv3mfX4vIAmNdCr0nl+R2GBF5FDnlLm98Y9a1T1JjDic1zvq9n1pN+OpJdVeQ=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr72636310ybp.383.1641462059361;
 Thu, 06 Jan 2022 01:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20220106015721.3038819-1-imagedong@tencent.com> <20220106015721.3038819-4-imagedong@tencent.com>
In-Reply-To: <20220106015721.3038819-4-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Jan 2022 01:40:47 -0800
Message-ID: <CANn89iJv9OUmwdCSQ-A9GRU78B5XLXEqx7t-psjU6tKOX680pA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 3/3] bpf: selftests: use C99 initializers in test_sock.c
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 5:58 PM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Use C99 initializers for the initialization of 'tests' in test_sock.c.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

I would have done this patch before 2/3 really.

This would make "bpf: selftests: add bind retry for post_bind{4, 6}"
much smaller.
