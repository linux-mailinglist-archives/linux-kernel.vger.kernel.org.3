Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72C14DB77F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357632AbiCPRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbiCPRm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:42:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE16BDE6;
        Wed, 16 Mar 2022 10:41:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so824673pjb.4;
        Wed, 16 Mar 2022 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Ow+kGtiOY3oh5aaxxEMEYzkd7Bfkm111SMhgSjbTYc=;
        b=NyKZ2dMQyhMPO9PAhi+GiL/xXA9vyF4L9XDAYzCXVbTfTSJlLWYJ3gax9kK3nXXDIJ
         4k9CoGMlJ9U1vx9j065MJYu8hx+2+V0SBQMmuCsQlUGEcLO13IzM58ef4cZJzM7wuyX9
         wsUThhe6UWlDwnWZ0VTblKmn41h5S83ZxWMqnVMDacTU8fpfcWQcbB0ukQPC36v0rv3D
         1V2gx4iohIzUOb+0R/DR7xXC/+nHz3pAhHlPgbvKkAF8B7CVIkDWWFEd3kL1phGI8GDk
         E6+bklRHx4K4+ADhC+6Y01iHXlYCNdMMhlUOVIeSKXFohfaJ6xLKbit4vglL4shLUGvm
         5Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Ow+kGtiOY3oh5aaxxEMEYzkd7Bfkm111SMhgSjbTYc=;
        b=Sbf1A2yLjTJjvhPBCFgZc6t9UUkaQV6JQnNm1p3ENnGGrmlmad+K8SDBZuotSq+4V6
         kab23XDPSW8nqaNtwwykeFt/aoIuC6WdcSRxsq7AkiRQyES2FImAI/Q3RGQSNqD5KdbA
         vSCzzdNwZ4CJRBH2G9e+vOHcmUkWV4pbiAPxW8GvgixP8j6nRsCRrA151E8MlrP7S317
         UywrvUpi8XoTHgHfiwlHpxj0CkWV0OYeKEVYUhONX/JPXK5/x2jEaMq5kP/bZ3zD6nIi
         HPj/H7FBjoL1a/abx1rf1s/AMsRNT0trcjnrpVOPa5dpKzzBrf8sijjkYFsZoJlrKlN0
         lWMw==
X-Gm-Message-State: AOAM533LK1IsH0Nj5uOLwaWWuV7c1JpQok5lMd4r7k53QNk9bk/Zce6s
        IgsNN4j3jY8T9U4hLMKGReE=
X-Google-Smtp-Source: ABdhPJylMLMEhg/D+2mxXnfYjAYghwhK/xve8O7Layo/rR+2MMj5hsK0594Ke4+TFFyn2R2xQel1uw==
X-Received: by 2002:a17:90b:4f4e:b0:1bf:88f6:e5b5 with SMTP id pj14-20020a17090b4f4e00b001bf88f6e5b5mr11430312pjb.47.1647452474263;
        Wed, 16 Mar 2022 10:41:14 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a00191500b004f78813b2d6sm4223887pfi.178.2022.03.16.10.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 10:41:14 -0700 (PDT)
Date:   Wed, 16 Mar 2022 23:11:08 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] clocksource: arch_timer: Add arm,cortex-a7/15-timer
 in of_match list
Message-ID: <20220316174108.GB21737@9a2d8922b8f1>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <20220316095433.20225-4-singh.kuldeep87k@gmail.com>
 <f54b0647-12ad-5861-8b8b-5d4233bb9bd2@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54b0647-12ad-5861-8b8b-5d4233bb9bd2@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:30:26PM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2022 10:54, Kuldeep Singh wrote:
> > Few platforms such as Renesas RZ/N1D, Calxeda, Alpine etc. are using
> > arm,cortex-a15-timer and arm,cortex-a7-timer entries in conjugation with
> > arm,armv7-timer which are not currently defined in driver file. Add
> > these entries in arch_timer_of_match list to bring them in use.
> > 
> 
> This looks wrong (also Marc pointed this out) and rationale is not
> sufficient. Why do you need these compatibles in the driver?

Hi Krzysztof and Marc,

I find myself in trouble whenever dealing with compatible entries and
had 2 options when I stumble this issue.
	1. Remove unused compatible
	2. Add required compatible to binding and driver

My past experience and advise from other developer says not to remove an
existing compatible. And also I found "arm,cortex-a15-timer" in binding
which was again not documented and was present in DT. This prompted me
to go for second option and make necessary additions in binding and
driver following current entries.

As per your perspective, current configuration isn't apt which means
"arm,cortex-a15-timer" is a stub and is wrongly present in binding.

I also observed many other DTs have compatibles which are not present in
driver. What is an ideal idealogy behind such cases?

- Kuldeep
