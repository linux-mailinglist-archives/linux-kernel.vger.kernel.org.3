Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DCA4E8000
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiCZI0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiCZI0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:26:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1E208319;
        Sat, 26 Mar 2022 01:24:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k21so16891694lfe.4;
        Sat, 26 Mar 2022 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=baD/hy7UqUwQ+dS5FFULxwEB9FIM9FTZhKUu9Qvd7wc=;
        b=gqtohLPJoIjzNVG85trDDWdJUwTmp22O8os9KywNzpz/c7GSl69ysNTdTrBYL7lo1G
         rUswZINZCsHrIVXmOwccLM5xu7AV1iZtYsxV4gZxyisHjrJkgVo7KMjtQjVLCQafEwtc
         kKCNFitQ/7z2nteerLrMkGXDG0nNn9eMmIAk1jxv62zfajC02FnwBw85wpQi3FEkdqQd
         KMFvx14lUBweVU29yCZhyf4KQdVxJ+ujomzu55tB46GekSmeh9GFCxIpL/XdRUr/8/qN
         hgruZ3TJYutId+8HZ5AVyaRg7oAjMW8dcGBXhdUd6FJM/U2wk2hYPUQr6kHwywQrdh/l
         mTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=baD/hy7UqUwQ+dS5FFULxwEB9FIM9FTZhKUu9Qvd7wc=;
        b=snF/lhA4CJ/oftggIZwY06Yne3TZMM9u2NL/siYWC4AP2BnRKJ1GrSyK3PsU3ttzi5
         tW98P6VviGRUCQC3kP/Wet6XwJc/hAakCaRMmwVjBT9lELSACqMZa0qL/ZL8NoJvwrwx
         fyQ8rwY8t20UXc8i8Z3HhIRmHRKFazD4QjEpafwV41GMS36XZxr2NFEE1kcQKdZ7l5Zj
         5cjBaGDP9kaLIprTVOgMBz7Yia2llxaQk6+ytUcMJmLn2t6X0Ws5jkkrRbAkEGv0Imz5
         1TjXubcoWnj7erVaRY21wo8POvvjvqYMAsrHNLuCkzobqA71omRHsEq/aY/MrS7pG6Pj
         gomA==
X-Gm-Message-State: AOAM530w6r3G7Dk9iPRJG/a0pgyvAZ5lVkL08GO5eziDtsepXJOYC9Ni
        CbqoN1ga/+Y3K54/eAkRpRvv/z5swjq2/AiUGjs=
X-Google-Smtp-Source: ABdhPJxzulhonwSSggDUXNivoTSltzywgZ6stL57WymfdoYG0jquIP/FDjem5JM/YsvrvUEaZ5agAVzFZdHq7ZpTMyA=
X-Received: by 2002:ac2:4d5b:0:b0:44a:14c9:89fb with SMTP id
 27-20020ac24d5b000000b0044a14c989fbmr10987259lfp.345.1648283074411; Sat, 26
 Mar 2022 01:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org> <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org> <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
 <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org> <Yj3oXuijuZY1gG9X@sirena.org.uk>
 <d2f220ae-c62c-a7f7-23cc-c33956c2eeaf@kernel.org> <CADiBU3-3QLi5PVUymk_VCbF+-uVSqjoP9jLGL+R=PQ-S=Y=_AA@mail.gmail.com>
 <Yj5nYUeizlmlbX4O@sirena.org.uk> <CADiBU38O6zdp5KYt90KgrZKJwAzBqPoaYQYehAJ=wS42NyVcjQ@mail.gmail.com>
 <de9ff5a7-ebcf-d08f-486b-5334be8fb703@kernel.org>
In-Reply-To: <de9ff5a7-ebcf-d08f-486b-5334be8fb703@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 26 Mar 2022 16:24:22 +0800
Message-ID: <CADiBU38Jo8n3m-BQ_3aCnapc2X=boQQS2PEKcGjPNfGHLMT=gQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:13=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 26/03/2022 08:55, ChiYuan Huang wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:07=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> On Sat, Mar 26, 2022 at 08:58:47AM +0800, ChiYuan Huang wrote:
> >>
> >>> I tried to remove only __maybe_unused and build with x86 config  that
> >>> CONFIG_OF=3Dn.
> >>> There's no warning or error message when compiling the rt5759 source =
code.
> >>
> >>> If so, I will remove only '__maybe_unused'.
> >>> May I ask whether 'of_match_ptr'  need to be added or not?
> >>
> >> If you add of_match_ptr() (which is a little better, though it's
> >> a tiny different either way) then you shouldn't remove
> >> __maybe_unused - the thing here is that the __maybe_unused is
> >> needed because of_match_ptr() is used.
> >
> > Sorry, I'm confused.
> > Originally, Krzysztof's opinion is to tell me why 'of_device_id' is
> > declared as '__maybe_unused'.
> > That's why I mentioned that the return value  about of_device_get_match=
_data'
>
> Your answer is not related to my question. of_device_get_match_data()
> has nothing to do with __maybe_unused...
>
> > And now we're talking about to add 'of_match_ptr' in struct driver
> > of_match_table.
>
> Because this is one of the solutions.
>
> >
> > Back to the original topic, two ways can solve this.
> > 1) only remove '__maybe_unused' in of_device_id
> > 2) keep '__maybe_unused' in of_device_id, and add of_match_ptr for
> > of_match_table.
> > But option 2 seems conflict with Krzysztof's gueestion.
> >
> > May I ask which option you suggested?
>
> Option two does not conflict my suggestion. I pointed out that having
> ONLY maybe_unused is incorrect. I pointed the mistake. Nothing more... I
> said that there are two ways to solve it later, just choose one. I don't
> know why do we talk about such basic issue for so long. This should be
> one email from my side and one confirmation from you...
>
> Obviously maybe_unused it has to be removed if you do not add
> of_match_ptr. But if you intend to add of_match_ptr, then things change..=
.
>
> Just for the record of choosing between options (which I also mentioned
> that there are two solutions) - having no of_match_ptr allows to match
> with ACPI PRP0001 (AFAIU also when !OF).
>
Ok, I think the way to add 'of_match_ptr' and keep '__maybe_unused' is
more formal.
I'll choose that one.

Ack in next.
Thanks.
>
> Best regards,
> Krzysztof
