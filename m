Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8254575C90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiGOHoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiGOHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:44:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F74E57E30
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:44:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l12so2558560plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avIvPkXnH4SzoYsvQQ3wX9xzRxcp+KK0o8HXPKUV/IE=;
        b=mSh4pzzIpXEloPc9V5bLiMFg43NSDwzfV8P5RYg4xbMKDQ3m8yx50pQcKM57obdU6k
         iUoDXjXFzQK7wAvMS+QGgpIzeTw4XCSKiHnNPXpcyXLBOj0q2o8a2p+7Vx4HaykgWdSz
         3cWehxBsAn7z2EcC3PdUesMa4b+uMoHfWfuEdjtPJ9b2rrUHNSr6HyDmtfk7Gh8HSR+P
         RptNpT1h6qAZJ7MICp0GZouSomyEPh45qEEDvLcO8fwTyWSevcXXIMCax6Z5lSiLXKmq
         GMr69r4tGe5YFi+OTCNzbM+Zb4ZU6nLM2aohWXEZxyfwQihHkgij84pqNfm8x8vfoGve
         q2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avIvPkXnH4SzoYsvQQ3wX9xzRxcp+KK0o8HXPKUV/IE=;
        b=vsMjhXTsJeBjMSaF+J2oIiEyXfCV3kFWbzf1L82plWXbflwbnBoNA7qP3sTrjWl+QD
         Th9K3gddSmZLc3LfYh9gNzQ8yE/xBsYZKlH9ZsI/hrCW+LESJBaPiV8UaCim970iivHK
         sdt+j3cUTwBschEfEf5hNDkG1hE7drCG7DOvfESG0cjvLtyMkPcVt0RlxWXbe3b7n9ZP
         JnPE5J+3ovfmiBPhF4ZN17oyujxJHyVmjAo7wrJAvmn1QeyhOzBXypRH+zUj/Vci4CT7
         TgDw4elBv/y57QQHUDc7MfqDo7bmwp/P3Kcq2+a1gQa+SspXiqrPg7+EQHdsjpei3h5V
         m6Eg==
X-Gm-Message-State: AJIora/Mm61IllK7PdwWqcq+J/GI/M3VXn6BX2PAGqE7PWZunNsocy3R
        tLbYFb2tXGKq2Rw9pt12fv0=
X-Google-Smtp-Source: AGRyM1vaDyYSLJnrEGMuCac23Hk82LYQVuGvvv4seL7ZU6BSHWE12BwXlG1YUvAMNkm6SOCwKZqRJQ==
X-Received: by 2002:a17:902:f691:b0:16c:4fb6:e08b with SMTP id l17-20020a170902f69100b0016c4fb6e08bmr12610701plg.174.1657871048772;
        Fri, 15 Jul 2022 00:44:08 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902cec100b0016a091eb88esm2851078plg.126.2022.07.15.00.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jul 2022 00:44:08 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:45:31 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 05/16] erofs: drop the old pagevec approach
Message-ID: <20220715154531.00005153.zbestahu@gmail.com>
In-Reply-To: <YtEVEtTOD2peFXum@B-P7TQMD6M-0146.local>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
        <20220714132051.46012-6-hsiangkao@linux.alibaba.com>
        <20220715150737.00006764.zbestahu@gmail.com>
        <YtEVEtTOD2peFXum@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 15:19:46 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Fri, Jul 15, 2022 at 03:07:37PM +0800, Yue Hu wrote:
> > On Thu, 14 Jul 2022 21:20:40 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > Remove the old pagevec approach but keep z_erofs_page_type for now.
> > > It will be reworked in the following commits as well.
> > > 
> > > Also rename Z_EROFS_NR_INLINE_PAGEVECS as Z_EROFS_INLINE_BVECS with
> > > the new value 2 since it's actually enough to bootstrap.  
> > 
> > I notice there are 2 comments as below which still use pagevec, should we
> > update it as well?
> > 
> > [1] 
> > * pagevec) since it can be directly decoded without I/O submission.
> > [2]
> > * for inplace I/O or pagevec (should be processed in strict order.)  
> 
> Yeah, thanks for reminder... I will update it in this patch in the next
> version.
> 
> > 
> > BTW, utils.c includes needles <pagevec.h>, we can remove it along with the patchset
> > or remove it later.  
> 
> That is a completely different stuff, would you mind submitting a patch
> to remove it if needed?

ok, may submit later.

> 
> Thanks,
> Gao Xiang

