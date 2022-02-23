Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500364C153C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiBWORh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiBWORf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:17:35 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529124553C;
        Wed, 23 Feb 2022 06:17:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lw4so52757103ejb.12;
        Wed, 23 Feb 2022 06:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1iyFg4ygVXSSGIi4bXBzc7ifbeyS/lQJxJfXbEl8Oqw=;
        b=Z5b/Sror4GA90/t//HoPA3zMdJL4iATEEBVopRnDMAVgCeO8KRm9ciFB87f0Q6HHvD
         LDL+Nw6jxGQyYxhwCWsH2j1v46HO7GBGgWkN/faUgns6niFdKRbda0M11Gb/jADazd92
         4BUT+E0BNqjSNJ19miqncyFwGOF3jSGVnZM274yXmcxsiJvrwIQuVjhJaO7UbRL51roG
         VtxVHJrjV3LQy0jHOUtQvv4XghBt2CaoQeBjOJ+jWcYc6AGXTsjrEz3EO9XvJ6Jp6hsa
         W4oRDxh1TfwE9orTCbE2BINKqvxPfu452Wos13FliNOlyJcX/36cv0pH++gkvP0ZfqQ9
         TsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1iyFg4ygVXSSGIi4bXBzc7ifbeyS/lQJxJfXbEl8Oqw=;
        b=bZqCgFmy56ENLvxf7yFKBKwQiszBdv6ww+VOLWvOmwmqmxi1AXvDGnxN9du/1JOntX
         FxtSAbG3IXf/TBiDWqVuM1qlcOVtmFLWnT++fHDOourwimK3MeJZqo8Sxitj5cbBzPOw
         o7DDgIQ6Z9nClEK5N3cbxB0/ZCTaUgfL94rc2YKN1Vww//ofcW7rH/puY2ALZG4NZFVL
         RBqOTihfF44fPuTXtt5TRlvwfMFA1fJy8bXEd7bW5lzHUNMux5ISCqZHUu0OLxKXiqge
         +AB/NKGtOq7Xsn0EDaIdl8y+PRm1+yZ77uiSAslaqUf/LOAX0UUy9f8f178cMCH+ZJ4Q
         l6jg==
X-Gm-Message-State: AOAM531S4eKN6G4udLUztaofdFMF2f/cgk388Ideujf1Emlv9u9zoha4
        M8YQ4lo8TgHg32d1Kh3Q6FQ=
X-Google-Smtp-Source: ABdhPJxG3QiQ+u/0xJB4apbYcbKMd+xIBSdNhfaHcyr0sqbEc6XuEXgcGST/W1RsP8+mbMf4P8sY4A==
X-Received: by 2002:a17:906:e4c:b0:6bb:c8c9:f681 with SMTP id q12-20020a1709060e4c00b006bbc8c9f681mr23717132eji.124.1645625825896;
        Wed, 23 Feb 2022 06:17:05 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id t26sm10513682edv.50.2022.02.23.06.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:17:05 -0800 (PST)
Date:   Wed, 23 Feb 2022 15:17:02 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: Check existence of FILE arg
Message-ID: <20220223151702.55a3a7a5@fuji.fritz.box>
In-Reply-To: <721f860a-a662-0f0c-a82d-eacf80841eb3@gmail.com>
References: <1c71e5d2-f87e-6c8e-6176-e5ce42e4d41b@gmail.com>
        <20220223144713.6e2284e3@fuji.fritz.box>
        <721f860a-a662-0f0c-a82d-eacf80841eb3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 22:59:01 +0900
Akira Yokosawa <akiyks@gmail.com> wrote:

> On Wed, 23 Feb 2022 14:47:13 +0100,
> Tomasz Warnie=C5=82=C5=82o wrote:
> > On Wed, 23 Feb 2022 15:07:30 +0900
> > Akira Yokosawa <akiyks@gmail.com> wrote:
> >  =20
> >> Currently, when no FILE argument is given following switches such
> >> as -man, -rst, and -none, kernel-doc ends up in the error of (long
> >> msg from perl folded):
> >>
> >>     Use of uninitialized value $ARGV[0] in pattern match (m//)
> >>     at ./scripts/kernel-doc line 438. =20
> >=20
> > It's a warning not an error. =20
>=20
> Good catch!
>=20
> Will amend in v2 with proper attribution.
>=20
>         Thanks Akira

I'd include this in a series regulating all the CLI syntax - all those
mutual exclusions and arg parsing error handling, etc. At the moment they
exist only in the documentation.

But I'm not sure this is the right moment to do this. Have you seen
my RFC thread? I'd wait until the water stabilises and see the result.
This script may be phased out - how soon, I don't know. Unless you want
to do this purely for sport.

Tomasz
