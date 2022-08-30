Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10BD5A6E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiH3U2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH3U20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:28:26 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B83776471
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:28:25 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11eab59db71so15682336fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pkoq/o9P8wU4zBUF6l/1Q8f9r4lCtzL1bt9bVqYTgbg=;
        b=vQ5OEjPyI48ASRgu7ssOii2xYWJ4xnPBiTNLBGGE608Z7A05x4M4cgABuJO0i9jN2c
         QATOeDvd8dss1mFC90RZMGre1/oN7HHYgFE95dL3a0OHfZ/Ihc//ZZYIFsxJQMK6pugb
         B+7pKt6yNeV1mFBvUg65k5/+nNf8pKWYIza0LDe2VoMgle5vh7b4MA+AjiD1+VcMJMHE
         su18WVASI8CWQEP7UMc830pIxfnlPHStDyF6kT9vyNw8ZfoyjFBZRR/OfYEtVMQAg91T
         tL8bJ2pLDUr5TE1aSyfy9x9QVZvCSXbduMX79y3Ql8kIDwreogHJIBaue2odW4VAIdRm
         u3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pkoq/o9P8wU4zBUF6l/1Q8f9r4lCtzL1bt9bVqYTgbg=;
        b=Mj/th+hTvKbVzAxXHQyOFxnLmdhPSY0fEtmuZNhFGFGUz1JeUE2zqJaoSHaZ4qZOCi
         r6XexD/UYCWc9r3dqwGs4WYy3rLkpx3W2oH95PN29h4QLtYrq9aAl3aWEnNvHCYEvx1P
         UJenPggLZ0rMMxkHel2PA8KhE9dygYYU6bwfElVF6Lb9mnLZzWQO2UXCweIYFrsAUDUW
         FTyVNx6FPY82Th9T+r56MoNs+Xb+8UH1Y1VMoDXDY5bDkPgg7hVbo47f1YPSrfrm4TBS
         WS28iB6YRULW5APDZ9UCxGaqnztrKrP3AZ6kRUjxP5c+VGxvqDJ+yqasxr2Z2oPxWroU
         J+Lg==
X-Gm-Message-State: ACgBeo1BbGx5shi/y4VnA4hR/3y88pZq73094tvTH0MPzADlpq81YP30
        NhQ54qSEgcBVwe5m0kEQZh7O+Pi4GZmkIZzEL/bWtyEgyA==
X-Google-Smtp-Source: AA6agR6o/lP5VVKIId0/k9uoG0ZQyJf1wTjojPiCx7MFLhqOZh+C+0wZydEzou1Rty6gZpdKl+qDXkaPZla6f5n/pMc=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr11345537oao.136.1661891304676; Tue, 30
 Aug 2022 13:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220830150058.300327-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220830150058.300327-1-cui.jinpeng2@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 16:28:14 -0400
Message-ID: <CAHC9VhT79eWvT4Nyd7BPZcfQPwQcWH+T4NaW7ARqA3BNHUOx2A@mail.gmail.com>
Subject: Re: [PATCH linux-next] selinux: remove redundant variables rc
To:     cgel.zte@gmail.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 11:01 AM <cgel.zte@gmail.com> wrote:
>
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>
> Rturn value directly from sel_make_perm_files() instead of
> getting value from redundant variable rc.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> ---
>  security/selinux/selinuxfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Please don't send multiple patches to fix the exact same issue.

-- 
paul-moore.com
