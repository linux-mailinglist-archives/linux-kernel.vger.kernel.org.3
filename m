Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD144CBE12
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiCCMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiCCMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:43:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128051E7C;
        Thu,  3 Mar 2022 04:42:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B58861976;
        Thu,  3 Mar 2022 12:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37719C004E1;
        Thu,  3 Mar 2022 12:42:45 +0000 (UTC)
Date:   Thu, 3 Mar 2022 07:42:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Chun-Tse Shao <ctshao@google.com>, devicetree@vger.kernel.org,
        frowand.list@gmail.com, jpoimboe@redhat.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        peterz@infradead.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] config: Allow kernel installation packaging to
 override pkg-config
Message-ID: <20220303074243.29ca40c2@rorschach.local.home>
In-Reply-To: <CAKwvOdkWcu5ZPADGieb1Vb+kTbfHNzFAa3FXTWC98xXtzuLwqQ@mail.gmail.com>
References: <20220302102705.15c32822@gandalf.local.home>
        <20220302193638.11034-1-ctshao@google.com>
        <CAKwvOdkWcu5ZPADGieb1Vb+kTbfHNzFAa3FXTWC98xXtzuLwqQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 13:48:01 -0800
Nick Desaulniers <ndesaulniers@google.com> wrote:

> I'm ok with this patch; a quick grep though shows a few more open
> coded instances of pkg-config.  Should we fix those up, too? i.e.
> 
> certs/Makefile:92:HOSTCFLAGS_extract-cert.o = $(shell pkg-config
> --cflags libcrypto 2> /dev/null)
> certs/Makefile:93:HOSTLDLIBS_extract-cert = $(shell pkg-config --libs
> libcrypto 2> /dev/null || echo -lcrypto)
> scripts/kconfig/gconf-cfg.sh

For this patch set, the above is probably good enough to do (and test
with a make allmodconfig).

> tools/perf/Makefile.perf
> tools/ in general

I would hold off on doing tools for a separate patch. With the
exception of objtool most of tools is not needed for the build process.

-- Steve

