Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B357A141
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiGSOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiGSOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:21:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD2866B84
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:04:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so9993001wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L94oHBSftAEa3rDT4AJ1V+PwG4JicNPHLRIniySo+rM=;
        b=StLIAtFJw2aByBPEd5DWw/mCW7IX8gyCWM24C5VoqghqL3x7mLezHcKBXBVSrWP84Y
         xwJElpDOvDRLZdnqDBCB9YrtqBbi8nAuLZ7PkqfcIRG8P2uZCRlaQkLM/e0+BkVvjmzf
         EoBA2nTXSoq6MqT7QsrHRWmlaghdUAZFzDjzMxYZw0AaCjJao/XrX/wnTYMTML475E5j
         GANHdeYrjqP2moSb/cJNcp5EQWfLnCtQtrtdNtWENXrpj2oBY6tzngcPwdFsMkZ0Uyqh
         mwM+Zonn09DR2yP4vuGqU45N6YFgxne2OxhbnzW1eCaZhoRvB4Ton3Y7R0TYnMCqorjq
         0BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L94oHBSftAEa3rDT4AJ1V+PwG4JicNPHLRIniySo+rM=;
        b=y8tyYNLpVNv5xOSDOmVXLkJUmfiFtEhJfkRBmYCKpOI6T+U/K8prrVIBxDKr5/BeXi
         zQ13Gz/PkYZgSKg1Onm1BFy5KYe/qHuXqj6qTdeZKfuc6fFabomvKyV4Y3LrIOzeEuKy
         TJ0Bxn2y44r0RLyL+sBYmRUi7PFCYKXCmWkSrZGTowQeBMpA2M98AtdUpT7J+BMF39mO
         dChk4tN55U8QA/W78hYLRPTGm3eUxBlYpXgUAWhUgZgpDU2pmtOXifyptGTR9u1Ktarl
         YUb1oPiFN6aZCNvAiB4BRfkB51mb8v9ySiHZc9haADvU15PDMwNCdREbZ0liOXGbc+sK
         l+gA==
X-Gm-Message-State: AJIora9DnuIan/zK+gD9h9H5Ab+ZlflzJRbdNeCcXCi4lfTlOyduxLGz
        yTaFkuIttgpfeL2Bfb89vdZdt2O8FpIjAA==
X-Google-Smtp-Source: AGRyM1tjuVhJR84hP2gMCuawKRlwNGX9ih4Tn6UUGN84EYqew++4Z1I0GdyS8KZxc7vD+L14OYUgug==
X-Received: by 2002:a1c:7915:0:b0:3a3:11a3:7452 with SMTP id l21-20020a1c7915000000b003a311a37452mr15511350wme.27.1658239485155;
        Tue, 19 Jul 2022 07:04:45 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i16-20020a5d5230000000b0021d9d13bf6csm13252481wra.97.2022.07.19.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:04:44 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:04:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is
 freed
Message-ID: <Yta5+UOcK2rgBT6q@google.com>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
 <Ynl+kUGRYaovLc8q@sol.localdomain>
 <YsVYQAQ8ylvMQtR2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YsVYQAQ8ylvMQtR2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2022, Lee Jones wrote:

> On Mon, 09 May 2022, Eric Biggers wrote:
> 
> > On Mon, May 09, 2022 at 09:17:26PM +0800, Haimin Zhang wrote:
> > > From: Haimin Zhang <tcs_kernel@tencent.com>
> > > 
> > > Add a new function call to deinitialize the watch_queue of a freed pipe.
> > > When a pipe node is freed, it doesn't make pipe->watch_queue->pipe null.
> > > Later when function post_one_notification is called, it will use this
> > > field, but it has been freed and watch_queue->pipe is a dangling pointer.
> > > It makes a uaf issue.
> > > Check wqueu->defunct before pipe check since pipe becomes invalid once all
> > > watch queues were cleared.
> > > 
> > > Reported-by: TCS Robot <tcs_robot@tencent.com>
> > > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> > 
> > Is this fixing something?  If so it should have a "Fixes" tag.
> 
> It sure is.
> 
> Haimin, are you planning a v3?

This patch is set to fix a pretty public / important bug.

Has there been any more activity that I may have missed?

Perhaps it's been superseded?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
