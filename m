Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89B54734AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbhLMTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhLMTJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:09:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD99DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:09:27 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r11so54708931edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BhDA9nIP3jKxj6kLj3PfeumvbAy1D8/aRgojun8p+s=;
        b=SsfOrFRMYggSqS+19aWF6UVE28xgRtdoMGcXYHt3iwVCXGQW4JCETAmpns4sDOgZSl
         J0kQ/5F5Y/+HWUjWmbr57MT6Ezfw0tBgLOaVSfATeligNHlzloQmMRcFKFCohub+jBoJ
         AJYT51bHZSv+9kFp7jUxr5qtEjElmct7krwNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BhDA9nIP3jKxj6kLj3PfeumvbAy1D8/aRgojun8p+s=;
        b=azZ33kZiXlxIO3F9iQ03ehEo3GTbpY3PZGLbfFtKrdbVcIonYt9JgaU7ensFLbNrgP
         29i694EWq+PuAWsPnY+EvMMSFapEjzU2sKbuJ94V6fNDSFzx9ijpM4gYGNq1Nz5ygL7T
         cQYLUZql0kTdIEmSn4qGRPQ4I/xcEtRb/Wkr6SoWgQc8hqb25JUSJ4Fkmm55j4OrbQzl
         vkEqpClqwJtfvnPAmrQq4Yht7X0zZA5A+KZnAjL28sPBMNclfW1qYxufBARPEfHXqezY
         cdHXzGtKDQWSZivE5RhXF87NLM7qLru5vpYvwI8TGzDivV5/h3pj3GrKMajv2F3JFh/B
         MX+w==
X-Gm-Message-State: AOAM531RjER2E446ObS79FB8jDSZH6MnxSJiDcOV0GTAAqlmhr4/FeTG
        SkGZ3KbsyE6vvw66NGd2x7vDmuW/1WrlA3/5
X-Google-Smtp-Source: ABdhPJz3+OcXkTd7IZ/zgIWqGkAUQHKlLBq85DOF/s2FO+Xs9SjtBjZ8wVS9g8v6vIJu+KhH+xcCUQ==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr862690ede.57.1639422565185;
        Mon, 13 Dec 2021 11:09:25 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id y27sm448433ejk.157.2021.12.13.11.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 11:09:25 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id k9so10970123wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:09:24 -0800 (PST)
X-Received: by 2002:adf:e646:: with SMTP id b6mr431393wrn.442.1639422564568;
 Mon, 13 Dec 2021 11:09:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wixe1NPqC0PmgUbV0Xoa8D0Pbyu7X_0sfABYMG+ocLdbQ@mail.gmail.com>
 <20211213035923.GA735445@roeck-us.net>
In-Reply-To: <20211213035923.GA735445@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Dec 2021 11:09:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgP1C723G7+fr9G0a9HO+dA8Zk55uuS9fdbquF-1GhrNA@mail.gmail.com>
Message-ID: <CAHk-=wgP1C723G7+fr9G0a9HO+dA8Zk55uuS9fdbquF-1GhrNA@mail.gmail.com>
Subject: Re: Linux 5.16-rc5
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 7:59 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Same old.
>
> Building mips:allmodconfig ... failed

Gaah. I just keep treating this as trivial and solved, and expecting
that the fix will come in the normal ways, and thus ignore it.

I'll pick up the fix directly, just to close this silly issue.

Thanks for your testing (and patience),

              Linus
