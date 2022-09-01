Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FF45A8A38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiIABFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiIABFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:05:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326C1F2CA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:05:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x19so14211625pfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dPq94oiVm9QUhHO3Q8tAdsnh8ysDEGmVlDofff13RBw=;
        b=ANCri3SoXaPORM1eQY5tJUp9QEhvyCYNiuisDeQtJkzdxgBU+u7+Nw+5zEsLhvz4Ca
         7WHVK4O1MLbU1n80pd3B34Pcg8vXGUpvaVotf8CTf1Jx6bN6j2LG9gGPIrZUfePTywo4
         6itpD5oObYsUHHkZ/SaDshohwCDGlsRrhu2x+S9Mumoa9MDmJBieCUc9mOTXEIj6K4ph
         2kJZf7A4L1/ZB6sXDTJQc34zN0trEg0+voKWPqptOuwly/0Mj5RWmUrU0ADmRvSTrpXE
         kRIhuDirFZMU89MbEuowOimNBt42gormlW1lBThY4gwG5kUFJp7pBA19K8KFoZE0sCgP
         IBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dPq94oiVm9QUhHO3Q8tAdsnh8ysDEGmVlDofff13RBw=;
        b=AeOYVXqDf0E78AgM02Dk8PxRIShrB5TGvA5BONewZCjE3roIcLcrzbMjF9zi5QjcqX
         xnA4/299Tp1VbzNz81Z1sy3yUXWX6OqKgBW8rksXHLzRTQ9l79HL7CoXnBZfMyq+9Nn6
         /VE+LR9r92Ut/ZY52pNEBvibNRJpXAAXlL353m3eASmyjmb3WoqYkXKuq2ht8rn2ODJe
         EmK7kpGLCqrLqJNqi8+00Ohhwe+GToMO+JhhN8q4l27VKMwPHEcb8pA6Tppay0ZuBrqy
         5YE79vWcy2eOuz+D4qFn34eqw6L+Adklh+m8xkxZJ0jUqb7+DNz/0AL2srlLyuedd2gV
         cGPA==
X-Gm-Message-State: ACgBeo377Snlpf21ceS+dytuD/+qqOJ48lhA4/fOxI1Gbbh9NvP3KfAR
        p3tAZw5Kkg2F5v9tYfjcG+ZozfwyrCPLiA==
X-Google-Smtp-Source: AA6agR5lFgTDbRawqAK+dnaj+eq11vQN8MwCbyz7q+lq9SGUAgPviDx8Id01KSTXqpqx2x0mbOsWqw==
X-Received: by 2002:a63:1e61:0:b0:41c:45d:7d50 with SMTP id p33-20020a631e61000000b0041c045d7d50mr23308197pgm.507.1661994314497;
        Wed, 31 Aug 2022 18:05:14 -0700 (PDT)
Received: from carlis-virtual-machine ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id w6-20020a654106000000b0042b80a27ac2sm3931692pgp.75.2022.08.31.18.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 18:05:14 -0700 (PDT)
Date:   Thu, 1 Sep 2022 09:05:08 +0800
From:   <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        zhangxuezhi1@coolpad.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] comedi: sysfs: convert sysfs snprintf to sysfs_emit
Message-ID: <20220901090508.4f3a6903@carlis-virtual-machine>
In-Reply-To: <Yw9p47naEjsCWAJW@kroah.com>
References: <20220831125520.239055-1-zhangxuezhi3@gmail.com>
        <Yw9p47naEjsCWAJW@kroah.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 16:02:11 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Aug 31, 2022 at 08:55:20PM +0800, Xuezhi Zhang wrote:
> > From: zhangxuezhi1 <zhangxuezhi1@coolpad.com>
> > 
> > Fix up all sysfs show entries to use sysfs_emit  
> 
> This says "what", but not "why".
> 
> Please read the kernel documentation for how to write a good changelog
> text.
> 
> > 
> > Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> > ---
> > v2: use a proper name for the Signed-off-by line.  
> 
> Does not match the From: line :(
> 
> 
> thanks,
> 
> greg k-h

OK, I see.

Thanks.
