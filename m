Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1161D5A8737
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiHaUHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiHaUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:07:34 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862BDC6964;
        Wed, 31 Aug 2022 13:07:33 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so25903675fac.4;
        Wed, 31 Aug 2022 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc;
        bh=FrnGJAg4fYCg1AP2pSGC4eTVKDTWelds3dMK140YAig=;
        b=F2RZ/kbcet2nnEjJuNUizC/5J0r4T31f0JF7s2UpgiOY/HHsZ2qJVekYU279tbpaV7
         T+tZmix6IAloGB9aZMupJWe56mAiwS5Y7aw8RvKwkP1tRImaLvbPP2EO6kQfKF+2gKIU
         xBm4nvuA9yeO9zynS3PjoARLgRS7Venew++IH3Fzzz8hPOGonXy9a2HknniGv3aJZhBv
         7rURkgJQWiGoMR2xsg2zuYW+plN8HbQtaKf0UIdHbwnUUUDE3geD54TeTLHYqunHO2B6
         YvAy4Kpa+wyR/3BQiiYOiuD9rM5tG/u8UPZ+WfegBhSL215SW6mla4lxsN680Bf6XGz1
         GzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=FrnGJAg4fYCg1AP2pSGC4eTVKDTWelds3dMK140YAig=;
        b=EV2kqrFX4k6UVXw0Kyg2R4TR0F4MEyclF9rNWoSXs9LNnd9/N1I7bb/Kn3SNKfPyxc
         Bh6P/EvwS6BGnNGHhTqgXcpEH3YzGnNDrLHql5KZ01jnmXiDsCHXs9OWcKR772YeGueV
         EifGVXHhRUWuP1PLlIGTkWZMv7w1hEvmcmPsZt5MkpCP1CWi9gzQJ1GfrgtEjEqWvKrw
         Cs7JI0811bCritat6cxkOQpXnB8etwuOsycAfLiaBYeNh+eI0SoNUKfixo/MStQT43Gm
         x4SGVc9NxmEV71Q69zsYEnkAmKw6JfiCARC1pmQ+8bdjchSBjdDYHC2/Tj1g6B2RnnO0
         mcwA==
X-Gm-Message-State: ACgBeo3B9x29Scb8T4M/TFTNR4T5HaSez95frNPGKKgbnWu2l+ElzhXJ
        4XmGuCQPJfVWRUQtzSPQtz0=
X-Google-Smtp-Source: AA6agR6p0fpsbFyUZPzFcYLr6TT2/7joPvqBfO2tIGHAZdb+YvUV+cNf3gOg1+5nBUh2JMFm16G0TQ==
X-Received: by 2002:a05:6808:df1:b0:344:5db2:e25a with SMTP id g49-20020a0568080df100b003445db2e25amr1995689oic.1.1661976452663;
        Wed, 31 Aug 2022 13:07:32 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.239.32])
        by smtp.gmail.com with ESMTPSA id c4-20020a9d6844000000b00636f7059b27sm9355348oto.5.2022.08.31.13.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 13:07:31 -0700 (PDT)
Date:   Wed, 31 Aug 2022 17:07:25 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH RFC v1 2/3] perf: Add perf_event_attr::config3
User-Agent: K-9 Mail for Android
In-Reply-To: <CAL_Jsq+wviPPgnFc0vj9j6cKqqnL8HRO8wa8MFeX2fP5J8BcUA@mail.gmail.com>
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org> <20220825-arm-spe-v8-7-v1-2-c75b8d92e692@kernel.org> <CAL_Jsq+wviPPgnFc0vj9j6cKqqnL8HRO8wa8MFeX2fP5J8BcUA@mail.gmail.com>
Message-ID: <2295C0C0-6F55-4554-8062-D10BFED58323@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 31, 2022 4:06:40 PM GMT-03:00, Rob Herring <robh@kernel=2Eorg> w=
rote:
>On Thu, Aug 25, 2022 at 1:08 PM Rob Herring <robh@kernel=2Eorg> wrote:
>>
>> Arm SPEv1=2E2 adds another 64-bits of event filtering control=2E As the
>> existing perf_event_attr::configN fields are all used up for SPE PMU, a=
n
>> additional field is needed=2E Add a new 'config3' field=2E
>
>In testing this, just exposing 'config3' in the format attributes
>causes the SPE PMU to be disabled=2E So we can't add this without
>breaking existing perf=2E Shouldn't perf just skip any format fields it
>doesn't know about?

Something it doesn't know about, even more at the main perf_event_attr lev=
el, may preclude it to grok new records=2E

"May" is the key word, as perf_event_hdr has a size field, maybe sometimes=
 it's possible to do as you say=2E

If you're interested propose patches to make perf ignore things when possi=
ble=2E

- Arnaldo 
