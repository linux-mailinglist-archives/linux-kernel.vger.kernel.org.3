Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6E525859
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359501AbiELXbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359494AbiELXbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:31:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5725DE5B;
        Thu, 12 May 2022 16:31:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso9241733pjb.1;
        Thu, 12 May 2022 16:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eYpdJ90sIk3qZfEgX1a80cpN/dFwOCIJBaG2OIahXBc=;
        b=qKp7BG8mXAqZXqb/q+PqxvmItgFgFMkAAnwKz1ZHXkZUzAmYP1HhV7uDIrl8P5ETsq
         wcXGlgBZT6WcjLF4FbrqrsOPbP6NYQLlPiTVFfR+/fdNCoT+aOUjWHFviEiJEDWPRe8M
         QAZVv4pIpo4JlGexYJ02gmNzrN7VyihR6x7qLYq1mKKzPKPZZoiql485/sL4mdIcSlaH
         qXl8S8sFG43zr08JWElKyp6uI8TS5HgtN4WwArQ9QPt7WWqnpi5JwOLaoVVY6il+NlE4
         Aft7cZSdhohv0lDf1inYoo0+fKqi5aFjNKon+ogLso8wmA2p1Z/RWkB02i+JU4p0uBbL
         Vwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYpdJ90sIk3qZfEgX1a80cpN/dFwOCIJBaG2OIahXBc=;
        b=PZcgH/et2KtIg4zaAHykniXJwhSOJ71LUyGULWmqihqatvkTNUW/be0SZMSLZH0pg0
         Ye04SHYnQw6gOGfG//fHvJLpE9VE8g8t/FDEE8SlJmLjCcEy2GAvLIJloyIk1dxalG7t
         TPDfDHA1VKIPNiZtX1bVHP/okjblixT4z6YdYaCPKnZ59fzQx5ZVhsdwxRfCJolON+MA
         KowDd+XRFqvN7KH56dZY5+iPLNr6Ik9dUDozKaKOqvnR72ZiTOg80HqQdoRCkkhl6iiz
         XAHDO/3DxS+Ixo6/gcllr3+HaVe7YAFzj+9iTTFv84UDQUzpnyGeJiS33NZuskpFVqV+
         mssQ==
X-Gm-Message-State: AOAM531VYxd/9ti1g3WpSvCWXx4Ij2mxiifpVaviVHLuvAPqpIuCzMDQ
        8P76set5+lsahjcPzcqspBI=
X-Google-Smtp-Source: ABdhPJxGwDjAa20EhqPaHUJXCC4KPV0xgsDoyqJN1XWSOCehFaWL3975iAR5D+4hE6C6ezwHizsd1w==
X-Received: by 2002:a17:902:f24c:b0:15c:b564:e4cc with SMTP id j12-20020a170902f24c00b0015cb564e4ccmr1893884plc.137.1652398272481;
        Thu, 12 May 2022 16:31:12 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:88fd:a79c:b005:79b1])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902710300b0015e8d4eb22esm443677pll.120.2022.05.12.16.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:31:11 -0700 (PDT)
Date:   Thu, 12 May 2022 16:31:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
Message-ID: <Yn2YvIFNhaz5GmfI@google.com>
References: <20220429233112.2851665-1-swboyd@chromium.org>
 <20220429233112.2851665-2-swboyd@chromium.org>
 <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
 <CAKdAkRSOtAD6u_cwKhHeMLgz5dC2hfPvVvqmj+17b4i-nspfgg@mail.gmail.com>
 <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
 <Ynzf5jEIECLmELK7@google.com>
 <CAE-0n50+obQ5qgPNPtUY=OmTgU9bZQ3hNw+MaG9Wi3SQSc-i4A@mail.gmail.com>
 <CAE-0n52WVNru5fnyaB_7wcBOk4twL0Q92YpRbd40-o6ZBmbXWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n52WVNru5fnyaB_7wcBOk4twL0Q92YpRbd40-o6ZBmbXWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:11:39PM -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2022-05-12 11:58:02)
> > Quoting Dmitry Torokhov (2022-05-12 03:22:30)
> > >
> > > Have we solved module loading in the presence of multiple compatibles?
> > > IIRC we only ever try to load module on the first compatible, so you'd
> > > be breaking autoloading cros-ec-keyb on these older kernels. I think the
> > > cure that is being proposed is worse than the disease.
> > >
> >
> > The first compatible is still cros-ec-keyb in the driver though? Or you
> > mean the first compatible in the node? I'm not aware of this problem at
> > all but I can certainly test out a fake node and module and see if it
> > gets autoloaded.
> 
> I can't get this test module to fail to load no matter what I do. I
> commented out the second match table entry, and kept it there and
> removed 'vendor,switch-compat' from the DTS. Module still autoloads.
> 

Ah, indeed, if the module contains both compatibles we will load it. It
is broken when we have 2 or more modules and DT lists several
compatibles for a device.

OK, it looks like you feel very strongly regarding having a dedicated
compatible. In this case please make sure that the compatible's behavior
is properly documented (i.e. google,cros-ec-keyb compatible does not
imply that there are *NO* switches, and users having buttons and
switches in addition to matrix keys can also use google,cros-ec-keyb as
a compatible for their device). We also need to mention that with the
2nd compatible the device still can report key/button events, it is
simply that there is no matrix component. Should we call the other
compatible google,cros-ec-bs?

We should also abort binding the device if it specifies the new
compatible, but EC does not report any buttons or switches.

Thanks.

-- 
Dmitry
