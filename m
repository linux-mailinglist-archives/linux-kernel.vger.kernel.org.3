Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F965752FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiGNQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGNQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:41:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF748CBE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B905AB82734
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9D3C34114;
        Thu, 14 Jul 2022 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657816898;
        bh=Ez1awhKzLVtAuOTytWhakc6zoS8fxrGEoZ1hsWNyC2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3T62TZnHKg4pyKKL2mnhBoRVveFa1Uwtq6FUYUNJUrX/TC47hA9e8VZ/mVb+iqkv
         RZf92+lzTZOx+8zYUagKXy4Mlxl33JWVbHuWQYGxzFyMoAh7o/vWKEHpz4btz7HOez
         OQ7uwQW6X2Ueh+MLKp/rz+JrFFbp1Ri4nlafyqvXrBSkPg58GszKrQGM90886hPbvI
         eG42KQQoEFiulG+ko516FU8vrOuu+C+n+EWnde9AC7djfCfxsqZAgwqlYRlbGEVJhK
         dGm8I94oUwIBdLjdI6eo6e1XDK7x8dpzO6iWkk0AbpNh/4w684PWUdliSpnsc7nGpp
         nUH66ZGAwC+Wg==
Date:   Thu, 14 Jul 2022 09:41:36 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     keescook@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faddr2line issue
Message-ID: <20220714164136.n2ycc5axt7vtctgs@treble>
References: <09df26a9-27af-1276-34c6-820bf7e27da8@huawei.com>
 <3492d341-a681-f344-f5cd-5b1ea3725f31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3492d341-a681-f344-f5cd-5b1ea3725f31@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:57:51AM +0100, John Garry wrote:
> On 08/07/2022 15:47, John Garry wrote:
> 
> +
> 
> JFYI, This issue is caused by CONFIG_DEBUG_INFO now being default off in my
> .config from commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable
> from a choice").
> 
> By enabling that config faddr2line now looks ok again.
> 
> BTW, Could we add a check for any kernel dependency in this tool?

Hi John,

The script doesn't know how to reliably find the .config file, but it
should be able to check for missing DWARF in the binary itself.

-- 
Josh
