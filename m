Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BED5223E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348835AbiEJSZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiEJSZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:25:54 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1C50E13;
        Tue, 10 May 2022 11:25:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r192so11126214pgr.6;
        Tue, 10 May 2022 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5sDgeD0YOOWBC8MnsZdewpm6fm+8JdOylgUar+PbYV8=;
        b=E8vh1kibB970hzIpWVqJvrUM/XAa+WhlHnQFKxRLbh2erbItToTT6MRIvKSM0P4r2x
         58dJE/MPLzbdvNTF/8JgkiZpQ+hkUiVXgM/IptFaGGnZoMvr+KfASvNybW4eIs7Gs2P/
         84WqOoBsFK3g0q4ZavWX9GVFjNFZuiil5rhwquelrWdxHNCbQxcbagx4CVcyzGC0nZeY
         N4llZYPHZytpybWUkGUmCzeUXQ8BdEzXFnUyvcg0E+uA8JZH9nCmcFl8u8et4fY4uCGb
         ELlIp5TsPXGhKeOsZM4/YeYzYMepEc6xwCceDtSxF+OdsmYoPeboh+xZ6Kfte0dCYDN+
         GcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5sDgeD0YOOWBC8MnsZdewpm6fm+8JdOylgUar+PbYV8=;
        b=hyb3FxOaKIHQzX6VW4/tWEKcEWnOTFxmoYjPxMCNmMnWzijgtzX2OpZmhnVO3HfsEc
         WgNMz7LcqMBHW2K4HnyF/1Q/avVZRqFxbv1oCSXznPYgpoYlqy0+E0B80NvpXxOcqlsG
         E0ZsGI3Z1CiTKqd/5wyM2oV3jEE8yABU1aPARdiOFNnWJPO5bN0O0EOLcLjyurLRAxNM
         N+Hpsrm4MvIga2o0BLflZCJgzn/usQCvyjXIQwOvkShYD2pGuFlITW0GGZpfkTvDdVy1
         5ZtzBq7+jvvHXvC7V+RbtpQdNVvv6KhiL212yS/M+1t12EdOMOifLOMBKgSfSeB3S45Y
         ZTBQ==
X-Gm-Message-State: AOAM530T2QEwZFIzY2SQ9vvkdeoBpnHk8/3PLjNumJu7TSpNApAB/te+
        FcD7+HB7pPQ91gyFdmdAdEE=
X-Google-Smtp-Source: ABdhPJwF8XAszm3XpAppQTe+sM8gW2oXwZnzdwX0bTLVfL3aggJ71RwN/6h58iuJvmppSz4Z6M9JEg==
X-Received: by 2002:a63:4f48:0:b0:3c6:b640:6046 with SMTP id p8-20020a634f48000000b003c6b6406046mr9396578pgl.118.1652207152804;
        Tue, 10 May 2022 11:25:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id a25-20020aa780d9000000b0050dc7628182sm11266714pfn.92.2022.05.10.11.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:25:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 May 2022 08:25:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH] blk-iocost: combine local_stat and desc_stat to stat
Message-ID: <YnquLkBZ7UxutpYq@slm.duckdns.org>
References: <20220510034757.21761-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510034757.21761-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:47:57AM +0800, Chengming Zhou wrote:
> When we flush usage, wait, indebt stat in iocg_flush_stat(), we use
> local_stat and desc_stat, which has no point since the leaf iocg
> only has local_stat and the inner iocg only has desc_stat. Also
> we don't need to flush percpu abs_vusage for these inner iocgs.
> 
> This patch combine local_stat and desc_stat to stat, only flush
> percpu abs_vusage for active leaf iocgs, then build inner walk
> list to propagate.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
