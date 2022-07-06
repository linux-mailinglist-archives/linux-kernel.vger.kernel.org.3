Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACE5569176
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiGFSMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiGFSMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:12:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D028E16
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:12:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n8so20336717eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WkeFi9/MfvFPZabTkFO/+z+qTX2NRIaktMM35/VLs4=;
        b=YPoiEtXlCOn1CAotjFMeoYWMAVUa1VAwEXx0SXCkZgy80iaObV0By3/8fkArYHBgc4
         C+k23RvYj7Z0SQ1lC7nGvaGEGFTM7LSEBC0C6lgwlKsqCpDZ7ZJ9XsHTZluuK53l/wVU
         56Tv2STb5ujU0jpC2Hs5qqgtJfdKcJnDGMPDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WkeFi9/MfvFPZabTkFO/+z+qTX2NRIaktMM35/VLs4=;
        b=MjWmBh6q8UK1tvZzvdOD8rrDHEhB64S+AsMFBTfnnZfGXYjMK6Cj6/uBCuX6BQU0/s
         7vbyHq5Gj3yfHosjZhxu0BOyD9v78IWE31w8+LGVQV2lTdU7imOW7/xorXcCy1e8TQYw
         OHhN4tXAkSRVtWRXKsCGGCDhU2YmnAdjdGrGT2tyVXgGHFa40GEaZ++ZYQhGNIp+0MYu
         agePXO9z4Hh+51EzK32D5BJ7ws7RGeAF6Cex8JAr8WQWDnHFtd9E0M36c9IRp/HiqIjl
         yE5nkbAYENteFx9hmwLRbdFLsIsdeaM9FuFqapRO5+5TaMOpk4BmXAwfYuvuvPsfEyYQ
         Je+g==
X-Gm-Message-State: AJIora+3dJRZHZhoFsXeNnrBQg/OaoupJqygmn8k7CMhKIaQVNiYu5Eu
        /GejxUurWl46LxNInJUClIxJEnHrxKuNnDHc
X-Google-Smtp-Source: AGRyM1svT0BDZZt6rFdDrfdad6XYxU9t0Rff6HXlOgLSX/6uZAgUsSMhwG4JNMh33Nqc6KV4ChkRkg==
X-Received: by 2002:aa7:cdc9:0:b0:43a:7b6f:e569 with SMTP id h9-20020aa7cdc9000000b0043a7b6fe569mr12125332edw.401.1657131160434;
        Wed, 06 Jul 2022 11:12:40 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id d25-20020a50fe99000000b004355998ec1asm25785549edt.14.2022.07.06.11.12.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 11:12:39 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id f2so17800839wrr.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:12:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr3874613wrb.442.1657131159375; Wed, 06
 Jul 2022 11:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <YsWMXAF3ePlWuxyF@antec> <YsWM+im7pmU8MdeZ@antec>
In-Reply-To: <YsWM+im7pmU8MdeZ@antec>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Jul 2022 11:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigH3PcQFjvEYcOZRQvqREcwy88iNFg0_ah32TJhQLCqw@mail.gmail.com>
Message-ID: <CAHk-=wigH3PcQFjvEYcOZRQvqREcwy88iNFg0_ah32TJhQLCqw@mail.gmail.com>
Subject: Re: [GIT PULL] OpenRISC fixes for 5.19-rc5
To:     Stafford Horne <shorne@gmail.com>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 6:24 AM Stafford Horne <shorne@gmail.com> wrote:
>
> Sorry, again with proper subject.

Well, pr-tracker-bot still didn't like it, probably because you
replying to yourself meant that the pull request details were quoted
and indented.

So no automated reply for you.

                  Linus
