Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CBE57EF3D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiGWNnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:43:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA4F641D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:43:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x1so4970026plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=74P+O8sp5lm0Sg+UxTgNRhPNuNgtyuLNzL/6fehWii8=;
        b=cb9KopSME0jgsnIYppaXVDtaldungGRFtZ0C312W7DD3noIbLzEoG5Fa1ocTgHkXaj
         ev47B/UYsERE/Nc1T9UxI0BCfZF97//epatiKgkIcx1JIbfjVBZiukq+M1248pWh4uMb
         91voPmAk7fdFlzbNf/jdDYC4Z69TiYBjd1/Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=74P+O8sp5lm0Sg+UxTgNRhPNuNgtyuLNzL/6fehWii8=;
        b=NVFHb68qxu86TXaR8K4nPr1w9wiMsQj06clhcolNcgc7IdgagW/Z+E8ZbM+NKMfsgR
         rlkplTMvo9N4GveUVLA+b0AX4a4tox5nZHLdYePrHnBETkSCy/t7ZrsG5NThr/fj6gkx
         b/Ik9cYVDKCtIWtC0xZwnYFJJ6xYiRGc/WlcOLrSJpmvhUlK3OGDrQQoN3MkFqz5mahl
         XvZrezVJ/eW6H+wZ7ybY2gA0vXFAbtciShOJ2+8483ImlXPSxF+BarQWtiWEoWoBmTFT
         kyrKRg4DlHBNaoSS3mmDOLioJqVcQO1mF+Z/M5aPycE9wiwY6/6zOjSnelTM27VgDsG3
         FcSg==
X-Gm-Message-State: AJIora+pgDZpZU0oEAvFO9vGSSkeOttdv0ViwjgV1NkYo7GzreKCvfMU
        OOKKGNhVUtIm5ocR/WZX/H6UbA==
X-Google-Smtp-Source: AGRyM1sByCtQL20f2n6BkvzsUI/95ohfg27wPbdftUGAk9oS174EzDS/7gH9vcSzem0b0LufuyeMPw==
X-Received: by 2002:a17:90b:1c8e:b0:1f1:b5a8:330f with SMTP id oo14-20020a17090b1c8e00b001f1b5a8330fmr22633471pjb.179.1658583780802;
        Sat, 23 Jul 2022 06:43:00 -0700 (PDT)
Received: from [127.0.0.1] (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y17-20020a63ce11000000b00419acadde52sm5161337pgf.46.2022.07.23.06.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 06:43:00 -0700 (PDT)
Date:   Sat, 23 Jul 2022 06:42:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>, ndesaulniers@google.com
CC:     arnd@arndb.de, gregkh@linuxfoundation.org, justinstitt@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, trix@redhat.com
Subject: Re: [PATCH v2] drivers: lkdtm: fix clang -Wformat warning
User-Agent: K-9 Mail for Android
In-Reply-To: <20220721215706.4153027-1-justinstitt@google.com>
References: <CAKwvOd=wn=tbX7ixs9a=4zoVSbAU1qP-6NE04hGG9dzvo0zFJw@mail.gmail.com> <20220721215706.4153027-1-justinstitt@google.com>
Message-ID: <9306DFB1-1873-481F-898D-CE141D0C32A5@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 21, 2022 2:57:06 PM PDT, Justin Stitt <justinstitt@google=2Ecom> w=
rote:
>When building with Clang we encounter the following warning
>(ARCH=3Dhexagon + CONFIG_FRAME_WARN=3D0):
>| =2E=2E/drivers/misc/lkdtm/bugs=2Ec:107:3: error: format specifies type
>| 'unsigned long' but the argument has type 'int' [-Werror,-Wformat]
>|                 REC_STACK_SIZE, recur_count);
>|                 ^~~~~~~~~~~~~~
>
>Cast REC_STACK_SIZE to `unsigned long` to match format specifier `%lu`
>as well as maintain symmetry with `#define REC_STACK_SIZE
>(_AC(CONFIG_FRAME_WARN, UL) / 2)`=2E
>
>Link: https://github=2Ecom/ClangBuiltLinux/linux/issues/378
>Reported-by: Nathan Chancellor <nathan@kernel=2Eorg>
>Suggested-by: Nathan Chancellor <nathan@kernel=2Eorg>
>Suggested-by: Nick Desaulniers <ndesaulniers@google=2Ecom>
>Signed-off-by: Justin Stitt <justinstitt@google=2Ecom>

Thanks!

Acked-by: Kees Cook <keescook@chromium=2Eorg>
Fixes: 24cccab42c419 ("lkdtm/bugs: Adjust recursion test to avoid elision"=
)


--=20
Kees Cook
