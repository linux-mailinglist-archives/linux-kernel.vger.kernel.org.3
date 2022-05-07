Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAD51E5A4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383782AbiEGIph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383748AbiEGIpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 550423EF31
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651912908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pH/8q4WWU1F57uoZuiEXN9uHXlw/jrDUSuY49/KnKJw=;
        b=Mwy+5ITd7KLS6/GDJbOS0ecSRve79nt5gyPBO7U27Y9G1y4zuS2c/2bW5nl7p305j6ozxE
        He9SceZcROTlKPW/FXL09DS2865yP1zFrtIqbgNK52kPy23oONzOdAbZDUS8pSwmDBDAqq
        L4EmEDeaZ39U6T5rlldWxyMtUD9ik28=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-2uIdGZ6UOfWLW7oZR9kPtg-1; Sat, 07 May 2022 04:41:44 -0400
X-MC-Unique: 2uIdGZ6UOfWLW7oZR9kPtg-1
Received: by mail-yb1-f200.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so8152818ybp.19
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 01:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pH/8q4WWU1F57uoZuiEXN9uHXlw/jrDUSuY49/KnKJw=;
        b=mTZ92lLdCPn01nIfx+3OMUX03bbzWwspqpt58uEgukspTgZiOYrQTUPCs8GIUgdKbB
         rGsBUOwi9jHQh17Sdg5TBd/42EK566O0GkX7oqeh5mD9cxb3qDqnObmwTpzm0ENfw2iX
         w0Oj+uuW/0AO7QIEl8AEAcTHR4Zz7/TIKBPYcHj5LA6QU3S0PFR2mnxmfMUVB9xjdwuL
         TNZVNDsajHl0dZvIQS9ST6o6+/oEgYVnUJTTTRNaKZNXRO5oywTQYg5de+wPS6HI1H49
         Shc996YEERElE0uOFxMcomAKsDQfKRBzDsoIM34qE/tqUxthsjyTPmg41BVi7KdYz1tk
         /abw==
X-Gm-Message-State: AOAM5322HwdKqzjatXATxS+H68yWUjuxVJoge0lQNYMW7J+mK15PZ3Pv
        yiJ7aKh5YQtkNuLtJF3SgMz6r0bDURu/ie0f7Ac8Yz4cve9Osewk8LYNeBqrWkZtku/+i1ehr8u
        33NAcBh7qrib5Gij0hssJlT3vkVAmyItlPzR4eBaH
X-Received: by 2002:a25:d209:0:b0:648:370f:573c with SMTP id j9-20020a25d209000000b00648370f573cmr5570212ybg.255.1651912904428;
        Sat, 07 May 2022 01:41:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL8lHgmhm01MbdmhDDqtcHd5MtPPN2X8/3Y6Vo0COEyOTfbsiMCUsGQj/N/qrO0ZhjLJ/gcTEuPNxd2WmE35I=
X-Received: by 2002:a25:d209:0:b0:648:370f:573c with SMTP id
 j9-20020a25d209000000b00648370f573cmr5570202ybg.255.1651912904261; Sat, 07
 May 2022 01:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220503115010.1750296-1-omosnace@redhat.com> <YnFUH6nyVs8fBgED@x1>
In-Reply-To: <YnFUH6nyVs8fBgED@x1>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 7 May 2022 10:41:32 +0200
Message-ID: <CAFqZXNsQK-0knY-W4YojJEFapJyWZBsf9sE=L=0drXnb4SPQeA@mail.gmail.com>
Subject: Re: [PATCH] crypto: qcom-rng - fix infinite loop on requests not
 multiple of WORD_SZ
To:     Brian Masney <bmasney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-msm@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Stable maillist <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 6:11 PM Brian Masney <bmasney@redhat.com> wrote:
> On Tue, May 03, 2022 at 01:50:10PM +0200, Ondrej Mosnacek wrote:
> > The commit referenced in the Fixes tag removed the 'break' from the else
> > branch in qcom_rng_read(), causing an infinite loop whenever 'max' is
> > not a multiple of WORD_SZ. This can be reproduced e.g. by running:
> >
> >     kcapi-rng -b 67 >/dev/null
> >
> > There are many ways to fix this without adding back the 'break', but
> > they all seem more awkward than simply adding it back, so do just that.
> >
> > Tested on a machine with Qualcomm Amberwing processor.
> >
> > Fixes: a680b1832ced ("crypto: qcom-rng - ensure buffer for generate is completely filled")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
>
> We should add '# 5.17+' to the end of the stable line.

Is that really relied upon any more? AFAIK, the stable maintainer(s)
already compute the target versions from the Fixes: tag. And the
version based on the original commit would be inaccurate in many
cases, as the commit may have been already backported to earlier
streams and you need to patch those as well. Thus, I believe it's
better to leave out the version hint and force people to look up the
Fixes: commit instead, which is more reliable. Also if you grep the
latest mainline commits for 'Cc: stable@vger.kernel.org', you'll see
that most commits don't include the version hint any more.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

