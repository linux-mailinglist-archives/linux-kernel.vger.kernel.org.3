Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633FA4C643D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiB1IAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiB1IAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:00:03 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E04EF46;
        Sun, 27 Feb 2022 23:59:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y11so10390940pfa.6;
        Sun, 27 Feb 2022 23:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UGFHXK2sDdYpn7z8FJXWp22uhUlSHArEwLvEYjihUnk=;
        b=fmB4cqkaoDVw6sfwRQgWeP8+qrBTtLVMb/rSWpHX6jLAK544PnkoR2Vd//4VrYIvUB
         w0/KCB1DwQRWjq8e+1fUwLQM+JphY0E77EiJGZonJ6RW7zg81yGiTnOB0ZsvEsmKEcV9
         ajqZUzrpKCxx4YBYWip1Jvkwobsz6nlE5bp23/dfIWchkvrYkNSKoq6SkDDJ9210Vb/x
         AX0p6id6A9Ov0kKvC/LEqT5JP2qecRmRwEXe4P8OkZL3goNQ9lh1ScBqK7poqXkB7xFQ
         H8TfiXG0/4cD+xbqLkQR0AVr3kPfuaAewuZnjM1+9ytI/cKnpdD9m5FfDG0ca9FC54rD
         rGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGFHXK2sDdYpn7z8FJXWp22uhUlSHArEwLvEYjihUnk=;
        b=pOlk0aZUHhD9M6qUaICTcbPFJ3U1aAkV3Khusd6uVuYd/zcn3hizJfdn7DcOJDokKu
         DdIi8HFZhXktkV0L+2ZhmoOsILNv5/9mSIjd9XXY8fDesZ8M3sXj1mNp3E4bDXXe557T
         7Gs+weQA3qZHjkFTCKp0L9yOa7dUtU/RPz1DbxcFoTCKjGiaYM922Rtwy8iqf1lUEBv+
         g45l7G9XVeLkifgJX31pu4sOb1+7+VWw29FDSQgxsFBpZUG4Zs9uGjz0JdNT0hgoA8CP
         opEk8e3xeYEhkn9jdejugwdGQIuXJfqPdyhuOz5sgLxvCq8RK+xWbJnQYi/aPOIng79n
         zJWA==
X-Gm-Message-State: AOAM531VOlE5vtwZ3EeiKYU8uOnOSpFbHOO/I96nzyneZW4xzJ2Aukty
        fjKwMQRn36qR9/mGZIrtCB0=
X-Google-Smtp-Source: ABdhPJwvvE9UO/GKXMFXs2IPtyqWN6hvo+pVPWONXqoE2I7GvFZTvAXFHkilH2Hu5lKNzfFDDQQEHg==
X-Received: by 2002:a63:6cb:0:b0:36c:e2d:8857 with SMTP id 194-20020a6306cb000000b0036c0e2d8857mr16108553pgg.214.1646035164542;
        Sun, 27 Feb 2022 23:59:24 -0800 (PST)
Received: from google.com ([2620:15c:202:201:43a2:93b6:ebd7:94fd])
        by smtp.gmail.com with ESMTPSA id v14-20020a056a00148e00b004e1cee6f6b4sm12613123pfu.47.2022.02.27.23.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:59:23 -0800 (PST)
Date:   Sun, 27 Feb 2022 23:59:21 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        Sean O'Brien <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v4 1/4] Input: Extract ChromeOS vivaldi physmap show
 function
Message-ID: <YhyA2TWIDMld8cq8@google.com>
References: <20220216195901.1326924-1-swboyd@chromium.org>
 <20220216195901.1326924-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216195901.1326924-2-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Feb 16, 2022 at 11:58:58AM -0800, Stephen Boyd wrote:
> diff --git a/include/linux/input/vivaldi-fmap.h b/include/linux/input/vivaldi-fmap.h
> new file mode 100644
> index 000000000000..57563d9da022
> --- /dev/null
> +++ b/include/linux/input/vivaldi-fmap.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _VIVALDI_KEYMAP_H
> +#define _VIVALDI_KEYMAP_H
> +
> +#include <linux/types.h>
> +
> +#define VIVALDI_MIN_FN_ROW_KEY	1
> +#define VIVALDI_MAX_FN_ROW_KEY	24

These 2 are actually details of HID, we had a #define in atkbd which I
lifted as VIVALDI_MAX_FUNCTION_ROW_KEYS and put here, and dropped it
from atkbd and made cros_ec keyboard driver use it as well.

Thanks.

-- 
Dmitry
