Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80D84D6A2D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiCKWvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiCKWvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:51:11 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E09A2CEA4E;
        Fri, 11 Mar 2022 14:25:09 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id r2so2044007ilh.0;
        Fri, 11 Mar 2022 14:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyRIcZoZdI7XJjcQT5Ld8APIti4p48Wxyfw1hBRxBYU=;
        b=dS5amww75jfn2iQvjxVUBXupGO2l6Bys4O6ss8C+vdIfjfPMJaujEm9TMdOfi7JJyn
         dbbcd0UFSTRfv2jADGOoSFe/5DqenzhVZiNNC5D7pcNNV5fNMn6qY9YozZdE73LxFZtI
         pnveBYNUf9BYXlTbd1eXM3UPGIUa98Z7uBLitXc8JdYSGBw9ETqBFQmoAbHVTtll4cyU
         K/KBDNv6YGh/NENGPHCdN9wCmBkbzE/D2e0bK4dxrorUsqRcpcKs9cG9AgxQA5ylD2nc
         RtdafaGoBCkTZ1oFaqNQ1swY2EvaLzVFAERsNeGJjn6VO9ThV34v6kZ9RrIh6DJTNqRs
         LhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyRIcZoZdI7XJjcQT5Ld8APIti4p48Wxyfw1hBRxBYU=;
        b=q+awXIar1gg5IRwQ055ABjExUa7TeEs48GnmcmJ4MTpSFrpNf4jELE//OxvnGrx6NR
         cT3Us+oqcaUtI12Cy2qRlbeCivmzwAhCJwKv6P+FwrpEaDEZS5km/IJEJp44AfCPthxC
         UuoFYTVW1oHHgydw+Roxl+IVKGiJm2W910l5yyg9ATMxgj4WUX+vzn8a1L+iGl02ex8R
         CWRAk6oT7azrShwexgsUaaBThtVbcdOk+2gFabiWE0fWXFugSIj4gMxHRiXVoeXsbCHp
         ISnXNcGqaH7k6Hy0bkDA1pYztTuoQjBHTQF8eyFS9U9hRceGDAZIH2H18ZelOmPGTM5G
         WpmA==
X-Gm-Message-State: AOAM533t2h8LTChWPbT5qrj1D9NNHU5xXh740ir+ib4bnz1rqFvGFNnq
        m2tWEajYjzzteENgb6QhgDh5S5zLwV976MBJHiM=
X-Google-Smtp-Source: ABdhPJxZl3L+TKpxjt4oWEG4AolAgkwpnkj2tGpgqjLVYdjTm0XEwk6syLuzVL7BUndaT96BlC3Ga8o+TnZXMlpD/Yc=
X-Received: by 2002:a05:6e02:20c3:b0:2c2:9e23:8263 with SMTP id
 3-20020a056e0220c300b002c29e238263mr9686933ilq.248.1647037508686; Fri, 11 Mar
 2022 14:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20220311132906.32292-1-steve.lee.analog@gmail.com> <Yit5v+JkYDiWz0z0@sirena.org.uk>
In-Reply-To: <Yit5v+JkYDiWz0z0@sirena.org.uk>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Sat, 12 Mar 2022 07:24:57 +0900
Message-ID: <CA+Fz0PY9bi7cJpbmD4LSMRyDFEyJ4JQPqWWNoV-PZm01=KboNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: max98390: Add reset gpio control
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryans.lee@maximintegrated.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 1:33 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Mar 11, 2022 at 10:29:05PM +0900, Steve Lee wrote:
> >  Add reset gpio control to support RESET PIN connected to gpio.
>
> This doesn't apply against current code, please check and resend.

I will check and resend patch.
