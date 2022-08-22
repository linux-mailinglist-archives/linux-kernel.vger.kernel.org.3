Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F032059BDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiHVKgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiHVKgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:36:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4EA30F75
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:36:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so13489019pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=nG5cok1QPdhwgOd/fGPOrpOpdg7Z3WhBB1mOKBv5Fpo=;
        b=quXugk55Ne0wGuoSR333VhDnDjpLcGold1fym5jNCA/m8WAQoA2xpBORPVWTju6Jhl
         i8UlH+ao2OtrGRQH97FtoVBurfanJl9J0twl2f/ovvD2iC7SlmWVIp3PFz32CXTWu43f
         vaprIWzWj6d/ZRkwOIR6hADB2HFRH/G7aitNAmdC3Xcx8khePprrAwRbFIg2LycAy31Z
         VK9+ZaDk6lCQm5oHTVwLjR3e4SFLOS1Tq/Ujz479LTWCgYNTASuLzOZVt1Uq4Y2v3+rX
         MMQ2KrvIF/BnMwjXUyqLTKrxzSA/o99Z2uaBVbg9/IKOF5DKPB6e9LeKyO7JBknu1NvS
         RRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=nG5cok1QPdhwgOd/fGPOrpOpdg7Z3WhBB1mOKBv5Fpo=;
        b=7zCmFV0vUr4cENZ+sFOZtkAPthc4vlQBh5wXVJ7WBP7oiFkm/qUa7IQmiUjnY2x4JJ
         K+IShjuwO/srYiVo2M68yx4flByKJLJufW1gKJXobMbTQQBc710gD2HkzXREUHo0E1xu
         1T68FG1kZBbocxPc2irBnLxOCUaBDv/jN1Z46jzpThdLGt/L4jqCbIhyQlHnGCWQln4E
         fusK/34WmCXxAMYoU8ziY9Q9dZxY+i2qkWw+Rx0/tYmtlo7QOXPoZTR/j7fODsAIrSir
         70imh4lyuDufczxwdewLL86BaMYnNQRuYR2COKzV0AVKREWEV4elhFByqkQo81hYiOp7
         frdg==
X-Gm-Message-State: ACgBeo2ic/zUHd4xoPhM2C9i/KT4BxV6MJzZLpalcgqUHt1DWs+tns9e
        uX0rE4+RS8ob0dn7L0im14TQFKyWQ3IQjI0IJn5A/A==
X-Google-Smtp-Source: AA6agR7BxTBuWzfu3tg263op/3bMmcPuFH4fqcAvnn05v7nq16Dw+WAx7QuiyNFiCFQaO8KLW+YvxUt+NWpsPB7N2j8=
X-Received: by 2002:a17:90a:4e07:b0:1fb:1253:475b with SMTP id
 n7-20020a17090a4e0700b001fb1253475bmr9006629pjh.0.1661164560580; Mon, 22 Aug
 2022 03:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220812071526.414285-1-jsd@semihalf.com> <YwB/aWRxyemPay58@shikoro>
In-Reply-To: <YwB/aWRxyemPay58@shikoro>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 22 Aug 2022 12:35:49 +0200
Message-ID: <CAOtMz3Ptx-xoGUUtAbssJsggmKrD+rX3nv6KMo3LJOE3ip0RYw@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: designware: Introduce semaphore reservation timer
 to AMDPSP driver
To:     Wolfram Sang <wsa@kernel.org>, Jan Dabros <jsd@semihalf.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, rrangel@chromium.org,
        mw@semihalf.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 20 sie 2022 o 08:30 Wolfram Sang <wsa@kernel.org> napisa=C5=82(a):
>
> On Fri, Aug 12, 2022 at 09:15:26AM +0200, Jan Dabros wrote:
> > In order to optimize performance, limit amount of back and forth
> > transactions between x86 and PSP. This is done by introduction of
> > semaphore reservation period - that is window in which x86 isn't
> > releasing the bus immediately after each I2C transaction.
> >
> > In order to protect PSP from being starved while waiting for
> > arbitration, after a programmed time bus is automatically released by a
> > deferred function.
> >
> > Signed-off-by: Jan Dabros <jsd@semihalf.com>
>
> Fixed this checkpatch check:
>
> CHECK: Blank lines aren't necessary after an open brace '{'
> #60: FILE: drivers/i2c/busses/i2c-designware-amdpsp.c:265:

Are you using the default checkpatch.pl script available on the top of
tree kernel baseline? For some reason my checkpatch.pl hasn't reported
this, but (due to operational error) I used the version of script from
5.10 stabilize branch..

> and applied to for-next, thanks!

Thanks!

Best Regards,
Jan
