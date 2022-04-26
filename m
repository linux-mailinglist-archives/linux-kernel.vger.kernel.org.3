Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A76850F885
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346958AbiDZJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347329AbiDZIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6341CCFE7C;
        Tue, 26 Apr 2022 01:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26896104C;
        Tue, 26 Apr 2022 08:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698CDC385A0;
        Tue, 26 Apr 2022 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650962411;
        bh=Y7Z7dCVcyqeGFz/D8avQ0iiz2pUwlgEGs0PVOgs5IEA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NANSNwZkt/EfQS56azmPlB8nVmpUB66Z8uLjasEMUUqLLHm4Tw5AN3jT+obncTvyC
         FetNX0sx8R8KQBnQZKBJUJtwd4lFVIZtDcNmF/RhX2BVqVlxPJHWfk/Pjz3Cl+Q0mR
         gZ+/f0yicISQ1hHO385w0YYsXFtGA/8hwBe58Hn6rokt4PG0oc3fA4u4ZmOtSnXn2N
         8HRzpkijUJIeKxs2Msb/HQDZvIlBssN8RZ9t5+B2EwH3Iis9Odh+XQkKBwcYc8S8/k
         k6st0KAcxKibgib8FayExvP8CzF8BBh0oRGKSbLYW8Y5HYJqUwwGw8DVDtgyrohA5j
         j/Hy85DxKV2nA==
Message-ID: <063c09f5-bb70-11cf-0a20-662c1b7f07fb@kernel.org>
Date:   Tue, 26 Apr 2022 11:40:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220426082611.24427-1-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220426082611.24427-1-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've asked LKP bot to test my tree.
We should get a report if there are any surprises.

cheers,
-roger

On 26/04/2022 11:26, Roger Quadros wrote:
> Hi,
> 
> These patches allow OMAP_GPMC config to be visible in menuconfig
> and buildable as a module.
> 
> cheers,
> -roger
> 
> Changelog:
> v4:
> - drop COMPILE_TEST as include/linux/irqdomain.h does not have
> fallbacks if CONFIG_IRQ_DOMAIN is not available. So build will
> fail with COMPILE_TEST on platforms not having CONFIG_IRQ_DOMAIN.
> - use GPL instead of GPL v2 for MODULE_LICENSE. Fixes checkpatch
> warning.
> 
> v3:
> - Remove not required MODULE_ALIAS
> - Mention in commit message why we need to remove of_match_node() call
> 
> v2:
> - Allow building as a module
> 
> Roger Quadros (2):
>   memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
>   memory: omap-gpmc: Allow building as a module
> 
>  drivers/memory/Kconfig     |  2 +-
>  drivers/memory/omap-gpmc.c | 43 ++++++++++++++++++++------------------
>  2 files changed, 24 insertions(+), 21 deletions(-)
> 
