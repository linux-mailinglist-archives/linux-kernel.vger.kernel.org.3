Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3605AB8DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiIBT35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIBT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:29:54 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420AB58523
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:29:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c20so2241057qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=IMZh5xqdMog0WQzJBL6EltSg/Pj8GlUcQe7Y1qvJwhU=;
        b=bID99jNOKTrDhg2oC20F2PzFgxlwcRnvH8SeMJmICRgrzXBQs8Oj8FUnKGD4VPZeQ+
         pJrucSPZRTBsSlTAAG1heVmMbS18WhW+ZlyLigxanb+Ij8LNNl6mJo50fAHB72ZnsReS
         EccDncFwE5HnkBYS7taqPd7PHLOaLaaW3FQmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IMZh5xqdMog0WQzJBL6EltSg/Pj8GlUcQe7Y1qvJwhU=;
        b=CvJdNbNKDHNs+3si6QQGaYAl5V9tx54HJH//KMJb7bI36Eg19bOj0XfnymUQIucf77
         wEJO3qER7jgYUk117aIzt3M6u+bBHSr8PqaCpdK8un+z/W2mA+K3YuGIpEb1fRO0RRJv
         cwtHnR9xDCMg+F+vGyxDKF2sW7dlH1meW97ZYkzLFjQnEPY8ssR4trEnMmKXevG5fiL6
         TPD3yZ4kkYpurv8WyM1zKukDcYJpEJO404rLCQ15ReQKvvBh1ep90otcN+yDlgT6Ne9q
         hbZxqnAZUc8jlFN56clP6mATjBTLQasp/3k+m3a34CFw+qqTm+HLhY1oudqXRlzvmrmz
         k4TA==
X-Gm-Message-State: ACgBeo3h89aK8p4y1eMgWDMqUPG2HsPqPg6TpuWjopeuGlg4cFYRNRLW
        UFPG3zdt3oquL1qoXBpzWWvVYA==
X-Google-Smtp-Source: AA6agR63TriAjfL7x5Rep66Wfr0k2UaIs0zqH3AhrLPQLPn5gX9vZbioyR42+LvNUDLDiQe8umVRXw==
X-Received: by 2002:ac8:5856:0:b0:342:f8bf:3582 with SMTP id h22-20020ac85856000000b00342f8bf3582mr29435146qth.573.1662146992375;
        Fri, 02 Sep 2022 12:29:52 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a431100b006b9c355ed75sm1932806qko.70.2022.09.02.12.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:29:52 -0700 (PDT)
Date:   Fri, 2 Sep 2022 15:29:50 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Conor.Dooley@microchip.com
Cc:     heiko@sntech.de, ajones@ventanamicro.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: cleanup svpbmt cpufeature probing
Message-ID: <20220902192950.ojetwk6fkhjzo7xg@meerkat.local>
References: <20220901222744.2210215-1-heiko@sntech.de>
 <20220902094939.wvzovl6ytujtjbtm@kamzik>
 <2910587.GUh0CODmnK@diego>
 <464dbc2b-e281-f9ad-f8c7-ba66e8247432@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <464dbc2b-e281-f9ad-f8c7-ba66e8247432@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:26:21PM +0000, Conor.Dooley@microchip.com wrote:
> >> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >>
> >> but now it looks like I need to go back and reply to each patch
> >> separately.
> > 
> > I'm not sure if tooling like b4 can handle Reviewed-by's in cover-letters.
> 
> Yup, it can! At least `b4 {am,shazam} -t` will.
> I am not sure if the new `b4 trailers` does.

Yes, it's the default behaviour for "b4 trailers". It'll probably become the
default for "b4 am/shazam" at some point, too.

-K
