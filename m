Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C644B7529
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiBOT7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:59:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbiBOT7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:59:50 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2192673DB;
        Tue, 15 Feb 2022 11:59:39 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id r144so25269915iod.9;
        Tue, 15 Feb 2022 11:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eXMbSl7pkbrXXY20Ci9OYDkC4iVOBT5vJ3kmdC5ZvI0=;
        b=Ut9U/dKzMKS7M1TiJ0KgGsH2gv17WDpgumc2LIGeYhzC2ToZhX6KggBqcBGGRWWBnW
         lzYckVrP/ggoXAZ6nPfDdv3OBVzzScqm6UE0hEVOzr/dw2gv7S1T1ptzC+TD1PgI/2Zu
         eJgatoKvJNX0y+k5WfJrNYTdNIlRNO1N6b4pZPaz7B5/n1nwuXPi7UKtNIJyQDGV2H8A
         H7iA+4mD0lNkAm0NejpiSEPxjYPBr1c3h1BQKaKfABqMxU7wM5wOIajms7kzzJlbDom4
         6xEG46CybXsTJD5cKN3DFGNsTFDoytKUVyGb2esUM1sEDt3n35WE/PqSOUIcew/aOVeu
         1MxQ==
X-Gm-Message-State: AOAM5338nQRgWf+VxC7pkPqsy3zPCFqK0hp3C5TdbxTFHW9r1rNIZKcG
        e+86Pv909SmPMbi9u+qCHw10U5ZcMw==
X-Google-Smtp-Source: ABdhPJyP0tXgowoX7f4MwVO8+v5yIrdTwKjrc2deFX5hSQamule4HQ9Og2RVu5spDDRTZJ9LuANhhQ==
X-Received: by 2002:a05:6602:15cf:: with SMTP id f15mr306598iow.135.1644955179149;
        Tue, 15 Feb 2022 11:59:39 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z13sm5438984iox.21.2022.02.15.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 11:59:38 -0800 (PST)
Received: (nullmailer pid 3828019 invoked by uid 1000);
        Tue, 15 Feb 2022 19:59:36 -0000
Date:   Tue, 15 Feb 2022 13:59:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] of: unittest: print pass messages at PR_INFO level
Message-ID: <YgwGKI+KUY9qKOnB@robh.at.kernel.org>
References: <20220210230819.3303212-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210230819.3303212-1-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 17:08:19 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Printing the devicetree unittest pass message for each passed test
> creates much console verbosity.  The existing pass messages are
> printed at loglevel KERN_DEBUG so they will not print by default.
> 
> Change default to print the pass messages at loglevel PR_INFO so
> they will print with the default console loglevel.
> 
> The test community expects either a pass or a fail message for each
> test in a test suite.  The messages are typically post-processed to
> report pass/fail results.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> One review comment to similar previous patch "of: unittest: print
> pass message as same lovlevel as fail" suggested to also change
> the text of the pass message to include "PASS" instead of "pass".
> I would rather leave the text unchanged to minimize churn for any
> existing users of the message.  It is my intention to change the
> pass and fail messages to KTAP version 2 format as soon as that
> version of the specification is completed.
> 
>  drivers/of/unittest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
