Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9368C599B21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348529AbiHSLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348490AbiHSLiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:38:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EA753D28;
        Fri, 19 Aug 2022 04:38:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so4636277pjl.0;
        Fri, 19 Aug 2022 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=pkQp/tVIm+IyNGxzFe2/bIrOHgqIAxdHXzgjR+cRZvc=;
        b=CliF7FRG9tvolY95akZRCp48s8StkzlBXM/iXnL6dgSBMGE3SIddNzeTOWkkoFd7h2
         c+/uzOLozKFsDyDPRWolDgYd7Pk4+vEZ6BRs2Hr+9/xLWfN8Cx3/QCcwJzGIanrhzbrA
         OQbV+w6t1W3PoBXcnUpvwaP6F3h7wMfiYv0W3hS+0+HkPNKsSBL50zpVjp0niCkBpA+p
         vBE03pSVMOy1yPC505P/EKQTA30f1tEhLGDSqXCPgFfhisXEyOHhSRer3SJDjyqlFwHd
         GmkCdqsBwjorfDOrZdTMI0PQ8BcqGLbc8NDO2VSJjSEetGj29LXcqL91Ar6Rurgpc100
         P77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=pkQp/tVIm+IyNGxzFe2/bIrOHgqIAxdHXzgjR+cRZvc=;
        b=3T7HnmulWB2rl8ZDFgRRH08D8bBb6MiDGT0RWORZkaWMnr8VAhFrkRjN4Z7t0JHuZI
         vyXQ7O/V4fCpQppVAsjV0/M0mCz7FmwLCpbgZ6T5QGDM2BwtYQDSWC6q82deAh4g9z2w
         TEICR3P1pr5Aoj8LAPc/gWPLwEkqVJ/04I/T7/TkTDZ4tw9alXmZw9fbc2I47gZqMNoh
         Ru1EowgFHOIKDRRDoPlOoyjzHKuRPz9rbr0bEP0HhXljwgquBXSPz9XYr8gg+sm18eIu
         6J0R12VJR0QxhSvDQpor6rHAHtJZLAnDw7MJrMUOWGzDM4XKbXCpmZsYJ4NHvKQHS0vr
         ze1w==
X-Gm-Message-State: ACgBeo28pzx6IFFlLWlHjFqqQTc6Vjy/yRBiu6TAH9Il2Y93+j5mrI25
        7Hbm2n1X+uFks5emjXpKbm4=
X-Google-Smtp-Source: AA6agR4+JPTBAZi6VgxPOG05ZW9iglyFXeYS4kupg5clWtSXqD4kNYsxdGi/ahV7W+m3PMqqndYW4g==
X-Received: by 2002:a17:90a:9907:b0:1f5:2318:ea6d with SMTP id b7-20020a17090a990700b001f52318ea6dmr8067012pjp.163.1660909124525;
        Fri, 19 Aug 2022 04:38:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b0016c1b178628sm2979524pll.269.2022.08.19.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:38:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 04:38:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 14/16] hwmon: (mr75203) parse thermal coefficients
 from device-tree
Message-ID: <20220819113842.GD3106213@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-15-farbere@amazon.com>
 <20220818202839.GA3431511@roeck-us.net>
 <e0b133e7-ac81-acf4-3783-44edf58d6426@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b133e7-ac81-acf4-3783-44edf58d6426@amazon.com>
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

On Fri, Aug 19, 2022 at 10:57:58AM +0300, Farber, Eliav wrote:
> On 8/18/2022 11:28 PM, Guenter Roeck wrote:
> > The calculation was just changed to use new defaults in a previous
> > patch. This patch makes it quite clear that the coefficients
> > are implementation (?) dependent. So the previous patch just changes
> > the defaults to (presumably) the coefficients used in your system.
> > That is inappropriate. Adding non-default corefficients is ok
> > and makes sense is supported by the chip, but changing defaults
> > isn't.
> The calculation was changed in previous patch to match series 5 of the
> Moortec Embedded Temperature Sensor (METS) datasheet.
> In our SOC we use series 6 which has a slightly different equation and
> different coefficients.

If the coefficients are different based on the series, it would probably
make sense to create a separate devicetree compatible property for series 6
instead or requiring the user to list the actual coefficients. Those can
still be present, but the code should be able to use the defaults for
each series.

Guenter

> I did the changes in steps.
> With this last change, both series 5 and 6 are supported, in addition to
> calibrated vs. non-calibrated modes.
> In addition the data sheet just recommends default values but they also
> specifically mention that actual values might vary from product to product.
> 
> --
> Regards, Eliav
