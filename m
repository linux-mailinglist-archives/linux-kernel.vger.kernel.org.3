Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67974CBCF7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiCCLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiCCLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:42:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABF1054F98
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646307715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqBSrbSdMNwPK2ZUsZhrHTBj0wDT7DRz3Uh9oe8j24M=;
        b=OLg88BfxCzUDnWLcbCK6WWoZjYbyMRdxQ7EdOjuK/Do19+eoXnRVt2qE0eV3obEuWL8932
        iVQd4txPw4qUKUecnaqYXmwUAFzrPpbwptl+dgTehp/21O/gKtpCv1SuWkQ5XDIYj0Lro2
        ffWRDBIkHPfLM81Jl0LRmmAgCnzDrxk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-xQpIU_i6Pjq7lxeH0wPl5A-1; Thu, 03 Mar 2022 06:41:54 -0500
X-MC-Unique: xQpIU_i6Pjq7lxeH0wPl5A-1
Received: by mail-lj1-f197.google.com with SMTP id u19-20020a05651c131300b00246a8982589so1796930lja.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 03:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqBSrbSdMNwPK2ZUsZhrHTBj0wDT7DRz3Uh9oe8j24M=;
        b=6HKRG4WboDmAe83cJ/VyvNjdZ1foqq7aQ8ISCA/RN3f1l9YTGzH1LdrfMJuC3aBXnB
         HvI28N6el0iZqSsvzl1PeDDbFzem0Q57pQP2Udhe4eEexkjbwgBRPkI6+50AwDm6e/BL
         rGmJqeddBWHT6idS9Qt4H8bZq1S7gA2/L4SkADUSRDv//ggX1PrrRQ6+fGrtWx9tw6iq
         fLzvH0zkmhbojZAGhrUev6AxJ70qdJRFWMmJ/9mds/pgQQqBeRKrCKY19UjWw5LZIptZ
         Qdcjxt5F8/JIXQ8RSYX3fG9l6r7MUTKjEZ/iKLwhcJMpcvL7opTlXg4zZV/rnJHMRxsw
         eGKg==
X-Gm-Message-State: AOAM531rc78LxQkQWiRAS+UCe+/1IyYjCOYAiY1lwFcEj5EPyRaMQWkc
        z60SImHd7qdUEFg2NCTo0rlmpEqbvBnwbCE/aKMtbXOKPFpoYTT+zCZGUR3ezE9QbphQ9/fGRoX
        nRtyFQNQDwWP9c0LeWu7Uv8bggDaNZ5JslfcxlyFV
X-Received: by 2002:a05:6512:490:b0:443:d65a:2bc8 with SMTP id v16-20020a056512049000b00443d65a2bc8mr20830479lfq.579.1646307713162;
        Thu, 03 Mar 2022 03:41:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxI2CyAVDrRpKoot3YdtX360CQv7KQn1exb01Q3XrvX14zqrROec19o0dyRL/oekGIY04Kwk/Rp60Fag1A7Wds=
X-Received: by 2002:a05:6512:490:b0:443:d65a:2bc8 with SMTP id
 v16-20020a056512049000b00443d65a2bc8mr20830459lfq.579.1646307712908; Thu, 03
 Mar 2022 03:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20220127151945.1244439-1-trix@redhat.com> <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com> <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
 <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com> <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
 <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org>
In-Reply-To: <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org>
From:   Konrad Wilhelm Kleine <kkleine@redhat.com>
Date:   Thu, 3 Mar 2022 12:41:41 +0100
Message-ID: <CABRYuG=WCBLp+roXzdEZE-X_HHDtwnN-S-CsA2V41h-1v3otnA@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Tom Rix <trix@redhat.com>, Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending in plain text format to make mailing lists happy.)

Hi Finn,

On Thu, 3 Mar 2022 at 09:40, Finn Thain <fthain@linux-m68k.org> wrote:
>
>
> On Wed, 2 Mar 2022, Tom Rix wrote:
>
> > >>> Long term, it would be good have a reliable way to automatically fix
> > >>> either new files or really broken old files.
> > >> That's really a maintainer preference no?
> > >>
> > >> Especially so for any automation.
> > >
> > > In practice everything is up to the maintainer.
> > >
> > > If some maintainer wants fix their formatting then clang-format should
> > > just work
> > >
> > > It isn't likely they will have time to hand fix every file.
> >
> > A follow up issue in the clang project has been raised by Konrad, here
> >
> > https://github.com/llvm/llvm-project/issues/54137
> >
>
> Why request a "leave" option for every style rule? Why not just a "leave"
> option for the most contentious rules?


Getting to the point that every style option can be disabled
individually is not an operation done in one go. I plan on presenting
the changes required to exactly one style option and from there I'm
all ears if you have style options that you consider "contentious". We
could certainly tackle them next. But for starters I think it's fine
to just show the impact of changing one style option only.

>> The response from the developers that anyone who wants to leave existing
>> code unmolested by certain rules should "wake up and smell the coffee" is
>> obnoxious, IMO.

I hear you, I like tea better than coffee ;). In all seriousness, I'm
here to help and I don't judge the developers for protecting their
code and having an opinion about other projects. We're here to talk
and find a solution, nothing more. Let's try to ignore the sarcastic
undertone in the dialogue.

>> Presumably clang-format must grow until it has sufficient program logic
>> and config options to cater to every exception to every rule. How long
>> will that take? Some carefully chosen "leave" options might make the
>> program much more useful in the near term.

That's what I aim at. I hope I've outlined this in the first paragraph
of this email. One baby step at a time...
- Konrad

>
>
>
> > Tom
> >
> >
> > >
> > > Tom
> > >
> > >>
> > >>
> >
>

