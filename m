Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F065D49E244
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbiA0MWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231201AbiA0MWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643286171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxOgqVaBtovwOha3ZcVtcrq82KpILnkAf73efsykbq0=;
        b=JtNYiRixN9WqSC35fGTmecZaM8IeR4NCkqCj8XZRKeVtI1vaLpRrDTdXIFVgoWqF1Qt8CC
        URfK65cqqzGDLsNQxrirWvju8pscALU2NFunQd1k1aYTKwEkB+vKriHvFUqTOUHabXu7+T
        UOEfJDFSWCrO5drSeToYIAHU2bZezak=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-AmMQJFBvN2G8l6BtcGtqvQ-1; Thu, 27 Jan 2022 07:22:50 -0500
X-MC-Unique: AmMQJFBvN2G8l6BtcGtqvQ-1
Received: by mail-ej1-f72.google.com with SMTP id rl11-20020a170907216b00b006b73a611c1aso1229616ejb.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=nxOgqVaBtovwOha3ZcVtcrq82KpILnkAf73efsykbq0=;
        b=ppRgpWaZMCSLC8xV8Wi2HAfTBY0fL7FSD7Cra/0iZcyA4HDplEFm+QCDyFp6yptRJm
         +8nGRcT8l6DB8WgnLoXCPMFO4nHo/pH8SB8/5oriC08diejcb4+iKgvUScB7JfcNIPaR
         jfXK4bDVBsEKJlbUgo80SgSbX7r1Kas4R+YPh0oT5YopqSMFEtxkraKaVmw6IJYdPku+
         pF/vpkzFMjmg7w4TpoQsJsK7n3bXYW2C57FVGEFCGKkoZkxznv6ZOSJecTQh2pZ2HaNK
         2hfJR5LaXmwAVTTPkplnapXNhzMhaWKdlkCoFHgbXk1Z+xzyHcuHlZxtbFlK0pOux9bn
         HUKQ==
X-Gm-Message-State: AOAM5303Hbsl4uAWHspdEIZUxlcX1v4KfqsoNpqca7sD5iQ5cDCHFfew
        UUvWtabEYohhdaFqCZ560WtZw0swI+SjuW5Cyn/HwKSMryMACnC9XLNeh/qQ4xU3lrb8BkTId2F
        g0WopsZqEI6EfDTWEhjyQUYvJ
X-Received: by 2002:a17:907:1c1c:: with SMTP id nc28mr2649060ejc.651.1643286168896;
        Thu, 27 Jan 2022 04:22:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNVn0jnbx1OlPtjBvgMoVu5Kvzo5GMcACdQCd0LC5App747E8g74+qlOMI13AN7LLmriq46Q==
X-Received: by 2002:a17:907:1c1c:: with SMTP id nc28mr2649050ejc.651.1643286168698;
        Thu, 27 Jan 2022 04:22:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id gg14sm8654976ejb.159.2022.01.27.04.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:22:48 -0800 (PST)
Message-ID: <ca62449b-7ab0-0e18-ee5a-b46b3f527385@redhat.com>
Date:   Thu, 27 Jan 2022 13:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Jianyong Wu <Jianyong.Wu@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Cc:     Justin He <Justin.He@arm.com>, "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
 <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com>
 <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
 <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
 <3e6513f9-77ca-79e5-d185-7e9a11ec7689@redhat.com>
 <AM9PR08MB72764111B775352448D75CD9F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <65fdd873-1f93-56e3-c7a5-98d621c5dbd8@redhat.com>
 <7eb4bc77-c1db-99c4-4c77-ae9ddd159abb@redhat.com>
 <AM9PR08MB7276062BC7B474174FFFA11BF4219@AM9PR08MB7276.eurprd08.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
In-Reply-To: <AM9PR08MB7276062BC7B474174FFFA11BF4219@AM9PR08MB7276.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Yes, system_state can roughly separate these callers of __create_pgd_mapping. When system_state > SYSTEM_BOOTING we can add the lock.
> Thus, I have the following change:
> 
> static DEFINE_SPINLOCK(swapper_pgdir_lock);
> +static DEFINE_MUTEX(fixmap_lock);
> 
>  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
> @@ -329,6 +330,8 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>         }
>         BUG_ON(p4d_bad(p4d));
> 
> +       if (system_state > SYSTEM_BOOTING)

As there is nothing smaller than SYSTEM_BOOTING, you can use
	if (system_state != SYSTEM_BOOTING)

...

> 
> It seems work and somehow simper. But I don't know if it is reasonable to do this. So, any idea? @Ard Biesheuvel  @Catalin Marinas 

It's worth looking at kernel/notifier.c, e.g.,
blocking_notifier_chain_register()

if (unlikely(system_state == SYSTEM_BOOTING))
	return notifier_chain_register(&nh->head, n);

down_write(&nh->rwsem);
ret = notifier_chain_register(&nh->head, n);
up_write(&nh->rwsem);



If we decide to go down that path, we should make sure to add a comment like

/*
 * No need for locking during early boot. And it doesn't work as
 * expected with KASLR enabled where we might clear BSS twice.
 */

-- 
Thanks,

David / dhildenb

