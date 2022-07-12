Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0BD572661
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiGLTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiGLTrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:47:24 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C644326F9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:40:02 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id l11so3319739qvu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=j8WAhKBpOc7wYs7Ko5g4Psu+Us9+b70bjp8g/dmZ0qY=;
        b=MJh0B3YljS9BFRrx0KWFjiaypnfnVap1G2m/RMlRL9QDB/qYE/EPMoNenHcm9N+7h3
         PLcBsWx31MaxdWtAsyTw0y9e4xckIMTNynhJkTVt7+ON2N7F7Cl6ozYtjRi4lIX/TbGD
         UlmSoLUpaoi3/ZVKj+P6NJiJAV1eDdgwgYA04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=j8WAhKBpOc7wYs7Ko5g4Psu+Us9+b70bjp8g/dmZ0qY=;
        b=kwKGnvpaYhIwlGTAlRCecXVlstNt2NtvT/a21DSiSLcVHD24t78TmyCdKuchHMpJzO
         4LzlSoxE5XcMh8HN+yyW8YsGq+PENm4d4l0s9RM/tzkSmg03X7RTJEE7wr64mybGP+Pg
         V1dnBAGADCTfHGEo3yJmCKTuPYBZ1pf54jO3/mAfv8BxdiZJFZiR/OzcoQnnti9t0jY7
         G76xzem2e0Oyr9dJpESjZAGlGfj7ly60MKLGowB3rMF5oBOnp+6/ClAlI53u666uDic3
         8dPkL98fWRomDze5WPWlbybU8rKT4f5BKawep7sZNr2ZqYFtUN88MufNGNYAtB3Pi11P
         JpFg==
X-Gm-Message-State: AJIora/qxBPBcQW7P8ZKHc4Y4gHhYt5LxDIL9x03tVkpe4LLbclYlBj3
        oqThvM/aGJISDd5ctb7LfkuGP05qYoyXVA==
X-Google-Smtp-Source: AGRyM1vBgwADc7/u+XrGr1/57R6Na1dl3N457lzCcnz5GD3A8Scdn98ZZjHWYbQHrcFIsV93BnlJAQ==
X-Received: by 2002:ad4:4ee3:0:b0:472:f785:593e with SMTP id dv3-20020ad44ee3000000b00472f785593emr19510742qvb.51.1657654801488;
        Tue, 12 Jul 2022 12:40:01 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id cm23-20020a05622a251700b0031bed25394csm8165100qtb.3.2022.07.12.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 12:40:00 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 12 Jul 2022 15:39:56 -0400 (EDT)
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
In-Reply-To: <20220711221658.4gpkizopmftpnav6@guptapa-desk>
Message-ID: <32ccdda1-63bf-746e-48fb-935fa58285b1@maine.edu>
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu> <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu> <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com> <20220711221658.4gpkizopmftpnav6@guptapa-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022, Pawan Gupta wrote:

> Output of below would be helpful:
> 
> # grep "rtm\|hle" /proc/cpuinfo

no results

> ARCH_CAP
> # rdmsr 0x10a

rdmsr: CPU 0 cannot read MSR 0x0000010a

> TSX_CTRL
> # rdmsr 0x122

rdmsr: CPU 0 cannot read MSR 0x00000122

> MCU_OPT_CTRL
> # rdmsr 0x123

0
 
> TSX_FORCE_ABORT
> # rdmsr 0x10f

rdmsr: CPU 0 cannot read MSR 0x0000010f


This is on a Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz
Family model stepping: 6/60/3

Vince
