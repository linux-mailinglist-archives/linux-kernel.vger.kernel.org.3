Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC4B533E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbiEYNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiEYNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:47:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0802CE24
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:47:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t26so2014060edt.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:content-transfer-encoding
         :user-agent:mime-version;
        bh=BQI0MM9mGzf2vAfQtbRgaX49I/EIbgEv06vyRUHl5E4=;
        b=LGoqhAUBF/M58vXaLWQVnCAAvoVqjcyqxOHhMPHMNVr0GfGjsYkt9IUzmhyT4Ud8U1
         FyupkHT7Ayck+WnVEZ8DBRiEn6DYxqa31UogXejlPOUQnYy5vICwLmjD4RYAxeUisIzF
         BXQ5WSYY58aU+MGve4LRrvO94G6F9Sajh2OGwE4L5IAaFdyoK2bE8evvoUMOikjpSmLj
         VPmbdFJrOmwheFIKtDYY9CPYhTqdVFc4agfDkWv5EgGPotzw+eOdYqhstZWcLw0ii2HO
         TgeAWMsSyRD8S5Urxdpb+9A/DlX4ywIlm7Izux0BqrfYcEWvtTe7Ti9PF3mxGgqafPTj
         hA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date
         :content-transfer-encoding:user-agent:mime-version;
        bh=BQI0MM9mGzf2vAfQtbRgaX49I/EIbgEv06vyRUHl5E4=;
        b=U85lBFmU86eODDM8eYswQWLJnI7UhG+bIBwPDBoWLAt5Yv/rXPHpzb7oIrorPOebgZ
         OlBiUlaVDF/raJyG92qR3/pfRUPAwwilkcs1DSxD9eRru244QWYMI9KAK0EPwGx50azw
         UoKED0zwh9CHkAFw1lQgu45U/88cFrPmocofPhE7YNJpklcHdkOK5f9R8PYoMhEso7u1
         vvDOSI92BPTGKCGrAp79fevFoTCKBqv6zwh8JIjX12T2cPg+oJHeptKu8ISyo89YpQNx
         f9LYzHFNLAo99NFuTyebfjFBXpa/YssaoYBRhRlh4ejOG12yKt3UbttjVrxZOrLwU+Zg
         PYXg==
X-Gm-Message-State: AOAM530EnMSvw1kpPAoDj2Se4oS9Cj6UuScvb873l7Ym7gYTwMWWK1nm
        9cxO5WLhOcwpapFxXSArFCJ1WypadCE=
X-Google-Smtp-Source: ABdhPJxbbDjdk9sI19QAfQ7/M8zWGloGRQrACk4Naqhv932foFGAHCEWb3/sdJ3TS+3vgGy78yDZEA==
X-Received: by 2002:a05:6402:1150:b0:42a:9dbf:8860 with SMTP id g16-20020a056402115000b0042a9dbf8860mr34497063edw.350.1653486438481;
        Wed, 25 May 2022 06:47:18 -0700 (PDT)
Received: from [192.168.11.132] (193-226-240-62.pool.digikabel.hu. [193.226.240.62])
        by smtp.gmail.com with ESMTPSA id q14-20020a50c34e000000b0042ba8658d1csm1476932edb.73.2022.05.25.06.47.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:47:17 -0700 (PDT)
Message-ID: <090267988a08ee969140a9593ece6bf10efdadad.camel@gmail.com>
Subject: Intel GPU memory corruption
From:   =?ISO-8859-1?Q?Baltaz=E1r?= Radics <baltazar.radics@gmail.com>
To:     linux-kernel@vger.kernel.org
Date:   Wed, 25 May 2022 15:47:16 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have a Lenovo Thinkpad T460 with an integrated `Intel Corporation
Skylake GT2 [HD Graphics 520]` GPU. Whenever there's intensive usage of
it, after a while I experience memory corruption. Under normal usage,
this results in random programs segfaulting for example.

I have done several memory tests, including the Lenovo hardware
diagnostics included with my BIOS and the userspace utility `memtester`
as well. When the GPU is not used, no tests have found any issues, so
I'm fairly certain my actual RAM sticks are fine.

However, when I run e.g. `vkmark` or `mpv` alongside `memtester`, it
will report issues after one or two loops. During the time I ran it,
all failures happened at the same offset.

Based on this, I suspect the video driver is the culprit somehow, but
I'm still not entirely certain it's not a hardware issue. If anyone has
ideas on how to track this down, I'd be happy to do some tests.
