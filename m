Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351354A092
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiFMU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352292AbiFMUyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1C2AE1D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:22:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x17so8497423wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNSQOYdF4aUChA2evFn2lCgcdKNRBXwLiO2UBbZQeSk=;
        b=azkHDkclWS6CSHjmTjRpoEBREa2BAJJcqk8J3vYFeMO3o/Cik4sXq6jqK5Vvr77saw
         l8b/AxE+syxDBIKtk0RTME80ml2RdygAUYKT/ZAeATvHnjjRn7T0H4P/6yaPqobKPQ5E
         CRgXXd9xZrV2/NCT4Kj6TifnRxO7+wXkSbhtZQj7ch9RtICkVEYiX5ehiF0WOthOcl7e
         YUkQHXRCQ2SJHKmi3hlMW/T+abNsnY0jt0dGySXf/KlSqVV74nCytJAHuY2MJ7GLlCUn
         RcaoiXbWMWRq/a/ea8asagGzWZDe708N8Tjp4vL7fR1AhFKqTv0dkM0L5QJ10B3WOOy/
         rq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNSQOYdF4aUChA2evFn2lCgcdKNRBXwLiO2UBbZQeSk=;
        b=bE6lF80SvT1Ok/SO+9iUyB5lOsHLaD2Fum9K/8JizLp0GxQl38tNC1ITetVcPe9Unk
         A/ZVMNVl9ui5uSwjzb21Gc+UGFafWiDLE9G85ieynHyCYXYMZbbmNA28/LNniDulPBwd
         X8IymruKOi1RRZoa1yIfrpDgQGEXp9wgkewe9HOHKDSLPsw4jr5ZBXPMPjLX46XMudAb
         YgmW0ijdmyix8nBH0F/Y/NrYcsBDQDRoHMeijJpQXdtCCTFc35Rm4X/QZJ5IcvSDojC5
         N06hPnGDW4bNGg8HkId7fm4jpeHWrO4SXT8p4WS8TNfkWwXUfbzjHicrOb0GR6f9BV8v
         SmwQ==
X-Gm-Message-State: AJIora8QOD+iMWY2M0xqzTHAekuPY/68QHu79yovagH52SFu60hkkleW
        1+RxcysKhWVWJhIkqjThXFoS5qvF4/yl6W39ADWezsSsyA==
X-Google-Smtp-Source: AGRyM1vicqR0MGly968BIwuj3k9Dkrrdns5uJdk9zY4Ip3egIEtSLmZV9bqPpVp7rF2jk1ikFhmbRnX+5kS5IsTME74=
X-Received: by 2002:a5d:64e7:0:b0:218:5626:7e7f with SMTP id
 g7-20020a5d64e7000000b0021856267e7fmr1404151wri.245.1655151776983; Mon, 13
 Jun 2022 13:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220611090550.135674-1-xiujianfeng@huawei.com>
In-Reply-To: <20220611090550.135674-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jun 2022 16:22:46 -0400
Message-ID: <CAHC9VhSwYdrHw8jNYxWApPYMjnmX-ZDN1=CzmRBeS1HoL-KOOA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix potential memory leak in selinux_add_opt
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 5:07 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> In the entry of selinux_add_opt, *mnt_opts may be assigned to new
> allocated memory, and also may be freed and reset at the end of the
> function. however, if security_context_str_to_sid failed, it returns
> directly and skips the procedure for free and reset, even if it may be
> handled at the caller of this function, It is better to handle it
> inside.
>
> Fixes: 70f4169ab421 ("selinux: parse contexts for mount options early")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/hooks.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Have you actually observed a memory leak from the selinux_mnt_opts
allocation in selinux_add_opt()?

The selinux_add_opt() function has two callers:
selinux_sb_eat_lsm_opts() and selinux_fs_context_parse_param().  The
former cleans up the selinux_mnt_opts allocation it its error handler
while the latter will end up calling
security_free_mnt_opts()/selinux_free_mnt_opts() to free the
fs_context:security when the fs_context is destroyed.

This patch shouldn't be necessary.

-- 
paul-moore.com
