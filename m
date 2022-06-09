Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21615545686
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiFIVg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiFIVg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:36:56 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407974CD7D;
        Thu,  9 Jun 2022 14:36:55 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id p128so4046811iof.1;
        Thu, 09 Jun 2022 14:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2GI2KI1Sv9nVJuFCWd4uVdfP1TjuW2GDmuuGQs73bfQ=;
        b=Rh3MnhnBt0E83Jeba6SVddAiv8ADnVc10r9w4p79vf0UtG+jGdiT4iJeWuRvKy5Ly9
         FYVMbHO+1qoge5/E/vzojq4kSVJVC5wRGRGfQQcdHyo3nFIPhMDgl6eeHT/ApAmjqYR0
         8Wt5CK3AH0rpYxq2deIkGQh7b4x27iBCTUtDDAcPj/WPIHS6D00af8vRnlT8hI4xtc9J
         dx/+Nm8agthoebEG8RWXK3G1/75R4AnnH+PnBLXheXjR4rZhuCYITaDrZRI8Sm8anVxu
         AJXGzdPOc4ZEEOla9LZLY1zny4p8/GtWhT40/gSVNZeEPUxH8O2l7Eg5nyxHSfl9LlwK
         Ak8w==
X-Gm-Message-State: AOAM531TI3CQKx2Mul5izPoRbuIYpvB5v/J1NubK8k432OanYID3sIkC
        9G/+uhPULOBXh8wcJk4Qa9VEFOw3EA==
X-Google-Smtp-Source: ABdhPJzmA9HKNjxiz4/zlBnWfsm/zBXu8DtBqt+f4EU3yMC+DxOPgS7LmN16jxvFjKOtvP2Avki6tw==
X-Received: by 2002:a05:6602:2cca:b0:664:d9c6:3674 with SMTP id j10-20020a0566022cca00b00664d9c63674mr19416950iow.67.1654810614520;
        Thu, 09 Jun 2022 14:36:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t15-20020a02ccaf000000b00331767e8113sm8418064jap.52.2022.06.09.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 14:36:54 -0700 (PDT)
Received: (nullmailer pid 139789 invoked by uid 1000);
        Thu, 09 Jun 2022 21:36:52 -0000
Date:   Thu, 9 Jun 2022 15:36:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoan Picchi <yoan.picchi@arm.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] Removes the x86 dependency on the QAT drivers
Message-ID: <20220609213652.GA115440-robh@kernel.org>
References: <20220607165840.66931-1-yoan.picchi@arm.com>
 <20220607165840.66931-3-yoan.picchi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607165840.66931-3-yoan.picchi@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:58:40PM +0000, Yoan Picchi wrote:
> This dependency looks outdated. After the previous patch, we have been able
> to use this driver to encrypt some data and to create working VF on arm64.
> We have not tested it yet on any big endian machine, hence the new dependency

For the subject, use prefixes matching the subsystem (like you did on 
patch 1).

The only testing obligation you have is compiling for BE. If kconfig was
supposed to capture what endianness drivers have been tested or not
tested with, then lots of drivers are missing the dependency. Kconfig
depends/select entries should generally be either to prevent compile
failures (you checked PPC, RiscV, etc.?) or to hide drivers *really*
specific to a platform. IMO, we should only have !CPU_BIG_ENDIAN if it 
is known not to work and not easily fixed.

Also, with the dependency, no one can test the driver without modifying 
the kernel and if it does work as-is, then one has to upstream a change 
and then wait for it to show up in distro kernels. You could mitigate 
the first part with COMPILE_TEST.

Rob
