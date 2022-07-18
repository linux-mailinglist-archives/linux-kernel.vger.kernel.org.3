Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD1577FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiGRKmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 758611EAF6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658140969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLrScKBdhpCdLMjjpdXV8SaTREGDjAlN+Xk7aTHMv2A=;
        b=GSvF4Bj9d2zoHiEDT20R9254GvzaPahjr6BCsO53m19deWInMEBy2suJwj0ejVhpbe0O/q
        YK+eD6ONsin4DmEyI3HJ1EwvhgDfAKit1O82XazpGx+1v3Ox0Om1YMTw7goR6LFF2s8kk4
        F6/sDc5wcISX3/ExyAAxsYLd3JBzmX4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-DlBkbfBCNDu9IcFgyZNHvg-1; Mon, 18 Jul 2022 06:42:46 -0400
X-MC-Unique: DlBkbfBCNDu9IcFgyZNHvg-1
Received: by mail-wr1-f72.google.com with SMTP id l11-20020adfbd8b000000b0021d754b84c5so1916097wrh.17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=oLrScKBdhpCdLMjjpdXV8SaTREGDjAlN+Xk7aTHMv2A=;
        b=UtyN9E+9J3hAwge7JmMJQShb7PVlXiIoa5I5bOMM7GFr6/HZcOi0dqq5Eg1fVu395l
         7252uRlI39elgxNesRV+8VOyGqze7ARiqHK5QiqoBWR6++7/JkltecsG8DzyF0QkeBZ1
         5y/rqJ39NlbjjoUJp4LPdyxERwFc1OyjErcd7QDhd98GjT8PasH3vMNw6sj8/Pd4Am/2
         7By++Bz63h8jVEbOQzIfq6nRqWZznaTONTLS7hDoOcEbktnTLC2F45rfIolo/cxFWihf
         3EK6hE3zsuOyukDwIwq3KfqLq6qeZ5rO1VnKkkV76cvqEMAs1NcSfcBfNdcEsTeFzzW1
         x/Sg==
X-Gm-Message-State: AJIora8XOXHgSxo8/Wn1xRTHlPSiy//fW+ggh2kren90EHbeL8JvUZ/i
        YdVpAlsaTDI6hCatnTK9u38zW232ruZS8b7b/g8bo0O36kbFEz7aDos/SmN2WJwaWlLZD6yOBNs
        Z1BYLnTPOkmomZGbljYXa7hkZ
X-Received: by 2002:a05:6000:1cf:b0:21d:656c:dd9f with SMTP id t15-20020a05600001cf00b0021d656cdd9fmr22448989wrx.15.1658140964969;
        Mon, 18 Jul 2022 03:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvyVTXl6JyA3KOeMpwZznouh8ZkjX9bsFoPFeugUtbQI8wxCD+26JoafOfE/Ds+FNKbNgmrA==
X-Received: by 2002:a05:6000:1cf:b0:21d:656c:dd9f with SMTP id t15-20020a05600001cf00b0021d656cdd9fmr22448973wrx.15.1658140964726;
        Mon, 18 Jul 2022 03:42:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018? (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de. [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
        by smtp.gmail.com with ESMTPSA id id15-20020a05600ca18f00b003a31f1edfa7sm1226229wmb.41.2022.07.18.03.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:42:44 -0700 (PDT)
Message-ID: <096eec91-89a5-6068-acd3-c457d3ebd4d1@redhat.com>
Date:   Mon, 18 Jul 2022 12:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Vaibhav Jain <vaibhav@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20220601163243.3806231-1-vaibhav@linux.ibm.com>
 <05623846-03c7-89f1-e1dd-0ee23723c7e9@redhat.com>
 <87r13p2jju.fsf@vajain21.in.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] resource: re-factor page_is_ram()
In-Reply-To: <87r13p2jju.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for the late reply]

