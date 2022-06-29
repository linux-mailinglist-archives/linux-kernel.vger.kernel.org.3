Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E555F5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiF2FrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2FrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:47:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A8B2A433;
        Tue, 28 Jun 2022 22:47:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso14991268pjk.0;
        Tue, 28 Jun 2022 22:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1YBqdukEjmcQv4229s2jn5G+rP7f7kYpmmkX2BQayFQ=;
        b=Cm2qlKkcPAX17uChMiGkNj5GD8pHjiFoJp6wwR46AcK6mvymGFg5IGht7iK/xtDBod
         Dv8YDNo5V6s/IkXxQw9mGC8ZpmCVvoIX+c7hKaea1NJJOpevNvOd41l+N21y+g95pilf
         YIKKON+cLz5JAZT697UhSfArvWloBHo5B1pW0B9FNl16dEYgEZSDE6BsRieGp4Tfiz6w
         aqLAXgUrBJ6dBvQ/1HEnnamBy842bXFUcaK+qHEgURz6/Tznitbmn4EiVnf5bGsckZ3+
         XqLoMVEvRygLvocKxBFj8OdC7oVteOxOl94Nq5MGSBOokNf6mI8dWvcM9hxEWVdQZrF0
         QCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1YBqdukEjmcQv4229s2jn5G+rP7f7kYpmmkX2BQayFQ=;
        b=7SxL7eHL54mJDQxI6m0CjTyzRjVniv1ko2Vqok8RXxw3jh/AXmMqCruvB1aCHKMc+S
         snvuQfqj7/ha4iH2X93v5vLQAj/718WcfPb4NA7Ms19y7VZ+oiIb6Lb4ZruBpLSHdwx3
         4Vl1qoEi3Qj00CoWReGsoByI16e46XiocO5aIZWhj1xQlJvHdAtz7faBwYXmdT+DOSsU
         dpAhRc/A7VPn35SL8BbKMp6JCugKFgHWe27Hvth1iD4FezZRlXGqccZ+IJ/EX72hPiBP
         cltQ2cVplyjP7H4+W+HCOlfGcD85S+2H1u6RyP3XRIhfZbxEdjS967PZdqlPq1BDKxeB
         JjWg==
X-Gm-Message-State: AJIora9J2pxIh8rozR7SgqkM6UeRKL54bIK2YOtlUgGGhA/b/GYO1rzl
        HB5sWJ4RR6ygZ6IrigdASgpfXXNRy9Q=
X-Google-Smtp-Source: AGRyM1u2SDRy7iMLDPJSK2CH/P0dllA9/4BQ/Rqx2yzeKsdcb1ayCY5dcU3ogFPPAnTmaBCrADghfA==
X-Received: by 2002:a17:90b:2251:b0:1ed:29d2:e013 with SMTP id hk17-20020a17090b225100b001ed29d2e013mr3687819pjb.223.1656481628908;
        Tue, 28 Jun 2022 22:47:08 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ff79:92cc:7905:3272])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b0016378bfeb90sm10382853plb.227.2022.06.28.22.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:47:07 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:47:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: exc3000 - Fix return value check of
 wait_for_completion_timeout
Message-ID: <YrvnWd0SkyG/QXyt@google.com>
References: <20220411105828.22140-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411105828.22140-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:58:23AM +0000, Miaoqian Lin wrote:
> wait_for_completion_timeout() returns unsigned long not int.
> It returns 0 if timed out, and positive if completed.
> The check for <= 0 is ambiguous and should be == 0 here
> indicating timeout which is the only error case.
> 
> Fixes: 102feb1ddfd0 ("Input: exc3000 - factor out vendor data request")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied, thank you.

-- 
Dmitry
