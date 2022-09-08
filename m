Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AA25B14DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIHGmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIHGmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:42:14 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82157CD511;
        Wed,  7 Sep 2022 23:42:13 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-12ab0eaa366so2505624fac.13;
        Wed, 07 Sep 2022 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gUbpbbKfF7KQ6Lsb7wztDuENXE7eYaOMwk9vpfh3W34=;
        b=D43d3wSldH8HgBUSqmOf8ObLusP+opNToR5dIAzJAX85rqh5wr9vUpFn0s2PAm+761
         dMIabrMKoag9GinKWZpuG+v3RSNJaiEcYE2Auo9/02LQCRjJUDBc2q9p1I54pPDdwiXD
         y/oD19zu4qLdtkxRgEAeKV1p6mchLeSaDB7rCKrPn4EbRMwVDiK8VATAO02F9nA8EBCc
         iLPvKqKDBnls/D5NOBHox4t6cclDtR1oC0CeN9OiJG1XlKofl2HkUpVVg8MuC+gxneCy
         3ltiZO3XMP5PSIlMRPmYIG8D07AyqB4ln55utAKRp1HdxcoJmHlLfAC7m8C3BCODnspX
         nRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gUbpbbKfF7KQ6Lsb7wztDuENXE7eYaOMwk9vpfh3W34=;
        b=KMioVP+BNxdzJ1SCZ+aKWEE4HSU3iqD7FCsTM4GajqOwndS4M3VWAxyE0pwmgGoaLT
         vVwGzbYhuHFcrsAx32X0otsVUJ4qacTWqgys350G3iLlX96Sqo8W8lMJV3f/JtLpGImZ
         2ar/il6573KXuXKiXPWiiQICyL4B/G5W3qK/X8OjAAtIC3NY+BvmWE2psnnB9Tgq2i/G
         OzH6n+p6DbQtpZM8cp/1eRwssBcI7DpVAU+tpaKwKF2+Y1LiCvcFGAFUHepjMOcIveMg
         eGAEvnuIGgwB2dPppvblufjWyIUKleqe0midBgvVFI8EYZv9Jevqi9JP/tqmR8ZKv7c8
         kW6g==
X-Gm-Message-State: ACgBeo0ISP883clCQXVw8KrLFeF2/oTinoWjSdecH5mrvxcp3MTIjoIu
        SPwKc942FqxFtgZ3kOs+IP3lpnnNSQKjyjcrkvw=
X-Google-Smtp-Source: AA6agR4WiJTkvL9tQYbGtA1RI8fLs0aeQZJ1uqSfrywT4eVH9lQCc8C+Yvea4ev6KORx1Z2lm0Q9TbEtUJcdx9xcZPU=
X-Received: by 2002:a05:6870:c1d4:b0:127:9423:22b8 with SMTP id
 i20-20020a056870c1d400b00127942322b8mr1062860oad.123.1662619332893; Wed, 07
 Sep 2022 23:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220907132205.28021-1-andrea.merello@iit.it> <20220907132205.28021-14-andrea.merello@iit.it>
 <CAHp75Vdc8bAiqiUhEmgjNmcpY5s0fArTy26g2i0wH7srwY6RQA@mail.gmail.com>
In-Reply-To: <CAHp75Vdc8bAiqiUhEmgjNmcpY5s0fArTy26g2i0wH7srwY6RQA@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Thu, 8 Sep 2022 08:42:01 +0200
Message-ID: <CAN8YU5MbGWbE6nRBCs3gYwyN2yYk7OsmaQsTrZvJctQOhgLBng@mail.gmail.com>
Subject: Re: [v7 13/14] iio: imu: add BNO055 I2C driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm... It has my tag but I have noticed something to improve.

One comment below, OK for the rest.

> ...
>
> > +#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */
>
> Can we elaborate what to fix and why it can't be fixed right now?

Ah, this is a stale comment; I'll drop it..
