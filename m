Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC344FBE76
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346952AbiDKOQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346964AbiDKOQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:19 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64080E66
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:05 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so11349423otq.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=epGgzu2Ny8qonfAKGy3XqYkS4s5oChNon87Rbg1X4DI=;
        b=jXam3gLFpWG8JdtBIsuGouhDsOGqqqai6AnScbayWfVdCMIXFumAjl4ZKhn61qXVuc
         GJ6LVeIPGZzrzCFmEqmce2+vNWRGbsrtBoXD16I8Hnmy/fc/83r66/cEdq4hB0NxJ44W
         LI2tTQYB0Uf4JoWjM/hI7R/O88DoiiqvuXj5bVXiDiFdlbZy3yFnxuR0NJFpw2iK4OzF
         ooBGUcW6MvUjmSMnaOTTqpAeO0evV2sy1xcs4xnP888fnlhrbWYZr8yd0u0/agz5JG2h
         OOxakjIlftyPfsDz1jYfyIfpQ4Ir8KYE3APW8Sfv+oNpL20aY3WllIMyBRJAtWt8zrLG
         18jQ==
X-Gm-Message-State: AOAM532LwbCbxT27CxhVxGzq7sltSnZvGmuQtrzeh53TAhvpfdSfdrYO
        KdVI1HuCTrz9VYXPvw4X9A==
X-Google-Smtp-Source: ABdhPJw88XMo9SoKDKkqY63+AaV8GxGkx57LPhvYdKeY94/HK72LX5lZr0Wp4IF6thsMJ9bA1q7l/Q==
X-Received: by 2002:a05:6830:22f2:b0:5c4:3f05:33cf with SMTP id t18-20020a05683022f200b005c43f0533cfmr11262336otc.330.1649686444710;
        Mon, 11 Apr 2022 07:14:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s125-20020acaa983000000b002ecdbaf98fesm11374779oie.34.2022.04.11.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 07:14:04 -0700 (PDT)
Received: (nullmailer pid 1159237 invoked by uid 1000);
        Mon, 11 Apr 2022 14:14:03 -0000
Date:   Mon, 11 Apr 2022 09:14:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Al Grant <al.grant@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: Validate single/group leader events
Message-ID: <YlQ3q9YFhQU9JsBt@robh.at.kernel.org>
References: <20220408203330.4014015-1-robh@kernel.org>
 <YlP9KgIZ1PW64tn9@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlP9KgIZ1PW64tn9@FVFF77S0Q05N>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:04:26AM +0100, Mark Rutland wrote:
> Hi Rob,
> 
> On Fri, Apr 08, 2022 at 03:33:30PM -0500, Rob Herring wrote:
> > In the case where there is only a cycle counter available (i.e.
> > PMCR_EL0.N is 0) and an event other than CPU cycles is opened, the open
> > should fail as the event can never possibly be scheduled. However, the
> > event validation when an event is opened is skipped when the group
> > leader is opened. Fix this by always validating the group leader events.
> > 
> > Reported-by: Al Grant <al.grant@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> This looks obviously correct to me, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks.

> Just to check, have you tested this (e.g. by running on a platform with
> PMCR_EL0.N == 0, or hacking the PMU probing to report just the cycle counter)

Yes, tested on FVP with 0 counters running the libperf evsel userspace 
access tests as that tries both the cycle counter and instruction 
counts.

Rob
