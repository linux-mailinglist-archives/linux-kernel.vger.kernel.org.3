Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859594967BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiAUWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiAUWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:17:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47164C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:17:41 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u10so5546439pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHzIhd7zKWJ7lgAIYdROcoiXMKWiKJ0s7v8JpfyrXqM=;
        b=SGauYPIjPHhHLYZm0Lf5FILu3k2ksbkH56iHA3blbk7riAmu0c7b9hj8Qk9oN2cQkj
         QEtKpbus5gNjptAhWm81cEl59gjANWDu2DMLt+CYAbQcRAiaL5nNUSru/nWLW8ceuMbi
         K/MJqCHVTk/5j9hS/UZbKr2Uu88s7Y07tDT1XzMTCCWMJmhDqrqfI2B68k/0CVed6C6o
         riujXaaQT/pdiSCpk58ZvcekYz4CXqlmhgMgO1HyaLdpRnvJQ3qV5XeBpBAk2cSn6ERZ
         aVtiAQ7g+Qy/LTf3Kgr+vqkpVzKurBMN++W4jdU3SZySr3BmIGtKvU/rb4XldmUyv4Eo
         xgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHzIhd7zKWJ7lgAIYdROcoiXMKWiKJ0s7v8JpfyrXqM=;
        b=ZXvmZo0H1r9pYp2Jak8o5F6aYftuygr9UbunDwsLBRYm1wAHam//D4R4jiIXqG2/E0
         Oedyyb+Pd5SlhATd6CYtF99gP9C+gxJjAkD/Q+trAjLOa1Ti8QaegUfJLOGSJThLSYX9
         t+bVGN4761HzqtJ8Rzko9DjOwH+tk4Ct1Eao8y4//ZVkmjVn7d9wHxSr7pvlAebbQ/rm
         itaqJGsjatgdvJvdIN4DFJrii+gj9oAxs0byL0Ow83+9gxZkK1NZJkV1+R93yGc1tqFY
         OIM2vLNaF+rYTOSu4IQHzosZsBoYNdpw6ouqN0IupoYDQXfqc8UO+iGupm3tv3hQ0u8Z
         XshQ==
X-Gm-Message-State: AOAM532DmBB3XH6JJAEHYBxz8X5uPMoyy+yRL5qk3CPTN71Y+jEBGkml
        JvnOX4ye+hgbZWgq6B8S32hTyPNb8zOqJH9VGtpqrg==
X-Google-Smtp-Source: ABdhPJxFGkV7xhGZ3e6FXpzbJe68yNJjVbxD8ZID5wmJ0tUkLe+IQOqEtXz8kBuZLo/IaspuO/2zrTFojETKDVlpZYI=
X-Received: by 2002:a05:6a00:8d3:b0:4bc:3fe0:98d2 with SMTP id
 s19-20020a056a0008d300b004bc3fe098d2mr5320258pfu.3.1642803460324; Fri, 21 Jan
 2022 14:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-5-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 17:17:28 -0500
Message-ID: <CAFd5g454zOO_wTgDRKxfCct0QguUbW1F4zKH4MTD9LrogAW8hA@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: decrease macro layering for integer asserts
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 5:35 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Introduce a KUNIT_BINARY_INT_ASSERTION for the likes of KUNIT_EXPECT_LT.
> This is analagous to KUNIT_BINARY_STR_ASSERTION.
>
> Note: this patch leaves the EQ/NE macros untouched since those share
> some intermediate macros for the pointer-based macros.
>
> The current macro chain looks like:
> KUNIT_EXPECT_LT_MSG => KUNIT_BASE_LT_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_GT_MSG => KUNIT_BASE_GT_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> <ditto for LE, GE, and ASSERT variants>
>
> After this change:
> KUNIT_EXPECT_LT_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_GT_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
>
> I.e. we've traded all the unique intermediary macros for a single shared
> KUNIT_BINARY_INT_ASSERTION. The only difference is that users of
> KUNIT_BINARY_INT_ASSERTION also need to pass the operation (==, <, etc.).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
