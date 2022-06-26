Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031E455B261
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 16:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiFZOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiFZOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55267DEAB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE0C6121C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDC1C34114;
        Sun, 26 Jun 2022 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656252328;
        bh=8UwTVpWaXH1CGQIpd3dbrMoa6SXga7jR/5sRO45a3RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tAbvygfjBOuinHOBjaTVwb+i7pyYTVTKA2ihlJPPju4yju40tWcCyiz7+Aza3h8+R
         +QDmc7kKnhi1cmrzsuw6egoRFA6T6OSDuW3k2vxr5tPZTPklU3HC2UWCgC1hs0fkgw
         Wab/5sc8uuYfVhOMOdChm+dYhovwxmdcspIvbwyN7lR8N6clh4VzHfc8IZQdMM36RJ
         JZnsUT7wF3D42P45CQ2R/LDSvIB3qw2h9jdFUu7hI2QRBDFhRJcAiCtDTY/yYmJe8v
         x8yiSxwqQSH4Wm7IeVgRqZRzI45pJL2S92N7em8P/hISznrtsjtpQwPqYzobTktTta
         Gj/HaHuKmlC/g==
Date:   Sun, 26 Jun 2022 17:05:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jinyu Tang <tjytimi@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock: avoid some repeat when add new range
Message-ID: <Yrhnmi8zuALkAKa3@kernel.org>
References: <20220615094015.3672-1-tjytimi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615094015.3672-1-tjytimi@163.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:40:15PM +0800, Jinyu Tang wrote:
> The worst case is that the new memory range overlaps all existing
> regions,which need type->cnt + 1 free area of struct memblock_region.
> So if type->cnt + 1 + type->cnt is less than type->max,we can insert
> regions directly.And becase of merge operation in the end of function,
> tpye->cnt increase slowly for many cases.So this patch can avoid
> unnecessary repeat for many cases when add new memory range.
> 
> Signed-off-by: Jinyu Tang <tjytimi@163.com>

Applied to memblock/for-kernelci with minor changes to comment and
changelog text.

Thanks,
Mike.

