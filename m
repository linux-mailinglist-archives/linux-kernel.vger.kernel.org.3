Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7536B53510F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347827AbiEZOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344373AbiEZOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:54:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91936E28
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:54:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so1898321pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b27DRtoxlB/2308oiVwCdP0CR5l57IzZlfzCO36+1z0=;
        b=6cX/QSnImn+Y8L8xNBy9d+0fVZyEUw5+9b6/HdY0U1G18Xwc52Tnl3SZ310VGG4KgI
         wztGk8RGR3iwRlFqL0+4p9mqiYDpUps8wKvFOW7vuBCWjLecXBazruOnMkB+KWGfJIKX
         HhlZM6eycTPvSclBLg2O6B08qvFFKoAyHuA9MnwVb+cBDJ7m0Td7uH78es7CusD/LlSb
         J/GY+rk2eHEW6bCOfRvGndDU/i3LnFS0K9jXIIwgVVxEmirOAHRsyyZdWqY52LdHkqsl
         5g1oSKKDUmEJJ/Hfrpq+uLqLWvVen57nZUS4ID5agpL6LACOfhwXvKAI3x/G2KuVsD5x
         U2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b27DRtoxlB/2308oiVwCdP0CR5l57IzZlfzCO36+1z0=;
        b=OzGMkfLPVHr3CLIBxf5u4Oq/cTPBQfzGVnFpLyizT3HZvzA5U4w9KLJl14+18fJJCy
         FKMBwUUlkdgSvz1ZoJBRXEvpiqQPlJ0L/V49NeSRZ1GEiafCMC01Rw7P8SySyLJmQf7F
         SakKH2qcm1j6lWlSM17yzrvPesFxaZNVAG5TWBz+jqJXmPm58ARU0o33JpsmJj4A5nD0
         7aYX4rJqyt1Or5U/TTBOjAFd99Qj9+jBp6Oblq04obkR1MdjbKyX9HuzQiPmyYROIm92
         EjMG/Rm+tKmUeMTYHkv/ZxZioO7ywzcIxzzO5Ri5q0sB+Qzksw9K84k9O+Iwwva/m/zS
         LxNA==
X-Gm-Message-State: AOAM5336duDUo7YHJTZsJ77cuYK0FJ+XcCazLr2GBk7JuInJXGripSF7
        G/gmt+M8D4dg6Q5rDiJjwkLXTkMUL22aR5PS
X-Google-Smtp-Source: ABdhPJxUcjNkGomlVhiqZnkjmGIpSqUeytZ0rdLLzGPD1zF9RTGUJKgTL0bXVW+70ryi59xwyklwbg==
X-Received: by 2002:a63:83c8:0:b0:3fb:9794:8199 with SMTP id h191-20020a6383c8000000b003fb97948199mr760865pge.263.1653576886276;
        Thu, 26 May 2022 07:54:46 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b0015e8d4eb1easm1703080plw.52.2022.05.26.07.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:54:45 -0700 (PDT)
Date:   Thu, 26 May 2022 22:54:43 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     bh1scw@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use PAGE_ALIGNED instead of IS_ALIGNED
Message-ID: <Yo+Us2dysbiqNuOZ@FVFYT0MHHV2J.usts.net>
References: <20220526140257.1568744-1-bh1scw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526140257.1568744-1-bh1scw@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:02:57PM +0800, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
> use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.
> 
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
