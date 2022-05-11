Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5FC523F33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347975AbiEKVGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347130AbiEKVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:05:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048103630A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:05:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j6so6402368ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynACITrtZzlKKqGyhSsamC0GjuNyAFQkpCuDbRLZ5eA=;
        b=L+AOis4yZWcZ1IL0iiPSTBcAUZGQn0SnVYsycwPfW58FE93ROmbF7Bq0hPrNiFRa8g
         JlrGFDByBnBWX5XKOuqEvyXXxMhG6UQkvV+XCCXX0AasnWtJ7lzwavwMGctz+7PCjPfw
         P8l9wg9vsu3om2MiVDp2PgbXcXZKSfn3Vc0pLg4NLih5m3Upk9BdZ1VzrwAGvFhmjLjO
         4M16DpVcSQ27cz+SJMwC/TKKZ3fNClJsGiy7u1rWz/ePh/1VRMnAZNrqe5POmmMFNCtq
         tGQ79/PFZYBRAUe0jo4rCXfD1S4WxZimlrsSErCx2ZbPncFLyz77tISUtsD8lw3bkz5y
         O7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynACITrtZzlKKqGyhSsamC0GjuNyAFQkpCuDbRLZ5eA=;
        b=eLemGbwI1a8poV6Ln/fn0RuLZ6CWAJpYHwjN0AqA8GfZMESDOl0ETaVbwhMKpNMVwD
         lLjgcOqzT5zp5fk4oFQRcsavEir1Vz5xoc08Wbsv3PqCU/cgbX7helZlErkemWmNdq7e
         jytnDV8Vull0860aUegUG1Oo8kY8lQi3EvIbp/1H064Fv8CaIL0ZvYpj8DZG5Dne0dpW
         oKVL9rskSpZhzKZ17JuFu+PjKmniBRe4aUh96ylTw4520jPa8P9NT7U3ICEIKH/ZOvPP
         CuvS6ZPCdxEtQcGY8YkvjRQeO/Azy0aeyPYnYpSftqscv3cq0kyS+iOZS6W4ENy3VvQR
         RPuA==
X-Gm-Message-State: AOAM531fmbyIyu/b8InGlEc13gl3nITUEy3yfjniG5L5T7j7DCErUchI
        +fSIOJPU4DUbCWY7edGA+KJFyT0b0C9663tgzpXQA8h1SJOwFHNK
X-Google-Smtp-Source: ABdhPJw4G75TGPYUDLK0sLGgvp0IXvKBjVwkHssJ3WNT+0ieIBKIsLsCtXbiQIiHz5aaWSrxJ7SnEdCMer/vL8uYcxE=
X-Received: by 2002:a17:907:968d:b0:6f4:9f9e:3e5f with SMTP id
 hd13-20020a170907968d00b006f49f9e3e5fmr27155651ejc.540.1652303155279; Wed, 11
 May 2022 14:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220405190619.540177-1-dlatypov@google.com>
In-Reply-To: <20220405190619.540177-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 May 2022 17:05:42 -0400
Message-ID: <CAFd5g44HjAHkwY9rAe3VCSTpRUNcoR0WU-e1z0BA+MKu_BYXyA@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 3:06 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This is in line with Documentation/dev-tools/kunit/style.rst.
> Some of these tests predate that so they don't follow this convention.
>
> With this and commit b0841b51cac9 ("kunit: arch/um/configs: Enable
> KUNIT_ALL_TESTS by default"), kunit.py will now run these tests by
> default. This hopefully makes it easier to run and maintain the tests.
> If any of these were to start failing, people would notice much quicker.
>
> Note: this commit doesn't update LINEAR_RANGES_TEST since that would
> select its dependency (LINEAR_RANGES). We don't want KUNIT_ALL_TESTS
> to enable anything other than test kconfigs.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
