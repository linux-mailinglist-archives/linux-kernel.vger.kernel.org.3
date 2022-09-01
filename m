Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9123D5A904B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiIAH3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiIAH2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:28:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21412693D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:26:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f12so16131317plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=r0v9myYmtxxM+zj3a4BVpOW5UkfGOnlhtcoYSNP2G3g=;
        b=laxc8WAcy0mU+MQpRaLzvMaWf5r6ILYu2zS4tatMsO2P7mm2RflZzf6WWzxWCJByjs
         iGs10EhK9Pz4lo+D2FKKFoiWd+MkdQEhjW+zu9R3VgYqaIJNK+hy21f8E5uragfPIlT/
         d95cvg1r3XTPdn2qx0ZdBn6y2mQGyvTPAmDB8XIsams2nlOJtRniZtXSfbHE3gAnOFQz
         YNJxGyxrGE3RTJ5vIRduyC0GJjA12s/APH9Bt+aOPlc6nQ8jsmDsu91BNkdhlDlVIQsZ
         zXlug298ZnXt18eFRRS6N3FeaeWpejSSHSf2/aQMMFL4BfIapZN5W0bLvEn6biODF9Tl
         CMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=r0v9myYmtxxM+zj3a4BVpOW5UkfGOnlhtcoYSNP2G3g=;
        b=UF7vFZ6Bvg2y+DEzXCwEJPDrC9GXADPCKjSCDMXcFk/89TSCyMK94hd/P9aBecJuKR
         om0/qqZTsovkoI42nqXBjg2G5KMmayzC/FrKNBoFPN+cN1NOWTlrgb2OLNaL4GtpG863
         wuHef2qiGIG4URBoCsO6uJkqdUFkmi+HUFzr5XEm9wrbijrXgHnUnUpeQls3TCxNDyOe
         B7PywmpDG5rip+thE9C9ZqL3qEfjLb54JcFznyb7I9o5f35S2UEWfNSD+TEQghM7X1yV
         5ZQwzGBtHrPwFn6wHa4N6oojStll+xAiNtB1KtTf3f8e6MCUNGjJ0KJ3MP0KN91C6Fyb
         jh2A==
X-Gm-Message-State: ACgBeo0D0uJSclBLxNTJm9sOPEGIchtvDAzQUQNz8+hdhdpO1/or00xc
        goH3+XwbWJXlYnfwXyI0cU5SRhSM6K+N8/ARFWi3sA==
X-Google-Smtp-Source: AA6agR4bpNi780iDvZecG4FWixtS1mBlalrj0101A8wkOZ7HEmEUF1YYFhfUI2Fe4Cam/Bt4uCffNIHae9NQdCtfFso=
X-Received: by 2002:a17:90a:988:b0:1f2:3dff:f1dd with SMTP id
 8-20020a17090a098800b001f23dfff1ddmr7471017pjo.150.1662017171543; Thu, 01 Sep
 2022 00:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-9-sudeep.holla@arm.com>
 <CAFA6WYPXsLt692eW3_tqy+=aLz7W-Ymh-RqZuqATeHpzGp8Tkw@mail.gmail.com>
 <20220831112652.brjnuygzkvcteadx@bogus> <CAFA6WYP9UF8qLcBkWVdAOyb_EArDHX6ihPf_6GqbkoZYkdNrPQ@mail.gmail.com>
In-Reply-To: <CAFA6WYP9UF8qLcBkWVdAOyb_EArDHX6ihPf_6GqbkoZYkdNrPQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 09:26:00 +0200
Message-ID: <CAHUa44E6nMEw+w6fA71X7oGdcXnBEroDHfNODCxHSZLxsLaPCg@mail.gmail.com>
Subject: Re: [PATCH 8/9] tee: optee: Drop ffa_ops in optee_ffa structure
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 1:29 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 31 Aug 2022 at 16:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Aug 31, 2022 at 04:28:01PM +0530, Sumit Garg wrote:
> > > On Tue, 30 Aug 2022 at 15:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > Since the ffa_device itself carries ffa_dev_ops now, there is no need
> > > > to keep a copy in optee_ffa structure.
> > > >
> > > > Drop ffa_ops in the optee_ffa structure as it is not needed anymore.
> > > >
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/tee/optee/ffa_abi.c       | 9 ++++-----
> > > >  drivers/tee/optee/optee_private.h | 1 -
> > > >  2 files changed, 4 insertions(+), 6 deletions(-)
> > > >
> > >
> > > Is this patch doing anything different from patch #2? If not then I
> > > think both should be squashed.
> > >
> >
> > Indeed, I thought about squashing them and forgot before getting there.
> > Does the review tag still apply for 2/9 after I squash this into it.
> >
>
> Yeah, feel free to apply my review tag.

Same for me.

Cheers,
Jens

>
> -Sumit
>
> > Thanks for the review.
> >
> > --
> > Regards,
> > Sudeep
