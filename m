Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551DB4FF10F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiDMH6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiDMH6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:58:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C94A37A21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:55:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so1341874pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BQqO6TV4r8xYP9ll759EC2sYrn2d+Lu4nF7LGYI0lzg=;
        b=KU/UgTioCBDtpq4qjf6dMXRyT2VYVzHvUI2rtjT+3/lmuvpT9Tx4AQFa3gXtjSstY0
         k/F2rY9bQfccugZOu1B6ypVL9C5eebvRoEtF3oGEMz/T1E5tE5ywAR7ivJP+/oLEdVy+
         /kegDWfGJBmXWbj9tQEIL43g0Z+6Z4qmnyxvh/u1dTglCe3E6ASXc7zJSZ8/SKQj5Z6Y
         nnm1ZLXzrtLW0ggtmmP2FAYJ8RgPAAEIzRZfUj3fFs1Xfstkh98gVDryicEfbyzCr8x2
         VZ+h7d77ST7eGufr/e5mMhoFwIjAoCwrEpNwnCINgXbbfeQ5P9ofD9KD9BZ6cwr8Ck0e
         bN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQqO6TV4r8xYP9ll759EC2sYrn2d+Lu4nF7LGYI0lzg=;
        b=H4UAh4kFetgLs1c8Yh7v1Bk3R5D+JbiQY+OOC+nKrNNokSC5QDplUG7nxXDKaeJgPC
         IFqYy9y7IquTDwi/9zhmn6fc43f4O+C+thdlMSvzjtXsAJBU5+WtiLb2oz2wpMroDnA2
         MNpy7utK/Jn2RZxynI/ic40f8wfeb4PDRKtbytdzZp3UvC8w7gsudV+ApXxrY/+YOx/p
         2xBXdFDNol3B9QTpy92UeTLWA1SP/JgbScfPGNaVRgOXVLbF9sY9+S+emBwlnyD+iX7f
         DzTa3eQo/Yb9YWG42NNkQUuelCfYuzxMPG0ow4J6bQ+1oZKJO9PELPxXldCxIT+/eYiv
         wxMg==
X-Gm-Message-State: AOAM531tpcXZ0hV4ZfszQ+yIHha2BTYJ1+8LGfR76XuS2CYfYZ2JL9Zz
        lK+k05wxl3HJ8fiF+WQQHnRxX8LyTCTCeQ==
X-Google-Smtp-Source: ABdhPJwH5lYT3GdpeVp09+OhXkHwPzhgrjzToSYi/WAqKGA6TIRQRz6tNAt4M/yyEHcfQ9HI8dU7aA==
X-Received: by 2002:a17:903:18e:b0:158:7255:4c12 with SMTP id z14-20020a170903018e00b0015872554c12mr11797050plg.123.1649836550615;
        Wed, 13 Apr 2022 00:55:50 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id k3-20020a056a00168300b004f7e60da26csm42132968pfc.182.2022.04.13.00.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 00:55:50 -0700 (PDT)
Date:   Wed, 13 Apr 2022 15:55:47 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, liuyuntao10@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] hugetlb: Fix return value of __setup handlers
Message-ID: <YlaCA6kqjN5nYNSH@FVFYT0MHHV2J.usts.net>
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-4-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413032915.251254-4-liupeng256@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:29:14AM +0000, Peng Liu wrote:
> When __setup() return '0', using invalid option values causes the
> entire kernel boot option string to be reported as Unknown. Hugetlb
> calls __setup() and will return '0' when set invalid parameter
> string.
> 
> The following phenomenon is observed:
>  cmdline:
>   hugepagesz=1Y hugepages=1
>  dmesg:
>   HugeTLB: unsupported hugepagesz=1Y
>   HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
>   Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
> 
> Since hugetlb will print warning/error information before return for
> invalid parameter string, just use return '1' to avoid print again.
>

Can't return -EINVAL? It is weird to return 1 on failure.

Thanks.

