Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F105B5AD9D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiIETpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiIETps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:45:48 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF625287
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 12:45:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so6752450otr.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fHl6yMeuzT6h5uK9FH6IQV1Bl24t9+tJv4vuXbMlEXw=;
        b=jN77iQLW/enFCxA0tVNh4FW8LCcXCtDLRSV7cZy2zRgZlg8Tbs3eIAbn4omhgVd57S
         yZPcV0uD1ulSe9A1xfjDpC+a1L30xq6OWsxDHTMGdjko2Fzr8l7tnpm+ZwQB/YwCkOyN
         FWxUZffsLsnalQScHeKZZB07znrShg2KxVYBpNUzKFaacYt6t0fq0mBF49lBtprxzpUr
         p8C/EUQaw5N5pak1Vk5MGNUZAXs6gqRSBE+A0MW2E+/gK6XB0xFrkP5jfhahK0oxSWxG
         MdepxsfJIoGwYZ+fAyjNjLBcP9kZ654jHFWKd+pGydfhQEwx63HBg5RyelQmkuYDnMIF
         T1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fHl6yMeuzT6h5uK9FH6IQV1Bl24t9+tJv4vuXbMlEXw=;
        b=WSaT76YXCDiuzLgSk3tbFqQ9McrC4zEX+yP4z/K7joIk83QOdpuNFMNvxC9ZjBfFJn
         G4lkFLzO0hF3tgNkBFwrFswHkZ3b2CSQWWS7n1aLDNGoUMhGAKJ4+rUD21i1v41y8/Ee
         LpwjctSJfjh14BnU8KVsWjTXrdJyVOkFx7vvAVTqz74MzmHchIOXTEnAhXIC/xZDCph+
         g0qo2weiyofNADsKUjBstqr6W2ROcxaWK+rOvM5pPuxXTVSyvPdKBe4f+FxnSf8uaVSH
         BtSCAU8pzd516WqM8mjcKX6TYHb4stK9LxZvHH6sKACUn3yUOuiOnC8LM7PuE7N08lV2
         fGLQ==
X-Gm-Message-State: ACgBeo218rFiIp1C15hS4kIbKEDk4xmBnppdUDMq+ixbA5kOOSL2CByT
        mZQs+B8awyLRnnO49XsMoO6yaOb/YoftAGD+459vGg==
X-Google-Smtp-Source: AA6agR4q/AoB+KeU5E5RhiN8gNHFlhVuqMW1yp4G17ibjmBEd5gcL7d0sGk4sZm1CIBLagVQ4LCpLHdY2AlXWUEnejI=
X-Received: by 2002:a9d:4d99:0:b0:639:1fe0:37c1 with SMTP id
 u25-20020a9d4d99000000b006391fe037c1mr19384886otk.267.1662407145580; Mon, 05
 Sep 2022 12:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220602142620.3196-1-santosh.shukla@amd.com> <CALMp9eTh9aZ_Ps0HehAuNfZqYmCS72RKyfAP3Pe_u08N9F8ZLw@mail.gmail.com>
 <fd73f376-345d-6f58-987d-cca203e06cad@amd.com>
In-Reply-To: <fd73f376-345d-6f58-987d-cca203e06cad@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 5 Sep 2022 12:45:34 -0700
Message-ID: <CALMp9eR5rFtjWA+oee2JnmKVN5Br4R5CcqUijzH-2N+ix8HAfw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Virtual NMI feature
To:     "Shukla, Santosh" <santosh.shukla@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
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

On Wed, Jun 8, 2022 at 1:23 AM Shukla, Santosh <santosh.shukla@amd.com> wrote:
>
>
>
> On 6/7/2022 4:31 AM, Jim Mattson wrote:
> > When will we see vNMI support in silicon? Genoa?
> >
> > Where is this feature officially documented? Is there an AMD64
> > equivalent of the "Intel Architecture Instruction Set Extensions and
> > Future Features" manual?
>
> Hi Jim,
>
> A new revision of the Architecture programmers manual (APM) is slated
> to be release soon and that is going to have all the details for
> the above questions.

It's been about 3 months, and I haven't seen the new APM yet. Is there
an anticipated release date? It's hard to do a proper review of new
features without documentation.
