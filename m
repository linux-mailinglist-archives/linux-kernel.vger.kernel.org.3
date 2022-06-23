Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B499557E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiFWPbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiFWPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:31:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD135253
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:31:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so2930615pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nF21AMsePORR8NSmiZC16+IO4b1x+xGFURv4Jfcr2KU=;
        b=MDikssTDJBivrf7MFu7wpENpKEqs1bTYneb/uSPr6/bVznvDeaadv73nvz7RNbRzsw
         YNBf3+zs2d1SLbGCrxa9joc6OLHsp27hbQJo2dknl4ktkrI8E8dxtjB57TmwmZsJzo/g
         vc37yYKahKwVwA/TB+2doCjr/aDr7/3UZH9Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nF21AMsePORR8NSmiZC16+IO4b1x+xGFURv4Jfcr2KU=;
        b=kyQV0KQ8zrtFgKrz+MeDIajF3qOkVRF4+8L0MKcUP2dEzlo01L/8Yr2E+1PyBu5pWM
         q2yKGWVvtMtG9mhZbpxisF5mACoSk+NFFJGLgz73ouxVTtMriQslyqJCZZ7XkN5ipTyB
         RGDKPclhEl4HBxEQy/jUaUsZMvpeBNNC2DIp/uyGiJY8iT+IxkqW3Bf6LmMsriVEhIme
         JtTCcCbm63huWkBD8a1X5sRfUAj9pBE55QM3ETHAkfA0SwBoGwDv6ivT2ahvSHbwrQ+F
         10O6VA9cEbkRh36l6czPjW7Xf9RnsAHZge281jXl4sUzJKE2O1/21CRdZOZZWgznM/yj
         kpoQ==
X-Gm-Message-State: AJIora/vZ8q8ZO1vITTA1q6o2najUQoEW9NNXUc0naKJBbIlahOo5K6n
        2dHLx/JDXtUxFrDNHYJdSUa5Hw==
X-Google-Smtp-Source: AGRyM1vveulzuiFHa0EJS+9PSYlmSmxndXMHB2Wzv5EZgFG7b48WcVfPSKdw4vEPYTcOozUThiNu8w==
X-Received: by 2002:a17:90a:1c09:b0:1ea:91d4:5a7f with SMTP id s9-20020a17090a1c0900b001ea91d45a7fmr4610861pjs.232.1655998270378;
        Thu, 23 Jun 2022 08:31:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x67-20020a627c46000000b0052549cc3416sm3917955pfc.175.2022.06.23.08.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:31:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     dan.carpenter@oracle.com, gmpy.liaowx@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        anton@enomsg.org, ccross@android.com,
        Tony Luck <tony.luck@intel.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pstore/zone: cleanup "rcnt" type
Date:   Thu, 23 Jun 2022 08:31:05 -0700
Message-Id: <165599826298.1932382.1524111439094870680.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YrRtPSFHDVJzV6d+@kili>
References: <YrRtPSFHDVJzV6d+@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 16:40:13 +0300, Dan Carpenter wrote:
> The info->read() function returns ssize_t.  That means that info->read()
> either returns either negative error codes or a positive number
> representing the bytes read.
> 
> The "rcnt" variable should be declared as ssize_t as well.  Most places
> do this correctly but psz_kmsg_recover_meta() needed to be fixed.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/zone: cleanup "rcnt" type
      https://git.kernel.org/kees/c/2c09d1443b9b

-- 
Kees Cook

