Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DACE56893B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGFNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGFNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:18:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C09DF0A;
        Wed,  6 Jul 2022 06:18:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i190so1402207pge.7;
        Wed, 06 Jul 2022 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=voMel3NBuNaXdYBPYrExHD2Fy53PT/XndyS1TmBeRqg=;
        b=bxUAYjgehuOZGUYWXyMJ5WblMcCx6iE0mgZUPso/epao9B+8k7p9U74l1Xd/STyeew
         zav54Zys40q4YgxSl87nzE3QO9hhOX4VgPZUqmnfrdhfSgV8qSpbPV4djQ0ZCRO4zxQS
         k40qCbisTEu/Wb08WgsorO9f7sF/6E6VFN2kGWovgef2BZruQSeFY6K9t1uSy186NsNE
         1+S6B+pV3hxWAbezzDVHAhQWqqKl2tHrq+cLLoIkD8hUHbTwXGlHHVsZaAcn/qFxy/Oq
         BuWzbPDZJck6b6aovkwGWZkv1KeejVoMFoIkS/dCmJvJFIqzFQs13iB3Y0lNsgESdYxo
         1Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=voMel3NBuNaXdYBPYrExHD2Fy53PT/XndyS1TmBeRqg=;
        b=E8wPy+fzheJ/EQl7WzXLqIdic55jwfoyfa4Xg60BSwEAFF4GJax8TiSVjp/KmRJPxN
         Z83CXksSlgbhE47Zwk5gcvoM3BVT4qNhIqGCPUEj0NeKatRQoPBznpk9yo05F19Uj1b+
         Yf32NgDvEv5tKkuurgH3472sbESTH29zzXGRbRHd2aqIiJwkobasPyV/m++E6pNCxjiX
         cB2/Ac8nRqMOrYnakoj9+m8LTZ8w8WvCb7l4Swr9WKe3Y4LD3MPHtC4LGym0cDofgBN9
         xdxyPXZDlzjjKyDd++Kvmy+KcKftTAHyNBbLVsrwen2nyvNgTYjBTs5pkCWIOYswDihc
         eYow==
X-Gm-Message-State: AJIora95IM57VX79XxnosQtTWiMIio6CKW2Rs1+fBLYFdcghyegRNOZG
        gj5acDCXSJILe2hIDkrd01I=
X-Google-Smtp-Source: AGRyM1tMa9QjsLu/zfwTLvFw7rNwXKBt+fO2fGXmCnyKBVq/mz+BKkl5NGgqU5+WPXRS4LGJaOJ9JA==
X-Received: by 2002:a05:6a00:240a:b0:528:5bbc:aa1b with SMTP id z10-20020a056a00240a00b005285bbcaa1bmr20186909pfh.70.1657113480515;
        Wed, 06 Jul 2022 06:18:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b0015ee985999dsm25524479plr.97.2022.07.06.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:17:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Jul 2022 06:17:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Kallas, Pawel" <pawel.kallas@intel.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        iwona.winiarska@intel.com
Subject: Re: [PATCH 0/3] hwmon: (pmbus) add power from energy readings
Message-ID: <20220706131758.GA652205@roeck-us.net>
References: <20220706104024.3118590-1-pawel.kallas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706104024.3118590-1-pawel.kallas@intel.com>
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

On Wed, Jul 06, 2022 at 12:40:21PM +0200, Kallas, Pawel wrote:
> Add support for reading EIN or EOUT registers and expose power calculated
> from energy. This is more accurate than PIN and POUT power readings.
> Readings are exposed in new hwmon files power1_average and power2_average.
> Also add support for QUERY command that is needed to check availability
> of EIN and EOUT reads and its data format. Only direct data format is
> supported due to lack of test devices supporting other formats.
> 

I don't think this is a good idea. EIN/EOUT report energy consumption,
not power. The "average" attributes as implemented don't really report
a reliable number since the averaging period is not defined. Also, kernel
drivers should not make up such numbers. I don't mind adding energy
attribute support, but that should be reported as what it is, energy.
What userspace does with it would then be a userspace concern; it can
calculate all kinds of averages from it as much as it wants.

Also, new attributes should not depend on query command support.
I don't mind adding support for that, but it would have to be independent
of energy attribute support.

Thanks,
Guenter

> Kallas, Pawel (3):
>   hwmon: (pmbus) add support for QUERY command
>   hwmon: (pmbus) refactor sensor initialization
>   hwmon: (pmbus) add EIN and EOUT readings
> 
>  Documentation/hwmon/pmbus-core.rst |   7 +
>  drivers/hwmon/pmbus/pmbus.c        |  20 +++
>  drivers/hwmon/pmbus/pmbus.h        |  19 +++
>  drivers/hwmon/pmbus/pmbus_core.c   | 261 +++++++++++++++++++++++++++--
>  4 files changed, 291 insertions(+), 16 deletions(-)
> 
> 
> base-commit: 7c1de25c06f31b04744beae891baf147af9ba0cb
