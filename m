Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA552A165
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbiEQMXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345325AbiEQMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:23:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0B44553F;
        Tue, 17 May 2022 05:23:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so2080274pjq.2;
        Tue, 17 May 2022 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neFz4/gw4GZbGKQE+sKbAChYelz9V5KdJJ0LHprcTfk=;
        b=oH82CmvDbeMGvzQ47QUPJHrPLVppZ0oRAJfwVGEhhIjs49n4Vl5G+6fke9/CgFpwXf
         SEYEEyGv3RwuWEEA1oJcEn4JpQKa79XLAwD8M3QKYvWmOZR17YXEbyCpDpYlJnfoHz6m
         vbfD4HN+LqBGJDLKu3PQyD/XtzMUBuCgzhTDnUOLk2wjuqPukHhaEiW4kQNMkYlpd/zS
         fgyqYdSy5QH7IZH48Hq09TYk1O5/V8WQYGesU3fhBZquANZOec8hGc5KCuXbQulk6cst
         G3ew2reEXWlt7seMuitot7HfPAeE4yspeoO0VqaWTj22EPTygZ+Kt4uzvj91B/9j8Uus
         Df4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neFz4/gw4GZbGKQE+sKbAChYelz9V5KdJJ0LHprcTfk=;
        b=Vin8Y7M1WDO2o757zTId1IatXPl21OPjfIUJ7oBZVZgJA+/LTToOiDYHg4M42hpqp2
         q0r2FRoReo3laPtGbBhwWCtmOqpZDFeQGYep7aljfmyoSkvincNTB9FcCzuVE0CNF5s/
         7DtPzr89KTU+6R4SMWrVJ31mcGJsQgu8eXa52ZStSwY/zJt1EGUCri9lhqDYFHWsuV7D
         vt4lzqvFBhikJC5n6fIhp+VYqvpSaRxLy/PX9KQ3ca1W+RPLas0TARX+S5HVcA1XXCyo
         +Cjr6E5YCbbgEygHcQ29tegcv4VnKVzFUcNey+kYwFcRMYtGSNMXWLXJrKuYpbjOs6c3
         CILQ==
X-Gm-Message-State: AOAM533fj8o1ExngV87/NZ9CMuy/fg73Hvl1yWZvLd+s2vEO2F62EhvS
        hL4XsE0NqvzgIL7QAY6R3Y9MpFLvmeSl12lYqEuv62aL9IfTZm8/pw==
X-Google-Smtp-Source: ABdhPJwo4Zvtc0ieMoWlmo8DUTEhTnJNpzES7Sj+dAzCaYKUoKjzaeYEV1j14cMWIo8LcRIk3+gLHbNuIMRk207MRMY=
X-Received: by 2002:a17:902:c2cf:b0:15f:1396:f54e with SMTP id
 c15-20020a170902c2cf00b0015f1396f54emr22590323pla.161.1652790222510; Tue, 17
 May 2022 05:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220513143513.2284425-1-zheyuma97@gmail.com> <20220514153625.18c4d9f8@jic23-huawei>
In-Reply-To: <20220514153625.18c4d9f8@jic23-huawei>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 17 May 2022 20:23:31 +0800
Message-ID: <CAMhUBj=uq6HhzRpTUO_iqrFQeVjiKE0n0bJ6SMKw8ZTdvFkCEA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: bmi160: Fix the error handling at bmi160_chip_init()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        sean@geanix.com, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 10:27 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 13 May 2022 22:35:13 +0800
> Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> > When the driver fails in bmi160_chip_init(), it should disable the
> > regulator.
> >
> > The following log shows it:
> >
> > [   18.709662] WARNING: CPU: 0 PID: 294 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> > [   18.712069] RIP: 0010:_regulator_put+0x3ec/0x4e0
> > [   18.716395] Call Trace:
> > [   18.716522]  <TASK>
> > [   18.716636]  regulator_bulk_free+0x82/0xe0
> > [   18.717077]  i2c_device_probe+0x6f0/0x800
> >
> > Fixes: 5dea3fb066f0 ("iio: imu: bmi160: added regulator support")
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>
> Hi,
>
> Good find, but Tong Zhang got their first and the resulting patch
> fixes an additional issue missed in this fix. See below.

Thanks for your reply! I'll check the linux-next branch next time.

Zheyu Ma
