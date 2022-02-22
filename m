Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A864C00FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiBVSK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiBVSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:10:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B7172E4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:10:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z16so12887275pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z5CMwP8NIk4EFDRAq2l/o2l6e+d+RgBkaYNFQ7hwo+o=;
        b=aaE3k90pS3EmG3r8CJGx1XPZCHA0r1CQxRrGD5olNTiKMSXkpbV4945pB33NpfUBu/
         zQOJ7pHLy7dXMMpJVw1QYFjPSqUbQeNou1CSrStliyOrHlgHfrP/vfUH+zwEm5sFYUJt
         2WHzYqi5g2mxWFBEfVVvmRTfPKq5V7YgMtSYMBTTntRZLTo2Q7P4FOcHEdjnYxFKTb0c
         7I9x6KR7Jm56jvD9It3JsFPGMxuHczrWOQ2AbhKvPhoLPK2BsfHD4847ll1zL0+fhEcC
         4jAWUXe1FCuEZe4SExRgtMLU/yYrhHQOw91Bgp7nfQirsC/AhH882a30fuxCVcAIpmld
         TFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Z5CMwP8NIk4EFDRAq2l/o2l6e+d+RgBkaYNFQ7hwo+o=;
        b=EU/HvSD/lupHPvqM1136+Zwl1DHv7V0SLRCCup+GKbSlwAR/W4A/2llqmVUF38N6CH
         +qTpvU2uOm5acKCWtWcY7Yt69v16XPGzKvgPvatKAcAxveuHYqiplWVjozWbqM0TT5Dq
         zh4Ux93ZVP7/Pt2vbmkHvqLLRRfMI9UElYZk+vBRgc6e7PDUj+IvRBbi9RzsDI3Ib0hd
         SbGdPjyGSCWmW6Kd3jOhamXxYmCXHIiOtucWYJtAjZuY8SksDh3ttcRWeJOUZki56+da
         6o4ECbN7mnFP1qahMqqL31nWuWBJR2h5NAtK+MVd5XbyoxrYKXHdq+DUk/GQn0k5SEd6
         /iyQ==
X-Gm-Message-State: AOAM532wo1BSb1WLL3jD3/AzDHm9RWsm/BiYA3wkHzt7XcqyCYV8usZP
        HQqOkGALhEjzgKhsBueFLyM=
X-Google-Smtp-Source: ABdhPJx1Izz4wlNdJ7gU9O+L4i8v0O3Vk1ggQtRlKGT9Yjj0Bm5jVOF3VFWW3GDJ9VRvqwN42T6WoA==
X-Received: by 2002:a05:6a00:1943:b0:4cb:79c9:fa48 with SMTP id s3-20020a056a00194300b004cb79c9fa48mr25950207pfk.47.1645553431241;
        Tue, 22 Feb 2022 10:10:31 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id nu11sm137649pjb.36.2022.02.22.10.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:10:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 08:10:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: remove redundant kernfs_rwsem declaration.
Message-ID: <YhUnFWUL3AQF50z1@slm.duckdns.org>
References: <20220218010205.717582-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218010205.717582-1-imran.f.khan@oracle.com>
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

On Fri, Feb 18, 2022 at 12:02:05PM +1100, Imran Khan wrote:
> Since 'commit 393c3714081a ("kernfs: switch global kernfs_rwsem lock to
> per-fs lock")' per-fs kernfs_rwsem has replaced global kernfs_rwsem.
> Remove redundant declaration of global kernfs_rwsem.
> 
> Fixes: 393c3714081a ("kernfs: switch global kernfs_rwsem lock to per-fs
> lock")
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
