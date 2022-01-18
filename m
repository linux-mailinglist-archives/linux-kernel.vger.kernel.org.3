Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4E491D26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358998AbiARDZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349986AbiARDJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:09:43 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C426BC06177B;
        Mon, 17 Jan 2022 18:53:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id j64so949180pgd.6;
        Mon, 17 Jan 2022 18:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=+dXow2D6kovl8GlAwap0AWMuajUQM5lAihY8qrTDEBQ=;
        b=Uv5L+1MPSrZqYe6Y8HG3UarPEcwEh0vkALvNOq2xAcgsltUatlSZhvAu4ZkCRlnxRP
         FG+LVXfusldaMUz7UqtURH52quTwxGC4/yimq+EOUpXqGwqor+DRCSsIvtYOcwN5QHl5
         W0R7HB/qG+3G2BxsGHl3Nt2xl43WRVP2gKUNTM1deSRo/DtHOwmzXiqK7q8tBs2HSebO
         pWYwrS/JgPs0ZJX5DjKnNjoEiljdIijhBH8X5esopzUOPtLubpjKOZixwwD4k2cn7/xZ
         xKKuycvIHwFIBOdVyt2yBQlZk3YaT50+wDcE8ANxk8CcAe3Avs5rNQ0FcOr7XVPi1ovc
         soLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=+dXow2D6kovl8GlAwap0AWMuajUQM5lAihY8qrTDEBQ=;
        b=gAFgnmpcQT1OztvzzvkDSFRT3bONZmZf1XfTN7NnVTcsLd6hts+D0CB+/RkbdopkP2
         2jMlEpfHbp5b71XRXH1rY5rrAvufsRj/O954OT4xf4cXVg1+tbsBOINuD55lnMyrnPrf
         J3llr4whsEhCv//N0/2D3YElykPvYlc4yVr7hDCMe3SKJVHmSJJ20cbUUfNLArXchJSa
         Z06fwlJK+xITK7CPDr9n/kL+LB++f0SyLO4MHvVjZx9rlshh5azdGdB6e5k7wC5Ogv1A
         K561637vzr05qwhJzmxIXSptJblalifN3XBspaKpIzNsMfEzxsUYsCdxKokzmL5x2uJy
         5idQ==
X-Gm-Message-State: AOAM5314dax8JK3pGW9lzXf9E81dr1xMx0z5Sv4mKwsic5LbM7i9r21R
        pLVzuWWAbchbm5QBP/OBpdE=
X-Google-Smtp-Source: ABdhPJwyL7zGIsi9bIicvksHnAC4wjZ/DiXJE76/NAwmIpYKT6kHX1pZelN6IF0T1eLHS2LvHWGV5g==
X-Received: by 2002:a05:6a00:23c8:b0:4c2:6a7:95c5 with SMTP id g8-20020a056a0023c800b004c206a795c5mr21194442pfc.53.1642474382328;
        Mon, 17 Jan 2022 18:53:02 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id i4sm617438pjj.30.2022.01.17.18.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 18:53:01 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:52:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Let user to control huge vmalloc
 default behavior
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>, x86@kernel.org
Cc:     =?iso-8859-1?q?Benjamin=0A?= Herrenschmidt 
        <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
        <20211227145903.187152-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20211227145903.187152-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-Id: <1642473992.qrnqczjfna.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Kefeng Wang's message of December 28, 2021 12:59 am:
> Introduce HUGE_VMALLOC_DEFAULT_ENABLED and make it default y, this
> let user to choose whether or not enable huge vmalloc mappings by
> default.
>=20
> Meanwhile, add new hugevmalloc=3Don/off parameter to enable or disable
> this feature at boot time, nohugevmalloc is still supported and
> equivalent to hugevmalloc=3Doff.

Runtime options are bad enough, Kconfig and boot options are even worse.

The 'nohugevmalloc' option mirrors 'nohugeiomap' and is not expected to
ever be understood by an administrator unless a kernel developer is=20
working with them to hunt down a regression.

IMO there should be no new options. You could switch it off for=20
CONFIG_BASE_SMALL perhaps, and otherwise just try to work on heuristics
first. Bring in new options once it's proven they're needed.

Aside from that, thanks for working on these ports, great work.

Thanks,
Nick
