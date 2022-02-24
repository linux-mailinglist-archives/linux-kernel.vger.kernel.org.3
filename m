Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512294C325F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiBXQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiBXQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:57:11 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E852738;
        Thu, 24 Feb 2022 08:56:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a5so1544575pfv.9;
        Thu, 24 Feb 2022 08:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OKozchZ6nUUG2P9RVNy0PUT+1lJZYAZmHm2d5Ug8c4k=;
        b=RPWVdCqBvxmIFsAbL8AwG9twyQlH0raWiZHJV+eKaBjnmY/VZrSQarXe2OyX6A17Qu
         xUEFmliZrL4zVf1fsA/hVVOpWznPUxgBxVJUm5Pcaf06ZRg/f3WAP/1YQOIct7hl2Ipm
         t1Y2JjKrNc7p+CO1tm+gh8QjmMFDaefyW7mf8fNj8o0HxLernVxzCo5IHeBhSqu75Mxn
         uK/+HrWuBIXGXMK9vfe+wqWG7yNnuumOsHkiY5FTBnhliVvJgwUG4X0BPj5kDTXRI/ZC
         ZbpF+A79+frt4zXFSLVZr3K7JOx0vX2DCkcJ1Qm53DL+7WIH1zGFRygP1j+Csa3qJ8z3
         igEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OKozchZ6nUUG2P9RVNy0PUT+1lJZYAZmHm2d5Ug8c4k=;
        b=t+uuqx9xVIqymMxzqSY2G+L/sxQgXpUeV8eMwxFltsCrp/WKlbWwiN2vSbVugUEf/O
         bS0479eI+OkG+TVs5xCLL2nsfBV8POrdukMwd46URYxjuZmRtrwq88E/rDGKcnBGlzrW
         EVl3UiQIuiHjGcvWm0RTaAhI/IfpxXJuBcfRWrx/iqkcvklYdkSiR3ocfqpVSDh+jkn8
         /1Hs2DazWBBbr/SfHNaj/GwgS9nYiMp/D73q9zJ3gU8VnKVtQvzOUu7vkWFs+kOvFhBD
         tW5zDuUAi8JcLjXkmnJbYNmnmlyKymiUTdKUv7YZwa7K0AUNkY//op4vcre3UsnlztiH
         ICvg==
X-Gm-Message-State: AOAM53027f19p0xrw2r8r+QGpWULcM4VfY6vbVKpfm3pzGBEDzfN3Kju
        v0XwgKQGH3snmT/QskgpNYdZbdi0LzU=
X-Google-Smtp-Source: ABdhPJzhvCP1yT++2MZwUUzanKwn4uQX+BzSLGQunDM1BoAT48TrhH1nAHuS6cQUvbsGGOx+CdW4wQ==
X-Received: by 2002:a05:6a00:1810:b0:4e1:2d4f:14aa with SMTP id y16-20020a056a00181000b004e12d4f14aamr3796449pfa.43.1645721798486;
        Thu, 24 Feb 2022 08:56:38 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id gl5-20020a17090b120500b001bc5d44f233sm6388052pjb.52.2022.02.24.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:56:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 24 Feb 2022 06:56:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V5 10/16] blk-wbt: get rid of wbt_enable/disable_default()
Message-ID: <Yhe4xA7r6Mew5tXE@slm.duckdns.org>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
 <20220224090654.54671-11-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224090654.54671-11-jianchao.wan9@gmail.com>
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

On Thu, Feb 24, 2022 at 05:06:48PM +0800, Wang Jianchao (Kuaishou) wrote:
> wbt_enable_default() is used to open wbt feature by default.
> wbt_disable_default() is only employed by bfq which has similar
> writeback throttling mechanism. This kind of policy should be
> selected by the user instead of being set in kernel. This patch
> get rid of the interfaces and let the user configure appropricate
> blk-rq-qos policy by themselves.

Some combinations simply don't work well together. The kernel should be able
to provide a reasonble default behavior.

Nacked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
