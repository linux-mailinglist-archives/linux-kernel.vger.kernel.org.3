Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2FD476968
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhLPFUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhLPFT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:19:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A20C061574;
        Wed, 15 Dec 2021 21:19:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JF0mX3yRdz4xhj;
        Thu, 16 Dec 2021 16:19:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639631998;
        bh=89BoGkjv1/HzkkQE/bALGUK22iLzNs4QmxP+8+6F9lQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fR1h5KV87GTW7GjPfIVIyQIG9Hug7SXkcc/qxR5eFG4yTs67E+JDDpf78OTHurZrV
         8XIvepCjiX6jKw/iZg6f9fWShGbP1iICRp5DCm6aNV0npZKQRBTHMiT6VQ0AwKHBU8
         wFqfgvkpGvjDoe12fZ1xG3s5G1Hlf3bAlR4LDAoUHAFUtNBtjHCxWJ9T04w9U/tW7t
         m96KyolUOhTyi9nUPd8ag4mV9MGbn1TUaeR6PPD15bNskmc50vUGk32nI4Ba8/zlGw
         scCMQo6dIgepMohRRxw8WyC4KopzFw012GHOQxR+zls4bhxCWsL/VRZgDjjZKe1/d4
         f02UJxh1tADTw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>, John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frank.rowand@sony.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4] of/fdt: Rework early_init_dt_scan_memory() to call
 directly
In-Reply-To: <20211215150102.1303588-1-robh@kernel.org>
References: <20211215150102.1303588-1-robh@kernel.org>
Date:   Thu, 16 Dec 2021 16:19:56 +1100
Message-ID: <87r1adktxf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> Use of the of_scan_flat_dt() function predates libfdt and is discouraged
> as libfdt provides a nicer set of APIs. Rework
> early_init_dt_scan_memory() to be called directly and use libfdt.
>
> Cc: John Crispin <john@phrozen.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: linux-mips@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> Link: https://lore.kernel.org/r/20211208155839.4084795-1-robh@kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v4:
>  - Revert the changes to search for memory nodes at any level which were
>    accidentally committed.

Sorry for the mix up, this version works for me.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
