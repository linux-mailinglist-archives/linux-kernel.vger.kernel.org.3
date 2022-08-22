Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1286E59C412
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiHVQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiHVQZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:25:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C02C40569;
        Mon, 22 Aug 2022 09:25:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso6136016pjb.0;
        Mon, 22 Aug 2022 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=4loECkPREqd2KldEisF0VFFtJVa4MK+m9ZV3bvHaKd4=;
        b=PijjwuK0QygrWuX++4tMf+m0vUD4Oe/mNMbf1MM2BjAgbwZVhCn3VPqAnuEn/PjQ1t
         Bs4ymE7HP+BjR2n8hyd2NkaUKnfnc7G8TQKAA2W3XpBnb38nwCOTwXefWb5Utp7S0Bad
         KdjLMsC72yuECNVPWLu/HqTDKH7RQMTfx5GUxI8Y+tmvT3uoGUTtDr3UQqmBE6kw3AUR
         pobniaU9nyHRqyiSudFaydNxYrRhzUfqs3MXZiqCeHE7OETzpcze9jiPBbC0zaYFXeUb
         1qA0yzYK0oEWpzgCg/bQDYPlJmsVls+N7kdDuVm2xyRHpLLz0SjvSy6FpvWNGR0ijxWC
         HW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=4loECkPREqd2KldEisF0VFFtJVa4MK+m9ZV3bvHaKd4=;
        b=X6NcKDpnM+v71DN+0gN/nvskwRUpn1pAsgmdGGaa5O+uEE02tT2g773MjJxXqqaNCw
         DUa0JUPBE5ujNfFJ6SVIgCoySa7Zy4ecKsvmH9YHED1PMu8tYXx3UfYaq2Yw/Qh6WKSo
         y4tCTZflTsTPjGqMTwx4+yPN6kIteV6sb/gVPF9MbPlKSt+mm2+dIdqSToe8LjXjUUWx
         gPAMdul+/mgyJSUN3wPcMohhaQgsYesKhw2DLY63UvW8AU0Pd8g2vIkzWLjyPfrLnAAD
         B0dug+2gP6b0xTYCja0qvadq3xx9n0zXMbqcVlNgvD2Sljc/85C1MHQUf5tGPhtH0nF4
         kccQ==
X-Gm-Message-State: ACgBeo1naY13/HqRhFFV0gzZ1tkYAc5MCZNJx54l6Sfz3q93W2rwvDwg
        ztJvNQiu2j8AeVgXdlYwBsQ=
X-Google-Smtp-Source: AA6agR5uPcCO/iIC8BrdjXOXXObRD+jLn5sIcoDWY0fUpRAKCaheaoumTsmutXPH0/+IcxFhZd3Q9g==
X-Received: by 2002:a17:90b:3c0b:b0:1fa:fe78:6385 with SMTP id pb11-20020a17090b3c0b00b001fafe786385mr13993071pjb.55.1661185522627;
        Mon, 22 Aug 2022 09:25:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5-20020a624d05000000b00536b67c6a80sm1999442pfb.109.2022.08.22.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:25:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 09:25:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 13/16] hwmon: (mr75203) add thermal coefficient
 properties for Moortec PVT controller
Message-ID: <20220822162519.GC4098765@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-14-farbere@amazon.com>
 <20220818202531.GA3431466@roeck-us.net>
 <58a79e41-4d20-0e30-cecd-4ca37dd3dbfd@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a79e41-4d20-0e30-cecd-4ca37dd3dbfd@amazon.com>
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

On Mon, Aug 22, 2022 at 04:24:20PM +0300, Farber, Eliav wrote:
> On 8/18/2022 11:25 PM, Guenter Roeck wrote:
> > On Wed, Aug 17, 2022 at 05:43:18AM +0000, Eliav Farber wrote:
> > > Add optional "ts-coeff-g", "ts-coeff-h", "ts-coeff-cal5" and
> > > "ts-coeff-j" properties to be used instead of defaults for the
> > > thermal equasion.
> > > 
> > Vendor prefix again, and shouldn;t there be some note about the
> > to-be-used defaults ?
> Can you please explain why to add a vendor prefix to these properties
> (and also to all other properties I added in this series)?
> All the properties I added are not specific to our SOC, and any other
> vendor using the same mr75203 ip block in their SOC, can also use the new
> properties.

To me it seems that the properties are very mr75203 and thus vendor
specific.

However, I am not a DT maintainer. Stepping back to let DT maintainers
respond and state their preferences.

> 
> Regarding defaults, these properties are optional, so if they are absent
> in device tree, the current defaults in code are used.
> 
Same as before. Question was if DT should say what the defaults are.
I'll leave it up to DT maintainers.

Thanks,
Guenter
