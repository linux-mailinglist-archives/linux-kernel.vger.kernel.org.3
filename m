Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2833F564140
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiGBQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiGBP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:59:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D7BC80
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 08:59:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a4so8688546lfm.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=Hz75Rx42oXHh7NmNLOTnnxJGcRdhgiXUHBkENH9MqHA=;
        b=t49DnnFkz+tH5eJrrVIDW1KUvaQG95jWIXLzQMKIvbpBvqNP3Roy+FMPGCu/PNyv2w
         p8pOjYWUSSBJ0Csnt61ODgx79ahGzcV7SPqLtzBoc60unYg+cbcKwQokXJNSqKXO66Uw
         AHciOKECs0eKerATKAPzaFm+6FKQkVmrjGYC5++MgFLUSWQHeTahilNBL634VEFgYFva
         LnAMjDrbcLNcYi45ctSY8kTB5rdraekMug3H4ePgfW6lWDBFVdJUmKSOSclc32TvVC7s
         ygN6y1TrlItsam5I6MBw8WUWLvdkpeFniEX9P/M9Vnc9GHq1IiXHj89dhChCv0jVrToL
         WxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=Hz75Rx42oXHh7NmNLOTnnxJGcRdhgiXUHBkENH9MqHA=;
        b=eWzxWOGeFFsEz+cJmO2bOmasdfHbnv7zWFO2wrCGBtK6X9CEUN2cqEKlWbfsS9m3/7
         XFM5YJL+wAXwyfJ/ljn7XAM9Q2lo6sk8ytdvCIowt6XE6yRGtCv1ldcAdtGGe+vNmzuk
         aEHEPLJ9kEqTXw5jjsJW5EUyq83fbJgoSs5hrCvAse/q+g/yCdeUrjHrgqxFX/Cxn+LR
         ocrHz9XDwDKxiXqSTsZL9ECBLztAL0m4Qh5aqmlkIoFowg34mYwJf4nvJueLZKMF40/7
         YtWoIKwp4/BxuerN0/LMflAKl6N/XvXRD2IsD/YpEx1VEFUdV/w71Q9Yvfja8LNqlzth
         4oig==
X-Gm-Message-State: AJIora/dqAUP3whbjvf7Q5zziVkc1Y6BRgE5Rg3EcZmfZ8tjRL0EN5qL
        +Pp3qqpZtVPPm3nIA42dxqGaxU3HtCHQrw==
X-Google-Smtp-Source: AGRyM1tHO8HVvetVfAh0h/jVYaKiWK6Ez13CzIyaZGdFPjFEl84NdJBoTUuNYZcZFE0ahUNr+LAMpQ==
X-Received: by 2002:a05:6512:2216:b0:481:1ed5:5a72 with SMTP id h22-20020a056512221600b004811ed55a72mr12427813lfu.142.1656777595238;
        Sat, 02 Jul 2022 08:59:55 -0700 (PDT)
Received: from [127.0.0.1] ([94.25.229.203])
        by smtp.gmail.com with ESMTPSA id v6-20020a056512348600b00478f2f2f043sm4165446lfr.147.2022.07.02.08.59.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jul 2022 08:59:54 -0700 (PDT)
Date:   Sat, 02 Jul 2022 18:59:48 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh@kernel.org>
CC:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        "Gross, Andy" <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/1=5D_dt-bindings=3A_mmc=3A_sd?= =?US-ASCII?Q?hci-msm=3A_Fix_issues_in_yaml_bindings?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAL_Jsq++gOUymWFf6RwoRuqCFkd9XUNqyo-17QU-UQ-o+TXLtA@mail.gmail.com>
References: <20220514220116.1008254-1-bhupesh.sharma@linaro.org> <CAL_JsqLxXLFjre9h2dyoUJ=f0+pueUhSYezx_5bZ2SdpDt29xw@mail.gmail.com> <D42FBBDC-A6BA-4374-A726-061A4478D4C7@linaro.org> <CAL_Jsq++gOUymWFf6RwoRuqCFkd9XUNqyo-17QU-UQ-o+TXLtA@mail.gmail.com>
Message-ID: <36C2A924-3697-42FB-8C14-8E6E163558F2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 July 2022 18:22:19 GMT+03:00, Rob Herring <robh@kernel=2Eorg> wrote:
>On Sat, Jul 2, 2022 at 3:14 AM Dmitry Baryshkov
><dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>>
>>
>>
>> On 2 July 2022 01:06:48 GMT+03:00, Rob Herring <robh@kernel=2Eorg> wrot=
e:
>> >On Sat, May 14, 2022 at 4:01 PM Bhupesh Sharma
>> ><bhupesh=2Esharma@linaro=2Eorg> wrote:
>> >>
>> >> Rob pointed some remaining issues in the sdhci-msm yaml
>> >> bindings (via [1])=2E
>> >>
>> >> Fix the same by first using the 'mmc-controller=2Eyaml' as
>> >> 'ref' and thereafter also fix the issues reported by
>> >> 'make dtbs_check' check=2E
>> >>
>> >> [1]=2E https://lore=2Ekernel=2Eorg/linux-arm-msm/YnLmNCwNfoqZln12@ro=
bh=2Eat=2Ekernel=2Eorg/
>> >>
>> >> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings =
to yaml")
>> >> Cc: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>> >> Cc: Rob Herring <robh@kernel=2Eorg>
>> >> Cc: Ulf Hansson <ulf=2Ehansson@linaro=2Eorg>
>> >> Signed-off-by: Bhupesh Sharma <bhupesh=2Esharma@linaro=2Eorg>
>> >> ---
>> >> -> This patch uses the dts changes sent (here: https://lore=2Ekernel=
=2Eorg/linux-arm-msm/20220514215424=2E1007718-1-bhupesh=2Esharma@linaro=2Eo=
rg/), for fixing the dtbs_check errors=2E
>> >> -> This patch is rebased on 'linux-next/master'
>> >>
>> >>  =2E=2E=2E/devicetree/bindings/mmc/sdhci-msm=2Eyaml    | 52 ++++++++=
++++++++---
>> >>  1 file changed, 44 insertions(+), 8 deletions(-)
>> >
>> >There's another issue with this applied:
>> >
>> >Documentation/devicetree/bindings/mmc/sdhci-msm=2Eexample=2Edtb:
>> >mmc@8804000: Unevaluated properties are not allowed
>> >('operating-points-v2' was unexpected)
>> >
>> >Should just need a 'operating-points-v2: true' line=2E
>> >
>> >This won't show up until a fix for 'unevaluatedProperties' handling is
>> >applied=2E But first I need all the issues fixed=2E
>>
>> Could you please add a dt-validate (?) argument so that we can validate=
 new schemas with unevaluatedProperties working as expected, while keeping =
default behaviour intact (while it gets sorted out)?
>>
>
>I think that wouldn't work well because the schemas have to be
>reprocessed when such an option changes=2E Though kbuild does look for
>command line changes=2E=2E=2E
>
>In any case, I'm going to commit this to the main branch in a few
>days=2E There aren't many warnings left=2E

Ack, thanks for the explanation=2E


--=20
With best wishes
Dmitry
