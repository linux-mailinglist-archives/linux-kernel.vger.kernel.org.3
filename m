Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E764967B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiAUWOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiAUWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:14:00 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3306C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:14:00 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h13so9359400plf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nnss6a9MA14+UWYAmsICTbIY39H/bkhpNFu76IHD8vg=;
        b=r3xJL4RGG40p9ajfsacqGZuOebfeT82VCBt8ubl5aH/TOJz0fE8X8KYEDGxePpDjVe
         NAJ+qciQthYxPyGbwlvt2aUhbmeCUclWM1aEmq5O1ewNz9dtaHjc1Ka0xS7YYnzOvoBG
         FRcoStxkhDPNmA0Eo51MO2hZ41/TqLewxohgiv6bPyEtpSFOQ/UZWbNYRnC8mne7m73u
         3EYBO5OQKhDdTgYXgsNUO8Pq8y9H5PhwrAN47VY7oF0ijmrYCEXc0LNoKkWMMQYGcTo2
         1HeUsDr1gojt4IvaIn5XEycbDRSw4LpiNRV/msZ1LZduq4wgUs0MvpRPTaxSClzxT0TU
         ardA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nnss6a9MA14+UWYAmsICTbIY39H/bkhpNFu76IHD8vg=;
        b=jRlljhIP7oLdQ2twffrf4X4YWunMUJQr/Jc8LXLPBDA3dKI5CNwcZ5/tmgbgz+j5Ks
         O+1GwrSaeK7t25X3YfRTGQinLo5FgKdzjUBvOGibH/00o0kVLdnM9lv3DZpXwJHLPgBY
         +UqzHDi9NCx+LD3+V93Ku2RVQ3dHNFSvRaEEVPUIMSEtt9pV1ZEh5msyGvucLvF8VrOq
         QR2s3Q5bzxWhC48xnNNUapZRaVE7qcpMnDGuS52/ZTNMrLhC/JvFFz5V+pAhov167eBV
         u4/ct8YosvmQQbWBin7o1mw/YMoLhSCOfDJRzfLKhw+lzJ/7UfWl6UjyfYmJj+SKbJZR
         wfLw==
X-Gm-Message-State: AOAM530iZT5/VgX0fKkI5S8+NOdFj0VXn0+3kVOKYbsRVZIGSd+5ozvl
        OPz3ng25W4ED9fLa0po7nkxXC2tDAKJhrTZksRr2zg==
X-Google-Smtp-Source: ABdhPJxziV7v+8obhn4MbPKIZDA64SQiHqv9vpRKZfykdhdDMO8Ro9y9Z9V8AjlhBm6Z/p/1vICYPVW47ZIbDhG9LlQ=
X-Received: by 2002:a17:902:6502:b0:149:1162:f0b5 with SMTP id
 b2-20020a170902650200b001491162f0b5mr5696756plk.126.1642803239982; Fri, 21
 Jan 2022 14:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-4-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 17:13:48 -0500
Message-ID: <CAFd5g4492KRo99mgVuKKXvmnw1Su_XjVrwJ9BGM0kLwC9ce_Wg@mail.gmail.com>
Subject: Re: [PATCH 3/5] kunit: reduce layering in string assertion macros
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
> The current macro chain looks like:
> KUNIT_EXPECT_STREQ => KUNIT_EXPECT_STREQ_MSG => KUNIT_BINARY_STR_EQ_MSG_ASSERTION => KUNIT_BINARY_STR_ASSERTION.
> KUNIT_ASSERT_STREQ => KUNIT_ASSERT_STREQ_MSG => KUNIT_BINARY_STR_EQ_MSG_ASSERTION => KUNIT_BINARY_STR_ASSERTION.
> <ditto for STR_NE>
>
> After this change:
> KUNIT_EXPECT_STREQ => KUNIT_EXPECT_STREQ_MSG => KUNIT_BINARY_STR_ASSERTION.
> KUNIT_ASSERT_STREQ => KUNIT_ASSERT_STREQ_MSG => KUNIT_BINARY_STR_ASSERTION.
> <ditto for STR_NE>
>
> All the intermediate macro did was pass in "==" or "!=", so it seems
> better to just drop them at the cost of a bit more copy-paste.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
