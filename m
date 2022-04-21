Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3238E50A5F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiDUQjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiDUQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:39:34 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09231483AF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:36:44 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso3621261otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83PXzm6x6eodtfaWWKtWJXEPAymm3hB3+JWzv8XJjRE=;
        b=YZ0zbWZ1qT4B2qeGZYeXoZQOF+2QyAZzlKtV3C4egrQkbWH5zETdeRWRzldys1bPFo
         ih2FXDbV5soqMVuCveMKgAOhTL9bcjrD+li153kj//vfYDSoNUm8crPdNkmT8O7r9SAg
         8bEeXrU6vOM4gv9luI4CP2OQl09e79pCZu8jZ0/DUzPg8ATHDapu3GSk59/Mej//NlUb
         uBJ8jLDO1Gf4qpruJSAXPAQMpraxRBbmsaTj6IFkvpV2vvZP+K+icqfUcNgBLDgJCe8/
         DvGKj5+Guyi6jn2zuaKE8sR86GSiDrrYmjRHDWM4uZadLZFesreOdwtHOok0BHdZVH4j
         z+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83PXzm6x6eodtfaWWKtWJXEPAymm3hB3+JWzv8XJjRE=;
        b=JptExfYwCs0EjYKxffh6q07IlW8QZJqgCReysa9uk0D8GMfX8FFYElV0p1N4LlMs4C
         NAFKdtS6GpKZTHSsMf1aT0FXkMRP984hC75QGN/xMmKrJ35bdApATnobHYfH71xe20eA
         SC0bTqjiY8PO2BA2o93d8lDv2RgilLeoOkNJ0z7Lcuy5LlCY02PhBsy1F8CGj6LJX/ZU
         n1p4dYSQ/tpqBTTnfRqSsWaAE4vm9Due2HeUSt+xvVzaRVfmdAE8+uqdaFT7ZL5FBYfb
         t7hpdY7+GrILipEXyEG6hpGXWVETfgsRzd8MjCiCFm/WIviBI+dc4VfByHDCG6rSokkP
         +eyw==
X-Gm-Message-State: AOAM530SK7OV7X/DNohuIBKCZ6LCX6lxfHOREpEhK/NmK8SLUCTwUDmg
        bnWvKBHxoUuhXxKLr6QPum52cQ==
X-Google-Smtp-Source: ABdhPJwc7/n1sA7lRJ8fymgn0dC0huOPaDGwWhO7t0+WFNHW5yYiUNnYifSc2gzQYpmp/6E0CjYGnw==
X-Received: by 2002:a05:6830:116:b0:605:4e0d:f020 with SMTP id i22-20020a056830011600b006054e0df020mr256809otp.43.1650559003377;
        Thu, 21 Apr 2022 09:36:43 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id hq6-20020a0568709b0600b000e59102e1bbsm1193568oab.22.2022.04.21.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:36:42 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:38:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v12 0/7] Add pin control support for lpass sc7280
Message-ID: <YmGIlZcxmhiegmw/@ripper>
References: <1647447426-23425-1-git-send-email-quic_srivasam@quicinc.com>
 <CACRpkdZKQRnxFjOD9z7iNvRQeM6kGBBopjW7VzFSuj91GYeJOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZKQRnxFjOD9z7iNvRQeM6kGBBopjW7VzFSuj91GYeJOw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 17 Apr 16:32 PDT 2022, Linus Walleij wrote:

> On Wed, Mar 16, 2022 at 5:17 PM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
> 
> > This patch series is to split lpass variant common pin control
> > functions and SoC specific functions and to add lpass sc7280 pincontrol support.
> > It also Adds dt-bindings for lpass sc7280 lpass lpi pincontrol.
> >
> > Changes Since V11:
> 
> Bjorn what do you say about v12?
> 

I say:

Thanks for the updates to the patches Srinivasa!

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
