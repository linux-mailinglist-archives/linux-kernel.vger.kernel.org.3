Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1734B62D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiBOFbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:31:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiBOFa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53F128DD3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6P0VShz4y4n;
        Tue, 15 Feb 2022 16:30:21 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Wedson Almeida Filho <wedsonaf@google.com>
Cc:     linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, paulus@samba.org
In-Reply-To: <20220202055123.2144842-1-wedsonaf@google.com>
References: <20220202055123.2144842-1-wedsonaf@google.com>
Subject: Re: [PATCH] powerpc/module_64: use module_init_section instead of patching names
Message-Id: <164490279930.270256.11789081622461037215.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 05:51:23 +0000, Wedson Almeida Filho wrote:
> Without this patch, module init sections are disabled by patching their
> names in arch-specific code when they're loaded (which prevents code in
> layout_sections from finding init sections). This patch uses the new
> arch-specific module_init_section instead.
> 
> This allows modules that have .init_array sections to have the
> initialisers properly called (on load, before init). Without this patch,
> the initialisers are not called because .init_array is renamed to
> _init_array, and thus isn't found by code in find_module_sections().
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/module_64: use module_init_section instead of patching names
      https://git.kernel.org/powerpc/c/d4be60fe66b7380530868ceebe549f8eebccacc5

cheers
