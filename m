Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B466257D7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiGVAun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiGVAuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:50:39 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6AC95C37
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:50:38 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31e7c4b593fso33432607b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWIVvYuXfIBjeEz1L1BUQJGM60Wr07LvtDNRs/D6R2E=;
        b=eAmLULbAhQWopUkGzyAvOQn37WHywZEHMsK6LudhADG0r2Dl1qcbci6rKpNDscS0Eu
         PIHTrIsozJ4K4+x1t9s8KWZ7z1DPHwAqkja+/xNv8S9eQAf/bAYfB4L4LCYMI3CNTrsa
         vg5Kfy4MDfb+8JzUsOjWC8qp9LIcpNCm6uil8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWIVvYuXfIBjeEz1L1BUQJGM60Wr07LvtDNRs/D6R2E=;
        b=52kQsKqQddMtQWXnoBwJzFrcAvE4hBm0srVU+B7TE63fxE7e0s2LKD8q5DRWCBZZa6
         8pOLHoQclwI+6BQjH0S4U3i8FXf8D14DQqdWddbng2ZvZjmiHCzEcDaUxGeXopLx4ba6
         DUAgzYx5aEEwssfHiWjZql1VTk9R7zBwQ9i2EqwR8qAlvM/mh/NxYEa9BJ/yxP6CMSN5
         vhqMT3mbVcFY070UymiUa8FD9rEV2+zbyxC9RNievw2LrBee3KqROudY9pGDR7DNnB/e
         j9/WbewMOJLCZeP9PHPgaOkdeZ8cV9P+zn1z1KVTebqFXn0rMgn8RzF9zDWfWYzcQsWm
         71Mw==
X-Gm-Message-State: AJIora817J8Yj8S1MUz4ja1qfFK/dhELNf/jJZqo8Gmql6AcF5QsO5u8
        RDqa8u5dJwiNgL492rSnSqdfc7DuSr2IKYEQH4TAR2A3SsjWTQ==
X-Google-Smtp-Source: AGRyM1tUfLrddZjiTZkDHLKPZXunu9XMp+3SRpRI0F+IguB+doIxRTG9J4h/gfTxAlh/t7QwYDU/8+UMiq5eO5SiN9I=
X-Received: by 2002:a81:3dd7:0:b0:31e:347e:ef18 with SMTP id
 k206-20020a813dd7000000b0031e347eef18mr1060784ywa.420.1658451037394; Thu, 21
 Jul 2022 17:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220601011103.12681-1-dlunev@google.com> <20220601111059.v4.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <CAJfpegsitwAnrU3H3ig3a7AWKknTZNo0cFc5kPm09KzZGgO-bQ@mail.gmail.com>
In-Reply-To: <CAJfpegsitwAnrU3H3ig3a7AWKknTZNo0cFc5kPm09KzZGgO-bQ@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 22 Jul 2022 10:50:26 +1000
Message-ID: <CAONX=-cB+hhjoZc_sy_swe6Tq6yMPdgdXu6mQE6y=fT+PVtMyg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] FUSE: Retire superblock on force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniil Lunev <dlunev@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,
Thanks for your response and apologies for my delayed reply.

> Why the double sign-off?
Some misconfiguration on my side. I will remove the extra line in the
next patch version

> And this is called for both block and non-block supers.  Which means
> that the bdi will be unregistered, yet the sb could still be reused
> (see fuse_test_super()).

Just to confirm my understanding, fuse_test_super needs to have the
same check as the super.c test_* function, correct?
--Daniil
