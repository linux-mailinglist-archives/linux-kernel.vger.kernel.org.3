Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F5514858
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358562AbiD2Lld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiD2Llc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:41:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0833C666E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:38:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so10253643pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lxo80hkJLmi8c0tJcxkFF+ydcROx6oGvAF7q5iqKv70=;
        b=MRvrM4UE7AO7Ur9y81kcK69pmlAfawHiE2HHbupOZeoEPvf9Ui+UEe0AVDMAK/bxlb
         AgybvUWkK4WozSv7rOG4wEUT/24pAD/TdOOXh3lYFPPC4ix73gklH0jpmFO80kcTAU/J
         f1bbD/vtLDTa2YClGmGfvf2zYxay1LVSlgcV3vHvfnqvgnR2VwIThR+Av3REqzRoaROT
         KsyKwt0++CUrN36OdatZXPmp2BMlz5hogubzRsHJ9BfKLAFlSdx2FhW41tIkEB0qEyMF
         WaA0C03LxTjSGxKWshhGr3NWo8LbbGTBB9I2X+ql/OMZbf97Dxr3OJrrjAKWZmFcwcn3
         hhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lxo80hkJLmi8c0tJcxkFF+ydcROx6oGvAF7q5iqKv70=;
        b=IAaBGnfrhiQkSe8zzxAscQGta4zBNr4b5i1z8lO5tSjM55nBbrEn3nN2QafGGW2Dz5
         dyl4ThXNQd2hJKadst/LzD4Cvj26I+1gYfSzUpAtnjVS2ispBAcGSy3TMTmyFQzADQC+
         1X4HchhSQBUIz1sSobM+HDPNvQBRkqpCxA3QANrOmEFzQE77XLISrzODYyfj/YB2pFN3
         XIjxntwZTXmTKfyLyWuQpz9yKS3oIKrdR1904IXWNn8z0wnmKm0E/LQRN3e3Ak9RYpI2
         VyftYrqjyPKhdqQF9S0nEm8pMiuuMSaKPSXMwcgyZ1El58M90+egMozXhFga5TSHhWUz
         uxtg==
X-Gm-Message-State: AOAM5322qwTQOggRsec6d+6scKTQxCTIwVoNj/W5FtXEoF40StcNI4oh
        yoGMkb4MonAX3DCyVbLORXW14Q==
X-Google-Smtp-Source: ABdhPJx9pBkht65sUHSuobHGkhIaBbLwmrrRIuH0S9h6QjlmCUW7PJ5ypv8TTNTvuyiDGrbCg9XmjQ==
X-Received: by 2002:a17:90b:3b4f:b0:1d2:7117:d758 with SMTP id ot15-20020a17090b3b4f00b001d27117d758mr3379358pjb.105.1651232294328;
        Fri, 29 Apr 2022 04:38:14 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090a744700b001cd4989ff56sm10197649pjk.29.2022.04.29.04.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:38:13 -0700 (PDT)
Date:   Fri, 29 Apr 2022 19:38:11 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove unused kmem_cache_order_objects max
Message-ID: <YmvOIz5cKIR8kOz0@FVFYT0MHHV2J.usts.net>
References: <20220429090545.33413-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429090545.33413-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:05:45PM +0800, Miaohe Lin wrote:
> max field holds the largest slab order that was ever used for a slab cache.
> But it's unused now. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Nice cleanup.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
