Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B121A59C418
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbiHVQ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHVQ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:28:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BFB40E35;
        Mon, 22 Aug 2022 09:28:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f21so11510505pjt.2;
        Mon, 22 Aug 2022 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=YZmav0eU9Re8BRlMJU0qUlh7LdCj5JWcUumcigXHBac=;
        b=eCDPhFB5hJl5EvTuxV5MVr5fM/PfS5HR20uStCf9L/RoP17bBuyr3VXqZ6N2fhTn1n
         GIOLVWCSKjih3mnz0lIkMgI70fIpdlwq2iG7mqSPXz2TAbXbl8HLz/rMpOVYtWLBTP4N
         DyiDazVAxuWWnoY02lSNoem2I9Xhi6NYB24nCzvntSs/yB1wCbSa3qbu76ENlJJxUtTr
         BkpfebRdOhkLgPgtt+jsQ+Mo0+a8WU6SwRAwXWTk0ibV3/ISyQTu8x/X234QiEIqytRY
         w83mPFAa2FfX+m7MQ8ktIWWv/eQXAGL9XhLp1tMCv1eQThcZvdJxZc+JLo5nRB6ilz7M
         juKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=YZmav0eU9Re8BRlMJU0qUlh7LdCj5JWcUumcigXHBac=;
        b=7ZMX14RGQPYZRlYioIdSZVZj+5f7WrthkXAK86QKtQg0brXJlDshIVkVesTcr1ryf+
         QWpsdvcapQ8aVCUAm6VkUCfses2v3Bilaqx6Dtf0FsKzUPFlj7fT1IkUZ3GiR6U4v500
         A+qrmm/nPTKEBAIOoA4zST+LPjRz46CiLMboO3QuB6gc3Bxi1xhCQucvYflhez4fPn/t
         OkPfFh5ooIDZ9T2iNogjkcpMZjkz2cBAftQJLxJV8+xmRPXCHXouiZnkXz0Vwkw3ZmCo
         7004cbltLAtoHmNgGOcFYRQV6pnEGOS4O2eDaWO4sig8U1ysLN7XMhtP0d31dltsV9BS
         KQnQ==
X-Gm-Message-State: ACgBeo156Ugj1oBwSTHK3Km0qqYaPwNHHaB3f2wqapqgchFCzyS8pLo2
        +GC1yznkCcite/hvWx1CmzE=
X-Google-Smtp-Source: AA6agR473qXL38cHZi5R9+v5xe244jooMU//Vzuh+SV6bxCcqDn0LDVHT89UukOgNgLNxYQ38eNVoQ==
X-Received: by 2002:a17:902:ce04:b0:172:9ff7:6747 with SMTP id k4-20020a170902ce0400b001729ff76747mr19929368plg.166.1661185687900;
        Mon, 22 Aug 2022 09:28:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m21-20020a170902d19500b0016d1bee1519sm8525757plb.102.2022.08.22.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:28:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 09:28:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 16/16] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <20220822162805.GD4098765@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-17-farbere@amazon.com>
 <20220818231106.GA3505191@roeck-us.net>
 <75165e58-8601-1fe5-7bdb-98761a73701f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75165e58-8601-1fe5-7bdb-98761a73701f@amazon.com>
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

On Mon, Aug 22, 2022 at 04:59:43PM +0300, Farber, Eliav wrote:
> On 8/19/2022 2:11 AM, Guenter Roeck wrote:
> > On Wed, Aug 17, 2022 at 05:43:21AM +0000, Eliav Farber wrote:
> > > This change adds debugfs to read and write TS coefficients - g, h, j and
> > > cal5.
> > > 
> > > The coefficients can vary between product and product, so to calibrate
> > > them it can be very useful to to be able to modify them on the fly.
> > > 
> > > e.g.
> > > 
> > > cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
> > > 4096
> > > 
> > > echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g
> > > 
> > 
> > What happens if you write 0 into all those attributes, or 0xffffffff ?
> The driver equation is:
> T = G + H * (n / cal5 - 0.5) + J * F
> So I added protection for cal5 not being 0.
> Besides that there is no limitation on what these values can be.
> I can't really think of any other logical limitation I can apply.
> 
There needs to be an overflow protection. I am quite sure that 0xffffffff
would result in overflows and thus in quite random reported values.

Thanks,
Guenter

> --
> Regards, Eliav
