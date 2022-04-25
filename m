Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2450DD1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiDYJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiDYJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:51:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E83DA44;
        Mon, 25 Apr 2022 02:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 843AAB811A2;
        Mon, 25 Apr 2022 09:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C1DC385A4;
        Mon, 25 Apr 2022 09:48:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G/HUQzWP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650880116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKHoAv+vmixzGQZWqsiVdYoM9oUo3C3QU7ycqCxzTcc=;
        b=G/HUQzWPvHyfPqCDK8eZ4G9oRrbfNsx1/9jy7kd5NaBjcKkh41EHIaqmC+C+wQtMObrQzD
        CNJg/YNuowYGd7ZyjwEoiQGBJWr8musWmIE5LOu94EapXSWbJHcNwmw4Rvb9NUejyeqsxc
        nyulzrFVHw86Gtpm8zVr4bKnaChENkQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8db81c47 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 09:48:36 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id f38so26018199ybi.3;
        Mon, 25 Apr 2022 02:48:35 -0700 (PDT)
X-Gm-Message-State: AOAM531WMROtZ+O0a5ey0sFV+dHYjQQVvXctR89D4rp9U1j3lhE+IM7c
        +cX6A27uZedwEaQ3Nwxg+wudzHo97XDMzxclSZ0=
X-Google-Smtp-Source: ABdhPJyWYhp+y4cYe4oMYAvdEsEj15xgslG2ghG9AVvAz+nOV1I7ket3X0kl5u7cJeVEyXZU0LLMiXsAZTFv4QwC7uQ=
X-Received: by 2002:a05:6902:1102:b0:645:1658:e19c with SMTP id
 o2-20020a056902110200b006451658e19cmr15087177ybu.267.1650880115159; Mon, 25
 Apr 2022 02:48:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6410:b0:177:a66e:7c46 with HTTP; Mon, 25 Apr 2022
 02:48:34 -0700 (PDT)
In-Reply-To: <YmZtJz4tsP6hr2H5@osiris>
References: <20220423212623.1957011-1-Jason@zx2c4.com> <20220423212623.1957011-3-Jason@zx2c4.com>
 <YmZtJz4tsP6hr2H5@osiris>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 25 Apr 2022 11:48:34 +0200
X-Gmail-Original-Message-ID: <CAHmME9r84RAvALEA91b+uRaRfhM1VJn=bQkPWQ=n+_ZWpnPb5w@mail.gmail.com>
Message-ID: <CAHmME9r84RAvALEA91b+uRaRfhM1VJn=bQkPWQ=n+_ZWpnPb5w@mail.gmail.com>
Subject: Re: [PATCH v6 02/17] s390: define get_cycles macro for arch-override
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22, Heiko Carstens <hca@linux.ibm.com> wrote:
> Is any of your subsequent patches making sure that the asm generic
> header file gets included everywhere? Otherwise I don't see the point
> of this patch.
>

Yes; patch 6 requires this as a prereq. I'm not doing this arbitrarily.

Jason
