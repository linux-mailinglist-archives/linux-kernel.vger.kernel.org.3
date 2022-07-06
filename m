Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE60567C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiGFC7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiGFC7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:59:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C11ADA7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:59:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id r1so12521714plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 19:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dpXsLf9WdKewVhg9xD6K1Zo+nxUZNcBo221W1cDLoQc=;
        b=FtDhCpXUiMfqGz2Yf2cOwtSDni4IyVzNAK+bogsD+N57PUGV3ZQxeWzuFztsmjTU0f
         gxvqmsOzSmJVRSd37G2P1J7GwZj1Weo4XQf4H9J7LJHfsR0rP/FZx2YwrDXFuxRF3j4L
         XJ0VtF5faJZsxP45ZigzJD8exEmBbZZtxzhJGLC1Y9JO69dZQBqiyehHMhDBCoRFND/s
         MpH2+hlInx2fOL7ecOqwnnxNYpK/x4dkCZwVD2Dvzqdi0PetbkCzUbVCwHmT51gLtqSZ
         LvjDCSRDaVp1iqmEFvqtYomr/pToL0VH8EvpZUxsGwxzn6H9iONU46UQEv8uyXXf/730
         YS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dpXsLf9WdKewVhg9xD6K1Zo+nxUZNcBo221W1cDLoQc=;
        b=xjLHqsJPitEPn9m7v4QjQMFbvvvD/K1aU7QLTcc/FSRGA7deZFBtfh60qNG0yBIDq7
         AN4Q+AlnCnTHctVqVIlwnY3MelwyD+NG6NbF3xYE2wWzBprbqP9Qzg/SEFLQTjHtEqQm
         +d25PJzxe1WPJFVHopgSKlvuEuArfYCwe+P0kHzJL9oVVx/wySJm4C03Ofm0eH78XQAo
         xCXfa9D9my/ZbqUHoeDJlPINHqkXXw49I/enx1zHBtrJ8xZ1eNC7pwS/S/8mi3ksJ3om
         FzdNOTbjcmmM3NQHbCj/lqLDw1FLHtOsWqantPmFJnJvKpaLPtmMvxhrCsm6wtzJ8TdS
         Uf5Q==
X-Gm-Message-State: AJIora/j0WE32gjMdKiAiXg01EMxdIFQrUuvYLAWLtkeA5h8E6WoNjxy
        rZsqhA0kTVDe84w22/ePOJw=
X-Google-Smtp-Source: AGRyM1sGkJJ8bUgbP5wOxkOEs7KYNucCBk33uZQwhVwcEX7A9R15TqrihLBVZWCrfD0jWN27QcdIXA==
X-Received: by 2002:a17:90b:4c0a:b0:1ec:d3b2:ed22 with SMTP id na10-20020a17090b4c0a00b001ecd3b2ed22mr46600535pjb.2.1657076348690;
        Tue, 05 Jul 2022 19:59:08 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n19-20020a635913000000b0040df0c9a1aasm17931301pgb.14.2022.07.05.19.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 19:59:08 -0700 (PDT)
Date:   Wed, 6 Jul 2022 10:59:03 +0800
From:   Chao Liu <chaoliu719@gmail.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH] f2fs: allow compression of files without blocks
Message-ID: <YsT6d1F+dz4vfbRr@liuchao-VM>
References: <20220621064202.1078536-1-chaoliu719@gmail.com>
 <7fb689d9-11ba-a173-8ad4-a328a03298a8@kernel.org>
 <YrPq5N61W9vFGTub@liuchao-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPq5N61W9vFGTub@liuchao-VM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Thu, Jun 23, 2022 at 12:24:04PM +0800, Chao Liu wrote:
> On Wed, Jun 22, 2022 at 08:50:33PM +0800, Chao Yu wrote:
> > On 2022/6/21 14:42, Chao Liu wrote:
> > > From: Chao Liu <liuchao@coolpad.com>
> > >
> > > Files created by truncate have a size but no blocks, so
> >
> > I didn't get it, how can we create file by truncation...
>
> I'm sorry I didn't make it clear. We can create a file
> by passing a FILE parameter that does not exist
> to the user command truncate(1) [1].
>
> How about using truncate(1) instead of truncate
> in the description of the change?
>
> Thanks,
>
> [1] truncate(1): https://man7.org/linux/man-pages/man1/truncate.1.html
