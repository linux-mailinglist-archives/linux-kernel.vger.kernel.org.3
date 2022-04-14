Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12C5019EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiDNRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiDNRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:22:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091F23AA58
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:20:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 12so5168919pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZKxiqiOGP8xT+pzPpG96RNqzRBaJRtyWz+j5RMVT+Y=;
        b=lymh6lTWr2Sj/q2KNN/sZh1+2+JNVgm9GNF/J1h9xIbILtCqkJ4X5rV0k08Hh+twHd
         QJmdssHM6pnT12/Lf6tURVpzaBio2EQQV4HtSur0oY4rKUk+qb422YW+5FBBwPoq7Rd7
         ULezyMYJqhGfudAlhzgoMNN96M9DCtkPjl7zDz3aoxWt6x824Jo8bKJ41ZF7f5sbvLHN
         qBKBxsJEz1dcltFx0xi7w+2k47IhBftfhOolhGf6NLlXWXSmBcVbjhu9olAs0/mKobli
         0dMnfWjwZZkF1JoziNLJieWWcwp9FmEbU0+Plpl0zP7OoaMkXuU/oeL5RB8kSy63ajEH
         QEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZKxiqiOGP8xT+pzPpG96RNqzRBaJRtyWz+j5RMVT+Y=;
        b=HaSi1pA3F3RvVra6c4YXJNCTlQDYOkP7Bx2nkULgYed5421Vl1P8AvI+e7Ul5t1Q6h
         8DdWx3ex1bkrbULqnXvvDWHt9e6dWMlxc3MCCs3WjLIs+dyia4Yt5z+JwPH8JAgxTmpi
         0C/t7JFBwioHKe6SJ+4q5jq7I0/Olli474OL1DQhvEvy7tssEfJ0TLUuOlf5xFx1zmX0
         ieOXcpGUFn5q8VUE0Vza5IVQRYcvrtgd5undR1gcKekmA292EdgKgt23N0NrWa596hSr
         XdIXdR/u+T8oal1XhKNnQCthlLcMH9ypTErRkrXpsX+SM41Cja7/qc7TWbSX4Ekgxsa9
         HygQ==
X-Gm-Message-State: AOAM533jcY6Hb6+4O4ptxMk9P9t86rqGiSscCEbtioNxe7EFtKxk9d3G
        VTdCWdsuW5ODOTaiaEwOneCe+g==
X-Google-Smtp-Source: ABdhPJwi8+ti1WpkD0ucDZjeGnXAnfZ7+/ecI6kI3PJTHAqbr5Kk6Xg8Mx1f9xcHje80M+6NCA/tsQ==
X-Received: by 2002:a17:90b:384c:b0:1cb:1b44:2939 with SMTP id nl12-20020a17090b384c00b001cb1b442939mr5468344pjb.46.1649956799574;
        Thu, 14 Apr 2022 10:19:59 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm466362pfu.120.2022.04.14.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:19:52 -0700 (PDT)
Date:   Thu, 14 Apr 2022 11:19:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 0/2] remoteproc: core: fix issue for multi-instance
Message-ID: <20220414171947.GB698343@p14s>
References: <1648434012-16655-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648434012-16655-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:20:10AM +0800, Shengjiu Wang wrote:
> Use the rproc->power reference count to handle the multi-instance
> case, move the state checking for 'stop' and 'detach' under
> mutex protection, and remove state checking for 'start'.
> 
> Shengjiu Wang (2):
>   remoteproc: core: Remove state checking before calling rproc_boot()
>   remoteproc: core: Move state checking to remoteproc_core
> 
> changes in v2:
> - drop 'remoteproc: core: check rproc->power value before decreasing it'
> - refine 'remoteproc: core: Remove state checking before changing state'
>   split it to two new patches.
> 
>  drivers/remoteproc/remoteproc_cdev.c  | 11 -----------
>  drivers/remoteproc/remoteproc_core.c  | 11 +++++++++++
>  drivers/remoteproc/remoteproc_sysfs.c | 11 -----------
>  3 files changed, 11 insertions(+), 22 deletions(-)
>

I have applied this set.

Thanks,
Mathieu

> -- 
> 2.17.1
> 
