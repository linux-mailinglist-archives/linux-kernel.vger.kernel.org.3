Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E14BEC11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiBUUsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:48:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBUUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:48:19 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBBCB12;
        Mon, 21 Feb 2022 12:47:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gb39so36312018ejc.1;
        Mon, 21 Feb 2022 12:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGSZ89NGWU5FaKpIsF1/9hh9l6nIkwe/qG/ZNjD1Gho=;
        b=WGVTzUfSeqcpIobttsC2YB0FBAfz9AJG8O2SqFwqkbZN1W3mzv4xX4ji5VS7KE9sr4
         aeSMQn7UgoagvDwc5wLxL0ymAtY3KdbU/MwJay+vgNFlvD3o4B6QbH3TIOdbxfDrTX8w
         yCyFRCLPSWS48GElAiH9sOMR2iUtZGlP2GYEypbF+p93pTzVvrS7lSUQcwecdfevodlW
         M6WyE8M47stH/JwBKC8kVH2A5EAF/4N8agW/vA6MnKAKFk4i2i1E2GE+FU31wIGcpFHO
         hNpcxAOmWoMW/hkjKWFHFnIQ3L+ywIjSLHaJtXrqx94QBZyDycAiIky/+bVBmJoo+DBb
         0BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGSZ89NGWU5FaKpIsF1/9hh9l6nIkwe/qG/ZNjD1Gho=;
        b=fjxN3e1b+Mtmc1N+RHEm+C7rIO6GUsRZexXrZs2YMq5FFRf2UxyD+oa//4Vwh0cQM/
         yyOh6OIWlZ4gPbP9UfOhA/taVpdQDyEELaM7ClGode8SmbcBteCvcsEFhxKtk/jKSmk3
         srMOTNK0WvPA8rHRkyV3JLg4jjA9d2vMREVfYUQ6phK/dz8Q21kJPjJ3B0isw+ont2Ys
         uHpdNHqpQXQcO3YjWiKoLSDLhpQRNHpgMrmbAguOBBy6MQMwSJTUBm5ztwAkwyPZIlNn
         jSJ/LxsTPquA5wptlCTUtqn4Qdx36MUDUvksZ5bJWJw9/Y/CgffFknpjQNjmcZkeV15+
         YpBQ==
X-Gm-Message-State: AOAM533dYlvHOYbfKTltJVbgHj4I9XmHs+jDIaMcKmzjiUYewFZahl0s
        1/KvJhy4uC80h489+wApXnq1dr/0TH39yTwriNE=
X-Google-Smtp-Source: ABdhPJxdwH7zfNkiQ4rytH7m242Ve2I/jw1LQ+RosnvzuBHwS2SMPecJxy/LPj8BMksh+YX6BEylXz54Ck1bjtQTNag=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr15837539ejt.639.1645476474036; Mon, 21
 Feb 2022 12:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20220218042038.15176-1-jagathjog1996@gmail.com> <20220218042038.15176-6-jagathjog1996@gmail.com>
In-Reply-To: <20220218042038.15176-6-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Feb 2022 21:47:18 +0100
Message-ID: <CAHp75Ve=CQ6DL-J=9v_fnCHZydc=QQZOAC=RkFq0Ckkjk+-dAw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: potentiometer: Add support for Maxim DS3502
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, sst@poczta.fm,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Feb 18, 2022 at 5:20 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> The DS3502 is a 7-bit, nonvolatile digital potentiometer featuring
> an output voltage range of up to 15.5V.
> DS3502 support is implemented into existing DS1803 driver.


> Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
>
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Please, make sure the Datasheet will be in the tag block (tag block
doesn't allow blank lines).

1. summary
2. blank line
3. long description (may contain blank lines)
4. blank line
5. tag block (may not contain blank lines)

-- 
With Best Regards,
Andy Shevchenko
