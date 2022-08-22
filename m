Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B3C59CC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiHVXmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiHVXms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:42:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDED4F1A0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:42:47 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v125so14201581oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Y+p9sZv8TADdYOy+baQfD2+YHkT0+ZPkagCh852ec7Q=;
        b=08SqEM9eYWUslIT27XTwbJLPkDZgQoNF1x0NSi+nftEpZ2qNVeeOaiY6eAy/1GxLjC
         XElGPISLFkeZR5tSiSIkzR81VmsQYha5bmSI/HJtCtTbJd9GfG60lHmUAbwZWob4MSnl
         awEQIiogKsYus7WfuY5yoYcud9mGnMI2bsDAVj8vvEJF2EBx3oes17wS6bzS99AK19E2
         tSijCGav4COenE1q6pgIPjyWFu/izeJ0QZahNoF2iiiBv4vI4ErJjhfJ2KkY80+oQGEn
         T1O423NYm7wC0kFBaL+FZoJ+ax3qHTCjvFjCvh4Ue2o/rJhKqPzJidSqUElsC1ObL6qx
         u9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Y+p9sZv8TADdYOy+baQfD2+YHkT0+ZPkagCh852ec7Q=;
        b=WgBwhvfOPPQqJaT8KELBmsh9cs7HMV+FzOgMvBoVSFPdaWjQamJj1aviwuoNdvbkKi
         ESyu0S1o86ozZc28Z4vx1fHUrtbB7t8xUPO+mU8a03pD7alkb4pntcWZhy/VnCoU0heF
         yvR5QUQgE2VmLbY3WT152gnLgv+TYZIiSkJYDPKBxQ41pbuXfNokEmSp1R05WM03qE1C
         NoxhZIny1xxvuhQbDRAm++g4RTjw1fZububGOWTD3OHpu5jICc3d+KWetA5f14FzaYFx
         kuFV7aEjpPo7bXdaLUquuucCSCtmwxgEZ0QXJen5rGW+MIMHrCTPO0+LQ1IcjjSZJdA2
         PXgw==
X-Gm-Message-State: ACgBeo0QdReLo5i9uOMdCveeNDkY5DX2y4CU1mU0cNvvsPo/imhzeZ3H
        vb5pmJS6BgmhsubZ1AbaY+pdwh+F0Vn1P5hLhFrF
X-Google-Smtp-Source: AA6agR6OGFkFAjuNC3Y3R+6rV263zV0DvPw2kXYwwJE9KkEMp6upnJGxPv+7Y8jhhQBMRWFFId5Zx1m/qLlXu1ETSZk=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr283653oie.41.1661211766867; Mon, 22 Aug
 2022 16:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB248ft0LFUQDHNtB9NN_D3F=12Jndh13Ue=LokajXNhMk5Q@mail.gmail.com>
 <CAHC9VhTXNPWBDRoPcz-Jw=f+NNAEhxbh-ySc56CUd-ZbuboW5w@mail.gmail.com>
 <CAHC9VhQnYY_wdUjBbL3NpPYTQcr0M_Nf1g8ObbHiUoUbHPYdYA@mail.gmail.com> <CALbthtfcfSKfn4JWSKxo0t0Y+_c5ZjoGPWW2e=z3doKcB3XvxA@mail.gmail.com>
In-Reply-To: <CALbthtfcfSKfn4JWSKxo0t0Y+_c5ZjoGPWW2e=z3doKcB3XvxA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 19:42:36 -0400
Message-ID: <CAHC9VhQzb6Dtmmfw4kdiG9BCFzT9fkt=ms3us2p-eAsQv8gMiw@mail.gmail.com>
Subject: Re: data-race in audit_log_start / audit_receive
To:     Gabriel Ryan <gabe@cs.columbia.edu>
Cc:     abhishek.shah@columbia.edu, eparis@redhat.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 4:09 PM Gabriel Ryan <gabe@cs.columbia.edu> wrote:
>
> Hi Paul,
>
> Thanks for taking the time to review our report! It sounds like there
> aren't severe negative impacts and patching to eliminate the race
> would impose unnecessary performance penalties so we'll mark this as
> benign for future reference.

I just want to reiterate that if you are seeing a serious problem
please let us know and we'll work with you to find a fix.

-- 
paul-moore.com
