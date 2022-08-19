Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7885998FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348076AbiHSJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348205AbiHSJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:42:38 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72EB79A61;
        Fri, 19 Aug 2022 02:42:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g16so2891967qkl.11;
        Fri, 19 Aug 2022 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Xra5wOcQVG12+wejDaPgCNN7Ex8BBmCGGrUkA59x0/w=;
        b=dyjHy/dUBiUpNDsh5agSwMcEFKBaGt0DbaWswj2y5LuThuLI4ctgD8UpWiEOoaziYL
         0hFauWnW0UQ0fkj6rRhBPM0QeyqCXrykAQ/u8Tagcy69jfOZkwvpArsH28W7MzHSvxOp
         6C95gnqXqgDBsEpMPh0MGlwSdayCKyXvkooRjkKjVIm91wVdEin+62VCCR0sJEjNjVdf
         H64CAzxtwBZurny/cWzvdcQutvJubaL0bwdMtVreLBia2WHddYh2/kkXn0StBxBvAhfM
         gUzVVprAONXpaClFr6gF7s15Tp4ErtU2E8j8BhohcQaGc1kVKYlAAQY5AV0VVDqMH9Cf
         cdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Xra5wOcQVG12+wejDaPgCNN7Ex8BBmCGGrUkA59x0/w=;
        b=PpwIkk+Xzt4VmqOM+3Z3pIm3n8SZLUdXg+ehvWAZ4J1sB0DGQ8yxgTXi91F75vTdsY
         FbE6zkk4bgB1FDsopfgfFu0dD+AX8iBxHe1+YhigqzRBlNx5wVd/bkAo7NddqnafNJH/
         uw3Cv432wCcSVcW0aQ2FRpW+CqNVMBn8+Jy4bZ86xM58WjqwGSl0T1ENKwnCoU0DKZ+5
         RxZm2bujBmmpExH6H2N9l51YFhWebyODmOHdnzSPK91TGHNSwUHCPV4g33XMaIYArxL0
         I1xwqATxVKh9yG+OaveE+fwZ8nk8f1aUPUOGJpheh1rPfyoXpUdnidE7i80SuTwodvdX
         doNg==
X-Gm-Message-State: ACgBeo0Dib3a1jFRfkD7zDHFw/g4mB9aip8jqHg+oy2lDIqZ/p6JWkxf
        AmQbTctrSKIK5OJstKtabdcMORKKlnxw0BpDd9s=
X-Google-Smtp-Source: AA6agR4Z6wmjzS7ZzrDPS1R46n9TWvkPbnPGmGbxIKGId+2Mk9AjHiMyDcwH3/GlgzPyz3ryNW8/HRYHg49pqGVHr3s=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr4716136qkp.734.1660902156806; Fri, 19
 Aug 2022 02:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220809211246.251006-1-eajames@linux.ibm.com>
 <20220809211246.251006-2-eajames@linux.ibm.com> <CAHp75Vf5wcabm_-oKGN2m7z=L2xu1D6wtzKLhu6n19Uhq8yijQ@mail.gmail.com>
 <e35b595f-572e-a539-c550-831cdd02dbd3@linux.ibm.com>
In-Reply-To: <e35b595f-572e-a539-c550-831cdd02dbd3@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 12:42:00 +0300
Message-ID: <CAHp75VfU26QZ7Z1ApzRcFPudgsQc7zWF5g0kwn7Jzk1htXaWng@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: pressure: dps310: Refactor startup procedure
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
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

On Mon, Aug 15, 2022 at 4:42 PM Eddie James <eajames@linux.ibm.com> wrote:
> On 8/12/22 17:03, Andy Shevchenko wrote:
> > On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:

...

> >> +       rc = regmap_write(data->regmap, 0x0e, 0xA5);
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       rc = regmap_write(data->regmap, 0x0f, 0x96);
> >> +       if (rc)
> >> +               return rc;
> > This code already exists, but still want to ask, is it really
> > byte-registers here and not be16/le16 one? In such a case perhaps bulk
> > write can be used to reflect it better?
>
> The temperature and pressure regs are 24 bits big endian, and all the
> rest are 8 bits. I think the existing approach is best.

It doesn't look like you got what I was meaning... Or I misunderstood
what you said.

The code above writes two byte values to two sequential registers
which make me think that they are 16-bit registers at offset 0x0e.

...

> >> +       rc = regmap_write(data->regmap, 0x0e, 0x00);
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       return regmap_write(data->regmap, 0x0f, 0x00);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
