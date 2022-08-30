Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB15A65A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiH3Nx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiH3NxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17603BE1A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661867525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UJVr43uWt8PVxH448vHnmIse/JFMIMR/CqYNuTX+I0E=;
        b=KI7ulRrjwIRswM84L4UQTjrai6STk1iriWRqGA6jCAUemjt/O/Jq4GL3eh1lR7kBuzEmLk
        LwFT+I9gvzmHpe3KaRWBzMKmqDIrRpbikUdgomMjuEvipR5DBWZ5mn8ydYmFoqk+zuGlEq
        uloRZ/DfE5tRMfnv6hS6qKdl2wNwfFU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-j2A3FOOlPpySpBLHblOpvQ-1; Tue, 30 Aug 2022 09:52:03 -0400
X-MC-Unique: j2A3FOOlPpySpBLHblOpvQ-1
Received: by mail-pl1-f198.google.com with SMTP id a13-20020a170902eccd00b001730da9d40fso8091855plh.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UJVr43uWt8PVxH448vHnmIse/JFMIMR/CqYNuTX+I0E=;
        b=mzELNixOl/S1MIky43oS7bLpB/jDSnKNMx7sUsrrc7ePLOKem8Czo37dJj+FXuZnum
         CXy7ZTjbyM602piXfUvfnJCVQ97ks1uFxrtUOVeevpFKDMwZeXmHJxYGwevZxohv1qZi
         QjhmyW8mUFwgCQxF1V00l/tUS7qAV8JAyyM8X7lMyIxRX0E7zGwJ/3Sfr8MvjTfaAkPO
         PhSjEKvrhwg5zvaSR9TdxY7gGPCpAaxXvEbHemESi6S4p2RSxy+Irghivn6yBBoXP4Qr
         0VCM8K6EFXvlJ8DKaDjoDuJHRljNl0j+QfqZTxYW0fMotHOF1KO9Naf97z+yQY1K99EW
         imRg==
X-Gm-Message-State: ACgBeo0sKsHY/sm2UDcwJAVhi6qx428WnoXzh6oB8pBjKC5hMOWqRIyI
        JoWmb3YUh5w2NbWwclRI0Ar/omvSA+oKGA+x6o+XkT1F+zmDdtAvFYgPLp6NJBeUHduzt/qcEXX
        X+TRSsqgD+xL2RSqzBYT2K0L/79CLTuuBezynd0TX
X-Received: by 2002:a65:6255:0:b0:42c:87b1:485b with SMTP id q21-20020a656255000000b0042c87b1485bmr3977295pgv.491.1661867522197;
        Tue, 30 Aug 2022 06:52:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4uttRB0OgUCrHoIJFyDwUqMmth8JbBFJmcReY4G9C4XP9O/bnAzP100AWpX19LwnHtW0ssr0V6liTxxc7zEVI=
X-Received: by 2002:a65:6255:0:b0:42c:87b1:485b with SMTP id
 q21-20020a656255000000b0042c87b1485bmr3977270pgv.491.1661867521925; Tue, 30
 Aug 2022 06:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220824134055.1328882-1-benjamin.tissoires@redhat.com>
 <20220824134055.1328882-3-benjamin.tissoires@redhat.com> <CAP01T76tie9dpjacCLxCcAjtra12GxfmeO9f_mYnUU6pO4otzQ@mail.gmail.com>
In-Reply-To: <CAP01T76tie9dpjacCLxCcAjtra12GxfmeO9f_mYnUU6pO4otzQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 30 Aug 2022 15:51:50 +0200
Message-ID: <CAO-hwJL6cy8JbXFSmSVtkNQHZkuYoHsvb1=JxvLSnBeeRBMZ5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/23] bpf/verifier: do not clear meta in check_mem_size
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 3:55 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 24 Aug 2022 at 15:41, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > The purpose of this clear is to prevent meta->raw_mode to be evaluated
> > at true, but this also prevents to forward any other data to the other
> > callees.
> >
> > Only switch back raw_mode to false so we don't entirely clear meta.
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > no changes in v9
> >
> > no changes in v8
> >
> > no changes in v7
> >
> > new in v6
> > ---
> >  kernel/bpf/verifier.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d694f43ab911..13190487fb12 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5287,7 +5287,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
> >                  * initialize all the memory that the helper could
> >                  * just partially fill up.
> >                  */
> > -               meta = NULL;
> > +               meta->raw_mode = false;
>
> But this is adding a side effect, the caller's meta->raw_mode becomes
> false, which the caller may not expect...

Turns out that I don't need that patch anymore because I am not
checking against is_kfunc in the previous patch. So dropping it from
the next revision.

Cheers,
Benjamin

>
> >
> >         if (reg->smin_value < 0) {
> >                 verbose(env, "R%d min value is negative, either use unsigned or 'var &= const'\n",
> > --
> > 2.36.1
> >
>

