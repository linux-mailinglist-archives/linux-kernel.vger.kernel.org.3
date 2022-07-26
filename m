Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931FD5819D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiGZSfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiGZSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:35:23 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EF5B840
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:35:22 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10e45b51f77so1473339fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HrcryoJh01CTNNs7KDd+YYqptrWAdUJ1tAMZzgvZifA=;
        b=Sf2BtLdfBv0k8xzCcPauhxidy1XoKP1CfPOXnYo4ibE0V4myHheYEO40OCpSfC0EEe
         EA3KTbgGn8AZf0CUBESqsYOgpTXmCls+ruhawYpDmsyJdtXYKpPRL6l0NynZFpAI0asG
         qoTZrg7W4W2B+C+Dq+scv8rVCkwCzaCIJQJpwnmBjg44qWX3Gw9kfgKnRYhyw1Zqb6sV
         +ZX8250dKzagR0+f45jAryoH5sxBo/wuHYRsZoYLzQwkjKvQ4L1lu8OeY9FBUYai7j2w
         G67AVqiMaE/m4YKzTimr6viMJ3mZ6+HHNI2atKeaAN9cNhtg3Kr5zCk0kyqinG1l1m6l
         2hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HrcryoJh01CTNNs7KDd+YYqptrWAdUJ1tAMZzgvZifA=;
        b=3VpyMTmx7XJFZIdcHQuzijvxp+UtBJ3V/eq+K0B9fNAxxsZNQmNvs9uvZUl+Ic6T2d
         9YQeAAbn7z7Nbhw/jyywaYF9ES3kzAebzWakwoS0n6QcT13kN2C/fQ3VU915nnNgUHdY
         2i8qKTcfNAMG/flXk7otu4Hk1KiOVpvDMAueoMIWQ8kCTmIVkYDjfrj4T6LUEn5kBMle
         P8iXMI/5lF8sQLZTLrftPN3BAtGDbG11QsE1yRTdZ60ecUnTDtCmjiO8d5rlGQQQdyoN
         pXl62ilXEONrsN05r2YDdoV0aO+UPmZcpc8gADdlrlCd9EgY7eArscw8v1uUxTXKkMiY
         nkoA==
X-Gm-Message-State: AJIora8KN/WrgIbhhlACfs8IYNR4raQHrY+OY6+7IinZC58KkoT+G761
        XMEsTAaqydp1KcQ1O5JVtMw=
X-Google-Smtp-Source: AGRyM1tluMn/3n5Af3Dc3EitEQFUpZRoYsmt5I/QF0ouM4xjvCdzxcceUMk5g4VrWHc18FjnRCmYOQ==
X-Received: by 2002:a05:6870:b48c:b0:10d:f6a2:8d9e with SMTP id y12-20020a056870b48c00b0010df6a28d9emr261565oap.227.1658860521371;
        Tue, 26 Jul 2022 11:35:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a6-20020a05680804c600b0033abe5ccfc8sm4901471oie.11.2022.07.26.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 11:35:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Jul 2022 11:35:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: drop arch implementation for find_bit() functions
Message-ID: <20220726183519.GA931941@roeck-us.net>
References: <20220726154407.3464776-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726154407.3464776-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 08:44:07AM -0700, Yury Norov wrote:
> find_next_bit(bitmap, nbits, off) shouldn't touch memory if
> nbits == 0 or off >= nbits to avoid out-of-boundary access.
> 
> Generic implementation has explicit check for this, but arm doesn't,
> which is spotted by KFENCE when running test_bitmap.
> 
...
> CC: Guenter Roeck <linux@roeck-us.net>
> CC: Dennis Zhou <dennis@kernel.org>
> CC: Russell King <linux@armlinux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: linux-arm-kernel@lists.infradead.org
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

bitmap unit tests succeed, and the KFENCE report is no longer seen
even after 65 retries (previously it reproduced easily with 5-15
retries).

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
