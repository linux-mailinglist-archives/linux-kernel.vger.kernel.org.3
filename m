Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD94D0D04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbiCHAvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244318AbiCHAvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:51:16 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CFE2AC4A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:50:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kt27so35820871ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbJpaOu/7xZ/bf4UCikgzAXZOJfFrMxYSG2Z5vNrDBI=;
        b=nQOEm1XQrASHzLPWYSNKp5uxS7raV2Xrr/QL60mtFRq0HPSH2fwlhXHItduWmhqhRg
         gUC031MpBStyvBQ2jZR+bEUfDR2p9p37sv4oJUX86m3P+8Iq+4RhT3+BTyyp4DGshE9D
         KDVfXeHGjIt9j8FdMfsI7Gf0IqudwdFPWuyJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbJpaOu/7xZ/bf4UCikgzAXZOJfFrMxYSG2Z5vNrDBI=;
        b=vQbHIa4zhnLeaWYrB4worYETX2jxgPGx9jB1ga/tcyh3TI3V9/PklSOMB1WauQOXeK
         vghFGcuzrypAcpbm6UtFNyIal3WcR2sAMK8O/hR5VKJCfO9GccPEWh4xNc42THIkFZKs
         GH9xDcHeRJ8U6CHpihf2NXH74YMjzShGzeDQRyVhLBhN3HuKFyHhHI9CD5XPjxOiB94O
         1m60NrRi2/z9RjNSqszHQ39uLincIDfMn6GeGi9j6XVLrk7n2+cE4chEUVzcV+lMHcQI
         qzsyNqOw8bzELYtd9KIo73yE+HFZnQaqYIQGmf+y5QgKunluPgbIthFxuFRi+8xG2v5b
         /mOA==
X-Gm-Message-State: AOAM530scj20tzTcMc9dkR4jumRS/Ujha35io7TaVMnNBzoX5jSQwEzp
        uX+gwqSKzKT3WorrC7rtSwipl2lbikK1L1iN
X-Google-Smtp-Source: ABdhPJy6YUxYHvnUQ+d1s9gwsIZvd7Sx4Pkj73AnSGrSsw6eTHnJqsJHNeyBkn/oIm9C2+AgVpUidQ==
X-Received: by 2002:a17:907:7209:b0:6da:9781:ae5d with SMTP id dr9-20020a170907720900b006da9781ae5dmr10729829ejc.73.1646700619704;
        Mon, 07 Mar 2022 16:50:19 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709060e8300b006d0e8ada804sm5217770ejf.127.2022.03.07.16.50.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:50:19 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id bi14-20020a05600c3d8e00b00386f2897400so449628wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:50:18 -0800 (PST)
X-Received: by 2002:a7b:c0c1:0:b0:385:be1b:e6a with SMTP id
 s1-20020a7bc0c1000000b00385be1b0e6amr1277359wmh.73.1646700618519; Mon, 07 Mar
 2022 16:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20220110231255.v2.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
 <202201110851.5qAxfQJj-lkp@intel.com> <CACTWRwtCjXbpxkixAyRrmK5gRjWW7fMv5==9j=YcsdN-mnYhJw@mail.gmail.com>
 <87y23is7cp.fsf@kernel.org>
In-Reply-To: <87y23is7cp.fsf@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Mar 2022 16:50:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W-kJQwBPStsGpNu09dN+QHTEZOgb5sZwZYzWnn_Zhv4A@mail.gmail.com>
Message-ID: <CAD=FV=W-kJQwBPStsGpNu09dN+QHTEZOgb5sZwZYzWnn_Zhv4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ath10k: search for default BDF name provided in DT
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        kernel test robot <lkp@intel.com>,
        ath10k <ath10k@lists.infradead.org>, kbuild-all@lists.01.org,
        Rakesh Pillai <pillair@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle,

On Fri, Jan 14, 2022 at 6:46 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Abhishek Kumar <kuabhs@chromium.org> writes:
>
> > On this patch I have a kernel bot warning, which I intend to fix along
> > with all the comments and discussion and push out V3. So, any
> > comments/next steps are appreciated.
>
> Please wait my comments before sending v3, I think this is something
> which is also needed in ath11k and I need to look at it in detail.

I'm wondering if you have a timeframe for when you might post your
comments. We've landed this patch locally in the Chrome OS kernel
tree, but we are always also interested in it landing upstream. If you
have ideas for a path forward that'd be keen!

-Doug
