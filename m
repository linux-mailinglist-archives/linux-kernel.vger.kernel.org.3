Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E044F22F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiDEGUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDEGT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:19:57 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E094BBB0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hys+baV0s/BB2X6ZjEsxUpZuW1LBvcMEwkegMMpJQ3M=;
  b=cqrtI2hEUJKTeUbxl1WD+MaczjMypTi0waEARWdg0vsuXS1Rekv2scya
   l9S0ZqR7h3qnI7eq/FG+x/wbhX5TbXf53zE4sAXfUWbo3uVyArnkDAsro
   tbyvlQb21VAhQ6TZ8RNg8y9vh7zDd2bSs7IyWMJB9Vudt67JMRIk7ydTH
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,235,1643670000"; 
   d="scan'208";a="30042054"
Received: from lputeaux-656-1-153-249.w217-128.abo.wanadoo.fr (HELO hadrien) ([217.128.47.249])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:17:57 +0200
Date:   Tue, 5 Apr 2022 08:17:56 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Nishanth Menon <nm@ti.com>
cc:     Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@inria.fr,
        Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] coccinelle: api/stream_open: Introduce metavariables
 for checks
In-Reply-To: <20220404215926.14811-1-nm@ti.com>
Message-ID: <alpine.DEB.2.22.394.2204050816560.2185@hadrien>
References: <20220404215926.14811-1-nm@ti.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Apr 2022, Nishanth Menon wrote:

> Coccinelle spatch version 1.1.1 reports the following:
> warning: line 134: should no_llseek be a metavariable?
> warning: line 141: should noop_llseek be a metavariable?
> warning: line 223: should nonseekable_open be a metavariable?
> warning: line 290: should nonseekable_open be a metavariable?
> warning: line 338: should nonseekable_open be a metavariable?
>
> So, introduce the metavariable similar to other check instances.

This changes the semantic from matching the specific thing to anything.
So are you sure that it is what is wanted?  If it should always be the
specific thing, then you can get rid of the warning using eg symbol
no_llseek.

julia

>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>
> NOTE: This is currently reported in next-20220404, though I have'nt
> bisected for exact fixes tags to be used.
>
>  scripts/coccinelle/api/stream_open.cocci | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
> index df00d6619b06..d33732f35710 100644
> --- a/scripts/coccinelle/api/stream_open.cocci
> +++ b/scripts/coccinelle/api/stream_open.cocci
> @@ -129,6 +129,7 @@ identifier llseek_f;
>
>  @ has_no_llseek @
>  identifier fops0.fops;
> +identifier no_llseek;
>  @@
>    struct file_operations fops = {
>      .llseek = no_llseek,
> @@ -136,6 +137,7 @@ identifier fops0.fops;
>
>  @ has_noop_llseek @
>  identifier fops0.fops;
> +identifier noop_llseek;
>  @@
>    struct file_operations fops = {
>      .llseek = noop_llseek,
> @@ -216,6 +218,7 @@ identifier stream_writer.writestream;
>
>  @ report_rw depends on report @
>  identifier fops_rw.openfunc;
> +identifier nonseekable_open;
>  position p1;
>  @@
>    openfunc(...) {
> @@ -283,6 +286,7 @@ identifier stream_reader.readstream;
>
>  @ report_r depends on report @
>  identifier fops_r.openfunc;
> +identifier nonseekable_open;
>  position p1;
>  @@
>    openfunc(...) {
> @@ -331,6 +335,7 @@ identifier stream_writer.writestream;
>
>  @ report_w depends on report @
>  identifier fops_w.openfunc;
> +identifier nonseekable_open;
>  position p1;
>  @@
>    openfunc(...) {
> --
> 2.31.1
>
>
