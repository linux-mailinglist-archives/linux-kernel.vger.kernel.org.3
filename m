Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27715A15D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiHYPbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiHYP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:29:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025ECB95A1;
        Thu, 25 Aug 2022 08:29:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id io24so5540862plb.1;
        Thu, 25 Aug 2022 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=ewFbyp/lEsLvlG4TjMvq7Ikhvy1ZiAGlWqCLdwgjxKs=;
        b=g84h4UQX+xvvGdoUL8ImfNq0/pE3tXzBR9dVZcyAZjKfVblPrkWIDpmVIQtKfrugfa
         gpnInJhJJQuGvxmhizjI89lFgRIezB0X/ubNaVh6+A7Qv1/y4pIkj3jjXxIoj2RrIupF
         dOEpxcxh8idHqX8Jf389xt2xIwuWSUTXM/dEixgh0Im3CSq2bMY8Ytj/sLAh9kjdosUH
         hLl7WYlTLCYigVqVWSYMrDSVTtAfVOlGQY3qxmHUcHJHgjF+tPFI1pNn7LPI+QMxrVH/
         LJFQ4CgUx/8mA1yebmgW4bSNxPV7v2XhCb/xzcnkm4NLjUlrPz2v6fxpX8E736aSI5Ac
         +r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=ewFbyp/lEsLvlG4TjMvq7Ikhvy1ZiAGlWqCLdwgjxKs=;
        b=TCQm53tBxhuhYWqd6jYT+zmmVomJdGCIcCm8inNimZ0XBE5iCCf5JDoWL+H3y8PjK7
         j0oQKdLXjNZxwvq5++qmVfbDDkV1jU5UjwYovDF5sjmETthYduTT2xPPDf+2Uk+x+eV/
         1Ky64YMrrUZK+8RhUjV6XbFc845aFSlz5IPCZ1TXhrfcT730tBC/Yq+3pVzo+Vl6Oayb
         7+n0o5dwDCBHzXCmRlRSt1n6eYjR7or6dU5kCMzJyVIh5MAXe4V72gIIYvIW9oCXjHNb
         BcXyBOxcRA9COVIdb+G4ykuJ4oZJ3mIaO+Jrj5wbvqEnh1pXsbN154FKHn3QxX1MpLjn
         wY2w==
X-Gm-Message-State: ACgBeo0rGy9Lp3Lnv0jX+wxE6u7NT+ASN4KnK6Ri+/toQpuJMSNEVMKa
        wf2U4yUttJQwVoD0abgLEqk=
X-Google-Smtp-Source: AA6agR6WgxCS52ceVEttDm2ihvYC5kWHgJO2Uted6ZyV0VQPo6LIY0FJES41I/5wFZ7dFxgYg14J5Q==
X-Received: by 2002:a17:90b:1bc6:b0:1f5:313a:de4b with SMTP id oa6-20020a17090b1bc600b001f5313ade4bmr14548108pjb.4.1661441376500;
        Thu, 25 Aug 2022 08:29:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m38-20020a634c66000000b0042b4d55a6e9sm1516171pgl.37.2022.08.25.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:29:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 25 Aug 2022 08:29:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Andreas =?iso-8859-1?Q?B=F6hler?= <dev@aboehler.at>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Documentation: devicetree: update bindings for
 tps23861
Message-ID: <20220825152934.GA1439919@roeck-us.net>
References: <20220825143737.77732-1-dev@aboehler.at>
 <20220825150236.GB240395@roeck-us.net>
 <CA+HBbNEEvyn7a-CXzbFHywvHBky-Kwu8O3POrqo=huOJf-n2pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNEEvyn7a-CXzbFHywvHBky-Kwu8O3POrqo=huOJf-n2pQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 05:07:45PM +0200, Robert Marko wrote:
> On Thu, Aug 25, 2022 at 5:02 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Aug 25, 2022 at 04:37:36PM +0200, Andreas Böhler wrote:
> > > The tps23861 driver does not initialize the chip and relies on it being
> > > in auto-mode by default. On some devices, these controllers default to
> > > OFF-Mode and hence cannot be used at all.
> > >
> > > This brings minimal support for initializing the controller in a user-
> > > defined mode.
> > >
> > > Signed-off-by: Andreas Böhler <dev@aboehler.at>
> >
> > nack for the series, sorry. The suggested properties are not hardware
> > monitoring but phy properties. There should be a separate phy driver
> > to manage those.
> >
> > Also, as mentioned, the hwmon 'enable' attribute is abused to control
> > port functionality and should be removed.
> 
> Hi Guenter,
> Are you referring to an ethernet PHY driver or the generic PHY framework?
> 

Could be both, though ethernet phy sounds about right for me.
I don't know where/how similar chips are handled. hwmon is most definitey
the wrong place.

Guenter
