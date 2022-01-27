Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3D49ED67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbiA0Vbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiA0Vbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:31:32 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5957C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:31:31 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e9so3434398pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pz/ww4Xxf9AhheuMjmzrqQdGjfk6TtqnXV/Ka043oaI=;
        b=JpsiDFIsg0tbXVWMBeY2nkKSacqRssUJMUlALByJKU5fMapNPnSugV2/objCHt/097
         gTYT2kLmoA3QTqhBXmJzNYpKPbrWrgtlV9KlAWCB14IM9VHbVrxF367sGMSjkz7iNBAT
         q+bwmeE3/OzO19oj6goop+rlUIQ35bx61SSpxPTzxtUni2LqxwZbMqsNW6nTNTNRPBJN
         LKJNukfHYp1K1Ji/PFjiXS4E/VhYKmK2v1BZaYDTK/6wH4DWq3yKyjdnFKn47X0k3T6f
         drtHqYcbeXgYN1tu99ByreTSqJCm3YYtHAjr47KPOd9tsytbHU4fFE0OIXXjhyMZKvdf
         M+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pz/ww4Xxf9AhheuMjmzrqQdGjfk6TtqnXV/Ka043oaI=;
        b=ppSZDotezb4u20LV6m+CLkY+Y900S8gNcSiVQ+B0nH/ZBmI0/KQJApLzLeHM6Lm2rU
         xuBeIrFopO03qF7r37tLUqu4NeKO0+yQiUnA+R24Q5Zz6mvmmQ6OjLBq9+vrqQ+8sxE/
         PL36WipzZQ+zWwLe0Apeic6o+a3XE4UHRYPxmv6E4dl8pz1EfhCd3dWpk9s9+FkfSwHG
         hjvpqxVREFsaA4cYoBLuG9ZUW8WGiZqtVdpY9vruW5mqC43hb2GeSzHSs2HuinHvjlz4
         Tztf6yzI3TV5dazBxdcLHLLyIwffQOU/xysMaGm+e7BFYTcXPeiSwUhBJoSkQBg40iwA
         yLlg==
X-Gm-Message-State: AOAM5329eyB3lmP76neW/ALVLczV23yXs6P3nVpW2tjc+EiLKLynRmPJ
        yhskfW4ktxSQymo6CGgOSiX/aMYlBvW3z0+gGpJF7g==
X-Google-Smtp-Source: ABdhPJxNqZSQoL7BZ8o8r/TPw366SyH3dmL+SQpyYDu7DxkNm8kbQ1NWikP78APW/PSg3HqugFMx7XdbSc7YfWgk29c=
X-Received: by 2002:a63:184a:: with SMTP id 10mr4053594pgy.609.1643319091140;
 Thu, 27 Jan 2022 13:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-3-dlatypov@google.com>
In-Reply-To: <20220125210011.3817742-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Jan 2022 16:31:19 -0500
Message-ID: <CAFd5g46jxy96NdTJwrBdydaLvzFNP4tvCQVMLmTkt=+VjDiciQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: consolidate KUNIT_INIT_BINARY_ASSERT_STRUCT macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:00 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We currently have 2 other versions of KUNIT_INIT_BINARY_ASSERT_STRUCT.
> The only differences are that
> * the format funcition they pass is different
> * the types of left_val/right_val should be different (integral,
> pointer, string).
>
> The latter doesn't actually matter since these macros are just plumbing
> them along to KUNIT_ASSERTION where they will get type checked.
>
> So combine them all into a single KUNIT_INIT_BINARY_ASSERT_STRUCT that
> now also takes the format function as a parameter.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
