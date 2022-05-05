Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF76C51CBB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386128AbiEEWBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiEEWB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:01:27 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A41F5C743;
        Thu,  5 May 2022 14:57:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so3792859ots.11;
        Thu, 05 May 2022 14:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=509K5q5w5Q3BFRAS70sMGRGeHF3csETOGikobOSYWkA=;
        b=LcETCIlYbzQXR/6AbUW4QFk5oDcrtbVpfcfzZn3fbYshQ2015TOgGQhFJOtkcd+YSX
         phcvx3bBu26ZpQzb97JQZ4JiLyZ5CF4uUch7kIeTQl79ygztbGw56OBNbRdRaRkz+0Ff
         zPCinQils9bxU6DCWRsSG8xQIXAgAvpoQvwGf2Euv9+2UTU48bwfWDCsVPrZIjPHINNY
         n/RrGeq3w69tT/We5ftF12W8SRFUc51N7w6ouPZAUYVj2+45fs5B0s6A2csCpkbHEUGS
         eqsXFyg8MsOFDToe8ZCrfzBkGB26yaoZ+ZPvx+CDY5ezQ+8oia++R1X39/U0zQeHsjhD
         n0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=509K5q5w5Q3BFRAS70sMGRGeHF3csETOGikobOSYWkA=;
        b=xXpvMmZsjVaZQnyJAtp4N+1MwM8ssAmMA9qSzA3lA7PjDic48YK4JaM+ttgOfSN4KV
         RgbX24GGPq+H7K6zumhX7kzc5JunOMQF6KOTyWMHS6O7eV5dh+1fWgu933G4kcTF749Y
         dua6jyQNnZ6LbY1v1MzFXTFQv1OKafGoLc9EgCkF+kwC8yG7M2jQaFkYItbsGhbExy8X
         3Bnil6cf3p17mbTXSVCXJivpFHFFfR/JSFMRcoaThGsgv1o5dyZF71TCzRg0r1xedUX7
         sg/OrnkJuyREVnM6p58eyxQAgW3tViZQsW3hkEuqqqWFEfxbBnkYGij980ic1zZFpGCL
         ig/A==
X-Gm-Message-State: AOAM531sDlZlbO7FJoIxvtzdSpPqzSduSf0bwHOa59967u0bV+FthXcW
        Mty51X+cfR5rfOfBM3jqewU=
X-Google-Smtp-Source: ABdhPJydUKSEZXQ8aX/lXkp0HXnuTHboM/MSlzYxQ2HDDlSpXRQkkGTPYfsEsUuJM+u7vm5tDhsnbw==
X-Received: by 2002:a9d:2ab:0:b0:605:6c58:668c with SMTP id 40-20020a9d02ab000000b006056c58668cmr107150otl.284.1651787865415;
        Thu, 05 May 2022 14:57:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r1-20020a056870e98100b000e686d13890sm900678oao.42.2022.05.05.14.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 14:57:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 May 2022 14:57:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 0/2] simatic-ipc additions to p2sb apl lake gpio
Message-ID: <20220505215743.GE1988936@roeck-us.net>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
 <20220308193522.26696-1-henning.schild@siemens.com>
 <YnJ2tYjCpJi7yc4j@smile.fi.intel.com>
 <20220504171951.0d569632@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504171951.0d569632@md1za8fc.ad001.siemens.net>
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

On Wed, May 04, 2022 at 05:19:51PM +0200, Henning Schild wrote:
> Am Wed, 4 May 2022 15:51:01 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> 
> > On Tue, Mar 08, 2022 at 08:35:20PM +0100, Henning Schild wrote:
> > > This switches the simatic-ipc modules to using the p2sb interface
> > > introduced by Andy with "platform/x86: introduce p2sb_bar() helper".
> > > 
> > > It also switches to one apollo lake device to using gpio leds.
> > > 
> > > I am kind of hoping Andy will take this on top and propose it in his
> > > series.  
> > 
> > First of all, they are not applicable to my current version [1] of
> > the series (it maybe something changed in the Simatic drivers
> > upstream, because I have got conflicts there. For the record, I'm
> > using Linux Next as a base.
> 
> That is possible, some sparse findings have been fixed lately.
> 
> > Second question is could it be possible to split first patch into
> > three, or it has to be in one?
> 
> I assume one for leds one for wdt and finally drop stuff from platform,
> and i will go with that assumption for a next round based on your tree
> directly.
> Can you explain why that will be useful? While it is kind of a
> separation of concerns and subsystems ... it also kind of all belongs
> together and needs to be merged in a rather strict order.
> 

That is not really correct. It should be possible to split
the patches and only remove simatic_ipc_get_membase0() after the
other patches have been applied.

On a side note, neither subject nor description of patch 1/2
mention that the patch touches both LED and watchdog code, which
is at the very least bad style.

Guenter

> regards,
> Henning
> 
> > [1]: https://gitlab.com/andy-shev/next/-/tree/topic/p2sb-next
> > It would be nice if you can perform another round of testing.
> > 
> > > Henning Schild (2):
> > >   simatic-ipc: convert to use common P2SB accessor
> > >   leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver
> > > 
> > >  drivers/leds/simple/Kconfig                   |  11 ++
> > >  drivers/leds/simple/Makefile                  |   3 +-
> > >  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 108
> > > ++++++++++++++++++ drivers/leds/simple/simatic-ipc-leds.c        |
> > > 77 +------------ drivers/platform/x86/simatic-ipc.c            |
> > > 43 +------ drivers/watchdog/Kconfig                      |   1 +
> > >  drivers/watchdog/simatic-ipc-wdt.c            |  15 +--
> > >  .../platform_data/x86/simatic-ipc-base.h      |   2 -
> > >  8 files changed, 139 insertions(+), 121 deletions(-)
> > >  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
> > > 
> > > -- 
> > > 2.34.1
> > >   
> > 
> 
