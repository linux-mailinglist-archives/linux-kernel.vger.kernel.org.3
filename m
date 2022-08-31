Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73985A866B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiHaTG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiHaTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD551C9273;
        Wed, 31 Aug 2022 12:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5132E60A71;
        Wed, 31 Aug 2022 19:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EB8C43470;
        Wed, 31 Aug 2022 19:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661972813;
        bh=5d1/Eml7Z8m8sM3vx7w+godDoYHMCOd8MSpKSqZuGuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tHh27dwMa9HwOcXhc36kle01dp70xJwb4bhGB03bVPfkok1+Kr6kuPqAfX3OASla1
         PR1Ey5xmdBxfOCm/Y4lXUho5sIeNROQU68URm7FALy+FE6qyj0+lVhfu4AtoKplVR2
         PuIVbMgxmHqxv0/FPzGm4uD8JVu0Dgn5e4lRDffQyW8lVEE+BdXnM8pYi1q1RuEd2X
         SjUwD/fJ+IwaffVICt+EdzNNqoWtc0ZJkjZb/CNpXxDl1ZUKpO3VAi/dhLK2pG2fcY
         uHaExnRYsMM8blBL96WiTlhZrhs7Av5/2qVcfGXLUV4YxdAeCy25u9A3AK/VpVxKqo
         e2g7MTLGNnunw==
Received: by mail-pl1-f176.google.com with SMTP id v5so8781206plo.9;
        Wed, 31 Aug 2022 12:06:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo2PzxmOzvHvH6+62N26wxXvaQ2BTs0GYYaYyK2hxvr49uw9/UF5
        fevj+35QfGcRvOGeyUG/ldHi0gLm5qSIK5cdtA==
X-Google-Smtp-Source: AA6agR7E+46bky5VkfJPThAWE3/PkJ7UGV1o9aEqPG6o0E6KWcw77Wf7qigu/SUBPgtw0OfNlE9s/UYDpvf+6dg4HuQ=
X-Received: by 2002:a17:90b:1a8c:b0:1fe:2c68:6ad9 with SMTP id
 ng12-20020a17090b1a8c00b001fe2c686ad9mr4778222pjb.224.1661972813237; Wed, 31
 Aug 2022 12:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org> <20220825-arm-spe-v8-7-v1-2-c75b8d92e692@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v1-2-c75b8d92e692@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Aug 2022 14:06:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+wviPPgnFc0vj9j6cKqqnL8HRO8wa8MFeX2fP5J8BcUA@mail.gmail.com>
Message-ID: <CAL_Jsq+wviPPgnFc0vj9j6cKqqnL8HRO8wa8MFeX2fP5J8BcUA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/3] perf: Add perf_event_attr::config3
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 1:08 PM Rob Herring <robh@kernel.org> wrote:
>
> Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> existing perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config3' field.

In testing this, just exposing 'config3' in the format attributes
causes the SPE PMU to be disabled. So we can't add this without
breaking existing perf. Shouldn't perf just skip any format fields it
doesn't know about?

Rob
