Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A51588632
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiHCEMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiHCEMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:12:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0309A26ACE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:12:38 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i62so24822047yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBLTjlzefU+wV6vGj0COojpi+1jnoL0XJw2TFigcBEM=;
        b=avnER6fGgw1/C/liTGNgQkRizCDYjaxRM4xmRyFKVZIV+kt2m5Im5J5vDcGEfOy+8a
         HPwsIEKErzm5vsEnRNn9S0n+ji1w9N38qBXk3SdAbWsUuNCTcQncBCqFbcUpzCvw+eGg
         /NnfzcNh+h6QLvqwvIdLiykpfkz9RcHH8nmYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBLTjlzefU+wV6vGj0COojpi+1jnoL0XJw2TFigcBEM=;
        b=trPm3CtHJa99aO4rob5SLMQTJA0tRDunWwue4KMMqAYIqL6Bs0lUfAVbDuuXO8VlTg
         dFGyUQxPISdj75QWtPQ2yXA4edgaTzyw1mc5ycld/CzQdVQtiu/CC0ppQoOeNrHfZg1H
         22BfVr3Djh3z9jfeTJcF3UmDiM9U6NaXvyRArVUYa2kGkJ+bh9IGYxYcX+AZFjAEhx7x
         HLjKH9FAJBtTbFjOiluehELOeatagVXINqOp/UhuAqBWZZsGqm0eOIAk8uqMilqEm0xx
         UqZeg3Bpx0e4WgRTlBWhRi259WshRY5/LYRMxOMHXKJRuGx0ryfkplknJj4ymKw2Qs4R
         MfYA==
X-Gm-Message-State: ACgBeo2KJvvxdTiq/vkAYKPr1+RcshGnkru1M2aID6w7dPYnaZt7Lzd2
        fUw+zmR0DPHbf72AT+vrz5vCxjEA7gECLkFyervfPA==
X-Google-Smtp-Source: AA6agR7EIuoh5Nv9c51B42311sXsZ7jHn4Hl76TruUb9ImpYEb06vAq9p3ocFdGuWV007jE1JxoiaKwdMithR2IRJfo=
X-Received: by 2002:a25:c206:0:b0:67a:6ba0:98f5 with SMTP id
 s6-20020a25c206000000b0067a6ba098f5mr940817ybf.507.1659499957299; Tue, 02 Aug
 2022 21:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220704000225.345536-1-dlunev@chromium.org> <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com> <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com> <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
In-Reply-To: <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 3 Aug 2022 14:12:26 +1000
Message-ID: <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow device open
To:     Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all
To signal boost here. What can we do to advance the discussion on this
topic? Can we move forward with the approach or are there any
alternative suggestions how the desired behaviour can be achieved?
Thanks,
--Daniil

On Tue, Jul 19, 2022 at 9:42 AM Daniil Lunev <dlunev@chromium.org> wrote:
>
> We understand that if someone acquires root it is a game over. The intent of
> this mechanism is to reduce the attack surface. The exposure might be a
> certain system daemon that is exploited into accessing a wrong node in
> the filesystem. And exposing modifiable system memory is a pathway for
> further escalation and leaks of secrets. This is a defense in depth mechanism,
> that is intended to make attackers' lives harder even if they find an
> exploitable
> vulnerability.
> We understand that in regular situations people may not want the behaviour,
> that is why the mechanism is controlled via a side channel - if a message is
> never sent - the behaviour is not altered.
> --Daniil
