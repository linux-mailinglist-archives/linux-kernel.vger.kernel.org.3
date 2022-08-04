Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB758A2FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiHDWDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHDWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:03:15 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129BDEBA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:03:14 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h188so841556oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=A3KaqbTDvr6yI86EPzA1l0NOPWv07KWx997g85QsDx4=;
        b=V06sSFt2ksPjM8k6wnSbaG2QkPaVwvcAPAKnSzq34sTv9ksxh2OqhTuqg8SpivF9Y0
         BeAYJPw9WS7SWCrlAS2ZuZhlUV0Va814LRQgaD8u4FmAed6qJn5lA7YVe7jiuQtzViV2
         U2pdwnl+QBpBXtgGdP1BnbBo3Ok4S5SQTNkLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=A3KaqbTDvr6yI86EPzA1l0NOPWv07KWx997g85QsDx4=;
        b=nQtWSEBD9LYuGnsRmcxMmYHua/57BDyb/DzIjHNEPXlLkaufUqrUp0dHXpLRFgrhTz
         ftzetZzafcC1LTWW3gjeqtp/CSe9dIgG9sDMBfb+ri10H/gVgzU9vGRy0NZ7/KPp4FA8
         8K+FnYFnGZPiLR1ZgIwFaKcFhtK9VHe90R6xoxGSoMQ2eABisXWFooMnNYn3iYhpfuA7
         Eojjp9Gr8Wr9N6IFn86uUNdtjJNYyOHy7LrVcxNxee54nGT94NeLAp0RQfOSLJ9fPMKg
         qpuvrvlQ5CrZeDRjS7csXfkY87m2H0Y2iMJOOmkmtSqb8Po+ny2jNSGwlNHmfTcdAsad
         7Bdw==
X-Gm-Message-State: ACgBeo3+/KGstFtp8yUi/DB3n8Up3X9+5Bmts3Kxt2GNgrU5PXSRL+jU
        Ef6X6IonQNW8k4lMyBwXk+we1jHu5WZaRw==
X-Google-Smtp-Source: AA6agR5ZCtL3IkfxdFw2tj5QBLkjoNUFXf9hxfv/I4IiSLMKBTeWUorGlgIdUTwXCnr2T5Yvi7zYOQ==
X-Received: by 2002:aca:2217:0:b0:33a:e056:dc76 with SMTP id b23-20020aca2217000000b0033ae056dc76mr1696058oic.128.1659650594266;
        Thu, 04 Aug 2022 15:03:14 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id 6-20020a9d0686000000b0061c7ec80898sm349711otx.23.2022.08.04.15.03.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 15:03:14 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-10cf9f5b500so1081884fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:03:14 -0700 (PDT)
X-Received: by 2002:a05:6870:b4a1:b0:10e:50b8:50aa with SMTP id
 y33-20020a056870b4a100b0010e50b850aamr1952047oap.174.1659650171298; Thu, 04
 Aug 2022 14:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220506160807.GA1060@bug>
 <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
 <CAJZ5v0gxq=EA_WWUiCR_w8o87iTHDR7OC5wi=GRBaAQS2ofd5w@mail.gmail.com>
 <CAE=gft6V6RLc-d4AOuRUVU2u1jMGghDRSrFqiCqMCLxemui8Pw@mail.gmail.com>
 <CAE=gft5OYAgosqmwNkk=Cwoooeg93Njmnzfz=gwCaLB0Ts+=sw@mail.gmail.com>
 <CAE=gft6sPkhNcz7+fJuDzQo2f8fM_0Wv_OWC9W2LyvXd6M6zeQ@mail.gmail.com>
 <CAHSSk05JEcZfS2tc22F+m76T3vZt-mZ7zUQaGRgSanKaFc5xBg@mail.gmail.com> <YusZ8gD/LjiAXadR@kernel.org>
In-Reply-To: <YusZ8gD/LjiAXadR@kernel.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 4 Aug 2022 14:55:35 -0700
X-Gmail-Original-Message-ID: <CAE=gft6LaNZLTK72n_Z7an0VA1FxxFFgGk6rmUF_Jvf=JinG3A@mail.gmail.com>
Message-ID: <CAE=gft6LaNZLTK72n_Z7an0VA1FxxFFgGk6rmUF_Jvf=JinG3A@mail.gmail.com>
Subject: Re: [PATCH 00/10] Encrypted Hibernation
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <mgarrett@aurora.tech>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 5:59 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Aug 02, 2022 at 11:36:43AM -0700, Matthew Garrett wrote:
> > On Mon, Aug 1, 2022 at 3:33 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > > One more bump here, as we'd really love to get encrypted hibernation
> > > to a form upstream would accept if at all possible. We were
> > > considering landing this in our Chrome OS tree for now, then coming
> > > back in a couple months with a "we've been baking this ourselves and
> > > it's going so great, oooh yeah". I'm not sure if upstream would find
> > > that compelling or not. But in any case, some guidance towards making
> > > this more upstream friendly would be well appreciated.
> > >
> > > One thing I realized in attempting to pick this myself is that the
> > > trusted key blob format has moved to ASN.1. So I should really move
> > > the creation ticket to the new ASN.1 format (if I can figure out the
> > > right OID for that piece), which would allow me to drop a lot of the
> > > ugly stuff in tpm2_unpack_blob(). Maybe if I get no other comments
> > > I'll work on that and resend.
> >
> > I've been revamping my TPM-backed verified hibernation implementation
> > based on this work, so I'd definitely be enthusiastic about it being
> > mergeable.
>
> BTW, is it tested with QEMU + swtpm?

For myself, so far I've been testing on a recent Intel Chromebook. The
H1 (aka cr50) security chip on modern chromebooks implements a subset
[1] of TPM2.0, and is exposed through the standard TPM APIs in the
kernel. I can make sure to test on Qemu as well, is there anything in
particular I should look out for?

-Evan

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/tpm2/+/3373466

>
> BR, Jarkko
