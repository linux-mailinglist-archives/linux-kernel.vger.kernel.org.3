Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70B4AB21E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiBFUgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 15:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiBFUgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 15:36:12 -0500
X-Greylist: delayed 353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 12:36:02 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD0A2C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 12:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644179761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ub4wT3g1eEoacmxyeWdpfyTXDKmJ6OBjCuUvDbLP1ok=;
        b=DZ/C/jES8PbembTY73e34zD6NkYgayEmXEYFvaPZkaPtOLlWINCQ5SZJIUL5qkBmNTHHod
        6lcTNVtnwKP51LRX9i49c9JeTd4KSX8BjDVh/dKwpHF7/nq1fUarxtoFKLmSep2GY76V6N
        YlMw32ev9XTAc3BCplTSuYZL/SWKtrE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-wuHtlgk_PUOzDv83FHHKAA-1; Sun, 06 Feb 2022 15:29:03 -0500
X-MC-Unique: wuHtlgk_PUOzDv83FHHKAA-1
Received: by mail-qt1-f200.google.com with SMTP id j30-20020ac84c9e000000b002cf986622d1so9602177qtv.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 12:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ub4wT3g1eEoacmxyeWdpfyTXDKmJ6OBjCuUvDbLP1ok=;
        b=p7wQ6+T8Qc6kT1ZWr4pdz4m9Ri88MXrTgnjjKfTMl5eC8/IVv7ijWurUEfc0sO/1S6
         CaWo6FAD/BgGRp1StejcaQWCeJJToVYKVRwsy/wdEX/3GXLrV4PzP9EA7o+NNOZH6dXD
         p+8W5yFthh1cgRo6tOcRAf6RCeR7DbUnXpddx6Y7cOSmFXT7VljNZpFsyIrAWyWG1V8b
         u6WykiEWN61hzcc3xSyzT89JIUmk2iDCW4E3Ds1f+Hx+CIWjnyAKnBSCG/Vg1ir6+ZOZ
         8CaVJVfXd0gE5R7Vs27kzujCqOixtd2P1FLqCewZiMlm5J5M5jQBaqeErEjh4n17XbJ0
         HMsQ==
X-Gm-Message-State: AOAM530rDTXhljfYNZonWczdk7mgC1vztegnXXES2HEN3WBaC0trw29E
        3/pgFyA/V0Y2p+nO/xEfoLhvNA6jCNutOc/qozMive91vt0sdJIll9LnaOQHN7c1dLW1ddCiu5p
        MK9USpYh+gHF6gjNfiGpVVkbR
X-Received: by 2002:a05:620a:25cf:: with SMTP id y15mr4970116qko.5.1644179342328;
        Sun, 06 Feb 2022 12:29:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlYm/9ZE7/n4Gj9eikLBGdP/yDuKDpFjIHf+OHBDrsFa/tw/sgdy6bSuTcDCVvzl6oR3zf5A==
X-Received: by 2002:a05:620a:25cf:: with SMTP id y15mr4970109qko.5.1644179342104;
        Sun, 06 Feb 2022 12:29:02 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id s11sm4887896qtk.82.2022.02.06.12.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 12:29:01 -0800 (PST)
Date:   Sun, 6 Feb 2022 12:28:59 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
Message-ID: <20220206202859.butmvavyw3tce4hs@treble>
References: <20220117194836.vj2rxr3wocrtdx7k@treble>
 <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
 <20220118175239.lqxi2ycgeusk5pxl@treble>
 <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
 <20220119212126.aydgx62abbngumwy@treble>
 <20220119234303.tmebbcrg2vpnri4s@treble>
 <CAPDLWs-DM64k6z3G7qgYwYm=F8piehYhLfaaXc3fDtnBBQiu=Q@mail.gmail.com>
 <20220120171751.gibauc4zovoskjns@treble>
 <CAPDLWs_28zYabLjsyT2gq-o6vEzidWB4mpGuUGdiYr0qb6YFWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDLWs_28zYabLjsyT2gq-o6vEzidWB4mpGuUGdiYr0qb6YFWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:35:13AM +0530, Kaiwan N Billimoria wrote:
> > Try this one?
> 
> Definitely better !
> This is the o/p i now get:
> 
> $ <...>linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko
> do_the_work.cold+0x68/0x126
> do_the_work.cold+0x68/0x126:
> delay_sec at <...>/oops_tryv2/../../convenient.h:279
> $
> 
> The source file+line-no doesn't show up here though... (as it's a foo.cold()?).
> (I'm unsure why the line delay_sec at <...>convenient.h:279   shows up
> ; i don't call this delay_sec() func directly... anyway, that's my
> problem.)

Hm... do you get the same result with addr2line?

-- 
Josh

