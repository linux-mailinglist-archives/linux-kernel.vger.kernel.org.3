Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094DD58D141
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbiHIANw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiHIANu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:13:50 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089ADF7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 17:13:49 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso7558526otv.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 17:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=kW3fIbHIYupxFutuFacuIfK5nAp/xhvWdF2dTNBXnwc=;
        b=JV3/K4ycsvpnX/sRbSuaJlD+dXLTfADOOideh4/JL6MFyF6uIWCi/VvPvaUZrHD/zR
         CkL/rJokC4pgwESEVruaIN3uY3tQYoiASS1WdBowlP1tsvn0ShY4mECYgzaHWlIb1BUE
         FMjp0WGejEY9jD9hJ6UTXxJHKb75uX1AFtUfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=kW3fIbHIYupxFutuFacuIfK5nAp/xhvWdF2dTNBXnwc=;
        b=Nzqhk4QAB3KjMJ0cT0QeMDnnAxjR0dfW0xVZBz1jIBPE67bz2/6XBoq3rrzQnb3D/K
         mXVPbtJedNBxDvXqiP4iuAfuc4/3v96cYXE3W1TebADOjI7imOlgsHspLS/Eq43+N+Q6
         J2ZC6qRpy3ZbIv3xAp4c01FY3fDMrKdETX3rH3uEyy5fJMFgnWncr3NIC8Jdj+J7NwBe
         lxEpLdBPMDqc0OsGrAmgnA4DXxAnteIFXpCXjMJKe+6ItPQdMiLfzswR0wwy44QP6Tj3
         ZPrGw7ZkTqIdc7WI8BcxU5Gdu4jh3CsKqPNC5z76Vho/bWHI4QROZUZgR3+ArxOn0qzm
         kEog==
X-Gm-Message-State: ACgBeo39FiLfjM5dxeXH881YsFF0O4T8Sse+UjBVuXJWo7rkxjIX61u9
        eSUyplrrVvZSIb4reuOObYyqT2bd1cEB64hzSnKRcg==
X-Google-Smtp-Source: AA6agR6IaK6tGmfxiic3VErOMlGfP21fXmWaZqXy9GVcbngzsk5DWEguMMnlsICPM2Hq0dikDa9V3kzk+RrnrLECQXE=
X-Received: by 2002:a05:6830:1d88:b0:61c:8b2a:22b0 with SMTP id
 y8-20020a0568301d8800b0061c8b2a22b0mr8048845oti.3.1660004028333; Mon, 08 Aug
 2022 17:13:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Aug 2022 17:13:47 -0700
MIME-Version: 1.0
In-Reply-To: <e28ef7e2-c23a-f87b-09b2-958f2212c30e@quicinc.com>
References: <1658316144-16520-1-git-send-email-quic_c_skakit@quicinc.com>
 <1658316144-16520-3-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53wdhH2P729KDDbghScCcU=4-sFmxVugyJgxmGeFs4mgw@mail.gmail.com> <e28ef7e2-c23a-f87b-09b2-958f2212c30e@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 8 Aug 2022 17:13:47 -0700
Message-ID: <CAE-0n50qou6zy6E=cDafMi6RknMjtVgDiBnbeVE+tNTj-JLshw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
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

Quoting Satya Priya Kakitapalli (Temp) (2022-07-26 22:51:08)
>
> On 7/27/2022 6:52 AM, Stephen Boyd wrote:
> > Quoting Satya Priya (2022-07-20 04:22:24)
> >> From: Taniya Das <quic_tdas@quicinc.com>
> >>
> >> The lpass audio supports TX/RX/WSA block resets. Also to keep
> >> consistency update lpasscore to lpass_core.
> > Consistency with what?
>
>
> Hi Stephen,
>
>
> We got a comment to change this on previous posts, to keep consistency
> with the other nodes like lpass_aon etc

Can you make that change in a different patch? Then the focus can be on
what the patch subject is about. You're not changing the same lines,
right?
