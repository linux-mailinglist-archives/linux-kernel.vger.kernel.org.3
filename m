Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6996F594E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiHPCDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiHPCBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:01:35 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADA220B86;
        Mon, 15 Aug 2022 14:54:09 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id g18so4485165ilk.4;
        Mon, 15 Aug 2022 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cfZ7AXIapgfEmy3HcGInV8lY0Q/eqUbvocWgttpRt5s=;
        b=dX2AjqXEr2g6tUQTPp5i62lnIBaY1KDRjuJzdk4ZqL2iw6Ll3AXmL27yEgW9i4df2L
         QHzilMOOSFwht+BK/9FURK7Yxha2ZAh/uM3s/IAWcOIgpWXgNuOZE/0dsggQbnYnoMV2
         4ht26qruOC2uh9RAI+hNRUs9MQbacQlLxyHgMTTJtz88tMGAIjebglpprFNBZk7q3tcu
         rvYqkp4G6V4o1DymlhtNRUrLNo37O+KeNHtsRdaJSPlLKgTDE/4QGTEyN+9zuLwGxEAZ
         sXGVXeagfoNiSFAQEP1t8VDNE3FRQbwAe2gJZ3uO5Hd5rVzmrhYfLE60t0myQrrP7spF
         fZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cfZ7AXIapgfEmy3HcGInV8lY0Q/eqUbvocWgttpRt5s=;
        b=qiwfAbzUiDRWe9PP53XjN8Md26CGpBIYSgHJSwd4mgGO7108j5sVAV230WMLsGH4jN
         wHvBdhOPaIeeBKn9svOc1IBzUPGt/GUEScjBpUw3wE5ZvG5DEkWS1SJoBIDDrtQz9Y8N
         G8ryr+Af+vbXuyp84UfK/6DbCeDiw0daLVsaNt3AXglXGzClzSn5qrYMSdlWBZAhdeff
         jp/9UfZAhKUIRT/z9UodZA0AGT8zGICbA0wFw2U+2bCjky15uUyuD6A0wC5rp7bmtuPW
         QeOZ2KvTcF9woi7Y8b0JHf/8w47MnzI2XtNklloyD1thkRwjblu3EPv08d+QPaDkFCFA
         QtuQ==
X-Gm-Message-State: ACgBeo1DWdH3qXppuk9xs/SeX3gaBdNj4Ob8trlnrQppEoAwCbjMDNAP
        XgNyR7YXPAlpWJzhnYMD2mNyHq5ZLu4dE8/8rBE=
X-Google-Smtp-Source: AA6agR7MEvDHtr5TgG49Br9jwui4tIN1ssSokF72+gwpQRKtl1hfpE3Vi2nKn02Sq+yEiwOhLSYXtiA7omlhuzJsdIM=
X-Received: by 2002:a05:6e02:17c6:b0:2dd:d9dc:6387 with SMTP id
 z6-20020a056e0217c600b002ddd9dc6387mr7828274ilu.321.1660600448578; Mon, 15
 Aug 2022 14:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-7-ojeda@kernel.org>
 <Yvq3IfK4+C94AeE2@slm.duckdns.org>
In-Reply-To: <Yvq3IfK4+C94AeE2@slm.duckdns.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 15 Aug 2022 23:53:57 +0200
Message-ID: <CANiq72=aeDzF0PX-2+X6XuyONAjY8yHh5VnJTtXusi=mPqiJQw@mail.gmail.com>
Subject: Re: [PATCH v8 06/31] workqueue: introduce `__INIT_WORK_WITH_KEY`
To:     Tejun Heo <tj@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Mon, Aug 15, 2022 at 11:14 PM Tejun Heo <tj@kernel.org> wrote:
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Please feel free to route the patch with the rest of the series or let me
> know if you want through the wq tree.

Since for v9 [1] I had to trim the patch series, this patch is not in
the series anymore, so I think this one should ideally go through the
wq tree later on when we send it together with the Rust abstractions
for it after the core support is merged.

Thanks a lot!

[1] https://lore.kernel.org/lkml/20220805154231.31257-1-ojeda@kernel.org/

Cheers,
Miguel
