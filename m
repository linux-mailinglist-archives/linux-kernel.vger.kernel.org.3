Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E958205E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiG0GpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiG0GoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E4422C3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x7so1444534pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uSbrL91D8dmhiCPRZ5j9cw2cZh5t8fmVS5nObDDnOS8=;
        b=wvzx8C9qFRQWz5sX2uVC60ABeC6Jom1JzL4E4XU+rJ5pJC1Sk0kx9LRtDbr0+5OagR
         jGPtdoDM659xgKOfhWoDGIBqWZMTU0GWUsdmLqVc+EHAxhghIbzqTbacrHxZ2xdCE+In
         2uAFKNq2u68afsMVZ/TGz57AbN4/doUd/DAvJj+CJFB76Q05cfSqHx5+LtvKmqMWdMZh
         BE3guhXA3Vk9Xq09Pt/cbMoUB6ziRjFRTq8pqvlrTy+C5F6lWs6YdRg3HfhQRNFo8oz4
         fihsOjKANQ6ZGmVj3bQxl3MiClgWy6SHkoUc4JdmAqvMmSFDCBkpmK7f1DAu8wQ6pZMz
         UdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uSbrL91D8dmhiCPRZ5j9cw2cZh5t8fmVS5nObDDnOS8=;
        b=kUuNXsNVQIqDS1pmSIqz4EICuYsEqJVDOB79yyiIELJvTDzfKpyJJbsk8FrnPiWyOA
         BPa2sQsZcfi/XaW2CtL7lM57IlS1vvqxaF6yCVPfwpTeUw54xYVvvH2/8tTKAfeBGzA0
         BqPy9KzBxeLxmKGNEPOY24GqOhhTy6PWNJ3fGHv7337+KCI6O1DBeANwXAgXKRvI0q6E
         JZxJq3KxjDoKfnL989Leg3UdcnUgGRTf9xqXmjq6l56M2wiAGZhLKP4VEKftqG1V+tAS
         UIao0+gt7ryLIlIh85cE1PhjC/hvjzKeaMvubaEHdKKaJggF35duA+fClyW/oAIrXMs8
         tQBA==
X-Gm-Message-State: AJIora9oKp+bGrIOqpc1Ewr12zYIWbrWzvbk5YQnHXRaKsPg2Nv8Uz9W
        WdP+f8OiFMCubNh+RM8hrVFKzQ==
X-Google-Smtp-Source: AGRyM1v9jbnVP4YUj1b6SWwJq2CymBR25medXBFVHukULKY5c+pl2zMynfq0uViVIUf3U5hxrr2y/w==
X-Received: by 2002:a17:90a:5508:b0:1f2:bedd:980e with SMTP id b8-20020a17090a550800b001f2bedd980emr2841528pji.178.1658904245128;
        Tue, 26 Jul 2022 23:44:05 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b0016bea26bb2asm11052158plh.245.2022.07.26.23.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:44:04 -0700 (PDT)
Date:   Wed, 27 Jul 2022 14:43:59 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] hugetlbfs: use helper macro SZ_1{K,M}
Message-ID: <YuDer11XLQKtcGR0@FVFYT0MHHV2J.usts.net>
References: <20220726142918.51693-1-linmiaohe@huawei.com>
 <20220726142918.51693-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726142918.51693-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:29:14PM +0800, Miaohe Lin wrote:
> Use helper macro SZ_1K and SZ_1M to do the size conversion. Minor
> readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

