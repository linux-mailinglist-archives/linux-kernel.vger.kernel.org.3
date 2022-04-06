Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E7D4F4734
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbiDEVDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573371AbiDES7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:59:20 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A07CD338
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:57:19 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id e4so76708oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Eg+uJvzARiyK+y5kdwfhnsez9dPo6iD29SbfPJ5zFbo=;
        b=SOQSZKy52LDl9ojVoe9ifg4gZDbfedX3HkeMtnOMdhgKQ+qR+r52Y+dGcz4uJd5Bob
         kv/cVP780ma8L1IWC4Xds1yYirTqiu52lXC03y3odfB52De0YP3povQqDRNnsie5Tbh+
         8gR0b7LCVS0p02zuIW9kppHpg2JdutvLf5iDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Eg+uJvzARiyK+y5kdwfhnsez9dPo6iD29SbfPJ5zFbo=;
        b=SNqH1eT/8ilfUG7mGvW7LEQMM+Hi6S1CBDtampzyLqb5CeD9nTxTRDxa6Jev+Kzl6l
         fAm2yv+5vRBE4SxdnZAQ3ckmUgJjkZ51Cpo1d2n3s4Fiscp+iefCXX7F0QqffHXuVfeK
         D3BVfxAIAuJOJE8RPVqaSAXTD8CCKmINz1k9Bc1PBWiSCMK4MOn/pl3bKJqsRXWI6+p9
         Gi9jQC7PK0lWpzLL36pkpxPlIJIjActCdJWdF4W3XnR5AM2IoOqolugCFyniqfp9FKY8
         Gf/0vcj8EOhabK2gSjipnElrqAYQOV9PmqyOhZB1L7YG4tDDM4hHZAD5JfMIOsqANmN0
         6Q8w==
X-Gm-Message-State: AOAM5326FDlxnS89NEHL1U/PwBFiLHscbMR0Th5kOqj6VFk/UMnrYAPX
        JaXxd+ENveKiGcvCMWwYRIwCLhWhF7ClVJqb8frBsA==
X-Google-Smtp-Source: ABdhPJxqFrAK9XKNfLSTAKp/DpPKoy3w3eYu+cvQpWHQQxYLJz3gqwv6wMtk9iToYxT4AHG9aUy+iRPRwFP3QOpCpz8=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr2062655oif.63.1649185039185; Tue, 05
 Apr 2022 11:57:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Apr 2022 13:57:18 -0500
MIME-Version: 1.0
In-Reply-To: <CO1PR02MB853729533D004EB671B273BAE9E49@CO1PR02MB8537.namprd02.prod.outlook.com>
References: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
 <CAE-0n51HZKXCtrzf3_5wnoCZfhRoq8AqmUwsdk31iaiteVRDYg@mail.gmail.com> <CO1PR02MB853729533D004EB671B273BAE9E49@CO1PR02MB8537.namprd02.prod.outlook.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Apr 2022 13:57:18 -0500
Message-ID: <CAE-0n51oA99uOu4S3Sywx7FpK1SJKACgX27UN9z2kKP8UfwGOw@mail.gmail.com>
Subject: RE: [PATCH v2] [RFC PATCH] PCI: Update LTR threshold based on LTRME bit
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Prasad Malisetty <pmaliset@qti.qualcomm.com>,
        agross@kernel.org, bhelgaas@google.com, bjorn.andersson@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, rajatja@google.com,
        refactormyself@gmail.com, robh@kernel.org
Cc:     Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (Temp) (2022-04-04 23:24:39)
> > From: Stephen Boyd <swboyd@chromium.org>
> > Quoting Prasad Malisetty (2022-03-07 10:59:09)
> > > Update LTR threshold scale and value based on LTRME (Latency
> > > Tolenrance Reporting Mechanism) from device capabilities.
> > >
> > > In ASPM driver, LTR threshold scale and value is updating based on
> > > tcommon_mode and t_poweron values. In kioxia NVMe,
> > > L1.2 is failing due to LTR threshold scale and value is greater value=
s
> > > than max snoop/non snoop value.
> > >
> > > In general, updated LTR threshold scale and value should be less than
> > > max snoop/non snoop value to enter the device into L1.2 state.
> > >
> > > Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> > >
> >
> > Any Fixes tag?
> No, we don=E2=80=99t have any fixes tag as this is new issue identified i=
n kioxia NVMe only as of now.

Just because you found it now doesn't mean it hasn't been broken for
some time. Can you look through the history and figure out when it
didn't work and use that commit for the fixes tag?
