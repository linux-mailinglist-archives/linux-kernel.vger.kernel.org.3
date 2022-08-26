Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907685A27B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbiHZMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbiHZMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:21:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6437674C;
        Fri, 26 Aug 2022 05:20:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t129so1386766pfb.6;
        Fri, 26 Aug 2022 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=59ExtF48Z2+vGviQ5JT32mWzE6IvJ75v7GYqKj4e16Y=;
        b=WQOU5q+OoOzPr1bMskgUFeCAK4d9cXLh0yU/HA9rpkwVwKZb2OdqaFSn81kuQpFPJ7
         Fg1dCA0trRi70qnxrD2CmVv2wQGeQtpyt7mf0FcXn9xsycAFtr4mz3i477yfiQOuxsEd
         8ce0i6vdT3sELTNlUvqS3yecvu2poHH4WthCWVmmJi9lbdaGwp80AoaivLS3oHRMEu0c
         D0C5dO5G0bEgbnLayrCLD9oL2BRH6unPk+I0WxJKA4VpmuRF1TVFY5soAst07v/iLd6G
         9hbqvdfoTQ5BVciOltyX8Bhc3a9zSlWZao8sNFo9qm9NUFSODNjsJz5UjJ25pPkSJ8xS
         u/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=59ExtF48Z2+vGviQ5JT32mWzE6IvJ75v7GYqKj4e16Y=;
        b=ZoyAcMI7Ohr98GpiZ73ee7Ky2Fn1xwOjFUywYOAOsgjTDNy4AE4tzhtNEmIjoQkC3D
         6xTSpjyuVPe4ygSm8kfXe0Oa26bEfovf3LQxI7nKTG9G5n66B4fuYwiLMqFqxmjzvynG
         77ScDxKy380SRw/D9h54HSHYRZQqS3pTOcy8U4wq9b0BajGE7H5F2khc+VIf8okxMhex
         4TbNRQsg2tvxPwS13Zq35X5bH8eoKIzKTy3/xfUazQkh+SWoENwXKMxBcGVuHJcpKCQl
         BUbF4rcyCs1ujou0yWQZl/TOsOO+oKawFtJQaoOr1I4tfmr18r41Sn7V3SDDmUmzqo7V
         JoJw==
X-Gm-Message-State: ACgBeo3QTOdSU/cOnGMMMXwtD5m0G6oyogUKOx4XmI+dlmy3g52kLL3M
        5FBOfhpjb2h9ly6WZ5ihThU=
X-Google-Smtp-Source: AA6agR4OpfpC6IwX4K56VI00fJs3GzZ/3hkLwq6ovd57/qBTvUsWIzHX98cZUrRLT/iO90pZh12IuA==
X-Received: by 2002:a05:6a00:acc:b0:530:e79e:fc27 with SMTP id c12-20020a056a000acc00b00530e79efc27mr3640679pfl.61.1661516395878;
        Fri, 26 Aug 2022 05:19:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902ea9300b0016f975be2e7sm1407426plb.139.2022.08.26.05.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:19:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 26 Aug 2022 05:19:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Andreas =?iso-8859-1?Q?B=F6hler?= <dev@aboehler.at>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Documentation: devicetree: update bindings for
 tps23861
Message-ID: <20220826121954.GB2897306@roeck-us.net>
References: <20220825143737.77732-1-dev@aboehler.at>
 <20220825150236.GB240395@roeck-us.net>
 <CA+HBbNEEvyn7a-CXzbFHywvHBky-Kwu8O3POrqo=huOJf-n2pQ@mail.gmail.com>
 <20220825152934.GA1439919@roeck-us.net>
 <CA+HBbNH5GGrqN4mUB2hByVuTjc02f_t88pdpKEKXNjxScYyrtw@mail.gmail.com>
 <9d25d239-8d40-e639-c5e5-a308bc41d22f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d25d239-8d40-e639-c5e5-a308bc41d22f@linaro.org>
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

On Fri, Aug 26, 2022 at 09:56:29AM +0300, Krzysztof Kozlowski wrote:
> On 25/08/2022 18:31, Robert Marko wrote:
> > On Thu, Aug 25, 2022 at 5:29 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Thu, Aug 25, 2022 at 05:07:45PM +0200, Robert Marko wrote:
> >>> On Thu, Aug 25, 2022 at 5:02 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>
> >>>> On Thu, Aug 25, 2022 at 04:37:36PM +0200, Andreas Böhler wrote:
> >>>>> The tps23861 driver does not initialize the chip and relies on it being
> >>>>> in auto-mode by default. On some devices, these controllers default to
> >>>>> OFF-Mode and hence cannot be used at all.
> >>>>>
> >>>>> This brings minimal support for initializing the controller in a user-
> >>>>> defined mode.
> >>>>>
> >>>>> Signed-off-by: Andreas Böhler <dev@aboehler.at>
> >>>>
> >>>> nack for the series, sorry. The suggested properties are not hardware
> >>>> monitoring but phy properties. There should be a separate phy driver
> >>>> to manage those.
> >>>>
> >>>> Also, as mentioned, the hwmon 'enable' attribute is abused to control
> >>>> port functionality and should be removed.
> >>>
> >>> Hi Guenter,
> >>> Are you referring to an ethernet PHY driver or the generic PHY framework?
> >>>
> >>
> >> Could be both, though ethernet phy sounds about right for me.
> >> I don't know where/how similar chips are handled. hwmon is most definitey
> >> the wrong place.
> > 
> > Hi,
> > 
> > Well, that is the thing, this is definitively not an ethernet PHY nor
> > a PHY of any other kind.
> > I dont see where it would fit if not hwmon, there is no more specific
> > subsystem in the
> > kernel.
> 
> It's not hwmon. The device has monitoring capabilities, but it's only
> one piece and calling something hwmon just because can provide sensor
> data is like calling a plane a car, because it has wheels.
> 
> Maybe this is similar to these series:
> https://lore.kernel.org/linux-devicetree/20220825130211.3730461-1-o.rempel@pengutronix.de/
> ?
> 
> The datasheet says it is a "PSE Controller" so looks similar to the
> problem solved above...

Excellent find. That infrastructure is exactly what the driver for this chip
needs to tie into. I would suggest to get in touch with the author of that
series - it is quite likely that they are working on adding support for one
or more real PSE chips.

The only open question is if the hwmon driver should be retained as a
separate driver or be implemented as part of the PSE networking driver.
I am open to both.

Thanks,
Guenter
