Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763CB5A9078
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiIAHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiIAHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C274E991A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662017882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MJQpcPd8ilsE+iHuPOM0sBVZL0bmjk6Frq1r8jdmRQ=;
        b=eTRS3bLAQiMedJeS/gCTU8XgiHkCmjesYPptxj/tNnsZuoi+JiLDhxk0hMlZGWPD93mx26
        ZDOBtw+/1FbdjfRkKmWXSHOMKf+V/iQYEmzLY3oGX/mqob8jk5ID9xEsRLVpwdxxzXThAi
        aCmcN/CbFZRm3hefaSqpYCOKYh3JvFo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-HCEYagDgO0Sx1mYmiM2nWQ-1; Thu, 01 Sep 2022 03:38:01 -0400
X-MC-Unique: HCEYagDgO0Sx1mYmiM2nWQ-1
Received: by mail-wm1-f71.google.com with SMTP id b4-20020a05600c4e0400b003a5a96f1756so895807wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=/MJQpcPd8ilsE+iHuPOM0sBVZL0bmjk6Frq1r8jdmRQ=;
        b=m2NvIwhthh+RtHWxOttEy/6dAXtewHZVCvuFon7jLWAotqPhLxGBZeWtGDx3IqMVTs
         oTX21rH3BgbVKrvZ40BxOrh6xgSdpQiJ5qykFvJfgEjUpph1+3vT72BsDgNk9UdShJwi
         GxTDIhUm7L9AIxo5L8yiG+OcNz7DkgfvYQAMT0OE09BKiCeZaEq3Rg5GswKh3vD739oM
         VF49qwA2Bup45vF7VisjvGYe7C8Tv/4LG0qbVaQzND0fb85AT2f9LjsNOQHcZQy5gGSy
         lukkOqjEC5De+C76Kw2bjW9c6G5pvK15EB+8kRU+/FSjW35EjTQeYi0qgZuzegmZrFWO
         Pjhw==
X-Gm-Message-State: ACgBeo1MgN1sOJK3aRO5rReiBAh2bMsf4109IAAnDhAetat0hHXdK8nr
        4qqOvgVvhWlP0wj2PwpsKitXxEpjUQshY3/7aZTV6LX/PdM8klzzjADKSTNc4uYCaiXhnRxN9GL
        XXA2HFpxPNFqW4L0Prhf3It4+
X-Received: by 2002:a5d:684e:0:b0:220:63df:3760 with SMTP id o14-20020a5d684e000000b0022063df3760mr13049998wrw.508.1662017880480;
        Thu, 01 Sep 2022 00:38:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6uAAlaEbliOr8SEscGeiKdIVPCDI4GZRY0wtVuL4pwMDIZvg9GHwC4eItvjQFlTCKwU7FAFQ==
X-Received: by 2002:a5d:684e:0:b0:220:63df:3760 with SMTP id o14-20020a5d684e000000b0022063df3760mr13049988wrw.508.1662017880199;
        Thu, 01 Sep 2022 00:38:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm4402765wmk.22.2022.09.01.00.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:37:59 -0700 (PDT)
Message-ID: <ff5ccb8b-adc7-8d74-6693-0e94785084a2@redhat.com>
Date:   Thu, 1 Sep 2022 09:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm: remove BUG_ON() in __isolate_free_page()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20220901015043.189276-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220901015043.189276-1-wangkefeng.wang@huawei.com>
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

On 01.09.22 03:50, Kefeng Wang wrote:
> Drop unneed comment and blank, adjust the variable, and the most
> important is to delete BUG_ON(). The page passed is always buddy
> page into __isolate_free_page() from compaction, page_isolation
> and page_reporting, and the caller also check the return, BUG_ON()
> is a too drastic measure, remove it.

Why not WARN_ON_ONCE then? But yeah, maybe this really isn't of any
value anymore.

-- 
Thanks,

David / dhildenb

