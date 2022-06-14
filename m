Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0954B649
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbiFNQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbiFNQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:33:58 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8088D27CD3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:33:57 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-30ec2aa3b6cso35210397b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/kEUFAftetAf2N7yHDHF4JNTzfknxIkkNoqCJfpWV0=;
        b=bQFtbs9YcHpIat+VNMaXN8GfVHbAWCDLkV7fg62QD0yIWV+0uP3jDb6bxCYuRrqEKT
         khJU61Bk1hb9Uq80iBtZyGFkblrK2wmswiU0/MbDSWcgffqTKuIHptrGMxqOTMIqbcC5
         sHDPSHsiLF/+5qg30zLjsDKcgknLfGgW1u29wprNjV5IKExT0DSPvuMIv9W8cvVBEDsm
         5HJuDD1ugXa43hE611TnQppED/4xi7YH9Yfla859aTKuPPndKZGqDFWWurUyMgqK4jRr
         xL31Z0Afw/Y6Rb16m9Il0Mtp3STHc2r+MPEzB3OgRTSAFGzSzZ3IIs/HR0OlrSmV8qTK
         UyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/kEUFAftetAf2N7yHDHF4JNTzfknxIkkNoqCJfpWV0=;
        b=T8mUwYP6NstXsW7hiFPbX2hPrJTdcydDU1+kyxa79qPP6NvqzXf++RPJclTiqavBRb
         RdSxBq5hYoheDf4YMvVBTyeZQO1EFQURHX2fAIK5rlSMgE44MRUVJOOHmn3rhBy80Y6W
         eXAB2a+Uu1Eljh9hn8yuPW+OeH192iuUlViTQWwa5fC4MJ0WGXc5/eHxtHVuuImC8on4
         Ga10vT4D9H9Z6L9BbP0I432D6jeSwMDwY47gVttVh8oyMdKqWdovjWcpW3EUPL/TMxox
         uEf3zv29VO5IdxL3tqb70NTWFaf7CKFZxw8g47ISB1TcGoJ6zHOI7Lo/sOhFmNJBsTqJ
         zZJQ==
X-Gm-Message-State: AJIora/1lFcwXuIucoOR0hkDRzV7Phme6hF34DDjQJleKAUfS9d+t4AY
        TMuJjDGPa1G/chNdSEHmiTadCna7L4rQv1hJybfON40CPnx3TQ==
X-Google-Smtp-Source: AGRyM1stOhRVUmqx6x88uP8qyvJLoxv+aOJ0qkV9zyqBCmiYqcqZF7JCtPygwqiVsQXO2FQ8S8R0hej7Hl8B6obkwRk=
X-Received: by 2002:a81:78d:0:b0:2e5:d440:d921 with SMTP id
 135-20020a81078d000000b002e5d440d921mr6236243ywh.251.1655224436611; Tue, 14
 Jun 2022 09:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220613155612.402297-1-daeho43@gmail.com> <Yqge0XS7jbSnNWvq@sol.localdomain>
In-Reply-To: <Yqge0XS7jbSnNWvq@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 14 Jun 2022 09:33:45 -0700
Message-ID: <CACOAw_xZvvJFC8OwDQibtXqyYS7bMRe8CVkkktT_Nd1_EtFw+g@mail.gmail.com>
Subject: Re: [PATCH] f2fs: handle decompress only post processing in softirq
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> One question: is this (the bio endio callback) actually guaranteed to be
> executed from a softirq?  If you look at dm-crypt's support for workqueue-less
> decryption, for example, it explicitly checks 'in_hardirq() || irqs_disabled()'
> and schedules a tasklet if either of those is the case.
>
> - Eric

Oh, you're right. Even though it's safe to defer all the release
process as a work in end_io function, it's better to check the
condition and process the release process right away if possible.

Thanks,
