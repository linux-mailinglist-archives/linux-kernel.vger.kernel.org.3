Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DAF540077
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244951AbiFGNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbiFGNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:51:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8FBBF887
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC383B81FD1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53953C341C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:51:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZNUeRYOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654609898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q4QsDWD9gMZnGSWO1AiZLllbLhjU6L2F/1RZHeLHa/4=;
        b=ZNUeRYOtdoBlzz0goMYB2W74f8gRPb4uH+lfDJxCDf9lG2DyoltjejNPTmxifeQPVeOMiD
        CDLVUdV+cJvFgpNSd5Kf3gSBJx5nA5MGEyqY+wQeTZYzyl3GY3h5RnJ+S7ceK+bIrt9t2a
        +27e8M8IZKLjqwCpR1Fky0bi1HpsLu8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bc359a60 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 7 Jun 2022 13:51:38 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id a30so12501450ybj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:51:38 -0700 (PDT)
X-Gm-Message-State: AOAM533qT+s6m/C4XkC+6AZiHrIcxnXvb/0CEDt/VmueGQDGDZwRnJJ/
        H4kEXeTgjvP0yf54eOWF4uNGA/yNFKP1la8aNqU=
X-Google-Smtp-Source: ABdhPJzzA3fKlaZoi0aZQgbzbc6gFSECRxk3zq4zcVhMMtu2BmDjV9qgDilSBdllfi8EmpdoSivjZ2FWKFUKpL3Neys=
X-Received: by 2002:a25:8d92:0:b0:656:a73e:a7f with SMTP id
 o18-20020a258d92000000b00656a73e0a7fmr28961179ybl.382.1654609896215; Tue, 07
 Jun 2022 06:51:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6407:b0:181:6914:78f6 with HTTP; Tue, 7 Jun 2022
 06:51:35 -0700 (PDT)
In-Reply-To: <9a5d23ee-06d2-82e3-1e32-00367125990d@raspberrypi.com>
References: <Yp9DWT3RttJGZhvu@zx2c4.com> <20220607124450.794347-1-Jason@zx2c4.com>
 <9a5d23ee-06d2-82e3-1e32-00367125990d@raspberrypi.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Jun 2022 15:51:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9owv1Cj8=XVV+i-4uC9Tc1TsKDUMeFcO-ziGv88GRk8Ow@mail.gmail.com>
Message-ID: <CAHmME9owv1Cj8=XVV+i-4uC9Tc1TsKDUMeFcO-ziGv88GRk8Ow@mail.gmail.com>
Subject: Re: [PATCH v3] random: defer crediting bootloader randomness to random_init()
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

And this one also works, I assume?

https://lore.kernel.org/lkml/20220607100210.683136-1-Jason@zx2c4.com/

Jason
