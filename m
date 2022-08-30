Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42E5A6F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiH3VUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiH3VU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:20:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420772DA9A;
        Tue, 30 Aug 2022 14:20:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so7777908pjj.4;
        Tue, 30 Aug 2022 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=j4alffD/D7kzGiND23XpCOGOeBaO15i/mjxY+rZ6Dn4=;
        b=ndGS/wNjmHWgK+omDL7ze19Cevd3dalrXQTuMMPRrDrwBBpvzgXKLyDiJvAHW6Rad1
         nzR4Y19FuBXPmjZaBn8mUY5y12G4dSFwk9tfOZbI5drfDhbbuxmpFb8SvjxvC5Zi22Z5
         johI1pl1cG/B9JqJdJNUqJrl++0fugS0qjgZcHswzBlbFyLmlPzqJuO9FOt7KwHGnZBD
         UjDBrBT2/wG+zyePUoWsPpOUQZIf5kz0FzeFHyoBbdMO26XbDORfcDmtc/HyvsXCjqFU
         fr5vr0bcxuM7eB8IoIGCuCfBofGDV3U85myWX4oqQHxe/g0GsYcZdCVRdTHbbhJUYXLg
         mEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=j4alffD/D7kzGiND23XpCOGOeBaO15i/mjxY+rZ6Dn4=;
        b=okA747AV85tDT3f8H/agBxQI3f+5483TpBnogcXBBsKm9OmehXTfCKhf/jJnpluka2
         /Y1kMB0dWha5tKNpdxV9gMebm05adFoM3D+rsXsGKvqYSbRA6edUK+4Rxl7725nqOxoV
         vwxqqt9uzcmu2mZohRuBG3fdLJKSBs2leOdfCgZdff295AoWy3o1Wb/fHOb50+vxpG+6
         oIdzbOPOEpbgWydRf7NdOa+CI+NqCruZt1vvWjCaD0BrrJ9ARlMIZx3ckI6GJucGGX3S
         LqHKUnUp4VVFzYDLKfoCViliQ+DmNoSNanH66VWsy6THzMsY93NJOtinDUk7s0NZ+sGW
         xXBQ==
X-Gm-Message-State: ACgBeo1AtD5+WtbIUHZsJJIEtTeOtpJAnVSEluu4Tdbn4jS318GUQbPl
        Kt7fm/OB34/fY16s35kT0x4=
X-Google-Smtp-Source: AA6agR7PwLbmdaH7zupxEeVjYDxxso+p15aiNbseUde2lEkz04zyKHyAzXzQlZpuTBFecqYD76O0UQ==
X-Received: by 2002:a17:90b:388c:b0:1fb:6738:6e50 with SMTP id mu12-20020a17090b388c00b001fb67386e50mr145410pjb.231.1661894425629;
        Tue, 30 Aug 2022 14:20:25 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2488:79db:897a:5de7])
        by smtp.gmail.com with ESMTPSA id f11-20020aa79d8b000000b00537f16e25d3sm7593184pfq.75.2022.08.30.14.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:20:24 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:20:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Input: matrix_keypad - replace
 of_gpio_named_count() by gpiod_count()
Message-ID: <Yw5/FWCssyHyzFOm@google.com>
References: <20220830183552.50695-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830183552.50695-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:35:52PM +0300, Andy Shevchenko wrote:
> As a preparation to unexport of_gpio_named_count(), convert the
> driver to use gpiod_count() instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thank you.

-- 
Dmitry
