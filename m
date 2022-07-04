Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8510B5657DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiGDNwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiGDNw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:52:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE164EC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:52:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so13842727pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IVNAHC1ugfs7fDNQ+3jQSCuN9UgOzsVldJaDjxNe/58=;
        b=3uP50AMw5x5ZHHRTrqfVXxfXqa508zVwIu+5tzfa8j3o2ihpRy5ZUTNtrmkMErgeY7
         Q8vM/ydO1ZG7LGM9ys7pXOCpOjXaooz1q8Csz1LKw32GXPp3W5zDhNXT3dNvMUExx7Vs
         vbXHZmkxhbIze4y7MFQFGqMFfPaeGyC78yHqDpiu7Eg+5sHP0+uV2wcgUFZAacL7oICQ
         ufmIe9Isc0HoOoy9CV85qA6iIyS/YsnySQai2iNzuKXSWB/ve1o1JurInQaYT2x11j66
         Xa+KDGE/CbL7phjFSqddYTx4Prll3Dd/fvn8akts+WR1P/rjiNhomeVlhHtbm5w2hJZB
         uYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVNAHC1ugfs7fDNQ+3jQSCuN9UgOzsVldJaDjxNe/58=;
        b=zy14nBqZasK6BX7Y+11QE2AMi0d9vmLbqH5NrKez6T2VzFFnRQUUH2Z/KzyKHGz2Ue
         1SW8QmN3/lwEuX6foje/iPBXEzn496Dkl3Gi4zzSl/SKE5Ws0e/Kd5RtsybSUS2rTH+J
         SDaPusYPIXtXDjnzIXBaBnxko8wlCwSaTY8H+XpHkHkkofGJhD/A6wD/UaTJ8Bm81SLN
         /tRdK1IZ1BbP5xgooz4iBp8ujLowEPyF8aGaxZSxHZ9X4BvrEM5v7PMh4IgG3TkPSdI+
         93mVAMxhwO3yqEb0GPvwue3Uuv5N+7jkNR/3zA9IVBRTp6Qv3Rw+QyaT70kdR/tZ9+Ln
         ZbMg==
X-Gm-Message-State: AJIora9hgDoSuH2d9kTtdlt00mtUKZ7hzMGqE8Zszj+iX9yxGAI/+R1R
        MJNFglWS2uUaW38O2ma/R+1kkA==
X-Google-Smtp-Source: AGRyM1tUf2VPrjqknvEjKr1ZQ2F/g32kXlMLt+vjtRiQ+6O691GdW6cI7ooJTdAIJzswSVuuRw8LFg==
X-Received: by 2002:a17:90b:3ec3:b0:1ee:d4f4:a35f with SMTP id rm3-20020a17090b3ec300b001eed4f4a35fmr35450598pjb.123.1656942748080;
        Mon, 04 Jul 2022 06:52:28 -0700 (PDT)
Received: from localhost ([2408:8207:18d5:ce0:b44a:d6ac:cbc5:89fd])
        by smtp.gmail.com with ESMTPSA id o11-20020a634e4b000000b004118fd18476sm9900640pgl.60.2022.07.04.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:52:27 -0700 (PDT)
Date:   Mon, 4 Jul 2022 21:52:25 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/16] mm/huge_memory: use helper touch_pud in
 huge_pud_set_accessed
Message-ID: <YsLwmWlvEIwef/aE@FVFYT0MHHV2J.googleapis.com>
References: <20220704132201.14611-1-linmiaohe@huawei.com>
 <20220704132201.14611-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704132201.14611-5-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:21:49PM +0800, Miaohe Lin wrote:
> Use helper touch_pud to set pud accessed to simplify the code and improve
> the readability. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
