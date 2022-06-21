Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DD85529E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbiFUDkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFUDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:40:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F38462D6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:40:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i15so11389387plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ncah84k9sMBGcB2WtPshMSQrdUVaR1RC5zTYDDCem3g=;
        b=rQaaBwyB65GRSW2+iq8RFmdRU/e01guMpTALlKzM/1EbKwfZeRLAJ4TW0Ft4mP0dyB
         R3r4j3HyIKOxVn7p+CR0+ffda1H6y7CMhmv+O3Msglrg4ZS3Dn+oyi1iyKoQzX1d0Wsq
         BXBBMRn/WgdnMu6RDIzRF+Vc4tCBij7fmB32Zil9ZlpTWjQLgOG+nFkmTjHUxwWlcU9E
         7wM3t3MYjytRaKy5oMW/wnt+Mz2v2c1P9t/JjLj4c319rGzJTM8p6S53Bgs3cbdrYU2g
         EFnfoIDfwFq01eyN5egGDgi4VX7JbY/ir2wHlELPyzuu2UkHlg0tV987zVil7fYy4BnA
         yQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncah84k9sMBGcB2WtPshMSQrdUVaR1RC5zTYDDCem3g=;
        b=UVwKge5N5ugb+xIdSWO1bJlfO3pCCZM7+PemVliPWjyk2YFLOe/UtUDYzJZ8DmAdqq
         6f3s2qn8Bbu0KPxNSQ1eN/QE8qBf0Dx+osHMnoiD2WnDl21/X77sWks6Zla5I1fS1SGX
         iK64AtczSKfGd28NmnehrOmyEaQoAggtOCPvYNWrQkdTBvgWbfh9aF0yXKOZ7KP5goRo
         wj5eW4h6PW/ovsraCU0EnvCR0gLHXNHqbvXHtrnhc7xxGTyuO2Yks1+mMkzWRX7FzoXY
         Q2dyfllTt1pGhBNvabPa7gQ4AW8jti3NTVBVlgkfdFVyJCmVZL4WZ2Hz0e4fmQZ1oqJt
         7i7w==
X-Gm-Message-State: AJIora845cZFoiyucEJjhSw7StYElkXbNfgkE5VcP0+7UZIgG4/xI4lg
        QNvhguN8PsUtwvDo32+i0OaI8lWFTYMtgbXx
X-Google-Smtp-Source: AGRyM1t+IOdRjsWZf2HOKGEv5IzGSX4elwgQ5HoXltg8QSzLXPulnrj/f9UlYLqB8ef43dX40Ne92Q==
X-Received: by 2002:a17:90b:682:b0:1e3:142:a562 with SMTP id m2-20020a17090b068200b001e30142a562mr40505915pjz.91.1655782803008;
        Mon, 20 Jun 2022 20:40:03 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id i64-20020a628743000000b0051b930b7bbesm9985607pfe.135.2022.06.20.20.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 20:40:02 -0700 (PDT)
Date:   Tue, 21 Jun 2022 11:39:59 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of
 inuse_pages
Message-ID: <YrE9jxTAvLjeBTiT@FVFYT0MHHV2J.usts.net>
References: <20220608144031.829-3-linmiaohe@huawei.com>
 <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
 <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
 <09ffac27-7fe9-0977-cb33-30433e78e662@huawei.com>
 <b61771ad-9daa-741e-27e4-fdb50a7c5e38@huawei.com>
 <YrB6R5uHQaz1adhK@qian>
 <YrCCFwgoLKhDn7Fo@FVFYT0MHHV2J.usts.net>
 <YrDob8+9Xgig6mZw@qian>
 <87pmj2q0mf.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmj2q0mf.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:14:00AM +0800, Huang, Ying wrote:
> Qian Cai <quic_qiancai@quicinc.com> writes:
> 
> > On Mon, Jun 20, 2022 at 10:20:07PM +0800, Muchun Song wrote:
> >> The lock does not protect the read sides. So the write side should be
> >> fixed by WRITTE_ONCE().
> >
> > https://lwn.net/Articles/816854/
> >
> > "Unmarked writes (aligned and up to word size) can be treated as if they had
> > used WRITE_ONCE() by building with
> > CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y (also selected by default).

All right, CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC help us avoid KCSAN
complaining.

> > Experience has shown that compilers are much less likely to destructively
> > optimize in-kernel writes than reads. Some developers might therefore
> > choose to use READ_ONCE() but omit the corresponding WRITE_ONCE(). Other
> > developers might prefer the documentation benefits and long-term peace of
> > mind accruing from explicit use of WRITE_ONCE()..."
> 
> Thanks for pointing me to this great article.  So although not required
> by KCSAN strictly, WRITE_ONCE() is still good for documentation, etc.
> Just like we have done for swap_info_struct->highest_bit, etc.
> 

+1

> Best Regards,
> Huang, Ying
> 
