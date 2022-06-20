Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA55551462
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbiFTJau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbiFTJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:30:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACAF13D1D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:30:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w6so2538596pfw.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F9FMzgZGjtkVq9AbputYdTQEVUZao0adrAEgaXfcxrA=;
        b=y8J3adRTFx0+l7qiCljpvacMAoRZTzljC86NoPhyp7A6KhE8XkrV0+sskJHqS20FLL
         BpONFh3dOC9GLQOJpXXVYb0yPcVg5Gq0zOBXmwGZpzuIQeH4cuYfKlz7Stserhxa/EB1
         Jh2U1u9GHn/IzcxV+n7J2gpdqOrQzsQ3hKW9/gHb3u12mXOWLugUUHVGqmT37GFO0HZq
         ILx3qoOZf8pv74pLSxVLMSRM9BccxcafW/yTft1bKmZLSGv67wBXpVY37Ly1DGv9kyQd
         2LDbYhY9L+lr15OjynwD3yrR+X9k1POcN5WAd3KtVluZftfpe6xUuF9i80PrI3roS9Gt
         pJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9FMzgZGjtkVq9AbputYdTQEVUZao0adrAEgaXfcxrA=;
        b=YENwSA3EBznE/191UYcaJySYQ+6Sz/9j+yYGMNtI209zmxl4Y1+XDOwsnybDBmArPm
         RfqA0Z+DprQb7okEH7H1AjFmHFD1ikyE5mMgHNAihHxuPM8Rv4Tlau7xXfgHVarwzA+P
         fLL45+qfpZTu1XtaEa0Lr/nLv2YAc7nGQBe0sOnL3cJMGaODdcu23jNhdXi0y9lT3kqM
         aWf0Yf55R8wubZhH59fqe1XDBYjPYj/Lpzr6qxbclso3ZDCin/NZAEaI4ESE3KflDVi9
         Z5sLAw61Yq9I/qwuAUlr5OqR199KHqhCgArcF+lrDvVVjBVegmU7ML8PvxMLtSx1SRzx
         /VSQ==
X-Gm-Message-State: AJIora/HlST0T29bOZUVjT/PN3fyv5N11JrgRftZ5iJAFKWDHFHmLg0x
        SZJu9oAtztJ8cakN1YQDXN4aX/gPevNM1SgkYs4=
X-Google-Smtp-Source: AGRyM1uulP868BsU4RImI3GLFupf/7hbGC6YsildM6h9Yesz0p+isYSxP8T101LoHoX+tkcdZKP5xw==
X-Received: by 2002:a65:4501:0:b0:3fc:4895:283b with SMTP id n1-20020a654501000000b003fc4895283bmr21219274pgq.231.1655717428290;
        Mon, 20 Jun 2022 02:30:28 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id y188-20020a62cec5000000b00525286c7847sm990754pfg.216.2022.06.20.02.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:30:27 -0700 (PDT)
Date:   Mon, 20 Jun 2022 17:30:23 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/swap: remove swap_cache_info statistics
Message-ID: <YrA+LyiEkgKRGu12@FVFYT0MHHV2J.usts.net>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608144031.829-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 10:40:31PM +0800, Miaohe Lin wrote:
> swap_cache_info are not statistics that could be easily used to tune system
> performance because they are not easily accessile. Also they can't provide
> really useful info when OOM occurs. Remove these statistics can also help
> mitigate unneeded global swap_cache_info cacheline contention.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
