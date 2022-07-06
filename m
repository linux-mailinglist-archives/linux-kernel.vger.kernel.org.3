Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED756931C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiGFUMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiGFUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:12:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E831EADA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:12:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m16so5148030edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVOyRJFl3auzy5uUE3eiIM7wPcPXSqEg2Dt9oNXrcRA=;
        b=F9A/ikOaqolthCndIJZefO+fHoLKvvK44RvSom0Jn2f1fnbLY01z98yfO6SAglmu6g
         ebvJCNo3VAMNdLgmCjQpAWUNiwcJ6iIjPkX2VHxTHLF7hgGzIx0Eb+RyZcaaYQaz19wQ
         B3teprZ/TfuB0OscMddQLkM7WyIEGKRPBJ8zopVGnwsWzCbjM+DTxiO8h9l5uhnE3ZhV
         hmSjqfK/VHae/9A16ZfAV9ft43alOi9r/4rS0uaiWY2/1MmnXCxzHlReQyt3Xwu1B1hz
         MJmQRF4RZwH7+514+XY2tdV5vJVu/8CPZJtWWQvm6NUVciFTGGk336na0q6FuPanRxrR
         PVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVOyRJFl3auzy5uUE3eiIM7wPcPXSqEg2Dt9oNXrcRA=;
        b=WJPHBgy4O6nWXykJw7GgUZx9Ul3Ad5pBLRNDFvUa3yWOtIsxy3vR6nyicKgvn5bSPx
         VRmsF3YXS968apBLO6top1BsjScMxF1PHoiZCXMYI1Km8BzgKGKDfXOLTu1AtkpKC53G
         rH8TE2k2NKNLchsd4uf/pueRZxFIrHkIoTkrKkVZMn70HUboEz9OYKDgsr/qNwOdyTto
         eiR4nNSJ4kQdN1EngCjdm6ebijZOn4fWj+KerRPbCPefY3macJgV6f1Q1B3lqn2coNQx
         dVB3MeEihB0ApIYcAnWr5L/RjY5sn8niV6YoKmYxlUSZmLZEdhr613QjFXMJi4869B/5
         NCrQ==
X-Gm-Message-State: AJIora//tWrgbJar1QG//hjOn2Ml8mZJFfLEUB3fzIOzBMVYpMvUgPdX
        H4FJfSRcEBucGZ4+dtwu0auqBQudNFVJZNIr185c2YEli7Y+d9Hz
X-Google-Smtp-Source: AGRyM1upvjBlwtiujlobvzhUsrrWYckKitJAPdADnaI3IcTWbKbOiUCVF31DPq4GG6oCK8d+coL85qPBSdx7XLBmVRA=
X-Received: by 2002:a05:6402:4488:b0:43a:7b6e:4b04 with SMTP id
 er8-20020a056402448800b0043a7b6e4b04mr13073971edb.202.1657138322816; Wed, 06
 Jul 2022 13:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com> <20220518170124.2849497-4-dlatypov@google.com>
In-Reply-To: <20220518170124.2849497-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:11:51 -0400
Message-ID: <CAFd5g47LpZDVe7L1-B3Pz-pDmPkyojNFiugHEEAzWD_W5eOrHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: introduce --qemu_args
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 1:01 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Example usage:
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>   --kconfig_add=CONFIG_SMP=y --qemu_args='-smp 8'
>
> Looking in the test.log, one can see
> > smp: Bringing up secondary CPUs ...
> > .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
> > smp: Brought up 1 node, 8 CPUs
>
> This flag would allow people to make tweaks like this without having to
> create custom qemu_config files.
>
> For consistency with --kernel_args, we allow users to repeat this
> argument, e.g. you can tack on a --qemu_args='-m 2048', or you could
> just append it to the first string ('-smp 8 -m 2048').
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
