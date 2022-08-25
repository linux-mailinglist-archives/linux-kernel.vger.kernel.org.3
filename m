Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A5A5A19BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbiHYTn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiHYTn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C533B248B;
        Thu, 25 Aug 2022 12:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C2B61DB8;
        Thu, 25 Aug 2022 19:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614BBC433B5;
        Thu, 25 Aug 2022 19:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661456635;
        bh=AU1L/9WvXb9tK9LK6n/OGeZTd/XJdd+E9DFB73JTPDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CHa7w+ucwrhZNcbbNSMur8jViE3jdJlnC7m8bE1Vlbjqu08WYDSmj5B6FhV5JItSp
         abGI12ii9JsVgnsr88CA9LN+qvdvK76mX4thIZOL4lCNSKOm/hTFxHcTM9j5+lIX6G
         z3xMGfzCfAZu+RYHDAfsYKX/hgVOPi7Uq0SQddqh/RiOvSp0JfTD5FVQM5JlHu+dFK
         lcjl9l0wHfscU2seRH1KHcmRgbVkEBfhqJbr92v3e6Ufe6O53S2e7r2+ivW9NN0igB
         kGtWGC3Wp7rPGe5lMNUqG45BBDmOOQM/SDZrFDjOoUDu+ThSQ5iyAlFtixo2WsxPoV
         6aI4WAilRrUjg==
Received: by mail-vs1-f49.google.com with SMTP id c3so21932563vsc.6;
        Thu, 25 Aug 2022 12:43:55 -0700 (PDT)
X-Gm-Message-State: ACgBeo2/3CpQMf/+ivPtiNhZNpP4NBhepo/pBkumVkCa+Mw79/RTxTwP
        Teq64WbJHrDT51SwiQU39PEG/40PEjsO8YrFUg==
X-Google-Smtp-Source: AA6agR7YOfyvUFVT4V26yEEgey1tLIMY8hsJ+TcU4eOUopj4T5kxr+NDjgJsmZDt93UHrUn8yw4pfSuVZckc+OlsPEQ=
X-Received: by 2002:a05:6102:3353:b0:38c:9170:a96b with SMTP id
 j19-20020a056102335300b0038c9170a96bmr2579310vse.26.1661456634272; Thu, 25
 Aug 2022 12:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
 <20220825-arm-spe-v8-7-v1-2-c75b8d92e692@kernel.org> <YwfOHjw/VsIJOPjt@kernel.org>
In-Reply-To: <YwfOHjw/VsIJOPjt@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 14:43:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKdEkA+SGRd+P=WJnZE1YUuMjyPz5JwKz6cttuJ5hA_SQ@mail.gmail.com>
Message-ID: <CAL_JsqKdEkA+SGRd+P=WJnZE1YUuMjyPz5JwKz6cttuJ5hA_SQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/3] perf: Add perf_event_attr::config3
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Thu, Aug 25, 2022 at 2:31 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Aug 25, 2022 at 01:08:01PM -0500, Rob Herring escreveu:
> > Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> > existing perf_event_attr::configN fields are all used up for SPE PMU, an
> > additional field is needed. Add a new 'config3' field.
>
> Try not to have tools/ and kernel code in the same patch, else you'll
> burden kernel developers into testing tools/, which so far has been
> refrained.

I knew that, but assumed the header was special...

Rob
