Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63D45A64CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiH3NcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiH3Nb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5BD5E8E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661866316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flDzlEay+lodzMjSMxeLlXBa87F2xJak8mHh7Ha6Q8w=;
        b=I4gTXpwwqaRd5ydjK5j3LpeRLJHTGDEp/+VafheUVO3vmKuWdSCB0QfEEs47alAKOg5Jdv
        mjelwD65iC72KbXknH8uCipAo6BXTW7rAta4mMsSK9wDtBYn+BsHLHh/pqYKdbV7AGOWai
        pMTwpdXvhD1q2i0V3RNIfqS/Ic5NHw8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-78-NZ4BMJJCN8GWsKDIWQp2Lw-1; Tue, 30 Aug 2022 09:31:52 -0400
X-MC-Unique: NZ4BMJJCN8GWsKDIWQp2Lw-1
Received: by mail-wr1-f70.google.com with SMTP id c25-20020adfa319000000b00226d3f6d28cso1303624wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=flDzlEay+lodzMjSMxeLlXBa87F2xJak8mHh7Ha6Q8w=;
        b=7Q9Wzm4jO1TB5yITaXoaR7IixV6EKnW1BJ3H9gUbJGa7P29nydfe1ocCYGDBMEdLJM
         Dp9uFpJ5O2m8KwJH9DB3GS6PQaMtHhHHR2jExTfb4A6nom1aJ+nTrR2pKxqL/MbgmIqN
         sxUM57I7OKDNJdT5lcbQhLE7KjayMI4Ly0UgoFCvt83MfdxQ1CwsRjzQl4dOPrJr5X1n
         wYnNxyRIwiypbA7DGzeOAUjw51o03pcgKk+oM+tnzjBM3C/jHxMn3iEjfci8hrYwYeHD
         n3JG/k31yoACuFSrz1Aw3sc/qfyOhQG7MPJtYZZpibIFSEIvU1XcZ2dEvR0YvDPEFnE+
         c49w==
X-Gm-Message-State: ACgBeo2a6TEQbaO+id9p+LZF2Nadax4s590Nli+Ysb7L+v3Sg2etdYjw
        hdiSvOkTstMrUQwIWirj7J9xZHKkpr88hpOh2DEaoK0xzY6yzfR62cTusWS4vhqo/x3T9d8rVR5
        6kBlJAauJxCtErombe3KD8k5F
X-Received: by 2002:a05:6000:250:b0:225:624b:13 with SMTP id m16-20020a056000025000b00225624b0013mr8629519wrz.127.1661866310600;
        Tue, 30 Aug 2022 06:31:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ybcKJlMPOgXGaL4HC4oxp8Kqtr7p+UpDGKDcABx3SZvT9l8XIqCiTiKNrbY3ebxVec8554w==
X-Received: by 2002:a05:6000:250:b0:225:624b:13 with SMTP id m16-20020a056000025000b00225624b0013mr8629503wrz.127.1661866310345;
        Tue, 30 Aug 2022 06:31:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id bs10-20020a056000070a00b002250fcfe2ddsm9366544wrb.14.2022.08.30.06.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:31:49 -0700 (PDT)
Message-ID: <4a76cc97-4185-4236-65bd-676a2684f46b@redhat.com>
Date:   Tue, 30 Aug 2022 15:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] mm: memory-failure: kill __soft_offline_page()
Content-Language: en-US
To:     20220830071514.GA1106752@hori.linux.bs1.fc.nec.co.jp,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20220830104654.28234-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220830104654.28234-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 12:46, Kefeng Wang wrote:
> Squash the __soft_offline_page() into soft_offline_in_use_page() and kill
> __soft_offline_page().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> v2: update hpage when try_to_split_thp_page() success
> 

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

