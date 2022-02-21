Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5635F4BE38A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355362AbiBUKsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:48:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355319AbiBUKsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:48:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF255BCA;
        Mon, 21 Feb 2022 02:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3806660B93;
        Mon, 21 Feb 2022 10:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38375C340E9;
        Mon, 21 Feb 2022 10:09:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WNaGEVBu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645438162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=663bi0btOdMwWSIP5MYRTJ1EmeBsqVVdWTgAxhqojTU=;
        b=WNaGEVBuv3933p/CiZuGaQH/J9KTjy4xGpRxF+Q+Eh7cwjwmI1BB6r+cvqINRig5iDPlo/
        D7ni9gst3HEI1A3XfYNWeiiQ3pkXTIOU5VNuvWQ4gsRsoVQmrLaoF9y0qtUJ2UruZHN10N
        Hf2ulZy0tjJ1BxjbhgNtMV9zyooz2+4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7e1a23b8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 21 Feb 2022 10:09:22 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id e140so33134254ybh.9;
        Mon, 21 Feb 2022 02:09:22 -0800 (PST)
X-Gm-Message-State: AOAM532BQF8M+dyJrJO+VbzM3H3ZiwoLmpMR326xOoUJw0E0Hlq2noRy
        3/hb87+8DtMWYMWaHZpS+m1Zap5S1T2RPo6h0zQ=
X-Google-Smtp-Source: ABdhPJxFGlCjT3M1KD6pw+F9N9ccpikmOPaVYGXkNUj2MRUkhfVtYM75hf+4YVUyqj5XTUNhtlOlwyZo/JxroYnPqjM=
X-Received: by 2002:a5b:d11:0:b0:623:fbda:40f4 with SMTP id
 y17-20020a5b0d11000000b00623fbda40f4mr18206844ybp.398.1645438161856; Mon, 21
 Feb 2022 02:09:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:71a8:b0:167:24f9:2d40 with HTTP; Mon, 21 Feb 2022
 02:09:21 -0800 (PST)
In-Reply-To: <20220218121054.45304-1-Jason@zx2c4.com>
References: <20220218121054.45304-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 11:09:21 +0100
X-Gmail-Original-Message-ID: <CAHmME9rQbEAc5Ap0ghxAJ+mvUmiDeJE7oiLNBFPngdNYh5MThQ@mail.gmail.com>
Message-ID: <CAHmME9rQbEAc5Ap0ghxAJ+mvUmiDeJE7oiLNBFPngdNYh5MThQ@mail.gmail.com>
Subject: Re: [PATCH] random: use max-period linear interrupt extractor
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
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

Just FYI, I'll probably sit on this for a bit before merging and will
likely send a v2. In practice this is probably fine. But I'd like to
spend a bit more time working through the theory before settling on
this.
