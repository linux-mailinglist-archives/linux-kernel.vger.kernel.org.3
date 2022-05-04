Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265EC51A57D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353437AbiEDQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353530AbiEDQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:29:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D778A18B38
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:25:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g6so3925162ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yl4WQenCDLJErgHp6t3UJjMlUc388BkN8ozV46DV1Jw=;
        b=UkruObD31qixCl3tEbnbC6/Szb3fOE20vobsG9EB3D9Txyb4DwrMg1MPuKOiuriQO0
         bfrFQY2q3GU5cpGZ7NEMVFeHonKS5jshPndb1NXSNCiTBMlfAEkFMO8MhdiXH6ubVy15
         BzqTQmHqpfWQzsfzfYtrrlft6mJ9zFxFJEfJ4U4Ie+qKpkI5l8BD5+La8b4QxtHnOZHv
         y9hlgtiUQDYw5ZGnGKioMzZ+lQRrGXXZhBVznZ74FaY+dTBY6b/TGGgYXY5R1PpQQCrK
         I9YG9e+4QLGYqahZJ2AFhjRAc1yU0adG166I7bIvuvzbKey6OlIqjHgUaeb4A8zObyB3
         Q+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yl4WQenCDLJErgHp6t3UJjMlUc388BkN8ozV46DV1Jw=;
        b=r16SWfxuN9WWjTxowxVklINqWY+2Zot1eJbec8MDZx6qyoSVVwGfbkOw5FHevAelWu
         g+8uJrjpqbm334cEUSDuj8L0xXjxsP3pz/enygaK+wyduYLrF6WcY4I/ld070UJooZJj
         bPipziVE39FA6+PAoW7vSB9u2j9Z7jHtssmELizk7K1y4WjHPRRUOenQbumOmsFVCTBT
         iJm3nWxWj4H8xaeK9V6nqVlfxX0BpdlIYmO2QRUu2pbliaQK0YJBNziv5qx8g/grt87j
         py1FeCGaahM6xFJbAfoEAtgL3RKHSO8s9yyyGxIryC/Iifq5RHfyK0BI4fy3hSeZblvF
         51tg==
X-Gm-Message-State: AOAM530C87myFxwZzQfeuJ2yHr4jYymoWzcumxhG478ALB6puMkMF487
        5afmcMY1yoiHRCChFBBwEwITzwRhaG50s4GzZDccFg==
X-Google-Smtp-Source: ABdhPJx2xz2gkiQHrChRkpvk1HKnyjR91ITm5VKWQSf9RezsTKQGBIkW/vQqKqLiPCJXMRXYwGVEze3ZiWHXru1KY2Q=
X-Received: by 2002:a17:906:a2c2:b0:6e7:efc2:17f2 with SMTP id
 by2-20020a170906a2c200b006e7efc217f2mr20140929ejb.542.1651681525279; Wed, 04
 May 2022 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220430030019.803481-1-davidgow@google.com>
 <Ym7P7mCoMiQq99EM@bombadil.infradead.org> <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
 <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com> <YnKS3MwNxvEi73OP@bombadil.infradead.org>
In-Reply-To: <YnKS3MwNxvEi73OP@bombadil.infradead.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 4 May 2022 11:25:14 -0500
Message-ID: <CAGS_qxrz1WoUd5oGa7p1-H2mQVbkRxSTEbqnCG=aBj=xnMu1zQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 9:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> selftests has modules, although I am not sure if there are selftests
> which do not load modules. Shuah?

I'm not Shuah, but there are indeed selftests that don't load modules.

I went looking for an example and found
tools/testing/selftests/bpf/test_doc_build.sh, which runs entirely in
userspace (basically just `make docs`).
