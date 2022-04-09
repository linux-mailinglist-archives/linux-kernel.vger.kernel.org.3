Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F924FA0EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiDIBIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiDIBIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:08:14 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5728E31
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 18:06:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p21so12594173ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KTg8PibcC8KQTgPBqCOsiC3mDCYVERkDcQnsHvYI9I=;
        b=PlFXj0irn77GOUGppxUMOrj5Hf8SW7F+QH+5hFPzJA4Ayryp5TsXijQV+Yocm3Mf69
         SxzfPnQ6Ks07h+kryRHAXafNXA2GJDi6pPDkPaL9PyuddbQw4W2skzJV5djaC2zi5spf
         7TJC1kRisK/n1XLcr61EuxSWU8AjO9wUxJLZrwL+XglcG95hUdDu02AQxhl98flbAXx5
         knwUfIDKQ+1tBIUt32nP4XtiOV7hVoIMYn+PVKJ8iHq6YpwGB8U8rQ/kb/Lk7k2gebzd
         WHyaYhd9nWuBHxE76QzM26ojDh2PAzob3bjO03FAGmNnRIO3n2ri/qWWd7WHlbUVY1oU
         BHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KTg8PibcC8KQTgPBqCOsiC3mDCYVERkDcQnsHvYI9I=;
        b=CuLqGJV945njfOzLRp7grcsNNPRXk+Dii3rhIvdyL2z2lymDmnpsIrOCPYfOAWj9r/
         RZGtpXk5PFG/joxYbWCSXazqc5mk/3uQqLmZiTuh/nWRxSpfqCvzoUsuCFkJOWNj0Cna
         RBBEagv/ntFcWZ4culOvjMDLGwXY/zzJ7XYZmrtdmSlAx1TpXa+BH6zx+oFfGcRVl0Fx
         MHueOcP884y43JJRBGXpmH7YxOkw+dqPhbl95gY6pa/oMR3VQtSsGRxMGL87fg0sMdRY
         dTNZz+e06AitD3ufuohPPgvrZ1vxF3HWtVlM+KuC6yKCXbVDsZ08Z6iCtePcIs6yLxRz
         kciA==
X-Gm-Message-State: AOAM532Gz6Ji2gNuT01qO0YWqj7iiWqi9GW5l3EYtEkfkgmaPns0sjkZ
        QaU1UtI9LNbYjYLrRWlu8TxNagetnl03W1jgQWuvtg==
X-Google-Smtp-Source: ABdhPJwWV1PbV74ls5FpClgb/DYi825MGm4/TudHWERdAAPIAc2vwYZYHR2MnU2d/hDKv3+J9rr4iNnh56SL2eHKdaA=
X-Received: by 2002:a5d:898b:0:b0:649:5bbb:7d95 with SMTP id
 m11-20020a5d898b000000b006495bbb7d95mr9371853iol.107.1649466362417; Fri, 08
 Apr 2022 18:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com> <7h5ynj5lhc.fsf@baylibre.com>
In-Reply-To: <7h5ynj5lhc.fsf@baylibre.com>
From:   Hsin-Yi Wang <hsinyi@google.com>
Date:   Sat, 9 Apr 2022 09:05:36 +0800
Message-ID: <CACb=7PVu6Rt3giBW78LWtkM=9xV6JzZgFSKOmUNx_26O0Wvowg@mail.gmail.com>
Subject: Re: [PATCH V2 00/15] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tim Chang <jia-wei.chang@mediatek.com>, roger.lu@mediatek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 5:11 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
>
> > Cpufreq is a DVFS driver used for power saving to scale the clock frequency
> > and supply the voltage for CPUs. This series do some cleanup for MediaTek
> > cpufreq drivers and add support for MediaTek SVS[2] and MediaTek CCI
> > devfreq[3] which are supported in MT8183 and MT8186.
>
> There's no upstream DT for MT8186 and there are no OPPs defined in the
> upstream DT for MT8183.
>
> In order to test this on mainline, could you provide a patch for MT8183
> that adds OPPs to the DT so this can be tested with mainline?
>
The DT change used in the downstream kernel is from here:
https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-9-git-send-email-andrew-sh.cheng@mediatek.com/
Might need some update (eg. add the cci property in cpu) though.
Rex, you can also include the 8183 DT change in the next version since
most of the mt8183 dts are in the mainline.

Thanks

> Thanks,
>
> Kevin
