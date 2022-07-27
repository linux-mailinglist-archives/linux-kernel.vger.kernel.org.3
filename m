Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2681B582067
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiG0GtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiG0Gs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:48:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB47474CE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:46:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c3so15278540pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=huLseZ/prynEXHgGXef4uGpZTHKOZwRXvpDZJspK1iI=;
        b=Wkv1NDwySNVXaaMCJM8rThXVUO7h97J4LISxt0YP1ga5DneYmzIrXSHZCN03ZAsrk7
         GYOeGZsRaO37owN05VzSPaCoogvUExe++Ny0qbj4xlTQRSwHK5RCIyB2UA59rKGtoYar
         4TyEixdo/LvxO51EfRCvFPZI7d0rqI4XCZAadEMjtoyH3v2unhZhKb3m451ZXvvjwAjL
         Oij9jkdppoWmo3+67inBL4U+dCgYzpS7Muq2ijeHo50sJNkSukeu2X1Lf2vkTC+PdxTd
         4MmFn2wAkotyZMYJIkeflw47i1TgpMQn17Z8nIEc8oFqAuXhh3lnbMgBM6irtPLveIst
         gtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=huLseZ/prynEXHgGXef4uGpZTHKOZwRXvpDZJspK1iI=;
        b=xF+IvsmBWP5eVX8vYqrKN/dEqMSiDRd5RXFBfErQOPOzjXsy/IaJGKOm3ePqxgSl70
         V7HGOntcXHduyW2D6UzER0npNtV9PIszbLWUv2vgyU1ZQ4zOJ2MZB6vd+9KlOi3ae0du
         NyBbRqTE+Ys1Jd5WCACo+Ab1q653fniZ6od/1rpPFmMiwcLDf7Vq74giQgQE1RFS0ctj
         W5RooP7HYIb3FdWBkxWbnILZMEzjQd+hsB+Q0hP26bduO1KwTYVUXQtXOTOzCan/v2uL
         1H0gZdd401MvdkB3rwRYuKEZ9k+LNyCPeWHTibAQb7x1i1lzPcONOGgJ7wN4+6T6Jw+4
         r6eg==
X-Gm-Message-State: AJIora8BzJkIm8hen6Ri9WwxMPIvXrKa21YL6KT+B7Z0afVQaQJP/sW+
        /iw5S2bR8AxYNE7jgjgXUjbs5Q==
X-Google-Smtp-Source: AGRyM1t0ZXgabQUbqCBqrBNdqF+VPD+FkdEKmNlNWyG3tPaaDA0dHgx46oalXTjIa1UroLsJ3o1VNw==
X-Received: by 2002:a63:81c1:0:b0:412:b0dd:d95a with SMTP id t184-20020a6381c1000000b00412b0ddd95amr17115401pgd.164.1658904379146;
        Tue, 26 Jul 2022 23:46:19 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 134-20020a62188c000000b0052ac038672esm12848359pfy.33.2022.07.26.23.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:46:18 -0700 (PDT)
Date:   Wed, 27 Jul 2022 14:46:14 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hugetlbfs: fix inaccurate comment in
 hugetlbfs_statfs()
Message-ID: <YuDfNvaNsB0pvvww@FVFYT0MHHV2J.usts.net>
References: <20220726142918.51693-1-linmiaohe@huawei.com>
 <20220726142918.51693-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726142918.51693-6-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:29:18PM +0800, Miaohe Lin wrote:
> In some cases, e.g. when size option is not specified, f_blocks, f_bavail
> and f_bfree will be set to -1 instead of 0. Likewise, when nr_inodes isn't
> specified, f_files and f_ffree will be set to -1 too. Update the comment
> to make this clear.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
