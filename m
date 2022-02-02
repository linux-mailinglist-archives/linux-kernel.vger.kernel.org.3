Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948794A73DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbiBBOzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:55:55 -0500
Received: from foss.arm.com ([217.140.110.172]:36040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345307AbiBBOzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:55:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C10113E;
        Wed,  2 Feb 2022 06:55:38 -0800 (PST)
Received: from [10.57.89.83] (unknown [10.57.89.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126DF3F73B;
        Wed,  2 Feb 2022 06:55:36 -0800 (PST)
Subject: Re: [PATCH] perf symbols: Remove demangle-rust files as superfluous
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20220201185054.1041917-1-german.gomez@arm.com>
 <YfnMhsF2/z0FUaWz@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <ebf26948-c9ae-409b-31c1-3e2a1b06604b@arm.com>
Date:   Wed, 2 Feb 2022 14:55:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YfnMhsF2/z0FUaWz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/02/2022 00:12, Arnaldo Carvalho de Melo wrote:
> Em Tue, Feb 01, 2022 at 06:50:53PM +0000, German Gomez escreveu:
>> Demangling of Rust legacy symbols has been working through libbfd for
>> some time now, making these files no longer needed, so remove them.
> Can this be made dependent of the versions of the components that
> provide this feature?

Hi Arnaldo,

I have decided to drop this patch.

It turns out that even shipped versions of libbfd and libiberty don't demangle some of the symbols completely

For example:
(doesn't strip away the hash at the end) _ZN10rs_tracing8internal11TRACE_STATE17h41dcd282cd61069dE.0                 ==> rs_tracing::internal::TRACE_STATE::h41dcd282cd61069d
(doesn't demangle full symbol)           _ZN41_$LT$bool$u20$as$u20$core..fmt..Debug$GT$3fmt17h10f4b7b0094c3a75E.2262 ==> _$LT$bool$u20$as$u20$core..fmt..Debug$GT$::fmt::h10f4b7b0094c3a75

These are cleaned up afterwards by perf's demangler.

Apologies for not catching this earlier.

Thanks,
German

---
Tested with packages:
libbfd via binutils-dev(v2.34-6ubuntu1.3) on ubuntu 20.04
libiberty via libiberty-dev(v20200409-1) on ubuntu 20.04
>
> - Arnaldo
>  
>> [...]
