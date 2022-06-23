Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CFD557211
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiFWEoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbiFWEYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:24:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AF72DAB6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:24:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id r1so17097041plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bekEvBrAwf7ehOt0TA5QrhCy5PmAltJgEblnufPH3EM=;
        b=KdK//VDD6kx3P/ZIaXk4K6S5ZpICov0tsGYyxei43BtZQKnuyDJxSU0cnYIifkHFzx
         BKXti9irzZRt0NTnpWEneOktfgc8vg/c3JJzUGg7NpkTgfzaJ6bRsm+hcjjCpGvZM217
         WcZtWX5NY2NHXn57moxaN6df9Vhca/gICgKM6qIuBIsV2Yyb9xLKBo6xywFHxXJD9JsI
         k3FFGu6LdvBM73ckEccNe8IZazkeuCpi24N5NTCpR88xbY5xGQkcU1D2VQTqYi6jjeMg
         7cZHzaShitlKiM/kpo1E0QJeknFfXoBBZd/knDBKCknfmaogY8RCJms/gwAAbKuaVB8r
         bbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bekEvBrAwf7ehOt0TA5QrhCy5PmAltJgEblnufPH3EM=;
        b=37YksUetLt0ju45lKaNSrbThpP17Eh8PRfLyv0N4Wajo385UfRN6lUaZhTOBL/RD0q
         z7/qQvOn/v7Z4+LVUnyZIPCHUBxxnMQ+2Byk+R/cGOJnEkK+z8B2qN4RMZKoWyZFyDYN
         t8cowVbXqTDoVRHhb2Xq/nL/ZjPSG/r5YXfmJUXGsByOkyCFEDx/8SgfX9Bq8d907M85
         rbJ4kQkI97BcBUdQcCcgGx2QA2QIkt6+VsH7CJC4Ip8lgJP/6DZ08wr4+dERa1Yw7FQ1
         ysafaKvxTqlknquEFNFp/aQgvPBmm+PcG79fzDwwi21qb4UkAF4jibwFAD7kao4su3Bd
         FCHQ==
X-Gm-Message-State: AJIora+rHIjXNLxHEEkUkdMCgwk31U7BnzXEzym2eoCqAclNIy58GCi4
        xQ7SgXfMNtb1b1HaEL4GSxs=
X-Google-Smtp-Source: AGRyM1vsLWvBZGegv7wcX1GkV0vLTjBiqD54awG+CV1o5P+AD5DBf2qnKRGasNxwEIhUWq2/zkNtgA==
X-Received: by 2002:a17:903:2585:b0:16a:3c86:c76b with SMTP id jb5-20020a170903258500b0016a3c86c76bmr10134891plb.88.1655958249566;
        Wed, 22 Jun 2022 21:24:09 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b0016a18ee30b5sm8208734plb.293.2022.06.22.21.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 21:24:08 -0700 (PDT)
Date:   Thu, 23 Jun 2022 12:24:04 +0800
From:   Chao Liu <chaoliu719@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH] f2fs: allow compression of files without blocks
Message-ID: <YrPq5N61W9vFGTub@liuchao-VM>
References: <20220621064202.1078536-1-chaoliu719@gmail.com>
 <7fb689d9-11ba-a173-8ad4-a328a03298a8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb689d9-11ba-a173-8ad4-a328a03298a8@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 08:50:33PM +0800, Chao Yu wrote:
> On 2022/6/21 14:42, Chao Liu wrote:
> > From: Chao Liu <liuchao@coolpad.com>
> >
> > Files created by truncate have a size but no blocks, so
>
> I didn't get it, how can we create file by truncation...

I'm sorry I didn't make it clear. We can create a file
by passing a FILE parameter that does not exist
to the user command truncate(1) [1].

How about using truncate(1) instead of truncate
in the description of the change?

Thanks,

[1] truncate(1): https://man7.org/linux/man-pages/man1/truncate.1.html
