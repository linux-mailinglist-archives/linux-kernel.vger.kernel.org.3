Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8235286E0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbiEPOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbiEPOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:23:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830463B017;
        Mon, 16 May 2022 07:23:10 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z18so16080498iob.5;
        Mon, 16 May 2022 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfuLbMFnE6T2gqljbFDnxPAiIollkJqGTTqUZar1THg=;
        b=mFTpIx7QJd9OPa2rfI+BdVzP84MpmVIgyY0ts0fmvC5ELBnjn8KhgXvspalPHgDl65
         GAlhZDDcNlPTjVz9f0cysymZt577t9/Ltz+wYdsk6YiWL/ImRshShRPwYid59CfKfK3m
         Gl8WoVDDixM/uYu0wDa8ACGVAbL9t+WWpAWDM8NWSX471CE4cVE8a7wQGgxhyRz9hCBH
         ULKT4O8zR2VmqUkTgkbm6fZnn9M5Z0y3U1o5amDwNRtA9ndnEDrC27b+4EBgLoFqe32/
         PY6NtQQx973ICwstG8vUooMm69SIHAYklrWJJPLJ4D+5OEcKjId8fRp2Q2LsmwmWtXth
         9KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfuLbMFnE6T2gqljbFDnxPAiIollkJqGTTqUZar1THg=;
        b=hTHgnIvUTzi2p5czXo2Bt++0uBikv25EHMTtmjRwsTbbIf7KzDfj7ZiDtEwhHwqXqr
         +dkfJKF0pc6Y75Nu8+a9yneyac70wy+uFOIbS4ktwQO6IaKVRbxgQOoo37SbYOR87I0L
         yRlUaqL3UVGy4BfRW96rzajw5QPkTxNzxtVqKjcDO8yQ+nX4Cv4LE9gNDJWwWtGGz5u3
         0PWzK2MWvNug9hHX10Nx16SE4BrP5m6/MJUzVu9GwYxEMcx/mtmLp78iJmhFouSE1lCS
         auIzvnqFK1lbmjbNHVvX8wxjN6p7FqHRv7Ic6k1u1evL5+zR/cATee/ElK9gdhdL2rff
         IjEg==
X-Gm-Message-State: AOAM533aByTjVs9EmfjDE60wMXXpNx1K5xb4/7VPDbY8geeTPEXJtbtf
        tQ4Y3WEU3uNCxHiV/UVRby9qqBZL9wDuCO3HsdU=
X-Google-Smtp-Source: ABdhPJwES2wc7TdMhiod+Gfl69w6wPnCgbe1YGCtJzOYOWtZ/sszBlzxfySY/AjwJEJtLVYes/CfhrG1dOOG8apzh38=
X-Received: by 2002:a05:6638:110e:b0:32e:4068:fd99 with SMTP id
 n14-20020a056638110e00b0032e4068fd99mr1425584jal.264.1652710988705; Mon, 16
 May 2022 07:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220516101901.475557433@linutronix.de> <20220516102615.884180377@linutronix.de>
In-Reply-To: <20220516102615.884180377@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 May 2022 16:22:57 +0200
Message-ID: <CANiq72kSqKqoUsiFhg0+a65vc3KPTW4zpt-Dh8geVWUMPkWFwg@mail.gmail.com>
Subject: Re: [patch 8/9] scripts/spdxcheck: Exclude dot files
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 3:55 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> None of these files
>
>      .clang-format, .cocciconfig, .get_maintainer.ignore, .gitattributes,
>      .gitignore, .mailmap
>
> have copyrightable content. They are configuration files which use a
> publicly documented format.

Should this files remove their SPDX-License-Identifier? If yes, we
should do that for `.clang-format`.

As another suggestion, we should check that the ignored files actually
do _not_ have the `SPDX-License-Identifier` (i.e. so the above case
would trigger a diagnostic).

Cheers,
Miguel
