Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76174B9E49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiBQLEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:04:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiBQLE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:04:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DA02AC8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:04:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw13so6271115ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i9OOHv94Xd7neCD450gXYCpsHR7VGmBdVUV3cKCEacA=;
        b=eDkNAQpKtVWiaXI4ukhGqjxOXlpU7KaMoDBzKQFGJW1xqgjxZ24eBVtsMvBh8/Xb8A
         fumIUauj8FJRju29Gs7tyetRzuiHS2MBfV1z90EVPkntNpl8oDki1XMH/y/Ki5kbn5Oj
         Ih5i/hankt94SPdkMq0hvnA15sa64WnJyJC0uoRa5C/WSEyDE2X4ey2hhZCNMpCOIfNx
         wzvCGtdBVraW9JB0vDR2oQuT3DM6M5acIMJHE7q3nndCb2Z3MNkNaLEqgfHnTy+eVKI/
         xnBvCO3IilH3scc+klKrksioH5LZIDXLRgDILwQMcCJlyMmCZhNecG3h4KvolQfRz3jD
         C6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i9OOHv94Xd7neCD450gXYCpsHR7VGmBdVUV3cKCEacA=;
        b=b1yqVzWZn8mxMa/FAXNalKQAWDA1MxsyZ8lobpgnXVnGciCyR384VvlztP2dOp4x1L
         jnHfRrbW3fWLlwpo1u0DSWGreto587Aj6S0P45y+pn8lqm+u8iVzR3xtmx1KttZEpYqG
         UTAqn3LQnHCBnPN8hO63p0ErNE1mzCDMqh9K7Ey3+DRaqiQtgcVKPitkHOf+cWDjEnqx
         neThHW0lSUu4/187i8PLF3Tb6arOuGGzGGIKsD+1WDJA+7cK0vGPA3QpIxXwBRF0iwMJ
         F/x9OQab6xoBVXtTMXfdPlpN61dBJozJdzAlWStqT1xqys7fPsA2gnoiLDibEQQgsEfi
         ag+Q==
X-Gm-Message-State: AOAM5333sPyHJxKam+0qNxU6bIdMlKiZK6cBtLVRMBt9I+fGMrFOIMZR
        nTYMY2v6ZQpsIY7onBakXmlmVw==
X-Google-Smtp-Source: ABdhPJyDTUq5Ysv2KOy33196hjwWg9hdzis5uUBMswvU59JESphRbM6qToR/CwxsQl0q+Ofm0SyEUA==
X-Received: by 2002:a17:906:2a92:b0:6cd:4349:dc1a with SMTP id l18-20020a1709062a9200b006cd4349dc1amr1871563eje.648.1645095853808;
        Thu, 17 Feb 2022 03:04:13 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id gq1sm1061733ejb.58.2022.02.17.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 03:04:13 -0800 (PST)
Date:   Thu, 17 Feb 2022 19:04:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Will Deacon <will@kernel.org>,
        Marco Elver <elver@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Test 73 Sig_trap fails on arm64 (was Re: [PATCH] perf test: Test
 73 Sig_trap fails on s390)
Message-ID: <20220217110407.GA784778@leoy-ThinkPad-X240s>
References: <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
 <20220118124343.GC98966@leoy-ThinkPad-X240s>
 <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
 <06412caf-42e4-5c4b-c9b3-9691075405bd@huawei.com>
 <20220215143459.GB7592@willie-the-truck>
 <8c582e45-0954-a2ea-764a-4dd78a464988@huawei.com>
 <CACT4Y+Z8pKXw=8nwVtdo2W=hu_rBk1ws-Q=7-tBkLGTcD85NaA@mail.gmail.com>
 <20220216131306.GA56419@leoy-ThinkPad-X240s>
 <be4afed9-9739-26cb-b1d5-0529e0f74221@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4afed9-9739-26cb-b1d5-0529e0f74221@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:53:23AM +0000, John Garry wrote:
> On 16/02/2022 13:13, Leo Yan wrote:
> > > It does and fwiw I am just trying to use it. Things work only on x86 so far.
> > So here we have agreement to disable the cases for Arm64/Arm.
> > 
> > John, since you put much efforts to follow up the issue, I'd like to
> > leave decision to you if you want to proceed for patches?  Otherwise,
> > I will send patches to disable cases in perf.
> 
> Hi Leo,
> 
> I'll send later today.

Cool, thanks a lot!

Leo
