Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482ED4FEEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiDMFxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiDMFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:53:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0AC33E3F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:50:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bo5so1079365pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kNZH8JLskElmbbqOhNacsLoH+eyKrEmSm/CudD5ltRg=;
        b=c/tFUWeWQ+OUvnBeDb63S51e335WKI6Ga6wJwHZ1rHkKqFbewV5q6QItyKlLXVjQ5j
         DD+V4qtKKkPRT+5D83l+0LZ5ETOZ5Ol0GCBjDpSJtK1WaOKrLkiuj4bIyfgycci6FJMh
         4PR0TWk2159+ARCnLns4VgSogODE8cUHex3NRUdKevlWr9M4cYDV8W+d9FpbzbPsHA6N
         hEO+14OF9ilgUErDuPued5nrr/j9C/N2b7fezOzSaQ9CNhOt7scvg/Or9nC+JqWQzedi
         +E8UMEbrFvSQ9CcnAc9rFlkmbj0CVbdLNAppgE1lw8XZOSNVJVCbuRCrRDal+NRJt0iz
         CP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kNZH8JLskElmbbqOhNacsLoH+eyKrEmSm/CudD5ltRg=;
        b=MKmwLj19tcWIKA9WuzJtKTDRz07RfDHit95AgrBTilKAemBa7EGgpRzJc+8nfj/bSa
         ylnt3XNq8OCAGYI3g/i91wajP0GOXDXA4KYfB9N0xEoCN24p5gkc7mhrCulk6g1AtIRx
         qmHCs3vNgHDMM8uMoz09XuPTZO34qeJklP6MSaiL7Sw2Zw9Nc1OfzJdtp//+0zqTPrBl
         9NdFT3s9WBzsBVAi5eQc2VHf5ng2S1zI4nvLuS9AKUMCTNVxEUFEoIdhwNMx7YPmMvb0
         1oz6mu2HAOJE4q8zeeySLL4r76Ev/lxyIv8MM4rG9Flz2z0IKVWjSDRBJulEK4egx22a
         yjVw==
X-Gm-Message-State: AOAM53090AN48rgSIWLwIDQHlsHXEE6g3OkMaaWnXOS39SM4gRGpXjli
        TxAXcI8RVgPcXL64gULLddrzHg==
X-Google-Smtp-Source: ABdhPJxQlZDrONRT84xUQMaKToMO+Su+pgvxEEaYIcoGnOEvmJ1XOPmQDi8yiF/UYjSdWVzdr+Opqg==
X-Received: by 2002:a05:6a00:852:b0:4fb:2cf4:a238 with SMTP id q18-20020a056a00085200b004fb2cf4a238mr8058324pfk.51.1649829040188;
        Tue, 12 Apr 2022 22:50:40 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id c17-20020a62e811000000b005058e80c604sm15807452pfi.53.2022.04.12.22.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:50:39 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:50:36 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, liuyuntao10@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] hugetlb: Clean up hugetlb_cma_reserve
Message-ID: <YlZkrOz8400dFqwq@FVFYT0MHHV2J.usts.net>
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-5-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413032915.251254-5-liupeng256@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:29:15AM +0000, Peng Liu wrote:
> Use more generic functions to deal with issues related to online
> nodes. The changes will make the code simplified.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