> 
> The improvement to the gcc (v12.1.1) generated code (x86_64) for
> page_is_ram is quite evident.
> 
> With the patch:
>    0x0000000000000920 <+0>:	call   0x925 <page_is_ram+5>
>    0x0000000000000925 <+5>:	shl    $0xc,%rdi
>    0x0000000000000929 <+9>:	xor    %r8d,%r8d
>    0x000000000000092c <+12>:	xor    %ecx,%ecx
>    0x000000000000092e <+14>:	mov    $0x81000200,%edx
>    0x0000000000000933 <+19>:	lea    0x1(%rdi),%rsi
>    0x0000000000000937 <+23>:	call   0x7e0 <find_next_iomem_res>
>    0x000000000000093c <+28>:	test   %eax,%eax
>    0x000000000000093e <+30>:	sete   %al
>    0x0000000000000941 <+33>:	movzbl %al,%eax
>    0x0000000000000944 <+36>:	ret
>    0x0000000000000945 <+37>:	int3
> 
> Without the patch:
>    0x0000000000001000 <+0>:	call   0x1005 <page_is_ram+5>
>    0x0000000000001005 <+5>:	shl    $0xc,%rdi
>    0x0000000000001009 <+9>:	lea    0xfff(%rdi),%rsi
>    0x0000000000001010 <+16>:	cmp    %rsi,%rdi
>    0x0000000000001013 <+19>:	jae    0x1064 <page_is_ram+100>
>    0x0000000000001015 <+21>:	sub    $0x40,%rsp
>    0x0000000000001019 <+25>:	xor    %ecx,%ecx
>    0x000000000000101b <+27>:	mov    $0x81000200,%edx
>    0x0000000000001020 <+32>:	mov    %rsp,%r8
>    0x0000000000001023 <+35>:	call   0x7e0 <find_next_iomem_res>
>    0x0000000000001028 <+40>:	test   %eax,%eax
>    0x000000000000102a <+42>:	jne    0x105a <page_is_ram+90>
>    0x000000000000102c <+44>:	mov    (%rsp),%rax
>    0x0000000000001030 <+48>:	mov    $0x1,%ecx
>    0x0000000000001035 <+53>:	lea    0xfff(%rax),%rdx
>    0x000000000000103c <+60>:	mov    0x8(%rsp),%rax
>    0x0000000000001041 <+65>:	shr    $0xc,%rdx
>    0x0000000000001045 <+69>:	add    $0x1,%rax
>    0x0000000000001049 <+73>:	shr    $0xc,%rax
>    0x000000000000104d <+77>:	cmp    %rax,%rdx
>    0x0000000000001050 <+80>:	jae    0x105a <page_is_ram+90>
>    0x0000000000001052 <+82>:	mov    %ecx,%eax
>    0x0000000000001054 <+84>:	add    $0x40,%rsp
>    0x0000000000001058 <+88>:	ret
>    0x0000000000001059 <+89>:	int3
>    0x000000000000105a <+90>:	xor    %ecx,%ecx
>    0x000000000000105c <+92>:	add    $0x40,%rsp
>    0x0000000000001060 <+96>:	mov    %ecx,%eax
>    0x0000000000001062 <+98>:	ret
>    0x0000000000001063 <+99>:	int3
>    0x0000000000001064 <+100>:	xor    %eax,%eax
>    0x0000000000001066 <+102>:	ret
>    0x0000000000001067 <+103>:	int3
> 
> Looking at the disassembly above, gcc has inlined both walk_system_ram_range()
> and __is_ram() in page_is_ram(). This ends up in page_is_ram() calling
> find_next_iomem_res() directly anyways with bunch of book-keeping
> afterwards which can be avoided.

We usually don't care about such micro-optimizations unless you can
showcase actual performance numbers. Otherwise we'd have constant,
unnecessary code-churn all over the place.

Most probably, all that list walking dominates the runtime either way.

Feel free to proof me wrong ;)

> >>
>> If it doesn't make the code easier to read (at least for me), why do we
>> care?
> IMHO, calling find_next_iomem_res() from page_is_ram() instead of
> calling walk_system_ram_range() makes it easy to trace the path of
> page_is_ram(). Also the dummy callback makes the code flow seems strange
> initially.
> 

I'm not convinced, but I don't care enough to object. I'll add more
review feedback to the patch.

-- 
Thanks,

David / dhildenb

