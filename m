Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC951C440
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381432AbiEEPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381423AbiEEPvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:51:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2294C5997B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C39B82C69
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11773C385A4;
        Thu,  5 May 2022 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651765638;
        bh=OsCCpbFBNuB9FABr2gqpVPt+rLWcODshGiCu1ChNxg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/w2DFtLFXAKZgxP1PiEIDVsuEz4JGHf8vP4UCdjgweCRDmDWppcLf6FQETo3/Eb0
         kK9ggMq+YM0P/Hlax2FcWBrN/Gc/gPnZcg4Nrbl7hc7fa+2HqhTlrSl0U1JxFswmpz
         zX+Gd5/Pdo8TCrQ4sU432WKS5mlLS6QAYyUf+KoTZdzIUfLRYFBBia9JaQh02/LyaC
         BRiIby0mrI3461nxnYgbA2ejzHKReMLgoF9oL0aym5E7wCcaIFzz/LX9F+6R0PYIc9
         Eg8OVK9y8kGuOmS5CpfzT8VqQHTyT+sAgRqjzog6/FJAb2y+EY49PqNJt2AKt4o5YG
         wAEc8NyaXCeqA==
Received: by pali.im (Postfix)
        id 25E9F945; Thu,  5 May 2022 17:47:15 +0200 (CEST)
Date:   Thu, 5 May 2022 17:47:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/85xx: P2020: Add law_trgt_if property to PCIe DT
 nodes
Message-ID: <20220505154715.xujvyjvewsj6jcw7@pali>
References: <20220504180822.29782-1-pali@kernel.org>
 <CAL_JsqLKjd3zPssbTo=mBfoa6nV144k9TamStk-jO3QbunmSAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLKjd3zPssbTo=mBfoa6nV144k9TamStk-jO3QbunmSAw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 May 2022 10:40:09 Rob Herring wrote:
> On Wed, May 4, 2022 at 1:09 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > DT law_trgt_if property defines Local Access Window Target Interface.
> 
> Documentation?

I was not able to find it :-( So the only documentation for me was the
source code and decoding how it works and how it is used.

> fsl,law-trgt-if would be the preferred form.
> 
> > Local Access Window Target Interface is used for identifying individual
> > peripheral and mapping its memory to CPU. Interface id is defined by
> > hardware itself.
> 
> Normally, we avoid instance indices like this, but if it is more than
> just documentation convention maybe that's fine.
> 
> Rob

It is id defined by HW. Software needs to know how to pair DT node with
address range defined in "ranges" to the correct HW PCIe controller.
