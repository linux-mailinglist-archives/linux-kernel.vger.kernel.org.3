Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55DD578E64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiGRXml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGRXmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:42:38 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD626572
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:42:37 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31d85f82f0bso123895987b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fdwo892EWIW1Y32bf4ujqomqp34wsbvkXOhTjTQ9ay0=;
        b=aXS8JPtW3rwTtIwwOgR/zbY6v6FY2W4CVb3aBvpsR5ecjHG0u0GKG4gs4gFtvTNe5e
         BTWCWs1k0Z3RUxwmU32J/keaD7EyrOkqcRZQGHKtNGtNRIguH0RxDkY4c5DmLXTG7tjl
         ShzIhCJ7m0Sxqh3yCv0kaZUWeyzG8bUZNqR+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fdwo892EWIW1Y32bf4ujqomqp34wsbvkXOhTjTQ9ay0=;
        b=4ZQV8k8pShIj8Vgl2a1SFt3Syn+BcGZI7BadaJvJio9Gx/fhV0SPXYOfQ4zPo9E9wi
         JDxUODLaxOqzi698eAO+chER11zuYilz7N+WngmipGbmKpXHNSQH0DYByQP3f61uZ4m4
         zaMPX7CEEnaXUixZmJXQmtXJKM8S5pNIlP1fh5KPoh2nbtmUO8zyVyB5KTKTA2q5ySel
         xWXW5Ai2tK9VL10ietVxfFp8qtj85OYHR12bYmJX5oKviXDfq1jy1vTfcijp4iq5iD68
         LSYdYZAbHufg17SgZe8Swv6uKyt8gUOS/Qeh3erAzCIdJp7u1Gf2ztPLllUECMSGyIEC
         PQEQ==
X-Gm-Message-State: AJIora8/mS/b4xqzspDHllmIDdtSZ7FexGr6ie5nxGptqTJu3h3WznHR
        lm8ITf9Q8/DhLg6lu/rLrHR7S+XH8lzwfVz+69YXgA==
X-Google-Smtp-Source: AGRyM1s7goTrVWuATwjOLxGNG1hUSLNURpzW90XmxiyJZEUnRSARH/dinORe36qNgea/XpmB92WOBwx+1YMUdfPucL0=
X-Received: by 2002:a0d:d8d6:0:b0:31d:44f:e04b with SMTP id
 a205-20020a0dd8d6000000b0031d044fe04bmr34100749ywe.296.1658187756826; Mon, 18
 Jul 2022 16:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220704000225.345536-1-dlunev@chromium.org> <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com> <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com> <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com>
In-Reply-To: <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Tue, 19 Jul 2022 09:42:26 +1000
Message-ID: <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow device open
To:     Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We understand that if someone acquires root it is a game over. The intent of
this mechanism is to reduce the attack surface. The exposure might be a
certain system daemon that is exploited into accessing a wrong node in
the filesystem. And exposing modifiable system memory is a pathway for
further escalation and leaks of secrets. This is a defense in depth mechanism,
that is intended to make attackers' lives harder even if they find an
exploitable
vulnerability.
We understand that in regular situations people may not want the behaviour,
that is why the mechanism is controlled via a side channel - if a message is
never sent - the behaviour is not altered.
--Daniil
