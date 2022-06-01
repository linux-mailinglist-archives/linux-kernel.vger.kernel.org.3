Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E9539B16
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiFACGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiFACGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:06:12 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F572E18
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:06:11 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-f2cd424b9cso860664fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AOE+maVk5InZYmJxq3fFhzfqd22A3DYPkKeLdVjuAXk=;
        b=f418KBsuUtPiY0sjTEprLPFRqYykXYxhDm3pCbzhRk0tBeu2jD9ibbibHZNVHnhd8i
         uC8Rjv7AS1geBjT2NNE1+sUcZYazcFXFchxAUW8ydsGAZC8v2OMmSAg393T8YOzZGBwD
         oxueJieo+f0E9wLol0w8P9QBTTCx2n1SUhbZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AOE+maVk5InZYmJxq3fFhzfqd22A3DYPkKeLdVjuAXk=;
        b=f47jpY8UBrcY1WZidJ6D4VO+fmbiaOJLI3P51gZCAZJ0SyxC3ZMjhio4i3D6htGrm6
         jZHDf5SCTnziFuI/yVDfLSVJSTyVPvCWYgujyJmPlN4G59EPDKAA8zKqJ+O6VlBAZp3f
         X/saKIm0m5SDBMzahqEGkNBM4+fSjf2XRwHMLSmPoMFKZjCIQml6rlOrwsZ98xt8n4uW
         V+MOVIfRvgqtfsiOXWf6/e5sIlZKcX3jh/4akzfmS1cKYL6EjQK0d41HW+zNSpEm+ElZ
         C65MmtCmfl5bYdpUSdfJaYLLEIuL3GJ1wl2zk0tue+Wq6dLi96JVJBbISuB11zDRj8LX
         XxFg==
X-Gm-Message-State: AOAM530wp1QupJyI9MvKmcyFNpNu2yQSAOIpo/NazvJA+BqSnCH8xAaL
        kG4TR2z1b9/jbAigC1Mz6a3W3YnOF2y7yBVIdqwsjQ==
X-Google-Smtp-Source: ABdhPJzu+uxIbiEpXSSvXqOR1ScFSqXQ+1eOAxLwujTyveBbGBmycq4fzS+xsM0gn91chDVuTC4ooQ4KFJJEREQ22+Y=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr15376480oao.63.1654049171244; Tue, 31
 May 2022 19:06:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 May 2022 19:06:10 -0700
MIME-Version: 1.0
In-Reply-To: <4b9a2abe-c462-81d9-2098-d430da24f030@quicinc.com>
References: <1653043777-24003-1-git-send-email-quic_c_skakit@quicinc.com>
 <1653043777-24003-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53WLYR1pjnr6wASVmXXQ7xTq5n2Q7GdeKOCkWf4H4n=0A@mail.gmail.com>
 <e70aceba-02d5-15b5-46d0-d5ed5706e81a@quicinc.com> <CAE-0n539gePyXhw7r+XcaHtooN98KfYsx_qwgDaFkJtMSg+80g@mail.gmail.com>
 <4b9a2abe-c462-81d9-2098-d430da24f030@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 31 May 2022 19:06:10 -0700
Message-ID: <CAE-0n529AD8OKrxbTpDNqR7Gw9SdCnJyWtiWvZAsADQKgj4kxQ@mail.gmail.com>
Subject: Re: [PATCH V13 7/9] regulator: Add a regulator driver for the PM8008 PMIC
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya Kakitapalli (Temp) (2022-05-30 03:33:47)
>
> On 5/28/2022 2:32 AM, Stephen Boyd wrote:
> > Quoting Satya Priya Kakitapalli (Temp) (2022-05-27 01:24:19)
> >> On 5/21/2022 8:26 AM, Stephen Boyd wrote:
> >>          +       }
> >>          +
> >>          +       pm8008_reg->dev = dev;
> >>          +
> >>          +       rc = of_property_read_string(dev->of_node, "regulator-name", &name);
> >>          +       if (rc)
> >>          +               return rc;
> >>          +
> >>          +       /* get the required regulator data */
> >>          +       for (i = 0; i < ARRAY_SIZE(reg_data); i++)
> >>          +               if (strstr(name, reg_data[i].name))
> >>
> >>      Why not find this via reg/address instead? It would save storing the
> >>      regulator name in the reg_data table.
> >>
> >>
> >> You mean match this using base address? then we should add base address in the
> >> reg_data table. We will need the name to be stored in reg_data table anyway for
> >> the pm8008_reg->rdesc.of_match
> > Why? Now that this driver binds to each node individually the usage of
> > of_match doesn't make any sense to me. Can you set 'struct
> > regulator_config::dev' instead and not set of_match?
>
>
> Currently we are setting regulator_config::dev as dev->parent i.e.,
> pm8008@8, because the parent supplies are present under pm8008@8, to get
> the regulators mapped correctly to the parent supplies we are using
> dev->parent.
>
> If we do not set of_match in regulator descriptor,
> regulator_of_get_init_node() would return NULL, causing init_data to be
> NULL during regulator_register and regulators are not getting probed.
> This can be resolved, if we get the init_data during pm8008_probe
> itself. I'll do that in the next version.
>

Ok then it seems ok to leave it as is. I suspect getting init data
during probe is more code vs. having the node name and the address in
the table.
