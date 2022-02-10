Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FCF4B19B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbiBJXli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:41:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345798AbiBJXlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:41:36 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B335F6E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:41:37 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c6so20125724ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDt7Ebs5orxS5hLnuynWW12WJImDk7oKJlaVl614dTM=;
        b=V0saLM/p5DnDyFfmBWvLAFv0jmBUdEthHyCS9/tiD23yPsWrM4p0MB1WbvesRBC+cC
         eBYY3E9XYvSUyF7FpRC2EsM9OzPLBPSFGueRxTtn9P+9bWCo6qMe5Q3S2fmubb6YZXXy
         58rPbQebXK+kYDWQs6YZDvnoK5DKVr8BQUn/EXw/Ozmxn56zhryR1DqiYpsXFlGzEbqJ
         +tCUV3KDZm/H1BhFtPkz2DNYEdM5iZbOUIQHFaFWL6d5cS4Dcm0ZEvCcsIifRtsb3PQk
         YBmBdRcDlh5yiH6Khhc3294l9Ix7Dgmd/VlykdfrFQK+lAimT8HIyL9nGGxbc/ketC95
         Te6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDt7Ebs5orxS5hLnuynWW12WJImDk7oKJlaVl614dTM=;
        b=TQFiBBsnkGpVQr9s0WKvNqLSZA0XYhr7SVJ9KUYvEEpPxFylO3HTJmQWtdRuaG2D/5
         gxmm/iyAGelI+xFjvCISUeBEwNs+0bNbEYim6H+gA5dYRCx8HrK1vS8Fq0+F1xwAxX+C
         qdtmzkb8pVlMIJQdOmUm8BnjZKrm+O6fowfD/u514nPJXRebyFhBhbaEyL0tz55oyx8N
         gaYTi7wmsTVDXflxctMLs0Da6mDHf67g+IcuqBh+o9kAb+eZdgn8c3mnd90T/938psoV
         eaNrsUF3JWrZAnFRHOe/NpziOv3We2IT7kxPTIYaiPoYjYVHEGpk6nl+Df7QqqiSC7Bf
         PtBg==
X-Gm-Message-State: AOAM532GHeTvKBCZJVB6sigYsS8IwLyPD4U0pOkvVN2wOn5+RfLDww8H
        yMXJ8C+vB7Qd8ZPnWmd0XaZo4HntmS55ejViaI5kVQ==
X-Google-Smtp-Source: ABdhPJzqbzQXwiSY/HRVQ6yHaGH6/eIk40oZ0otDKgO9LGJYCiQ3w/BtkOyc3sxs+lJAIebQ8jaOn+tvJPqGbzw1bvQ=
X-Received: by 2002:a81:ad1e:: with SMTP id l30mr9669943ywh.151.1644536496271;
 Thu, 10 Feb 2022 15:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org>
In-Reply-To: <20220209162607.1118325-1-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 00:41:25 +0100
Message-ID: <CACRpkdYfrAexUhFV6e86QW+GSc3hM=38VNucKLhPppJ2ZdQ7fA@mail.gmail.com>
Subject: Re: [PATCH 00/10] irqchip: Prevent drivers abusing irq_chip::name
To:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 5:26 PM Marc Zyngier <maz@kernel.org> wrote:

> Having done that, we can cleanup a few irqchip drivers and make their
> irq_chip structure const (which requires touching a handful of core
> functions). Whilst we're at it, we do the same for a couple of gpio
> drivers.

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Since Bartosz is queueing GPIO patches and I am mostly
playing with a baby during the daytime it's good if you also
get an ACK from Bartosz on this one before applying the
series.

Yours,
Linus Walleij
