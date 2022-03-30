Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9694EC5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbiC3Ndq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiC3NdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:33:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6C39815
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:31:35 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j21so18029730qta.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=sleTbU3o2LpxIYiBmlX/kKYFsR/lkVlTPZZsTo+MWCM=;
        b=S11wbdv1fZMuKBFRCOo0G8y41Hc56Qh5/q7m5rprd9dpQVKyucpMvT5wMtAebrJBLY
         vDmTjmtE5Q2fCE18kywy1GtidztsePxM5Owt5Lok+ghb4Z3eb7xFEZyYYk6Cd8Q7xrPo
         Uq8d4U6Exn0adT+R+j7qzLOGTKaol8mVhBzJI/3RMmkbaCKWgLZM4LWt8M83brUKJfFf
         rv3oAcaPGVycMfhF7gBYRtuXGCXNUUCm0yXGluEWv20o6ziUMQhlcNvJ3gN8jNP6aM5F
         2EfuGYilPS8PisNifJGl/z/S8oms75Wv1XwIJUYMeeMDmDPBXFzDPbdshCDJG7bQTf1C
         JjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=sleTbU3o2LpxIYiBmlX/kKYFsR/lkVlTPZZsTo+MWCM=;
        b=HMBo+oG5GiQcQvr1jNBBLQoEmQEoifqaKMQhSxlO5Z/HNdqtyIRBahC58nBL0vre5/
         AV4MWnZmQRB223nGWDTrlnjxsKNYHzv6c6W9uykQANHlVd0D/GW7F7dCPvzeDytlvygL
         eUbuvCc80S7dTXImftDY1SV8zYobPrVjlI8rkEDXz5Ca2zyOHOs3bPrsBefapESvPR1w
         yeoKWU6A/deUkqhYDThDYSVH7nHaMw+c5q61TJy9m/87hq2VjoVj6hpZMJyuFvu+vwqS
         flDnI3xDWlVl4SV/bTtorsnkCSQBhNczAPgIO3pdnPKWYyLxXEpRvhZyL4dFa0JS08WS
         7O3Q==
X-Gm-Message-State: AOAM533hF30iseOz24W2w2JdLAIvJ3mWvdkaD78Nm33CuPPNFfSq6FjN
        kJjS4TZQ9NmYTNUzPBsTrw==
X-Google-Smtp-Source: ABdhPJx9eZ5FPr2dLUqGAaQrb8udGsxnJKIokkzHWbt9HfdNcc31DVVKZV6LDvtNnJIin4EZXPl8Tw==
X-Received: by 2002:a05:622a:653:b0:2e1:c046:4825 with SMTP id a19-20020a05622a065300b002e1c0464825mr33430655qtb.430.1648647094638;
        Wed, 30 Mar 2022 06:31:34 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id a7-20020a05622a064700b002e238d6db02sm17611593qtb.54.2022.03.30.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:31:34 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:dcc2:ca6d:a437:b3e0])
        by serve.minyard.net (Postfix) with ESMTPSA id B33D91800BB;
        Wed, 30 Mar 2022 13:31:32 +0000 (UTC)
Date:   Wed, 30 Mar 2022 08:31:31 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: use simple i2c probe function
Message-ID: <20220330133131.GU3457@minyard.net>
Reply-To: minyard@acm.org
References: <20220324171159.544565-1-steve@sk2.org>
 <YkQi6EIhknRJgv3i@shikoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkQi6EIhknRJgv3i@shikoro>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:29:12AM +0200, Wolfram Sang wrote:
> On Thu, Mar 24, 2022 at 06:11:59PM +0100, Stephen Kitt wrote:
> > The i2c probe functions here don't use the id information provided in
> > their second argument, so the single-parameter i2c probe function
> > ("probe_new") can be used instead.
> > 
> > This avoids scanning the identifier tables during probes.
> > 
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> 
> Looks good and builds fine:
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 


Thanks, I have this queued and I've added the review.

I'm just waiting for the merge window to close before I put it into the
next tree.

-corey
