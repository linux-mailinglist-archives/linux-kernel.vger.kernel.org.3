Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BF0531814
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiEWUFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiEWUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:05:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544CF8BD21
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:05:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso347191pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=8nlcPdUIGG2cVtX3RxOVUlvfsw4FPYq0A3k29gmR/pU=;
        b=T3D6yNJ37K7Afl1Tb0B+iS0pzL7eDNFeRj1lcKNj7dh/uPFFOGQYZBflz3r330WMWs
         v8zJ4tt9zPGQDeMAWnS0eTaXNEQJ118SPRLPlFw5jOC3o9BxPhQyXmenCcMYwrqCk2A3
         VePb6xiEgrKUqTVZbz0hLT80m/T/zqgLZ9FzW83kyK30815NArQk5bH2PQdH0vuymT/z
         1wSIVhACFrJX5tdCStlbpXHi2ueWtTfw1i3i5YoxoSXC7agx/x5c+dft9Zn+qRwQOO1C
         uzoPfjwKuB8LB+fp9jViGOvgCmVs8+svbJ/Q/DTIRlP89GJl6ptr1wNCMhfSLqELJ+OL
         t80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8nlcPdUIGG2cVtX3RxOVUlvfsw4FPYq0A3k29gmR/pU=;
        b=5Ni0h+kCXyvsju++4qP/MZ7ykg7UxP85o6o1RnSNgSPpJ5QVgCW7ouNQoJof+zYMrW
         Umhu5HOj2kH+DbqqZFgehrzb6htRP6UXQzs0De4t5WZU5Fz2MeTPG5iAGkh1g0h0IzLU
         Fr8OV7JGHwemfP8TsYZ70bhQastGQCBahmvJnCxdf0wNPFifYA1MIZKkG3Jh1cBslmyc
         V5GZsKQgJKcXVwgRYL/s3gyJ/KxqQXv8EJSUcY/7oC8Tne48wdaHEjaRDxFz/gDT6REF
         aIDne9QylZNfplEWFF5xCrRzc5kcMwo0dpetAYQr5lIQfUJ2+hPIQMqLvtZ6sOEJdgGY
         hSjQ==
X-Gm-Message-State: AOAM533MiK80IFLJPN+WySY8NWow7A4+HORlZAshQvQCpqAdM0s45Nau
        srSTAlNR9+E4kaeUEAQ3DZ0xiA==
X-Google-Smtp-Source: ABdhPJw5jFG8elE6hgZ8FZveZNV3BjkMoKBiRXm9zUm5oqGpeDoeKe76siVSOtsPMKKhmzBClRVq+A==
X-Received: by 2002:a17:90a:cc6:b0:1d2:9a04:d29e with SMTP id 6-20020a17090a0cc600b001d29a04d29emr679619pjt.136.1653336333432;
        Mon, 23 May 2022 13:05:33 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id ge10-20020a17090b0e0a00b001d75aabe050sm83853pjb.34.2022.05.23.13.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 13:05:32 -0700 (PDT)
Message-ID: <e1f7a033-e1f2-bb52-536e-e7975ca93235@linaro.org>
Date:   Mon, 23 May 2022 13:05:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
Content-Language: en-US
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz> <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
 <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
 <YodNu2C5iHKW3UeZ@slm.duckdns.org>
 <489592f6-b783-7bdb-2cc8-0c8e35ebc674@linaro.org>
 <20220520164255.GB17335@blackbody.suse.cz>
 <6ac66e89-2063-c5e8-df15-f77b76befc05@linaro.org>
 <YovaKZV7IzQgCo9E@slm.duckdns.org>
 <7bbf2792-355b-65a7-e239-879b3f928384@linaro.org>
In-Reply-To: <7bbf2792-355b-65a7-e239-879b3f928384@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 12:08, Tadeusz Struk wrote:
> On 5/23/22 12:02, Tejun Heo wrote:
>> Can you try holding an extra ref in the killed path?
> 
> Yes, I can try that. Should that be with or without the extra work_struct?

With this patch:
https://syzkaller.appspot.com/text?tag=Patch&x=1264b23df00000

The issue still triggers:
https://syzkaller.appspot.com/text?tag=CrashReport&x=162b5781f00000

-- 
Thanks,
Tadeusz
