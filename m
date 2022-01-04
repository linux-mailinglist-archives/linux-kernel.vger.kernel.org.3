Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28A448425C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiADN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiADN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:27:04 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F5AC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:27:03 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id g5so28260480ilj.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74gu9JZubuKYRl/uklnRtpTi2dnVxEJ4sl3z6B62cNc=;
        b=Qs0Cvp40Q2vcdHhYjTn9Cq9VBfbSIWP5QbgKp04p6HXaqaI9ANW+4AlvEPHeOvIYaM
         XywnW/09YSBfxhWiZfCuVxbz/7QoQTo3digk3zUg2w96s0b+XTssG8bMamEW7jD7QwIP
         Gqa2WHLPvMIBh3G47ENrgL8UzbYX+yMYDvhk8CNV/NljcykOd2ffcKvXuUipvwAf323r
         fu+pgLl3OW7cRJgafZ3y+Jfv8T7jG/4V3IQgmttyIOZxatfvJSiVGb3tjyizPqwKNuRK
         k5QMuXE8G5vTmbbyc43aRJe37AJMj4BBGYQs8uG4je6C3yUJ1IuuEHFqYR7s59xM8+wz
         XPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74gu9JZubuKYRl/uklnRtpTi2dnVxEJ4sl3z6B62cNc=;
        b=n4ZfjedVJqzcIlLVGw4tsdb6TJ1+RQC8GgOy57xTn7SLyLjoMRp+cQTAsW3nS0/NtM
         ZWZNHIVRhnwsV2n2TAhlj3QbZkgUWtPtfsK+zQY2OK0RXdl2MnRwHBH8LYLjdlMNQoyz
         VdtpSU3XXdNDtXcli6aEs2qvl98HfXJcfekifZI/7cxuK9NTUUJ4Uz920nSwkXdRhcEl
         X2oexeX1HRcje2XGQtdbqmgIPgxCE6IMJyiYAz1qDKGpVMmFrNM9dRJvxWrwyZfsSfUF
         b7zZtBNvqaisFIeoTI0n2wvRMRi4nCSUktqHEmls8oI0EsJ6rQr/bZSymLhOWq6uPeVr
         8I8A==
X-Gm-Message-State: AOAM533arwOfkhW4ZHEn4vWY5kexcr4nZbWZwPi5gMS0SfLM8yTZe8Au
        xXeBfFqfqG+TxJY/jjLEptI=
X-Google-Smtp-Source: ABdhPJwfGi8fbL2EPBcPAOXmqGROtwfhD9ThoZdOIcGL/kj+H1LnqMTLElfeQiQWlIarQAqwsLZBBQ==
X-Received: by 2002:a92:874f:: with SMTP id d15mr23708200ilm.194.1641302822551;
        Tue, 04 Jan 2022 05:27:02 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l14sm22693680iln.11.2022.01.04.05.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 05:27:01 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 75E9F27C0054;
        Tue,  4 Jan 2022 08:27:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 04 Jan 2022 08:27:00 -0500
X-ME-Sender: <xms:I0vUYUZPKLHawRb3lAbd3-lb972VcE_JuhxOwnnuAC5H5deMzIlOaA>
    <xme:I0vUYfbA4LVLh8izsH9C2Hm4lzzdx5TjmkPBy9HPN0JHMfEHxd-3pbrr1EwiVIOIe
    X0kAOoTsOp1qd-4-g>
X-ME-Received: <xmr:I0vUYe-EN4zpx2gWvdaC-FDrKf2Lbk2p9RvcYgHQu0YuUtUpqqI8JWFq8y1C7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeffedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:I0vUYeq_Sag27RvkR9Cy3spLy3oBH8dSQuEmJzcMfq4eecNmeB3jFw>
    <xmx:I0vUYfq2zv0_LdJu7aEO0w7vZZY8f-jiAbiiSORB4gCz09SYlI9_KA>
    <xmx:I0vUYcQgx8TMR2c6abtVNnE8-ODB3bS96W-wgd8qOSnZzNgMHQMjCQ>
    <xmx:JEvUYeVaAWlPOVGY_IrXY-KxSqSCawdpo4eAsvniMIiJP8Gefx7mnA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jan 2022 08:26:58 -0500 (EST)
Date:   Tue, 4 Jan 2022 21:25:58 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as reviewer for atomics
Message-ID: <YdRK5gEp/gVYSZPe@boqun-archlinux>
References: <20220104095018.1990058-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104095018.1990058-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 09:50:18AM +0000, Mark Rutland wrote:
> As I've fiddled about with the atomic infrastructure a fair bit now,
> Peter suggested I should add myself as a reviewer or maintainer to make
> sure I'm Cc'd on anything I might have an opinion on.
> 
> For now, add myself as a reviewer.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Welcome!

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7168aa..2f7126e104c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3142,6 +3142,7 @@ ATOMIC INFRASTRUCTURE
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
>  R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	Mark Rutland <mark.rutland@arm.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	arch/*/include/asm/atomic*.h
> -- 
> 2.30.2
> 
