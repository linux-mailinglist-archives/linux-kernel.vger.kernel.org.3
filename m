Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8AB485F28
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 04:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiAFDV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 22:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiAFDV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 22:21:27 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A48AC0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 19:21:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso1758108pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 19:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=L1kt8i+PKHaNiwL3dKZWcYg8PXU//JPnPYFIcwDdGfc=;
        b=2R0Da2tFc7++Xc3yybYIx+8Lh8wqtM9Mjox4PAZuIEDFcqITJek0A59lpXRvWUlXk0
         uF53KE3M8oeji64aGEwHFwT3WuJpkD+dBsw7/yt4ubkkB8RynEGp3sfCH/ChZNHdRwKV
         wABF92HSTztHwKgLaHghfMnbWBLGRE5sSZVgf1vJ2XOGqIkPIbjgSN5Ko5Ug0MmuwO6n
         5PoPoJpw9tpp4ir0O4bJ8UNC9v4JELpYzA2L/Db9H3U+iYpeHBAOM8ZbeHareODlS+Zv
         AfkBEf8hxLpqlT3pBLEj4e2rA0NByIlRmkZFefYd6/xhOPOueMj/79HVhTXkMXJ1XGqO
         qvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=L1kt8i+PKHaNiwL3dKZWcYg8PXU//JPnPYFIcwDdGfc=;
        b=mK1Sb2Pp8AijCg5aDgf/uQxJV6NF9HyKQs+K7xBRquslrJlpyK31pTvdvKW02+zQ35
         JQgma+8W8I+1uIzAjE7BRnem1/xtBT/EWdGRK0Juc8J4kmEbQIrN84/3mT2IVDH5g+A3
         7JVc7r7YYgEQYeYeP3AT1Y+VgEraMhicnVSwp+AP6uz5+2f898UwL2Qy2Tz/INZ7TVxn
         L8t6kn3R8+oO/8q66TBwN46xpRWIlKXjq/wnfX6C/25C31KhgHlNTLDlf5p/vR6zuCSX
         k+GIZM0sNyaRjkuBtH67FOnuCwsDUXgxAPCwpdKl5jEtqeibQ2B2QNUDyj27yyB5/Hzt
         tm9A==
X-Gm-Message-State: AOAM5300YJhjq4q8rF0ttKRw3YoDzByg0pNH8RqwrEukf/OCNAqti4PU
        /sSpxKTUuZtXjvhqUDSIQ6OTfQ==
X-Google-Smtp-Source: ABdhPJx+qsaW9e3nS8xYE3uGzJD868WVU1ZiRYqaH/dQax0aODKoR/36iJxLlMJS1PRFkPjsegb6YA==
X-Received: by 2002:a17:903:1cf:b0:149:b6f:4e98 with SMTP id e15-20020a17090301cf00b001490b6f4e98mr56918701plh.118.1641439286739;
        Wed, 05 Jan 2022 19:21:26 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q21sm467662pfu.176.2022.01.05.19.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 19:21:26 -0800 (PST)
Date:   Wed, 05 Jan 2022 19:21:26 -0800 (PST)
X-Google-Original-Date: Wed, 05 Jan 2022 19:20:58 PST (-0800)
Subject:     Re: [PATCH 09/12] riscv: extable: add `type` and `data` fields
In-Reply-To: <20211118152155.GB9977@lakrids.cambridge.arm.com>
CC:     jszhang3@mail.ustc.edu.cn, tglx@linutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, wangkefeng.wang@huawei.com,
        tongtiangen@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mark.rutland@arm.com
Message-ID: <mhng-84ef2902-21c8-4cde-9d02-aa89f913a981@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 07:21:55 PST (-0800), mark.rutland@arm.com wrote:
> On Thu, Nov 18, 2021 at 07:42:49PM +0800, Jisheng Zhang wrote:
>> On Thu, 18 Nov 2021 19:26:05 +0800 Jisheng Zhang wrote:
>>
>> > From: Jisheng Zhang <jszhang@kernel.org>
>> >
>> > This is a riscv port of commit d6e2cc564775("arm64: extable: add `type`
>> > and `data` fields").
>> >
>> > We will add specialized handlers for fixups, the `type` field is for
>> > fixup handler type, the `data` field is used to pass specific data to
>> > each handler, for example register numbers.
>> >
>> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>
>> > diff --git a/scripts/sorttable.c b/scripts/sorttable.c
>> > index 0c031e47a419..5b5472b543f5 100644
>> > --- a/scripts/sorttable.c
>> > +++ b/scripts/sorttable.c
>> > @@ -376,9 +376,11 @@ static int do_file(char const *const fname, void *addr)
>> >  	case EM_PARISC:
>> >  	case EM_PPC:
>> >  	case EM_PPC64:
>> > -	case EM_RISCV:
>> >  		custom_sort = sort_relative_table;
>> >  		break;
>> > +	case EM_RISCV:
>> > +		custom_sort = arm64_sort_relative_table;
>>
>> Hi Mark, Thomas,
>>
>> x86 and arm64 version of sort_relative_table routine are the same, I want to
>> unify them, and then use the common function for riscv, but I'm not sure
>> which name is better. Could you please suggest?
>
> I sent a patch last week which unifies them as
> sort_relative_table_with_data():
>
>   https://lore.kernel.org/linux-arm-kernel/20211108114220.32796-1-mark.rutland@arm.com/
>
> Thomas, are you happy with that patch?
>
> With your ack it could go via the riscv tree for v5.17 as a preparatory
> cleanup in this series.
>
> Maybe we could get it in as a cleanup for v5.16-rc{2,3} ?

I don't see anything on that thread, and looks like last time I had to 
touch sorttable I just took it via the RISC-V tree.  I went ahead and 
put Mark's patch, along with this patch set, on my for-next.  I had to 
fix up a few minor issues, so LMK if anything went off the rails.

Thanks!
