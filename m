Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200C55098FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385709AbiDUHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbiDUHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:25:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94411835D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:22:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so1055478pjf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cmd0E8Et4Aqh5aFcilCHXMmJJLWu1Jtl7bjaRVoAghc=;
        b=wlpnfsZ16kVfFPfp0k7Xj0f/aywbiZeLM4giSo7yBwG9EWkqD7nzRgzQ8sF933Mir5
         5J5YxRb1Sn613WSHJZqpEO1cao98as3MMx1p/h1VIRoV1NPKbuXITZTdwCBtB4w0Hvhv
         NzGU7bgDiaG0QTcoVX2PdwFTW0ISrwv8eCeKnOknh5CzqMN8fNsJnKqrH7Qbi/ATlAn9
         mc+ajMM1PLJX0m84nWKrxEhe11zMs3WDUqOwac9nZZyhtqOAZp/phrX55gcTelgupd9V
         L6Luf/Qt9k4lTI/FcV5s090CQk9HwX5H+l7eFF2QhizHRLp7sv23a5GpyZMNONzkqP1w
         mkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cmd0E8Et4Aqh5aFcilCHXMmJJLWu1Jtl7bjaRVoAghc=;
        b=hCV+xx1gKEqO9nk2PILh785i7afI6egtJz0tyzhVU0YguSzr4qYXJa7SuJzdfUd4Au
         s0PTXAJLsLQaW89zuxvb9TrB3JNh+slYt1Ah0BZyxPrV6eV4tm7+FqUpAyj0EImF/je8
         gAaW1oBEcjBI6ac93x6uUOfzpv/IRiOzA6ObCa+4SWROdLjywX4IquN8PoYGPwx7MQKR
         ds91OwFup+eiFx3O3W96jHTlDu7G7PpQyqH+yZKwRg0GowJV4dXrW0Lyb4F6yJPHpzpH
         SgLrog/JlCjHEH8XV4otBUTp87U0V8k6asD4v//EgJw/aCy+/i3F1i79E1PWNoB9bWPz
         3csw==
X-Gm-Message-State: AOAM533NH495O+qp4nm2q/bdlXq6GBJi/s3gtkp78ejXxwHWlcwG1SMY
        avTb5fP0vKhQ6X+HA1L9jPXQcyS9JXGSDL4wPnfELivfrgQ=
X-Google-Smtp-Source: ABdhPJwJ+eJ+vATRB/XjaodcI4GTsx+t0J1D+9WNX9bPTfhZ/WJLHVyG2MdACY15rk8788iGZEzyO+B/x7DhWAjNAjI=
X-Received: by 2002:a17:902:e881:b0:158:fd34:7b28 with SMTP id
 w1-20020a170902e88100b00158fd347b28mr18501645plg.95.1650525778165; Thu, 21
 Apr 2022 00:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220420102811.3157-1-slark_xiao@163.com> <CAMZdPi9WJsz5nyzQB39q=Jhy8_q2=N8VAucYMUYKUf_faL5csQ@mail.gmail.com>
 <55f0b74e.25a7.1804aeeedb4.Coremail.slark_xiao@163.com>
In-Reply-To: <55f0b74e.25a7.1804aeeedb4.Coremail.slark_xiao@163.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 21 Apr 2022 09:22:22 +0200
Message-ID: <CAMZdPi93zxGmb-ns0bNk6itcUck1=Hsh5Y9-FFCNBU2qNg248A@mail.gmail.com>
Subject: Re: Re: [PATCH] bus: mhi: host: Add support for Cinterion MV32-WA/MV32-WB
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com,
        gregkh@linuxfoundation.org, bbhatt@codeaurora.org,
        christophe.jaillet@wanadoo.fr, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 at 09:04, Slark Xiao <slark_xiao@163.com> wrote:
>
>
>
> At 2022-04-20 20:00:23, "Loic Poulain" <loic.poulain@linaro.org> wrote:
> >Hi Slark,
> >
> >On Wed, 20 Apr 2022 at 12:28, Slark Xiao <slark_xiao@163.com> wrote:
> >>
> >> MV32-WA is designed based on Qualcomm SDX62, and
> >> MV32-WB is designed based on QUalcomm SDX65. Both
> >> products' enumeration would align with previous
> >> product MV31-W.
> >> Add some new items for mv32 to separate it from
> >> mv31-w, in case we need to do any changes in
> >> future.
> >
> >On the contrary, do not overly clone the structures, and re-use the
> >mv31 ones if they apply. You can rename them to mv3x if you really
> >want to.
> >
> >Regards,
> >Loic
> >
> Hi Loic,
>   Thanks for your suggestion.
>    Actually, for different chip(like previous SDX24 and SDX55), they may
> have difference behavior. For example, the item of 'sideband_wake'
> of SDX24 is true but the rest is false. It's hard to say SDX65 would
> align with SDX55 until now.

I agree, but as long as the structure's fields are the same there is
no point in duplicating them.

>    Maybe I can re-use the same item '.config' for all MV3X products and separate
> them from device info(mhi_pci_dev_info).
>    Do you agree this?

Yes.


Loic
