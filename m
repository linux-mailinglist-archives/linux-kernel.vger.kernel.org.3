Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BB50A281
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387396AbiDUOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389520AbiDUOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:32:33 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638CB3DA46
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:29:42 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f18982c255so54128637b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZG4EdorLv78tv5gy7THOMV2FGRHjDBuHsHFXEweTNaI=;
        b=cRJuoHtW2JT2jmMyQ8WMg5CHugHDUd4E5HXsi0zKH4EPgLSAXjpZAgCMWeHon+5QgA
         WEQz2oDxWUyrJLpkopdc7G9o55qHDXMo7+mDyTfCChhsIrdJmtAVN8jqjH3ZnPXhnd5+
         ZwFkMhRVBikN4hDp6ZS0v6hIS0i1HMhQiUSdw3WqWu298NsyCBSDwnN1dVQiz4696Ohx
         X1ssHQxTIXqcX07tQ6n6sm6dOi1ErDb0bSIR/XNp/28l28OCxptQ+eOoucSkLiO+91bo
         G/uTNM2338KKUE3LpvO/5gqY88YCDwFkg0P/Z7FrbZ7XMBPHJBxf0uw2vLCJGgu4q3XQ
         /t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZG4EdorLv78tv5gy7THOMV2FGRHjDBuHsHFXEweTNaI=;
        b=YL3KZmrX/MCT5Zw//ArLO7yMv0byWnCAc3cy87tWIh5TQZeXuP5WRjHpGu8qNU39Nh
         t65sBgaiYSXpFpuAO19vHLAyef7w23RGT7Ohv/9hHLEE58qqopSqo90dGSD6mNC4VjI1
         knOdrd/VxJglyeX5zi4vqHxexxqBff6N9FMKLtPjtPz6VHLV2/EhF7pxyW2Ix6ngv3rV
         O9EKiVZl6E/Ua608bLNwcCmtFijf9Y8ufExCpi9ctEZLSIBwU0O1PK5OeszbIHI/i+tm
         42Gj5r625b2EdXX7EsIM1dnzVblsdxyv12DyNXrdyB5WVVDBUCs/BgQJ3IyOdfPMrMTR
         jGCA==
X-Gm-Message-State: AOAM5301gx7KHsv9GnOqFSvrJLlEP6tFV4dxfAmuQ1TjzHS/jtcot7aT
        fYbTiVXft+xB9ZqPc2W9srcJ+rR5m9QU9Jca47BuEw==
X-Google-Smtp-Source: ABdhPJyBfz1L/nhJWU9qmmJ7Q1gFQtBUMk3+GOFUjBGAUJUZHnadadeK1Meil5aghtO4b3xCaIkrvNlxjPFhZSO8+OI=
X-Received: by 2002:a81:5dc5:0:b0:2eb:3feb:686c with SMTP id
 r188-20020a815dc5000000b002eb3feb686cmr26766540ywb.268.1650551381675; Thu, 21
 Apr 2022 07:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <1650015688-19774-1-git-send-email-wellslutw@gmail.com>
In-Reply-To: <1650015688-19774-1-git-send-email-wellslutw@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 16:29:30 +0200
Message-ID: <CACRpkda+r0x6DG9E451Ehw4ojE=mj5SHzUyShXs5CU+Bar6efA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Fix an error in pin-function table of SP7021
To:     Wells Lu <wellslutw@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 11:41 AM Wells Lu <wellslutw@gmail.com> wrote:

> The first valid item of pin-function table should
> start from the third item. The first two items,
> due to historical and compatible reasons, should
> be dummy items.
>
> The two dummy items were removed accidentally in
> initial submission. This fix adds them back.
>
> Signed-off-by: Wells Lu <wellslutw@gmail.com>

Patch applied for fixes!

Yours,
Linus Walleij
