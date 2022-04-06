Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0324F65FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiDFQvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbiDFQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF47C1CA39F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649254518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o5D1jVQxb/RiXN5ItDFOnU6Wu4Tbka/jZzEb29hae+E=;
        b=CC+LRhbEJSdL2tYSG4vyMfNGmtZ/+hk2M4SPcVWh4V+Y2IxB3Rmyc22t/fxgTg/XKZPzOy
        KI/td8+wRFc50uKJFdWlrs1q4CgADpArwATVVwhtU0h+PAGrMLahtT2uuXdP2gDnYL0J+0
        ebU2xL4+0jWmoyABGdITGCKRMb+4ANc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-99D1abUgM0qaxdjxK7yeUA-1; Wed, 06 Apr 2022 10:15:16 -0400
X-MC-Unique: 99D1abUgM0qaxdjxK7yeUA-1
Received: by mail-wr1-f72.google.com with SMTP id l22-20020adfa396000000b0020612097035so547188wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5D1jVQxb/RiXN5ItDFOnU6Wu4Tbka/jZzEb29hae+E=;
        b=Glwp90/h+P7qUVFQrlrxIMiMlO+Ov9qjrKEeQKA1Nm2ex9IymumtE+VyhkhXywr2fz
         3ViiODKqnW/mLZRKNgr56Dw+6mCWJlygfBAPASurgX6iIqW9et6ZPMMP9JkJRmn2cc7z
         4BHA+AelDFyz+9Jdi6v8kUzM6lwV3078beyYby7cLeyXFirqp8KIXRucX4Z7iqfGOeXx
         qjqlHS+RneyZv6AhPduBraY3BEZ7tyqefnC80dEFZgFkr20h/TsntOcgP1Sb9V+3XB0c
         I7L4mVnPrDIpqZLlNWHYVdOwf4drsg9nauOvSyxmFINzFtDNrJI9T65gjzLPEpPD7kXB
         xwaQ==
X-Gm-Message-State: AOAM533e5f7mv0Tvelx/cb27xUIapmudnxF7qCzaoCOFZDCVA9j05MpW
        EQjKcGsjG5cBE7dcJ/f8mYd750c13LWj/02PDlz9g1QNhMcUftnnYmE5d8hU9Uo2T2JHunBEvQI
        YGbbUTpDXwLyNNgajWQg/KdxN4qL/qLAyszdoR/6kOgr3IXvvO36033e4nruKLGgX4a0uWs3q62
        OX
X-Received: by 2002:a05:6000:188b:b0:204:109a:fbed with SMTP id a11-20020a056000188b00b00204109afbedmr7019086wri.569.1649254515446;
        Wed, 06 Apr 2022 07:15:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXWOrnzTRFMhV48JM7o7ypwRqRswg+8mtdEDt5G3GaCDjYRZK0NmwA9STVVfjzNghj2gEqrg==
X-Received: by 2002:a05:6000:188b:b0:204:109a:fbed with SMTP id a11-20020a056000188b00b00204109afbedmr7019060wri.569.1649254515235;
        Wed, 06 Apr 2022 07:15:15 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b0038cc046cb2esm7708788wmq.32.2022.04.06.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:15:14 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 0/2] MAINTAINERS, mailmap: tweaks for yours truly
Date:   Wed,  6 Apr 2022 15:13:13 +0100
Message-Id: <20220406141315.732473-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've had a nice long shoreleave inbetween switching ships, but it's time I got
back to work!

I faintly recall some objections to editing the mailmap if one isn't named in
either a file header or in MAINTAINERS itself. The only files I can remember
creating are include/linux/sched/sd_flags.h and
Documentation/scheduler/sched-capacity.rst, which now that I look at it aren't
covered by any MAINTAINERS entry...

Anywho, I do want to keep a presence on the list, and this gives me an excuse to
mess with the mailmap :)

Valentin Schneider (2):
  MAINTAINERS: Add myself as scheduler topology reviewer
  mailmap: Update my email address to @redhat.com

 .mailmap    | 1 +
 MAINTAINERS | 1 +
 2 files changed, 2 insertions(+)

--
2.27.0

