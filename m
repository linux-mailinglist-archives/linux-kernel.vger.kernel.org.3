Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C894FA943
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiDIPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiDIPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:30:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CA4217384;
        Sat,  9 Apr 2022 08:28:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 068A9B80836;
        Sat,  9 Apr 2022 15:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D93EC385A5;
        Sat,  9 Apr 2022 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649518083;
        bh=fH6R5XI0+0MFwVlPvp4WGTQEHHbOqX/unKqNw5JN0fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XuZzvDcjwzt33GApdo4mT8wyKTeHEbtZzEUxNitkFJbRjt9HdqKu72e8XXr4+P5ro
         HbzPfDVzTHfF9mh2gk45gdBJ6BoMTMP8mN7MBQN5WQpoA6HqXYKpMahvWYhVR9q3YZ
         uzUuAmPT+PuPzmevLpFjaBgCjyBsRdAPPzKV9+nlBv10EDD1OQJS+rkyUEZYcRNi8U
         spOkAiXFKcHxLmdX4ALNmYs7FLKveYOh88TRGVraNYFRWwTPd4zbGngas6OSmyEPA1
         Lwjc4z6nD0SOxycooll8D9EV9ROi+bh/eDUcdBwMS3p3KuOgLsoe3349dTevmxmkTy
         ERRcuypNQIinA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E06F40407; Sat,  9 Apr 2022 12:28:01 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:28:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, disgoel@linux.vnet.ibm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        srikar@linux.vnet.ibm.com, irogers@google.com
Subject: Re: [PATCH v2 0/4] Fix perf bench numa, futex and epoll to work with
 machines having #CPUs > 1K
Message-ID: <YlGmAd3LEh9He6Pg@kernel.org>
References: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 06, 2022 at 11:21:09PM +0530, Athira Rajeev escreveu:
> The perf benchmark for collections: numa, futex and epoll
> hits failure in system configuration with CPU's more than 1024.
> These benchmarks uses "sched_getaffinity" and "sched_setaffinity"
> in the code to work with affinity.

Applied 1-3, 4 needs some reworking and can wait for v5.19, the first 3
are fixes, so can go now.

- Arnaldo
