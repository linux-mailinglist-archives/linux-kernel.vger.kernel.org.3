Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF07543E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiFHVTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiFHVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:19:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFE213B8CA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:19:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t25so35067549lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ilRet/KteeJG0WVmL4enbjfFb2OgDEAZfxK9I2Kp4c=;
        b=orw7vd9hf+k7zjOWPiiZOZtmqN/hWFJl5pW99wtt+Rq1Hm7YBjzEOSP3mhwJ2DORMw
         XSmLhs40wtsUHUvaHtig6ZRdICE1hd1M2vPBhZYOEMmpQSr/oqykZPZi/K3YfP17SfTn
         /7vU4RiM7cvzSs6mBGmPZtmWWr6qQA+O3yZ+z6v13v9zqyTLh7TZQcpJO4LfbhbpDp+8
         nIkXxUT+AOpLOvvprZnmPzdG1JGPb7sZTLMDpGtWlxp8fxrR/eq1Unx7+ZxLofC0X7l7
         02nNRjyXRadcrqWHAI5Iw99RiXaL4UjpfIxCqUJCTAhqvJCoblJg3hJgqhfxEXEvkLug
         odgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ilRet/KteeJG0WVmL4enbjfFb2OgDEAZfxK9I2Kp4c=;
        b=g1s/PoGg3NPHx4LDjCvQpR5k7b/LaGyVMTHAch9JGwz/PPgxzNutOUTrDFr0AARBNV
         o2tCLljKBXnfZal6j/cQ9ppCdHGv3ARLtYLZabcZXOeQ2/t4iQSiJfdguAel4qSRVaMr
         8DwDlJ1uZ7yiD98YZvw3uxI+CMPPz6oFsjPyC8WzJpibPQxUDW3sEM/OVjbCpXq0sNAq
         zgDuy+Sd9ZOoLPbYHwvDjat88nRi1KI4ZPBbxYnsFwi0hPID+qi2CbDQs6cTdqjm6gZ+
         8h1WA6ExHLJ97QJ0xl+eFTO4QU9furrOI8x7ZuE34Dh+YzT0vxEoiGGrEjvWnlHltxEA
         0ERg==
X-Gm-Message-State: AOAM533X800/Rx3YnMl9e/S3sL/T5ilrwzwTKZz6hZKsk3ivJZRVUv+k
        7hKQr72DsveHaqDV1SndQzYuMfgpES0oFNrEyFwypw==
X-Google-Smtp-Source: ABdhPJwwAW2b+mfAhfkM0cP+SQRSXeyrHsaUSLs3aLLpRzT3By9pcpZYszrhRm4pOIhPQhNMmMpBn8zAokUuYAV6JT0=
X-Received: by 2002:a05:6512:2614:b0:445:777d:3530 with SMTP id
 bt20-20020a056512261400b00445777d3530mr70405545lfb.647.1654723172773; Wed, 08
 Jun 2022 14:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=-NXR5HoHwwEUZMsCt90oaADH6XHifje9n-8S8rj9SFw@mail.gmail.com>
 <20220608001422.26383-1-jstitt007@gmail.com>
In-Reply-To: <20220608001422.26383-1-jstitt007@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Jun 2022 14:19:21 -0700
Message-ID: <CAKwvOdn7Dj+BJv6LSCs93fp767_J2ZisAHJJV3uAbtws+YjgEA@mail.gmail.com>
Subject: Re: [PATCH v2] include/uapi/linux/swab.h: move explicit cast outside ternary
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, trix@redhat.com
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

On Tue, Jun 7, 2022 at 5:14 PM Justin Stitt <jstitt007@gmail.com> wrote:
>
> A cast inside __builtin_constant_p doesn't do anything since it should evaluate
> as constant at compile time irrespective of this cast. Instead, I moved this
> cast outside the ternary to ensure the return type is as expected.
>
> For instance, if __HAVE_BUILTIN_BSWAP16__ was not defined then __swab16 is
> actually returning an `int` not a `u16` due to integer promotion as described
> by Nick in this thread. This has repercussions when building with clang

Also, "this thread" won't make much sense when applied if someone is
looking at git log.  Consider phrasing this instead as "in the lore
link below" then include another link tag to

Link: https://lore.kernel.org/llvm/CAKwvOdmXeRbFjkHgFXps4pLH6Q6pGWRNOqA85=h2aFnR=uaggg@mail.gmail.com/

Though, I think it's simply more concise to just include what Al said,
and drop this sentence altogether.  You can send me v3 privately as an
RFC and I'll greenlight it before you resend to the list.
-- 
Thanks,
~Nick Desaulniers
