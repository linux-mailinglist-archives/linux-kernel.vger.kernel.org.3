Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84D155A78A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 08:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiFYGii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 02:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiFYGih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 02:38:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668D46C85
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 23:38:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a17so3859044pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 23:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nut5kDzyjWGKSE89dkEl9hgFYVipo4uRdXMhdN0CtF8=;
        b=B1neMVHcMORyelS8eOpCDybJFSjRkeDCckipXzpceUt+t3rFCqM5pczwluTtqv8j6N
         1l0c4W7m80xJwMhE82WvrvToEbv04kijbH+5XoilRdlY82dBADKac4sYAWQp6McMniMA
         BtsQrl6PNYMVhVVrOqoIYhjx4hm+m/6sfNoo75FDBGAi1ceWQt719UKT7UA5mSUTGEBR
         EdTA+Knu+vqufDme5aoNfN4nYFW8u/7qQkG8RbKrntyyM/5h2or/A0tzYTOqfwqwzyhI
         GEsWxcjbW38JVzRf4v3QfZ+dr+YfjWlWKBEDy0Kn66P7CXDXl8vEMizbBQwtWFcMlUl8
         +POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nut5kDzyjWGKSE89dkEl9hgFYVipo4uRdXMhdN0CtF8=;
        b=22tVDORn4mzlyw1L4/vsyInfocAWtb2kh9hQk68yqeE85qB++R8deThsP+ZrHKOUfo
         VySVxmLF8ya36tFRTa4Jyne/P/skV6/v1A3W/Q1pPZmZouIMPxjK0JNurWPYm5XGkgNM
         zXRO//BlibZLZigieltSXqrTWWpB2i1tPBNoq5ZxiGAw8ap9tzU3FlIMfh+brRZMj1YG
         MOwgtONxKN4goB3Qk4XzX0SaZ9LZtlFUNUg3YrzMn94iQHpcl7+YEUSku0vLS+y/mFW5
         45+xes1110TtNXq12Gh/ZSA6Ae2dgoNUx+JTAfWDf+Ch7RxqV43UG5K3dAhl2p1EGpTN
         OrcQ==
X-Gm-Message-State: AJIora+WgB6VM8uXm7WofquGpaQDN6uIxz97DApoNq4ORcRzGJHNq9UE
        FsdHTMPkz84DqcDjjebj9dLdOYCwNKYBuQ==
X-Google-Smtp-Source: AGRyM1u+uvJmg4vfpayP2/4SySDJpTxBHsSoeb+Ncv7VlwWT1xE8S54uZUIKf6JaxXO63fbS3zNn/Q==
X-Received: by 2002:a17:90b:3e86:b0:1ec:f7e8:e4e4 with SMTP id rj6-20020a17090b3e8600b001ecf7e8e4e4mr8405003pjb.218.1656139115981;
        Fri, 24 Jun 2022 23:38:35 -0700 (PDT)
Received: from [192.168.1.104] ([101.228.25.62])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090a481400b001e882d2eb02sm2858118pjh.23.2022.06.24.23.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 23:38:35 -0700 (PDT)
Message-ID: <50b253d5-7719-ac79-d72a-a28b83af1049@gmail.com>
Date:   Sat, 25 Jun 2022 14:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/4] mm: kmemleak: add rbtree and store physical
 address for objects allocated with PA
Content-Language: en-US
To:     Yee Lee <yee.lee@mediatek.com>, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
 <20220611035551.1823303-4-patrick.wang.shcn@gmail.com>
 <09d9066b3e55966c108670219711482791d38880.camel@mediatek.com>
 <10660122efb538669144e4c46558b83400125d79.camel@mediatek.com>
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
In-Reply-To: <10660122efb538669144e4c46558b83400125d79.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/23 19:25, Yee Lee wrote:
> On Thu, 2022-06-23 at 16:45 +0800, Yee Lee wrote:
>> Now we have seperated rb_tree for phys and virts addresses. But why
>> can't we have kmemleak_free_phys()? It may apply the same format to
>> delete_object_full().
>>
>> Some users would request to remove the kmemleak object from the phys
>> tree but we don't have this one.
> 
> Please check this, an issue happened at kfence with the latest kmemleak
> patches. kfence pool allocated memory from memblock but have no way to
> free it from the phys tree.
> https://lkml.org/lkml/2022/6/23/486

Hi Yee,

Thanks for your information. Similar situation appears in
percpu.c (address allocated with memblock, object freed with
kmemleak_free(), if I didn't miss others). Kmemleak_ignore_phys()
could replace kmemleak_free() for physical objects like Catalin said.
And adding kmemleak_free_phys() might not be essential, because
there are few places that meet the above situation.

Thanks,
Patrick
