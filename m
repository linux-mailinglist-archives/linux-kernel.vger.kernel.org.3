Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4599350603D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiDRXeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiDRXek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:34:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A198B27CDD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:31:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k14so21665452pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u9HwDSu3jkL7GJkxdCGm5YU8ByJmgH0nknQ3b6eIwRs=;
        b=k0TMbaYzoa+OpneeXjXULYrDQlTSjIF+F3LakzftsYDwdrmPYjl/VyFfYJI2HfdCGA
         OT+k+eak3/T/cCFkYLP8k4W8e88ZFlObRsuM6NogdC6+D3Vpidz4HLP/TAiPtNXyIQoI
         Yl0YWKbPRXDAvLag5neYUgdEm0xLQJ2AVw9Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u9HwDSu3jkL7GJkxdCGm5YU8ByJmgH0nknQ3b6eIwRs=;
        b=f+zMgqPdzwD/pMg2CaNrd0jz8yyOB2T+suRHZZP6Dbnk40w/kz185eNk9gWk8FlG12
         ZLnfTacyH3GGJ3u115pGBi8Bp624PRtps7+yw3+TsaGciyYHDY9KsDaR5D6iQB4hKvrA
         0fXPgsDqvBvwpVzS94okptk80TvWJ5Y6xj6f77Sjzx4DA4D2MzSpTugxr8vFy0P71SGY
         Ct5+4r7dXN5a4rG4zQCna/0/aLEfzJ4xiS7RWPGATOakdM3VPY3mwV3p3qiYow4NAMJN
         74mEmA6Klpfq8GAe2wB4sAZEt+o1k+aefrsnA143vGELbbAoB3sm8ah9xCi7+awcAGiE
         deZQ==
X-Gm-Message-State: AOAM532M1re1TsX6YWfkj1l+uW1GBuMaEUi7QFmYhOuXjWKuxrEiz0mX
        +e+o/E8n/4gptLmXH+aHq2cO8w==
X-Google-Smtp-Source: ABdhPJwxK5PaPInu/IR4v+tY4NZnK4X/5TSAG8oOcafdt4PbOYXt5YvZ4a1LKPMfOXWyZcuYYlyz5g==
X-Received: by 2002:a05:6a00:2391:b0:50a:3ea9:e84d with SMTP id f17-20020a056a00239100b0050a3ea9e84dmr14999727pfc.21.1650324719179;
        Mon, 18 Apr 2022 16:31:59 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k10-20020a056a00168a00b004f7e2a550ccsm14283141pfc.78.2022.04.18.16.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:31:58 -0700 (PDT)
Date:   Mon, 18 Apr 2022 23:31:57 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral
 charger count API
Message-ID: <Yl307fUo09z2/M+w@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org>
 <20220415003253.1973106-2-swboyd@chromium.org>
 <Yl3vd4kfgwJXMs/w@chromium.org>
 <CAE-0n53N1k_b9vWJ84nBdm9sxpYV3o4-FLJQM1HGqEhQsdr19A@mail.gmail.com>
 <Yl3ykMvfCaQlQ7t9@chromium.org>
 <CAE-0n51PX1SgqiB5vgoOLunkrxiWxH2O=jCCM5gNL97O8Ltt4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51PX1SgqiB5vgoOLunkrxiWxH2O=jCCM5gNL97O8Ltt4Q@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 18 16:29, Stephen Boyd wrote:
> Quoting Prashant Malani (2022-04-18 16:21:52)
> > On Apr 18 16:16, Stephen Boyd wrote:
> > >
> > > Sure. I take it that I can drop this function entirely then?
> >
> > Yeah, if it's a simple response, should be fine.
> >
> > > BTW, why is
> > > that function name the same as a struct name? It confuses my ctags.
> >
> > Yeahhh, didn't think about ctags... :/
> > Topic for another series: probably can be renamed to cros_ec_cmd() (just to keep ctags happy) ?
> >
> 
> But then there'll be two cros_ec_cmd() because there's a
> cros-ec-regulator. Fun! :)

Ugh :S

I think we can get rid of that one; it looks to be the same as this
one :)


I'll write up a cleanup series if it all looks OK.

