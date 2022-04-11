Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE204FC52B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349661AbiDKTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349604AbiDKTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:38:09 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570013F27
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:35:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so29436415ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctsBGHHI9fHwwFQuTHX2ntOMJxKsTa2iIDRP2hXt+D0=;
        b=slGV0/Ar19gJuMe7YfVJmI0gWO/MmehfBZr/e3d8u1vwMKQDfD1ZQ7zU9cj9fDFuwp
         wqKkiOUS43bCN4vuYG4V4ux9AgeWG2YzhWrq2NzRnZI5RvWLZudhZiPAxOVSdD2v434n
         cbC2aypUD7NBboBMLUhKyfxLHZXWERTa1uM6W7zwJjsd40XAmUZ+0evN2w6RDLBrYZgu
         bCJEyWbyvNnzOIg+xNefryDdGUVEikcChZsvnbox/NIowRGnvZk7b9YypdOcXQjCcAz+
         qqhXlFPRSyNA47L2ge11qrzzytK2u/YbkE5j/RtysNa8mvW8dlOPXsy5sFU2cjxrUX0w
         rPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctsBGHHI9fHwwFQuTHX2ntOMJxKsTa2iIDRP2hXt+D0=;
        b=WyeLz4gApxz6r6xQ7wdgSOXZwhxSMghfuS0RTT6/ChYg90F1FTV6YxWU02dil4ehDz
         VzK/Hx99Cgr79N+tF8zM24cTgFybm+1M0xa3JMorNMyAM9e8VwzHGPcchgCMqvVKnTgK
         gagYcQAEb2RVu+0PPJphXsTEKbD0C9NKrwTaim10MFTz3RjBLISFdzdmP660BQpi1kbZ
         54hxsK+YYiqOyyWQ7g3XUMgru8LuTRYATKfCnvhYeOBoanv3g5O+VZY1AwhJCWtkjHM6
         7Q+6dq/YgikM7WmbWwu+ivB6p3zs3C12UsCahL3dMh1mF+238nWSMwUlIMoM6Ul5o+SX
         Dcpg==
X-Gm-Message-State: AOAM5320KGLgnlLQrZtPAmRaFRmphJvByZ6fn2WFV20RJWlPzQricHXR
        gfZQCnRc90kXuuwJ9qmHaO6zBpJrrdNHoV3GA11L
X-Google-Smtp-Source: ABdhPJzxdu+zSoihQSMJl+2XUSrgNDyTf8QD+9tKSBur49OSsRbf3Dting9soeQbT4KwfUCDKsy4mk3XI39sNW95F1U=
X-Received: by 2002:a05:6902:706:b0:641:5f7d:8ff2 with SMTP id
 k6-20020a056902070600b006415f7d8ff2mr5176516ybt.80.1649705753449; Mon, 11 Apr
 2022 12:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220411180006.4187548-1-jackyli@google.com> <4278ae8b-eb87-06ac-43af-41a1c741f9a9@amd.com>
In-Reply-To: <4278ae8b-eb87-06ac-43af-41a1c741f9a9@amd.com>
From:   Jacky Li <jackyli@google.com>
Date:   Mon, 11 Apr 2022 12:35:42 -0700
Message-ID: <CAJxe5cvAq9+FVfHrCMkN-re9v_v33FZNVsT6b1NyVZb8bdcC8w@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp - Fix the INIT_EX data file open failure
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:58 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/11/22 13:00, Jacky Li wrote:
> > There are 2 common cases when INIT_EX data file might not be
> > opened successfully and fail the sev initialization:
> >
> > 1. In user namespaces, normal user tasks (e.g. VMM) can change their
> >     current->fs->root to point to arbitrary directories. While
> >     init_ex_path is provided as a module param related to root file
> >     system. Solution: use the root directory of init_task to avoid
> >     accessing the wrong file.
> >
> > 2. Normal user tasks (e.g. VMM) don't have the privilege to access
> >     the INIT_EX data file. Solution: open the file as root and
> >     restore permissions immediately.
> >
> > Signed-off-by: Jacky Li <jackyli@google.com>
>
> Should this have a Fixes: tag?

Yes you are right, will add the Fixes: tag in v2.

Thanks,
Jacky

>
> Thanks,
> Tom
