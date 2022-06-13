Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F250549DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbiFMTnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFMTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:42:56 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13086F4A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:13:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z17so6437043pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pS93cZ8zfzX0KSUDIstEnI4VWxOrKrIwnT6HfZRMjgo=;
        b=qDe4O5v0wBOcNDn504Dl1TCT+N6uFzSPDdXAbVwhC2d5mCW01cmiY2uxvK+9bwfsdH
         bB7cu93F2b8cmuLxThz4d5UGjINKeLJc4tjDs4RbJbJY8t2WUcH7bna7XeSe85375KZc
         sIitn9IbfpwSDxxMIwLVV+foIGJ3qE0Lp1cMIXxMHumTz3zTuTdXQlRgfUis39HVKndr
         1sibp8dikq79qDzMBZ2+goVdPleUTbwZ7p6PhdmDpYznVec9INgqgBiCfhfEKf0U2TxP
         rweaOVSVow9ip9xLOR6pax3tCui/j4uD0/+wbSAGwhS++p/xAVc72S+ziBQghJU7dt0T
         voJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pS93cZ8zfzX0KSUDIstEnI4VWxOrKrIwnT6HfZRMjgo=;
        b=OeUVxOa/nQF585yJnFGiNWxAk7c7g8dRsCJj0L58GwWWODFp4nN+j8ADNSfKC+dnl5
         zdEAFnzy5W/IkYL39ucbI4WE79+e2lQRUkpok69RVZtc6IkEoCS0VFoTDBi9XvO5cdgB
         1QKbFpCWzlYghPryWPYTP+PcO6kHd7Jn/kZrvv/D+rDc0y9msXbK/jYyWDfJDd2r7LML
         mxpaab/HqOAjlJOmYap1SPf348UD+XZrWGtvrgTa7RcuARMbU6VkJaZgP0hAqpppR/H1
         RlVLRsbDeBxmldErrgc3aip5VBbT/wBImAM03qnkoFft2kEiu41iVp7b7Tk29/YKHVZx
         ddfA==
X-Gm-Message-State: AOAM531ANjXpA/bfv0Y1W85LvgnCCqbwcW6XQehPXqFI6b6SAVCsPmIK
        xcvyM+88vOcAK+iRggAJbXxYYgaNwqjeuWc4Ztl0
X-Google-Smtp-Source: ABdhPJy2mJpc7Tfo/6Q5EUscOgaNCrG8dnDUOtA3fZWhE2vPD48rN++bXocY0gXmI7vzSctxCVvLCgy7qbvuGLNhEXY=
X-Received: by 2002:a05:6a00:21c8:b0:4c4:4bd:dc17 with SMTP id
 t8-20020a056a0021c800b004c404bddc17mr435359pfj.57.1655143997123; Mon, 13 Jun
 2022 11:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220611092304.152469-1-xiujianfeng@huawei.com>
In-Reply-To: <20220611092304.152469-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jun 2022 14:13:06 -0400
Message-ID: <CAHC9VhQsbE2p1agqKvwjqo30HOJ3aBPV+6AuHzjZQdpeE1JEXw@mail.gmail.com>
Subject: Re: [PATCH -next] audit: make is_audit_feature_set() static
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
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

On Sat, Jun 11, 2022 at 5:25 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Currently nobody use is_audit_feature_set() outside this file, so make
> it static.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  include/linux/audit.h | 2 --
>  kernel/audit.c        | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)

Merged into audit/next, thanks.

-- 
paul-moore.com
