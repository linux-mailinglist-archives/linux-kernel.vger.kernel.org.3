Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E5558B90
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiFWXMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiFWXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:12:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C5527FE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:12:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so1168266ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvH+WCwwww3y35Yzw/6cK3NiQ2zgYQbh9kzZY1PopZk=;
        b=BD0ba7qdsK1G6kW6CFHgWzYQlkQiSHnf6NLG7sdKUUT7Z3FC3EV2LHafLNV3wC5YLl
         Bz2I2ddgL1EQn08kTtDUYBcPq/EUBzB6tHRHqY+C/p6o55o4iHKXb4AD+C8WqypChmJu
         rHzf3OKW5dHOFzTTBqM45JTTxQ9XX+AOHYD/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvH+WCwwww3y35Yzw/6cK3NiQ2zgYQbh9kzZY1PopZk=;
        b=DSLtggPtf2wJn/efzmLHDO/8Bppb5mfKhFKTo7Nc8zR1zNss03L1D3OwyFMCDkC3Ld
         JL3PQniP1iF6llLs7zO+RnW/VTcCcUs9+WDYGNWCRu0CQaElg/WNnIL7EbAxIysay2yh
         3eH6+fDNdsxDxjBhuJz/JgD2FJXt0rduRlUqYwna1h/mKZ1np1gMpalUlvsHaFduJjsG
         6AOglrMInkU0sCnukZVfksc/tKQ5WjU+0N1DfXeT8v4HusEzNAngyMCzzKmdEIOoiOvY
         vOT4mRraNEpFilUYyI73TPba4RRDZfs3Y0LqE+RZOpPeg0xp3/AOXfkbm+8q73b6fIyF
         HsOw==
X-Gm-Message-State: AJIora8w16xyAXywaU0TVIY/Oq6PyOpdSlf6rjNBB3OgObMVZEr5heJ9
        StAX0J31NcfFWFOK5HM/iXIkLze79f0ENHxy
X-Google-Smtp-Source: AGRyM1tYOa4JEDIGxfUFPTbxZYNuU0AUP/U/h7cchbRAQvGzxT91YnIR6CT/XkhJfYFIVtSzvKYF1g==
X-Received: by 2002:a17:906:4e91:b0:722:f996:fa20 with SMTP id v17-20020a1709064e9100b00722f996fa20mr8354838eju.733.1656025923761;
        Thu, 23 Jun 2022 16:12:03 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm625048edw.20.2022.06.23.16.12.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 16:12:02 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id i10so888326wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:12:02 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr10771841wrr.617.1656025921466; Thu, 23
 Jun 2022 16:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com> <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com> <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
 <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com> <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
 <da18c508-f32e-fece-6392-e6a95f7c7968@quicinc.com> <CAD=FV=Wytm9EYu=4ndN+En2AFEgPK9NjrUMbFPA_h6TwyxGCYA@mail.gmail.com>
 <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com> <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
 <BL0PR02MB4564C633F46BBCC315D86322FAB39@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB4564C633F46BBCC315D86322FAB39@BL0PR02MB4564.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Jun 2022 16:11:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoqTeUg9mQLck-fwtFptSqn2eC1htmRkt_b-pih+wqug@mail.gmail.com>
Message-ID: <CAD=FV=XoqTeUg9mQLck-fwtFptSqn2eC1htmRkt_b-pih+wqug@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: minor fixes to get_clk_div_rate()
To:     "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>
Cc:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
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

Hi,

On Tue, Jun 21, 2022 at 10:58 AM Vijaya Krishna Nivarthi (Temp)
<vnivarth@qti.qualcomm.com> wrote:
>
> Hi,
>
> For desired_clk = 100 and clock rates like 1st from below, DIV_ROUND_UP seems to cause missing candidate solutions.
>
> static unsigned long clk_round_rate_test(struct clk *clk, unsigned long in_freq)
> {
>         //unsigned long root_freq[] = {301, 702, 1004};
>         //unsigned long root_freq[] = {301, 702, 1004, 2000, 3000};
>         //unsigned long root_freq[] = {50, 97, 99};
>         //unsigned long root_freq[] = {50, 97, 99, 200};
>         //unsigned long root_freq[] = {92, 110, 193, 230};
>         //unsigned long root_freq[] = {92, 110, 193, 230, 300, 401};
>         //unsigned long root_freq[] = {92, 110, 193, 230, 295, 296, 297, 401};
>         //unsigned long root_freq[] = {92, 110, 193, 230, 295, 296, 297, 300, 401};
>         //unsigned long root_freq[] = {197, 198, 199};
>         unsigned long root_freq[] = {197, 198, 199, 200};
>         int i;
>         size_t n = sizeof root_freq / sizeof *root_freq;
>
>         for (i = 0; i < n; i++) {
>                 if (root_freq[i] >= in_freq)
>                         return root_freq[i];
>         }
>         return root_freq[n-1];
> }
>
> I modified to handle such cases, optimised little and uploaded a patch.
> It seems to work for all the cases like above.

I think it would have been simpler to just change this little section:

/* Save the first (lowest freq) within 2% */
actual_mult = DIV_ROUND_CLOSEST(freq, desired_clk) * desired_clk;
if (!ser_clk && freq <= actual_mult + two_percent) {
  ser_clk = freq;
  *clk_div = div;
}

That was the only bug, right? Then you could keep the DIV_ROUND_UP() solution?

-Doug
