Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB6529884
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiEQELu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiEQELq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:11:46 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A34507B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:11:44 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2fedd26615cso61884827b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NO/qVr25gl9DWObhrjxNHN1PGGWIrTbPudg44b/JLeI=;
        b=6KEbpLl+WAWuaT8l95JqbSOJgxSfJpLNEobjxxcKridU4U1e87XUTvnUWU6odxyltG
         sXCcYvAJY+6YB1DpztmiFEnawZUnjEhrpZdrVqDMMN1cGgA1leE+uGdC2eL9FIQFSPdB
         xEO8+E2C/VI8ufjhzynb2Z+cjaYGHRHv3EiZaE0UgmgXsHBuI952bSfrr9GwiudXZovw
         CVqHc0o16YBvjIQ9aiw2/bi+cIfUuynJXbTcERUtjLZy+1Zd8Een7qt0NcebDbVycA6i
         4xth0GFVrEk/CoU07cQjxYG1M9u2NZERL1P5PXhcCQ6ywkbKUWXRQHnHLustaralGwoS
         2tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO/qVr25gl9DWObhrjxNHN1PGGWIrTbPudg44b/JLeI=;
        b=gss9NKENX7QWPoFoVnLiATU1sdhXn+lZGrVyms1Y4vVBv0pJjdsQBtDpWBuGkbFakC
         cWYQ3G2liPkKRKiJF5h50P0P6LFSkbJFJ78Zu9n8WV9rLp8+h8SP398e/YHwNZXrVSBG
         2OumIYOmAgsdvbHjQlJ97H0EKJSL0aOXVt6bPKhnreKE+R3E/I3w3XUwPu1IFLupuiRZ
         uNUQc7/NcY2+oTx/atbmjBHCF7G3GcOaGsLUPotMQNywxr0tLPRTyVJNSKT+RUNr0LN1
         YsTYJ7MDUMkjH4GSe17aXFxcwq9lLPNIWnUE0wD3kN/x1BuIJZDXP1U6mIxU4AldhPWK
         31oA==
X-Gm-Message-State: AOAM533H/E1a+pB6q86NL6gZY+9Xfu+UuNMKYChB+WIzJB9fZtVmOSN/
        irUmq4K8DvxZ7NUU7dyFph3rO+ziB4cUb1PDnzJYgg==
X-Google-Smtp-Source: ABdhPJw94mquCu2tzO4e+v+R3EKZQm+TzZ6hT1GPqsmlWqCmuAgQDMm/rqRAJ7UuVR8eO1d1Omo9W844ZRuDq2Cs1+Q=
X-Received: by 2002:a81:7b05:0:b0:2f4:e45a:b06e with SMTP id
 w5-20020a817b05000000b002f4e45ab06emr23607287ywc.458.1652760704159; Mon, 16
 May 2022 21:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220516173930.159535-1-bh1scw@gmail.com>
In-Reply-To: <20220516173930.159535-1-bh1scw@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 17 May 2022 12:11:08 +0800
Message-ID: <CAMZfGtU8GYN6aLepHr3z=AvJ4XivmWpPdnvUBgaJUnmf37-28Q@mail.gmail.com>
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
To:     bh1scw@gmail.com
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 1:39 AM <bh1scw@gmail.com> wrote:
>
> From: Fanjun Kong <bh1scw@gmail.com>
>
> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
> Which can serve as RCU read-side critical region, so remove
> rcu_read_lock/unlock().
>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
