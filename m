Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E779853D3BD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349488AbiFCXAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244659AbiFCW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:59:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C082C56776
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:59:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u12so18567863eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9z4AdzgDWuQPwQgbpxeMmLcgt6+lYKFImpeM73S4cMM=;
        b=LHWjMTkCf7hqgYzvwOgDh7lbnpwJTOkPjkJZFLGY79Q5G92YiPn3piJIjTkey6jBm/
         klS4oZwkf0LRsgqEbR5XKsuTY8FBPE8ZJBWDuz1fOYqVLoJ9EZoV/fD8K//Ux92GKhae
         cERo55lHkG0T00YQ1S4cA2U3ao7/6JYX2AKQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9z4AdzgDWuQPwQgbpxeMmLcgt6+lYKFImpeM73S4cMM=;
        b=nohy/yhTUWHtvoQPKPzphs20LyIKVG5nXVp+Alni946Cp5xtHzvCc8+ND0Z88crsTd
         0lk7qL1L85yF1XT0cXJesIfjzmH5/yib3dEYuVkk/gtus+mBeTK1pEUAaS1DGF5HHAcJ
         IyZLogMEoong+zQoAb8EF327oYtsYPC5DWKMepHnd7Rx9YdjCgRcjoEDunTlcKZhr/Xp
         tjAaIwQ+RtLQsfoYAa/+io+WkHJkxy/yslVxJduJQqVaW24TQP29v03nGclVaJPreYWP
         U6vIssXLOwqWVUcM6WE7wXQaLSX2UGq+hA0vLJzgS8F4E3vNLYg5bzxHxMVNYjzu5RPZ
         AOeA==
X-Gm-Message-State: AOAM530o+cJ5RL7I/Rx2eKfOlu1A87PVSq7DVE+Xo0jc8ZBJVpyeWrFK
        Mw2TeqxttAqE/ZpFTkL373rr/dhzzYOB6joj
X-Google-Smtp-Source: ABdhPJz+L8aW0av8QUSEBEpuh2gbRBkFoRIVyINEuPQ68Tu/dD4+krevbBqGKlmRATgfvxNAWds5Ng==
X-Received: by 2002:a17:907:3e8b:b0:6fe:f848:f5b with SMTP id hs11-20020a1709073e8b00b006fef8480f5bmr10611097ejc.374.1654297191100;
        Fri, 03 Jun 2022 15:59:51 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id u2-20020aa7d982000000b0042ab4e20543sm4544172eds.48.2022.06.03.15.59.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 15:59:49 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id u8so7754786wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 15:59:49 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr10192231wrf.193.1654297189459; Fri, 03
 Jun 2022 15:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <875ylh8xxx.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <875ylh8xxx.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jun 2022 15:59:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0ZYiQuCJmohyYpk99mch=Nb+_m4DWxBX03DQWnsvCZA@mail.gmail.com>
Message-ID: <CAHk-=wh0ZYiQuCJmohyYpk99mch=Nb+_m4DWxBX03DQWnsvCZA@mail.gmail.com>
Subject: Re: [GIT PULL] ipc: per namespace ipc sysctl changes for v5.19
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Linux Containers <containers@lists.linux.dev>
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

On Fri, Jun 3, 2022 at 10:21 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> These changes were sent for v5.18[1] but were dropped because some
> additional cleanups were requested.  Linus has given his nod[2] to the
> cleanups so I hope enough cleanups are present this time.

Well, I'll be happier still when the next set of cleanups hits:

   https://lore.kernel.org/all/CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com/

but yeah, that further cleanup series clearly wasn't quite ready yet.

              Linus
