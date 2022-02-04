Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB424A9942
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358768AbiBDM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiBDM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:27:44 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CA9C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 04:27:43 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v186so18265387ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 04:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E3CkuQfRDLa6yHQhfPXnQaFzdcsQFUeKCKzEBzUj/zQ=;
        b=TLYrEShYRf1FgVk7hHjObf4x7nd8odacHjXXRpq7yKoaHl2d4cJ8VON/yE+OgjlACN
         Deh2m4l0lPgbHURrAba9Ro14SwwCHOG+0Nv/hlUJcn2mcThUbfxE1IEO+W36tUg3MKW8
         n9FacUSOrGV/A/mXTq2Us80gIm1AwkidrArvgQCcxcpwcOfU251m8g9w7lWjvl5mpD4u
         SfanAQlOPlFgouyo1XEy0iTabqHr8/mV6qhVD2e86dRrwMGK8LqcKRLW9ShW+qjxuzZP
         Qoqi5BjNrLiMA0YsO4/3q0qFyxsOyT2LoygR0q9mALUNNnZ+Tl4jGIva6c7WrbMUHXYo
         vjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E3CkuQfRDLa6yHQhfPXnQaFzdcsQFUeKCKzEBzUj/zQ=;
        b=2dGh7LURKs7DGo5ZipfJIygDfp1u9ZTKpWXvGZKBwHkyQDnos81KQasHxRFtVr3604
         Q/M26Jgm6ZZv7ZDmnijDYKm2uOSbONDyuu/atJxo9OgNs3eTcOR3RQ162cdymF2fmdQe
         zhTq5eoRGVD66T+x1HGnSFMrG+iiirwTbgiNuPyAG/TCHWvfr4y/DmYlpeP/j9e5Bag1
         WQQ+CmjoPentUvzhoDFsMbhcxtGz4eJsqu/S7fB53si0R0YyHWuXRXWU1AW9iU601c/y
         QZw0z8DIWYbNdaIoXhtK7cGsoLzHiDIf4fjSH4PM9yq1c8YKxMIPhyAv0drXw0ECioYH
         L7iQ==
X-Gm-Message-State: AOAM531bYpvDijOg9iMIi8B7lucHVr4ovP4QLLBCaNqhTc1w319Rluv9
        9Vu4gaadzLNx7j4GVueYKIUX90lM8O2JOvZdTNKJdg==
X-Google-Smtp-Source: ABdhPJy0uUYEV/PGiz45GMg1qGGeLJ0gKE2zXBEUciykyjrQIx6iwM/SZFE1OhdU1ZXjgjR2rQwIB4Km1IhUiy5ChGA=
X-Received: by 2002:a81:6605:: with SMTP id a5mr2526438ywc.510.1643977662982;
 Fri, 04 Feb 2022 04:27:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:1756:0:0:0:0:0 with HTTP; Fri, 4 Feb 2022 04:27:42 -0800 (PST)
In-Reply-To: <Yfyx8s9n+CZ6TPgg@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com> <Yfyx8s9n+CZ6TPgg@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Fri, 4 Feb 2022 09:27:42 -0300
Message-ID: <CAKgze5YZF09F3FTwD6kODd2RrWATutcmM5J7-wcLTK32C6aptg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto capabilities
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22, Mike Rapoport <rppt@kernel.org> wrote:
> On Thu, Feb 03, 2022 at 01:43:28PM -0300, Martin Fernandez wrote:
>> +Description:
>> +		This value is 1 if all system memory in this node is
>> +		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
>
> It didn't jump at me at previous postings, but other architectures won't
> necessary have EFI_MEMORY_CPU_CRYPTO marking crypto-capable memory.
>
> How about
>
>   This value is 1 if all system memory in this node is capable of being
>   protected with the CPU's memory cryptographic capabilities. It is 0
>   otherwise.
>   On EFI architectures with value corresponds to EFI_MEMORY_CPU_CRYPTO.
>
>

Yes, sounds good to me.

Is there other architecture with something similar to this? Or are you
thinking on the possibility of such architecture?
