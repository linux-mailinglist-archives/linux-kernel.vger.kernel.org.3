Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2AB50FC90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349789AbiDZMOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345832AbiDZMOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:14:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABC2B263;
        Tue, 26 Apr 2022 05:11:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j4so7046118lfh.8;
        Tue, 26 Apr 2022 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+br903NyR21SWcl5ZBYljZ4f/K9hAeZr6fd2QjmU5dg=;
        b=CHo1L/KX7xn4SoMbiy9RDHjSQAPaRWJLm5xaIm4BBnh/tHzkR0sLtPG+KVOGJKXLeR
         oFID5joPA23943rTS5KMdZ71Fee3/CIzkWJLVj0oVZMAniHFa01fjCmsnkHaiUH/GiAm
         pmf04jKdegcmKsH2PAz5mvQqMqHEixN+QwHPcfrYUDVEQv5MuREfi4fr9zbNfWEdkQ+K
         7W/ZJW8SLxdu++MeRrpXopsi8yAfWnWmqif+yTKrEA3/F7VJ8aq57tJ3RjqMzlYRxfsv
         CxfCMnmRsMrje5x/wzDyZK8/GmAsmIQ1Bp+ka7Up/pPspM2Cr/6hiqhd0Iis+1+Vu+yp
         X4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+br903NyR21SWcl5ZBYljZ4f/K9hAeZr6fd2QjmU5dg=;
        b=BXAwC2+14awJGtvEL0PZtUCfoPKXgNSBRGo9s13UayxEUi7aUiFZYZv318mPtmv1zO
         esnG9/wc+PVprg1D1/siDqWd/SxiTBf3Tohn6hf9M35mA8MeAaGtb/Y7YlyECqlCENwP
         EuQcl7sMsCQlzVPxfOxkSLv976KdRUCxmaDSsyHy53dG61tvZDFxXQ8+Zx2h+OB6i+nS
         qfoiXGzVz4tdICtdfkIie0wh7PXBo0DqGvmG4e7vLnXsEqenI3TOlEfQVllQkb6tY+wT
         YVU/KQOoBUtLFaR83o41AWnSB0B4vQ9NtWjzBcnw0z5giftX+GeMOWNaJpM0VJQgwgcT
         FyoA==
X-Gm-Message-State: AOAM530dzQdnaURnLWHhhH6UdThimJ8qDSNz3o6PKpAbO8EXgOuUrd7t
        QtjctZ3uwmHjsQk1WB+w87UKr79O/o7omUIrj6g=
X-Google-Smtp-Source: ABdhPJyLpraVSr7neLRx56WSV8K57TlMP+eMZTzwqc5iJ01FjCyox3tzTCGQoWOp8lpw+zqaJRYAqWeFz9w16iopdUk=
X-Received: by 2002:a05:6512:400e:b0:450:e09d:c9a6 with SMTP id
 br14-20020a056512400e00b00450e09dc9a6mr17559078lfb.243.1650975092062; Tue, 26
 Apr 2022 05:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220426105511.53010-1-patrick.wang.shcn@gmail.com>
In-Reply-To: <20220426105511.53010-1-patrick.wang.shcn@gmail.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Tue, 26 Apr 2022 20:11:20 +0800
Message-ID: <CAGcnep85Lqta6EtAjKXvaEPySRdiep3YesVgEp75i+NmE52n+A@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: ftrace: avoid tracing a few functions executed in
 stop machine
To:     paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, jiangshanlai@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[These two v3 mails are duplicate due to some network issue. Please ignore one.]

Thanks,
Patrick
