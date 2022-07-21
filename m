Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7924657D348
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiGUS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGUS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:29:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C568B4BC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:29:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id os14so4628094ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HwUsGLRpMv31IoKhe6aFZhAJeU1EkSbKNMjO7y+3gIo=;
        b=aLmdooI7aEU3//m4BQ6o/XXcpWaZ5+5a6zyCBNi3zi0O0NiHxICF6FpCTsdkxf2h+1
         dfUoYQT30805peQUM3uo5AZCSrMFbQjucVADyl4eDrvayM07weIpS36apUqMeqC2mSEW
         KM8R1cyxxOqmhN7DpLwKFicbiErjwJfyQYBbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HwUsGLRpMv31IoKhe6aFZhAJeU1EkSbKNMjO7y+3gIo=;
        b=zD4eFeORkMdlkNJYDcLuphxYdOQ7Pic8nUjogiVmBNpRek5gdLULpPssZq+SDJ5WF/
         q5g+vWBpTEMV1HpOXPxELYI1zTp6tPsusACjRf/uV/je9BxSpRTv2CC/4rfS125HJFH9
         2m88a+lST2m5W2EuOeFyflasRVPieSTzOsJUCxCSH5eDHMdytcYX+yVoX+LvZLZNxjdX
         vbNMARyPf7DrKfj3DrfczysDxmZ4fwzt7nAhUKzqYVr10NSbl1Uo8lxTK40fizIpyFPx
         KTakemN29QuPC265LRN8LDynCBG90OrX/SWyW81lfYh2H6JeImPSKcSlPzDHaPIbzGvW
         z9vA==
X-Gm-Message-State: AJIora+BazL/ifXbQYolIfnlSjPVvhXHkCHJqs7nJ6+PB9egn0joAlMy
        cIQNWJ8pmKQtDtMmhVTcw3qDi7co0aDIxPuwf6U=
X-Google-Smtp-Source: AGRyM1tmv3Mp9O2jXjdJD2/hmdyatbSJAxsBkyNEq71d2gj77Qiks042Wg9kI/sK3fnKEG1fRM9b5A==
X-Received: by 2002:a17:907:2808:b0:72b:50cd:2c8a with SMTP id eb8-20020a170907280800b0072b50cd2c8amr40023882ejc.246.1658428171124;
        Thu, 21 Jul 2022 11:29:31 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b00704757b1debsm1114563ejf.9.2022.07.21.11.29.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 11:29:29 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id h206-20020a1c21d7000000b003a2fa488efdso1264446wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:29:28 -0700 (PDT)
X-Received: by 2002:a05:600c:2e48:b0:3a3:1ce3:3036 with SMTP id
 q8-20020a05600c2e4800b003a31ce33036mr8955194wmf.188.1658428168451; Thu, 21
 Jul 2022 11:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
 <20220721033918.v3.2.I7ecbb7eeb58c5e6a33e32a3abf4d6874e6cb725c@changeid>
 <CAD=FV=WSBgupLFMCZgianck6uTkAyqrG0WK2ChSbNbJdhOPdLA@mail.gmail.com>
 <4b2fe9d0-f590-0fac-79fa-bb05da1d61df@linaro.org> <CAD=FV=XmaNdc9k98vAwbcN-sm0w_WeqhRsK_AUm3h4LZ5-egmQ@mail.gmail.com>
 <c2b03863-2249-13e6-98e0-731c1b40d0a9@linaro.org>
In-Reply-To: <c2b03863-2249-13e6-98e0-731c1b40d0a9@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Jul 2022 11:29:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XKC_fbBzna8TgiPRmPH_=AQ3ckv2EEjoNvayKQ83Uciw@mail.gmail.com>
Message-ID: <CAD=FV=XKC_fbBzna8TgiPRmPH_=AQ3ckv2EEjoNvayKQ83Uciw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: qcom: Document additional sku6
 for sc7180 pazquel
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 21, 2022 at 9:52 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2022 18:43, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jul 21, 2022 at 9:33 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 21/07/2022 15:37, Doug Anderson wrote:
> >>>
> >>> Not worth sending a new version for, but normally I expect the
> >>> bindings to be patch #1 and the dts change to be patch #2. In any
> >>> case:
> >>>
> >>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >>
> >> I would say worth v4, because otherwise patches is not bisectable.
> >
> > You're saying because `dtbs_check` will fail between the two?
>
> Yes

OK. Then I assume you agree that reversing the order of the patches
won't help, only combining the two patches into one.


> > How does
> > flipping the order help? If `dtbs_check` needs to be bisectable then
> > these two need to be one patch, but I was always under the impression
> > that we wanted bindings patches separate from dts patches.
>
> I don't think anyone said that bindings patches must be separate from
> DTS. The only restriction is DTS cannot go with drivers.

I have always heard that best practice is to have bindings in a patch
by themselves. If I've misunderstood and/or folks have changed their
minds, that's fine, but historically I've been told to keep them
separate.


> Bindings for boards go pretty often with DTS (subarch). This is exactly
> what maintainers do, e.g.:
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=arm64-for-5.20
> Bindings for hardware should go via subsystem maintainer (drivers).

OK, fair that in this case both the bindings and the yaml will land
through the Qualcomm tree. I guess it's really up to Bjorn and whether
he'd prefer "make dtbs_check" to be bisectable or whether he'd prefer
the bindings and dts change to be in separate patches from each other.

-Doug
