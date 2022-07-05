Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D925C567A73
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiGEW4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGEW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:56:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3614D00;
        Tue,  5 Jul 2022 15:56:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b26so19564231wrc.2;
        Tue, 05 Jul 2022 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zL3YaBsI2xTGiJj2TbzH8GBqtIjY97YUDCwE5WljzJo=;
        b=ozr5AtTt/pUS+XSeTixcByO7KyRlNo+uPXS8SCZ5Jlg6rUP5T6qUx/wxMYIIOxN4BU
         mZ8xHIt1d2D053oiV1hAq4ZXeSRZ3W88EgdxNgC9UXBkjzr1+JXSNppWOcVTnno0l2nh
         JVE4lO/TFfQW9tSAdpotJTUGf5XOaWdW2RQecuLnMvsCi6iX3KMT0t2rax2jXEUI52dK
         hwXhWjZG7ar4AzZ8Fz8mNGev6nE6NA/nTfgPxD1gk7aKXbn8TOnWmiZwPMtvo8CGbNog
         kvH2CqX8XCumzB9xgOTubOwslmlApYIC+F65CE3L3UoKxzKIq43jb61WG07WhhDZ2W8M
         4Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zL3YaBsI2xTGiJj2TbzH8GBqtIjY97YUDCwE5WljzJo=;
        b=mUm+M/q7DprsEdzkwvK/2OS57/V3sSoJqJlTd6spEmSmbspiXnxnUecz3vUObDazvg
         r7G7zYY+s8PTv9vfkU8/ZY6UdI+owF9SsfkPkSPOJgcChyAESMLKFVZVrv1t4COp8ERY
         I64NBcmb47O+iUTjC0+xxyfv655z84QpweU6upG7Adz1MsWAImQ+Gl3hRHFXHie3coSS
         qEAD+eFjm2nj8ssleqJgo8oDBRLhLb5/s08ly/Fx2csC7bZjy5ygYKAjMei2Ev0AKPmz
         71UqSuRrAZ+XOoqXNy540vnIK1ogLQ3r7z5d2ntP56mesJGvn7FTQ1X+kugMpKa5ArrJ
         P8WA==
X-Gm-Message-State: AJIora+11cf0s8U6uO2vobFxk0oFBgK5sv55pPmLd3H8MNBqfPGqFa1C
        ZtvcuA2OWhPrLwWybfBjOe2lHItNIxU=
X-Google-Smtp-Source: AGRyM1txX/s3W3BFx3VdgP4BD00VAhluDQ/i92/owuJD4QW+h+/xZkjmVhZxj7+Hf9E7vw/kCJ3YcQ==
X-Received: by 2002:a5d:6da8:0:b0:21d:2598:4e28 with SMTP id u8-20020a5d6da8000000b0021d25984e28mr36105913wrs.373.1657061806688;
        Tue, 05 Jul 2022 15:56:46 -0700 (PDT)
Received: from [192.168.90.207] (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm33178876wrb.70.2022.07.05.15.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:56:46 -0700 (PDT)
Message-ID: <886b99b4a0f2ddb8cd89faba9e23b5d710f59f12.camel@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: simplify driver
 initialization logic
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Jul 2022 00:56:45 +0200
In-Reply-To: <CAHp75Vcgivf1cDFBqWqoYQKdLYjH5NFsJi18HSy3L4U7WbjnGw@mail.gmail.com>
References: <20220704002957.207850-1-ang.iglesiasg@gmail.com>
         <CAHp75Vcgivf1cDFBqWqoYQKdLYjH5NFsJi18HSy3L4U7WbjnGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-04 at 22:10 +0200, Andy Shevchenko wrote:
> On Mon, Jul 4, 2022 at 2:46 AM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> > 
> > Extended chip_info structure with default values for configuration params
> > to simplify and unify initialization logic for different supported sensors
> 
> ...
> 
> > +       ret = data->chip_info->read_calib(data, chip_id);
> > +       if (ret < 0) {
> > +               dev_err(data->dev,
> > +                       "failed to read calibration coefficients\n");
> > +               return ret;
> 
> return dev_err_probe(...);

Got it, thank you!

> >         }
> 
> 
Thanks,
Angel Iglesias

