Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F974EE337
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbiCaVUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiCaVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:20:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C51277E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:18:32 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d39f741ba0so604237fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5tewtVH4AG8KY8Zi+lKOWP3q7/lgqF7baGpu82kuyIY=;
        b=HO/XidmOh6O1mLaZzRwaAWMD0ksLSqOqNih/0cePtCkm2XfI0APg5sbKHiY3iYDGOp
         n7hMPpU71o8VdW7qv+/U31BxUhJAGl0zjsBIfAhSLlhrvqyOh3AIPha1kEh6Zaed5Ekv
         dSzISimULrt7G8ZyRN8LfeKEgbxly/wdrwseY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5tewtVH4AG8KY8Zi+lKOWP3q7/lgqF7baGpu82kuyIY=;
        b=zbqKC8kNfJBAW89EGJ9xHpa3irgFKm2TDFIq2VMsBV5LbWgmGHJ47Yb+Ocy4mArPoj
         rkuoAnY9zA4O93TZQYORQKdDyMzZpyxHLA4twpIYFUsz6Kg6+NmeZ0CoZU/19akTlb5q
         Xgo1rOxxwTNd/FUs9sTZP2dkk1P0ZXjYmAh5zeZbRGIAoMGP+6umBe+hJOT/4CZiT67t
         30QE7/NP8hbUb+P15RdMyZgegBU1PAFMjf+GudyhOA6452UEDHI7saYIWp9FNfY/gUnJ
         bTESwYfMeBeB6kqUz/+cTRe40R0vF7zUSR7+OkCo7oEY8IFmeH5bx4iZmexvd0xRFE6J
         YNfA==
X-Gm-Message-State: AOAM532b2LOH6x2vKBFdk212J6QNceY/D2qfS9lZEiJ5BB2j8Rzd2pLz
        jUxQLEVa9DciYE6000seM+NWXp8D0q7UXjW/1ievAg==
X-Google-Smtp-Source: ABdhPJzMwsXdxTR0m9DYSxxmGH1ubNPKIIiNyFd3yZQzwSM5ILbKgnGh4kEAwRu0jrUAIArl5nrbGYO2Ot1jNJJJzW0=
X-Received: by 2002:a05:6870:46ac:b0:de:5d48:9d27 with SMTP id
 a44-20020a05687046ac00b000de5d489d27mr3646771oap.63.1648761511849; Thu, 31
 Mar 2022 14:18:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 31 Mar 2022 14:18:31 -0700
MIME-Version: 1.0
In-Reply-To: <094d8faa-c42b-be1b-cf92-04232d618a3e@quicinc.com>
References: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
 <1648209491-30165-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n511eQTnJHqt0B=uiiSjigy-RHZ52YuYz4kfEpX1x6CMfw@mail.gmail.com> <094d8faa-c42b-be1b-cf92-04232d618a3e@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 31 Mar 2022 14:18:31 -0700
Message-ID: <CAE-0n52CVuc_kQbpwEnHEEODS8jPt52v6P=gAdVxqenPu4ehkw@mail.gmail.com>
Subject: Re: [PATCH V8 7/7] arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
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

Quoting Satya Priya Kakitapalli (Temp) (2022-03-30 03:44:01)
>
> On 3/25/2022 11:18 PM, Stephen Boyd wrote:
> >       #include "pm8008.dtsi"
> >
> > and then the nodes below.
>
>
> You mean
>
> pm8008_bus: &i2c1 {
>
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 status =3D "okay";
>
> };
>
> &pm8008_bus {
>
>  =C2=A0=C2=A0=C2=A0 #include "pm8008.dtsi"
>
> };
>
> and remaining nodes, right?
>

No. I meant what I wrote.


       &pm8008_bus: &i2c1 {
               status =3D "okay";
       };

       #include "pm8008.dtsi"

and then the pm8008.dtsi file would have

	&pm8008_bus {
		pm8008: pmic@8 {
			compatible =3D "qcom,pm8008";
			...
		};

		pm8008_regulators: regulators@9 {
			compatible =3D "qcom,pm8008-regulators";
			...
		};
	};

and then this patch would modify those nodes with phandles.
