Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380B04DCBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiCQQyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCQQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:54:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A12B62A37
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:53:18 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y142so11272799ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpjeJ8QdW/CmqR2xDeXs/92h46wSWjFSBCozUg7uNqs=;
        b=gTvdJVxU5LXYliDDCmEWbkrnko0Ce8YhCfpPalJdRHYuKPj+8//gr2BTDR8yZuyx79
         4oCQWvQSP8YEA5A7vu1LShb0QVL7Fcaqv6rdI6MeqhbdOKifbeY3D9tZPurpvUX2Xs+5
         kQEl8nMNYOnXuBSo+pLVwAsTPHgEY7lyEtP/MS7BOXxzJlMY7i3URcR4m/pNAqDSn+6V
         BhvslQJFvA1k9FvAAb/rqBCGb4LNeyyjqO5S6J4988CUISzgL8FadrAqSPvORUKSVE06
         OHjLmZq38EpO1GILzdeg00H+5f064X0Dm0gKV/6+BKBK91tCsw6CwDPP1bTQqomXh+51
         vY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpjeJ8QdW/CmqR2xDeXs/92h46wSWjFSBCozUg7uNqs=;
        b=cadTiFvW5wKSTpPfk7gbLhkoyG/a135b5KMCXwcrBuA+6K4px/RSWFlQYU+RT752z3
         DmkepCyw+vQZ6m3gNjLFQjFYUb+t7KITcQtvfGTx8bjfCncftlP44fSiyq9T6TdYkYow
         rp9dLP4yvAjjCaAK/hv4m5CZ89cnNAG1SuxSmw8HEa/Qv1OElegOIm08u/cplKMFklNG
         EUQTkkh3o4NJ9ErGCR+aS9MbFQSEt8pJiRfUUtfpTpKNeTiULZzW/szAeEoFLpqo6lfU
         /xDflj8wNLows5r2GSNF9deotGHpDK5t7NqXCGo+eL8y05AeFPwI10Re6cWermo32Zdg
         bv/w==
X-Gm-Message-State: AOAM532OXPiZvxZR4BZ4Z808cd9uznRjQuQrZkdxR6UpwE4+3OK6y7hM
        Wgp/0F9+ZaP0umCVjym8zne2B6MJM/SzTEqREpCP5A==
X-Google-Smtp-Source: ABdhPJyJYSYDZjLCDSULZ1P1ZZ5vjZFLsDMYo99t43UMgeiqWKfG6cxaG3yU+sgeECqkvltfODNP3glHpXcKDREAQnU=
X-Received: by 2002:a25:1906:0:b0:61d:9576:754e with SMTP id
 6-20020a251906000000b0061d9576754emr5795294ybz.426.1647535997540; Thu, 17 Mar
 2022 09:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647008754.git.quic_charante@quicinc.com>
 <4f091776142f2ebf7b94018146de72318474e686.1647008754.git.quic_charante@quicinc.com>
 <YjEaFBWterxc3Nzf@google.com> <20220315164807.7a9cf1694ee2db8709a8597c@linux-foundation.org>
 <YjFAzuLKWw5eadtf@google.com> <5428f192-1537-fa03-8e9c-4a8322772546@quicinc.com>
 <20220316142906.e41e39d2315e35ef43f4aad6@linux-foundation.org> <YjNhvhb7l2i9WTfF@google.com>
In-Reply-To: <YjNhvhb7l2i9WTfF@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 17 Mar 2022 09:53:06 -0700
Message-ID: <CAJuCfpGBJev_h92S0xLEQXghGQzNPCsqWTunpVPJQX4WWPjGzw@mail.gmail.com>
Subject: Re: [PATCH V2,2/2] mm: madvise: skip unmapped vma holes passed to process_madvise
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        nadav.amit@gmail.com, Michal Hocko <mhocko@suse.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 5 . 10+" <stable@vger.kernel.org>
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

On Thu, Mar 17, 2022 at 9:28 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Wed, Mar 16, 2022 at 02:29:06PM -0700, Andrew Morton wrote:
> > On Wed, 16 Mar 2022 19:49:38 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
> >
> > > > IMO, it's worth to note in man page.
> > > >
> > >
> > > Or the current patch for just ENOMEM is sufficient here and we just have
> > > to update the man page?
> >
> > I think the "On success, process_madvise() returns the number of bytes
> > advised" behaviour sounds useful.  But madvise() doesn't do that.
> >
> > RETURN VALUE
> >        On  success, madvise() returns zero.  On error, it returns -1 and errno
> >        is set to indicate the error.
> >
> > So why is it desirable in the case of process_madvise()?
>
> Since process_madvise deal with multiple ranges and could fail at one of
> them in the middle or pocessing, people could decide where the call
> failed and then make a strategy whether they will abort at the point or
> continue to hint next addresses. Here, problem of the strategy is API
> doesn't return any error vaule if it has processed any bytes so they
> would have limitation to decide a policy. That's the limitation for
> every vector IO syscalls, unfortunately.
>
> >
> >
> >
> > And why was process_madvise() designed this way?   Or was it
> > always simply an error in the manpage?

Taking a closer look, indeed manpage seems to be wrong.
https://elixir.bootlin.com/linux/v5.17-rc8/source/mm/madvise.c#L1154
indicates that in the presence of unmapped holes madvise will skip
them but will return ENOMEM and that's what process_madvise is
ultimately returning in this case. So, the manpage claim of "This
return value may be less than the total number of requested bytes, if
an error occurred after some iovec elements were already processed."
does not reflect the reality in our case because the return value will
be -ENOMEM. After the desired behavior is finalized I'll modify the
manpage accordingly.
