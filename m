Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280D555C2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbiF1E5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiF1E5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:57:15 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2113560D5;
        Mon, 27 Jun 2022 21:57:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B2D718106;
        Tue, 28 Jun 2022 04:52:01 +0000 (UTC)
Date:   Tue, 28 Jun 2022 07:57:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Liang He <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/mach-omap2: Fix refcount leak bug in omap_hwmod.c
Message-ID: <YrqKKBflkZKRHwXW@atomide.com>
References: <20220618014747.4055279-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618014747.4055279-1-windhl@126.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Liang He <windhl@126.com> [220618 04:43]:
> In _init(), of_find_node_by_name() will return a node pointer with
> refcount incremented. We should use of_node_put() in fail path or
> when it is not used anymore.
> 
> NOTE: As the ref will be passed from 'bus' to 'np' by the xx_lookup(),
> in normal exit path, we should call of_node_put() at the end use of 'np',
> not the end use of 'bus'.

Looks correct to me. What about missing of_node_put() for
of_get_next_child() also in the _init() function?

Regards,

Tony
