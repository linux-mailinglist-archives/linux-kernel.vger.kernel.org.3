Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A3E5512C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbiFTIbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiFTIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:31:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD511C10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:31:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s1so13554286wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f8h+p6YNabNl4RKgR2y8XH455u0zXJFLFjZrTjaNW6Y=;
        b=j9QEpmpJqMvtTAXlLrYmuHUVqn46fAvmLSYg0MY6u2/kQ3wIpaE2yW06TGF/hyCCI8
         /EPNkrpFsNGoqu/SI/yIq5BxXO+9S3lMgGxVjhwa1JEh3MBFUxLsRmP8ER5/BznBN5sd
         a36Pwusy29znmIpPLzaNR0J1eUc5v5IK//daHW8nksqnhZSm3V8yR59diYCSE6bs67v7
         AZvcew69CmRHFikKWxMRUUWREXYWpRAbiAKDW5sdvcXRiOn7Q3OqGmxhUTz58j5CaHmd
         i4bOAtENKlldKFvXKn9HdJwuuzsxfzDsT66a18Hm4dUlJSSer6FFbd3UlzMDQkmgutyk
         4bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f8h+p6YNabNl4RKgR2y8XH455u0zXJFLFjZrTjaNW6Y=;
        b=wDEkgUwolIHFMg4+TNoLbbAY8ZDnOsCs/V1SCGavbPD9ToEctsS0IiGeUFRcU9Oav5
         yC0NTZRUW84KvyfQmWcbPX6ZfhRPnx3Um5UZ4ma2dWFa+n+omOFLK3VXiHeXCTAfQ6ci
         TDSKlIejMCJ0l6/Q5NATXcp7fD09vvQ1cEMH8eqUvBHQ2jntL6UK64ANcnzx1NJbOdcY
         9SdBWLdBGDOET/kb6+hzxeT3YS2NnTOBhgbB5IN6Vqzpmv/C9772Xfhi7sGFXvhHADAS
         77v07f8UVHgMBWx3in/4nNj+tfxVx6UjT+ARw4dPCQXj0U8hm/ahSOIJUFe6ouW8eUbT
         XThw==
X-Gm-Message-State: AJIora+iJY+ctewpf+2ehTW1hY5Db981ceIqIXiOX+ds2qngB9hzbfSm
        gfmxj3+y2czubMNY41WhTkt6cg==
X-Google-Smtp-Source: AGRyM1vgi2PEv+AIClSqdl50GS4qE0AexzUlDZyI0AZ8wGbk700yI+nFCzqi+9d9u8VeT56jFUx/GQ==
X-Received: by 2002:adf:9d82:0:b0:21a:3906:59cc with SMTP id p2-20020adf9d82000000b0021a390659ccmr19017891wre.289.1655713894785;
        Mon, 20 Jun 2022 01:31:34 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k190-20020a1ca1c7000000b0039c587342d8sm17856456wme.3.2022.06.20.01.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 01:31:34 -0700 (PDT)
Date:   Mon, 20 Jun 2022 09:31:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] mfd: tc6387xb: Drop disable callback that is never
 called
Message-ID: <YrAwZCGjN+1NZ0ua@google.com>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
 <20220530192430.2108217-4-u.kleine-koenig@pengutronix.de>
 <YqpJ+GDjsMsILL4P@google.com>
 <20220619083200.gx3ardiogbarlvzs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220619083200.gx3ardiogbarlvzs@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Wed, Jun 15, 2022 at 10:07:04PM +0100, Lee Jones wrote:
> > On Mon, 30 May 2022, Uwe Kleine-König wrote:
> > 
> > > The driver never calls the disable callback, so drop the member from
> > > the platform struct and all callbacks from the actual platform datas.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  arch/arm/mach-pxa/eseries.c  | 1 -
> > >  include/linux/mfd/tc6387xb.h | 1 -
> > >  2 files changed, 2 deletions(-)
> > 
> > Applied, thanks.
> 
> Are these already in a public tree? They are not in next and
> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git#for-mfd-next
> doesn't contain commits that are not in v5.19-rc1.
> 
> I assume they are still in an internal tree and I just need some
> patience until they are pushed out?

Correct.  Patience is a virtue.

I'm back at my desk today after a week of travel.

Check -next tomorrow.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
