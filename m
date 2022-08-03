Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F5588684
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiHCE35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiHCE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:29:55 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A7D57201
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:29:52 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef5380669cso159856027b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbtXNCpzIHOXao+YSnQZdhcH786as3lUPJ/TZmv8CNw=;
        b=Hgz4TqIWl4pJo49RQXXWoNPSdOSqCLbXTwSkc5BG1Ic5qEa+SMfmG/QhBSjdPZ3KNG
         YhCBVCj1nZvne/4SQtLLhSIw7Vafg0bbVoqYdCBYeyYJXHkCXolxDZo/3EdPaB3cD6Ko
         70Pq7cwbqCQeHKiQ0d+VxTSJ5b9vrJzqfFFWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbtXNCpzIHOXao+YSnQZdhcH786as3lUPJ/TZmv8CNw=;
        b=tmwV7b6uY6wBm5INN05tgTqigmX7FHFO0A/LOxt3DVYykrGeMxkxvwbdqDGhs9K87u
         9HC0i1IZkeGMcL4dj9H+4bkt/9RttJ6kjaKjcJO6mMrQebdRv4Rvl0JdFmj63uIulkaU
         baysh7VfuaCpD9o7RZOLwkfG681wcJt0C3Q7cgn6ZE5nBA4ldQ+I14s6xqqTPR5Ngb3g
         bw+7jqD2ATCGimtAhNk/fFNq5WejKDFagilwpHbSIzjjfF+NWRR5dZXG5Lz4LfOgPZko
         0q2z7f+7c2tP/3bxeXN/GgtPfHqbEq+KG9zj2tTymXrTrIhomkVI8jI+cMy26tWVKN9J
         cBBg==
X-Gm-Message-State: ACgBeo0KRIDwM6Xbn6k9qcQFP973Cp27ZRA4TmSnUetSRFQcBgqxwXgF
        +S7qMhFnH/AjIJZVo4nraouqO3/TDqpB8TywfnWo3g==
X-Google-Smtp-Source: AA6agR4WjX/epmvJWCEqJybFZZuQMaMMSBvBmrgjPDfUnQXu59XYjGRrURmOgu9EbFsiDo3C7nrzNWdlWn0yVmaLHM8=
X-Received: by 2002:a81:81c1:0:b0:31e:7378:960c with SMTP id
 r184-20020a8181c1000000b0031e7378960cmr21836822ywf.266.1659500991420; Tue, 02
 Aug 2022 21:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220704000225.345536-1-dlunev@chromium.org> <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com> <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com> <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
 <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com> <Yun4LH+StcuBXRtO@sol.localdomain>
In-Reply-To: <Yun4LH+StcuBXRtO@sol.localdomain>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 3 Aug 2022 14:29:40 +1000
Message-ID: <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow device open
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Zdenek Kabelac <zdenek.kabelac@gmail.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This seems like an access control policy, which the Linux kernel already has a
> lot of mechanisms for.  Chrome OS already uses SELinux.  Couldn't this be solved
> by giving the device node an SELinux label that no one has permission to open?
That would be the ideal solution, but there is a number of challenges
that prevent
us enabling enforcement on all SELinux domains unfortunately. While in the long
run that would be a preferred option, in the short run this doesn't
seem feasible. I
would assume the problem of enabling full SELInux enforcement would plague
any big project that didn't have them enabled from the get going.
--Daniil
