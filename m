Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E72569DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiGGIqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiGGIqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:46:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967DC53D02
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:45:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a15so17998895pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LXPcq2Af9n7ylka13q3J/GCtVlWN40pJ0Aglu5KRqbc=;
        b=VXUhck8efLWgPtTQ4fVFDQtgYpWodkTHrLpwYEVg75Io5kMWwS+q0IqP5kfb4ktare
         2VXSRcQIf5Qu5AlbQS7lPtImczDjhyxtway38Yeheh68MiVrw2i0Pnl1oiUNqFOiMkkv
         7Xb9cfhtqMLU+wXQSX2mREVUEHl5zpVTvTZP9ttBnfXYraUbZ6EhgEL9mv1vi8LyOd96
         ++/qE+vfumUkRYbEiPLPisCYG9NiqQidCNOrD/5YAPbWymKIXNP0AX3J+YUNAF7w/+9p
         r2bFBudKomh8bEZ9oeEFrF1t7G8YpEqqDJ1htmtWHK7UptoEeW+FsYXzdkdn7bRVcHdG
         jrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LXPcq2Af9n7ylka13q3J/GCtVlWN40pJ0Aglu5KRqbc=;
        b=ALVPZ/xLQIfzc16u92vHVZvEptxyfSUdQKtkVTs4I/BBC7AqnxRF5bcx9rbFS7AqBH
         uSXXUcTEocnjYRj5GUs1gcAwikzntmKs7I/dtXvIAVQGXu/7gR5eTZejPOCyjKRwaDii
         Im01B3puUgm4/+9mj5HV+h2crHsFvBG1LLYNNrirTjeXN4YTbFdXqE4mCER6OeFOrRjP
         WUsSzEH30iEXPXMEFjs7fOy7kq+zT7S//VIJh+FTKdibPtATkmOs1gumvWb0SB2m9fgr
         glHGxnpE4Ela0Sbx+4b9BABXDk2d/6Zk0NSkRgLXTlkYFwBWUrD6DThNF2ocJCApf8bB
         35WA==
X-Gm-Message-State: AJIora9Qd5LC0FTasfotYfw7V87Gp0FzdfaAtoznVRWiqyJMf9lIqynF
        6G3UCJu9hIv6It0bgKBmMo26HhDtHRAgDQ==
X-Google-Smtp-Source: AGRyM1v+T+cWE/QAWB+I4vzYm417qjNCHR4WlkFU2zmXNdtTVuvHPMn7PN08GVceFJMjo7Yj+R7gvA==
X-Received: by 2002:a63:451e:0:b0:40d:c602:4e with SMTP id s30-20020a63451e000000b0040dc602004emr38782515pga.453.1657183553009;
        Thu, 07 Jul 2022 01:45:53 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t14-20020a62ea0e000000b00525521a288dsm26094229pfh.28.2022.07.07.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:45:52 -0700 (PDT)
Date:   Thu, 7 Jul 2022 16:45:47 +0800
From:   Chao Liu <chaoliu719@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH] f2fs: allow compression of files without blocks
Message-ID: <YsadOzTdgUvi/Be2@liuchao-VM>
References: <20220621064202.1078536-1-chaoliu719@gmail.com>
 <7fb689d9-11ba-a173-8ad4-a328a03298a8@kernel.org>
 <YrPq5N61W9vFGTub@liuchao-VM>
 <c181672a-faa2-2f2a-b495-b9c9fee56d50@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c181672a-faa2-2f2a-b495-b9c9fee56d50@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:27:44PM +0800, Chao Yu wrote:
> On 2022/6/23 12:24, Chao Liu wrote:
> > On Wed, Jun 22, 2022 at 08:50:33PM +0800, Chao Yu wrote:
> > > On 2022/6/21 14:42, Chao Liu wrote:
> > > > From: Chao Liu <liuchao@coolpad.com>
> > > >
> > > > Files created by truncate have a size but no blocks, so
> > >
> > > I didn't get it, how can we create file by truncation...
> >
> > I'm sorry I didn't make it clear. We can create a file
> > by passing a FILE parameter that does not exist
> > to the user command truncate(1) [1].
> >
> > How about using truncate(1) instead of truncate
> > in the description of the change?
>
> Fine to me, as f2fs_disable_compressed_file() uses the same check
> condition. ;)

Thank you, let me send a v2 patch later. :-D
