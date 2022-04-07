Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA694F8690
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346599AbiDGRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbiDGRuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:50:44 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5701E961E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:48:37 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id h14so5806813lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6tlYhVs8F66Thqbq40p3Pn5Dg16Z81S23zARavPm7o=;
        b=QQM0aroO8YK53f4qj9dqyDbJrUUCxfT5h704vqpHGE/8v7I6Oy5R5htpyavYKk55YN
         GOksd/uXmEWEddGa9LSsDpL6jT6rUQJpoMZ+nDPSp8LS0+OWUhSvjhRlVIIuOcUyidDc
         13Qt/QvvFntqxzTZEnDsf9kW5bEo8jZ2Mm1Rt/NjC26+j4mYxTcFlOFgkcxVojr9pKle
         PEVCuAH97NAT36QW77qsk+dQfHy+kANuJ5TgkKjhujbKEZXZFzabgUlA4zhGFJqQ/B3i
         U/mHUze90noA9E95C/feo8eb2axPkPxBkAKY29j3jmLZ6N88R5VyPDaJ8s1QcF/FBTqI
         ca+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6tlYhVs8F66Thqbq40p3Pn5Dg16Z81S23zARavPm7o=;
        b=1/vcCKuouMeKB5fpk/+dnbHymHOwaboZQKk8JNqXfXdk0adUpIgWmOKO7pr1DOC68r
         pl+zkcyjrK9iYd/dD1rDfsYKXOBuPTG58eJLJEyyPZsK90nCGulXcFoljPCQZgEWMowZ
         KyiKoqUZUWzyAachoIVz27DsgibOr7HO7MClBtT1rjCF5Nv6tC65GWLetFMRCJbw/Oa8
         hlyfriTe0clxy97S66XgOeGSNlPXOoko47kmh2VdQ8hk+t0iGxUtgprgT+2niJv7Mg3H
         hK0LRsQB4Zvq2WIMzd2oj8NP5jtU4ZpNZuKEng7KlV0GqnXgTAHI1fHekp9snncWEvJl
         011g==
X-Gm-Message-State: AOAM533lui92p8yLwPfEP7DdF37IOQ0g4+SV3p1jJ0cf1IZJb5sfuYZu
        QMA4BVHdD3Y+LkZ0+0yoqKFC6rbSFZR53qRK59EaMg==
X-Google-Smtp-Source: ABdhPJxhaFUD0ynZi5lDtXOQke6xvPZ7Heh3zVXLCsNjLk96lL3cpNs8jeorjEz3Y7fdcNV+YU8FrlgxCDKOsXNWE44=
X-Received: by 2002:a05:6512:b9e:b0:44a:10eb:9607 with SMTP id
 b30-20020a0565120b9e00b0044a10eb9607mr10007744lfv.626.1649353656153; Thu, 07
 Apr 2022 10:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-5-masahiroy@kernel.org>
In-Reply-To: <20220406153023.500847-5-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Apr 2022 10:47:24 -0700
Message-ID: <CAKwvOdmT0G5b2nz-HBCXOVKaC2h5XNsoNbsAVHTo=86b5pdBDw@mail.gmail.com>
Subject: Re: [PATCH 4/7] kbuild: split the second line of *.mod into *.usyms
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 8:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The *.mod files have two lines; the first line lists the member objects
> of the module, and the second line, if CONFIG_TRIM_UNUSED_KSYMS=y, lists
> the undefined symbols.

Enabling EXPERT and TRIM_UNUSED_KSYMS, I didn't find any .mod files
containing a second line that wasn't empty. Is there an example that
has such symbol list that I can use to verify?
-- 
Thanks,
~Nick Desaulniers
