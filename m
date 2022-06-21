Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A86553E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354287AbiFUWHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353230AbiFUWHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:07:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8CE2D1D0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:07:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y32so24646776lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8wwgGAq8d4z4LA30RN/37tv5nej7sfXrWlNWAFCBfU=;
        b=ecaKjaUXigig96syw1JqIXMgHI+wAHdoIVeO+/ayorUfW8ko0hP+AG3CkHf7kvQC6T
         W5DKZqDRVimTQc9wLuiji8+ZLNkXjPq10t5ERomU7vT9+9FrVuy6TxaTqbx4q44zZzeR
         PTsdQiXdJ5jKdT9Vg8L6z8wIT0gK13XEoBqbf+coWNG3WJGxt00pcpCwQYQRYsDfDaL6
         VqMnYxzUfA6Ml93aAWfRqTKrtsSlyr47sd7OCdBhNAKkt7H/Hi9HgY2JSDtKtm/9fpBC
         7TOXY9EC4Z5cC6VRmqnuyXphIUerM3uHso4dpmh2pTaj8c27c+VkT55BN9bNF26Trfsp
         SllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8wwgGAq8d4z4LA30RN/37tv5nej7sfXrWlNWAFCBfU=;
        b=YctgGjTPp9SFO9wxbhOZVrApMVrLhNZ6YlZIz2ORve8QaRqBX9aGH6bLKk4F3zn9TH
         XM/2C7ad/2Fxq3O3Tz2Sg4wReOO4vfOTsa7JdMKUKIGnnM3v/cqcYQyyQA38MwphG7De
         2/Id49IXz5Vi3SIACxd9uOJ4aJes//aEt9F1nGDXpbHh7sPhQkkRwfKm2Y7TQ3InaioT
         fFM/WdvP35NQJew5SzPKq2x3OE197uGQWdPV0XfrGgcwBtYzTjE7NGg2aIkRUXRRRnPl
         RkD23jm63stnP/EVI4JWJJssZwtEP9lIe9+k5aN1iZdigaCYjrW6xczhbvhEeyA7mctM
         dXTw==
X-Gm-Message-State: AJIora87Us+dEpZeBdoOacTWCuIGiQTbBJ8ykUDRXi888LUAtd2P+aGB
        ugeeq0MJC2fwPIXBCI0KK93oBAWkpSM/nGHFXAdg6g==
X-Google-Smtp-Source: AGRyM1vIZOn+d7juZxc3nYUdcSSYUvzmMe/B2NGIfTleD/o0LVRaB0n0aY/enbAR7IXLInVaMLqpTNtUeBMgDzX7Iz0=
X-Received: by 2002:a05:6512:b8d:b0:47f:74f0:729b with SMTP id
 b13-20020a0565120b8d00b0047f74f0729bmr217850lfv.403.1655849224024; Tue, 21
 Jun 2022 15:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmFzNZ_r1itJJkAh-VPMCjqvCCB1DPXSUwUFeeAjoJviA@mail.gmail.com>
 <56ed5cf9-f526-79d6-08aa-e1e8dd1852cc@oracle.com>
In-Reply-To: <56ed5cf9-f526-79d6-08aa-e1e8dd1852cc@oracle.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jun 2022 15:06:52 -0700
Message-ID: <CAKwvOd=XVRdnS4+8QZF4iwt1KqKju44n8EVgtN2q=9De_1wmDg@mail.gmail.com>
Subject: Re: plumbers session on BPF/BTF support in the GNU Toolchain
To:     David Faust <david.faust@oracle.com>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Apr 19, 2022 at 1:01 PM David Faust <david.faust@oracle.com> wrote:
>
> Hi Nick,
>
> On 4/15/22 10:50, Nick Desaulniers wrote:
> > Hi David,
> > Jose and I are currently in the planning process to put together a
> > Kernel+Toolchain microconference track at Linux Plumbers Conference
> > this year (Sept 12-14) in Dublin, Ireland.
> >
> > Would you and Jose be interested and able to give a presentation on
> > BPF and BTF in GNU tools?  There will be an audience of kernel
> > developers there, so discussions with kernel BPF folks could be
> > facilitated in person.
>
> Yes, we'd be happy to. It will be great to have a chance to discuss in
> person. Looking forward to it.

Hi David,
If you're still considering attending Linux Plumbers conf, please
submit a proposal:
https://lpc.events/event/16/abstracts/
Please make sure to select "Toolchains Track" as the "Track" after
clicking on "Submit new abstract."

>
> Thanks,
> David



-- 
Thanks,
~Nick Desaulniers
