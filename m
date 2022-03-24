Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214834E6A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355346AbiCXWZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355296AbiCXWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:25:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715FE2AE13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:23:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a17so7234345edm.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6MBbcTTX+22LzDQ6ECr2bIqiwia88/SS+r4U6tgNmU=;
        b=CvOL71164K8S1OKOR/5ZUvKVejQ6sOY5QjWJX0UL0Zhx3WKZh2jNAzhPX6Z3RbeiCK
         1CtOryJHYEtEZFtFzE7ANmMwsbBx35uLSeqzmt/+/QfSGiwGCvj/y7z8eTzi3tIooWQN
         IZI/EFul54Q9URG80JKdNUuBowY2MUYYRAkrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6MBbcTTX+22LzDQ6ECr2bIqiwia88/SS+r4U6tgNmU=;
        b=P/9xwm9e9CtGt3oZ8hlFiyQ3wrtA8aTjyRbVwPN5kKk3GA102m7nqx+qnHw5JtLytl
         eTYPWd6PD8baMUT1aDRwOsSnyRqc6Qio63vg0qPFyQSJthPalLEKaxtc/JksQC46DwgD
         /siPrqR6EiSzcY/Go/31MtYT/zLf1pknTselMEqSp2XTJ5Mpg1wDhDj/Gil0OaKhNrWS
         HqU0GFbB/D63ArELnihvDvGoAWb4/EownsT6k0W3rxiXXSo6ib3qBkCiEdPSiFBdXPKP
         FwPJrlw+YYJ1TYEJVflad06gUdLSKLHGgGiJGEjjE5MF7tlrB7PEo8uiZ1ulGZpbDgWE
         ZooQ==
X-Gm-Message-State: AOAM533fdLjVSXK2CkjbzlbEIAYO8yPBwLn9AgoCHT1tGXqyKFaV2QOH
        LFgqT+szN3kkrw7htkrm+1TOqJ0OkRgyX7U+
X-Google-Smtp-Source: ABdhPJwpydlsVLyhoHLJEINebrF64sM4s7FZrWmPz/SCzSZCTsAVjRUG7PSkqeFD8WywXtqDpuurpA==
X-Received: by 2002:a05:6402:9:b0:419:3c6e:b0d5 with SMTP id d9-20020a056402000900b004193c6eb0d5mr9308721edu.216.1648160634495;
        Thu, 24 Mar 2022 15:23:54 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm1587182ejc.66.2022.03.24.15.23.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 15:23:53 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id a1so8503708wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:23:53 -0700 (PDT)
X-Received: by 2002:a5d:4491:0:b0:203:f63a:e89b with SMTP id
 j17-20020a5d4491000000b00203f63ae89bmr6363442wrq.342.1648160632993; Thu, 24
 Mar 2022 15:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220324101242.v1.1.Iebdb5af0db7d3d6364cb229a27cd7c668f1063ae@changeid>
 <CAD=FV=XchtJx3ZsL4Bxj29b_-43E8p2fiJ5SBQSzbW8wp+gNfg@mail.gmail.com> <YjzsqyEhxOLwJzUL@google.com>
In-Reply-To: <YjzsqyEhxOLwJzUL@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Mar 2022 15:23:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W45wydNfUc1vAx228_yQrE6uzyucBhT6sc5_iqktva=A@mail.gmail.com>
Message-ID: <CAD=FV=W45wydNfUc1vAx228_yQrE6uzyucBhT6sc5_iqktva=A@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add device tree for
 herobrine villager
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 24, 2022 at 3:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Mar 24, 2022 at 12:59:51PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Mar 24, 2022 at 10:13 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > Add a basic device tree for the herobrine villager board.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >
> > >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> > >  .../dts/qcom/sc7280-herobrine-villager-r0.dts | 274 ++++++++++++++++++
> > >  2 files changed, 275 insertions(+)
> >
> > Question: how does this interact with the patch:
> >
> > https://lore.kernel.org/r/20220316172814.v1.3.Iad21bd53f3ac14956b8dbbf3825fc7ab29abdf97@changeid/
> >
> > Specifically, if that patch lands first don't you need to add a patch
> > to turn on "pp3300_codec" ?
>
> Right, I missed that. I'll add it in the next version, thanks!

Great! Make sure to list that other patch as a dependency somewhere
too to help Bjorn when he's able to apply. ;-)


> > I was also looking at whether we should be enabling the wf_cam
> > regulators for villager. I believe that answer is "no",
>
> I agree to keep them disabled.
>
> > but _also_ I believe that we should be _disabling_ the uf_cam
> > regulators for villager, right?
>
> it is not clear yo me which regulator you have in mind for the UF cam,
> could you clarify?

I was thinking of the ones next to the rainbows and unicorns in the
device tree. Oh wait, those were just in my imagination. Please
disregard.

-Doug
