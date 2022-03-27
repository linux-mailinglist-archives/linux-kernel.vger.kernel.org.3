Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61C4E899C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiC0TQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC0TQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:16:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD20340E1;
        Sun, 27 Mar 2022 12:14:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so24578814ejc.7;
        Sun, 27 Mar 2022 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4qI7bOJeV7sbEMrTacQITe1PWo4hWMmxqslrYusUyE=;
        b=d1Z5jALUMlJmWbRwJcqON/IloBLDPclRYecQfAXnY80J/ZcbtJB+MSAvZtyx99hzrq
         5FXwEPw8hkHw47YhUVs6AmumwWIq/zbp88YexmodHoGOMQ9AO275DWQKbWtHF1ZK8TtN
         d30BQgnIavnV/4BkS0k/dCYnxTHuUGrwVxlpS1T6l02q5ePoZQw/GFrTmSWsOC2cfkji
         4RfuvxNjGPtU4znkmh1up8VOcR8/9uq5nl3IMXjjowY4e7LFD2fs2sgRrK/OLQ+xSymW
         tS/u1IYg920P7xgl7juaHvJPeC6C+uHHOkCk9YFpcK3OgCxrL6k2WUOcqZDs2l8Fp7bG
         WfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4qI7bOJeV7sbEMrTacQITe1PWo4hWMmxqslrYusUyE=;
        b=lFpdIemTslY7UAYpLjpQLFwTMBJyW6hJHy1ertu4J/6MxtbiWpsKiEvuj/48NV9/ZZ
         qNEGtBsaY4fFRFF125LxD3PiEKe1Ie/FCn1qOq+lF9apfCb1c0q9AMPVWzoxIVRyZ4Fq
         k4hDjI/kHFbYwJ5Qm+VEjI9IGr4vMX7+rCKiRVrtITLOAhch2p+y9x7JO3aj4th/9voL
         xf6aJNi+r0lPnutV28olgxEMm6l72r9qyhiwRAzZdIEC+xg79G9KbRUHo+sIaaiusVV5
         iV/Q4NxlZFSYkznWilt0HV1EWZHiWnsvhgQIUmAfXOukC42xm0xld41E4dVUdilAuQ4y
         aUlg==
X-Gm-Message-State: AOAM533U0bQ4rRDLfD3s2+SoIt/uh7iByCTUzl7pnrI3LFZabhMPejS1
        HfMNfPnOD/71J6wibc/ihEPYDXyMNLa2jNPNhdY=
X-Google-Smtp-Source: ABdhPJwo8aTPxxndWHX6iBx4/MdmrjiB/0auIdxT43+eQjPQMv9RwwwNvxPg1u/UFAt5zmQBEQB4eigfkDcHFQPy9yQ=
X-Received: by 2002:a17:907:160b:b0:6e1:116e:7a59 with SMTP id
 hb11-20020a170907160b00b006e1116e7a59mr921453ejc.579.1648408490785; Sun, 27
 Mar 2022 12:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2203260927200.3141@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2203260927200.3141@hadrien>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:14:14 +0300
Message-ID: <CAHp75Vdex+_nbKg_tRDsZ_yR-bf3wujDQKGRdV14nP1ektT87g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: fix for_each_child.cocci warnings
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kbuild-all@lists.01.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Olivier Dugas <dugaso@sonatest.com>,
        Manish Narani <mnarani@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Mar 26, 2022 at 12:28 PM Julia Lawall <julia.lawall@inria.fr> wrote:

> Please take the patch only if it's a positive warning. Thanks!

New code rightfully switched to the fwnode API

https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/xilinx-ams.c#L1254

Is your stuff only for LTS backports?

-- 
With Best Regards,
Andy Shevchenko
