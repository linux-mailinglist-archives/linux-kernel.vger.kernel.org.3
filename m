Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B685AF38F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIFS1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIFS1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:27:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80A9AF95
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rgs/1H7bJBh2F1qEKZG0lCHdBWmi1z+ETeD6YVAIZT0=; b=O8Py8iy8MHNddfoC91h5G8bBAj
        omqjSyQL7yiULp5sqNL7NBN2VKMXHFaic7OJC9j2UuhnPd5ue+YfevQGYcz1Zo8K+y00T2B2FkGPS
        qSe9s+YZs5xxI4Gn+OGrM4KCpx7vGvh6YFvdKBI+2jb/IKr9QF/QtNQ25FXYyPUct35ocKC5uhUj/
        IXH1O1rl0O7nd3dxzN5vUhOapmCcK7tH+KK5JiuzEl/lDjUqZFXR9oMrV4BvKuRDyCy8IESn2gpkF
        yXvq493edmNegAOUsjUzLhxM5UUFeatNEBPBfNYeaCHaz8xNEWliUdf0oovcXd6ylsrOJc6oahqqW
        ////8dnQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVdHy-00GLPS-8u; Tue, 06 Sep 2022 18:27:10 +0000
Date:   Tue, 6 Sep 2022 11:27:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     rafael.j.wysocki@intel.com, Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        tangmeng <tangmeng@uniontech.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: ACPI: reboot: Reinstate S5 for reboot
Message-ID: <YxeQ/i71s/wxiIe1@bombadil.infradead.org>
References: <20220906143108.1749183-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906143108.1749183-1-kai.heng.feng@canonical.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:31:07PM +0800, Kai-Heng Feng wrote:
> Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> PowerEdge r440 hangs at boot.
> 
> The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> system reboot to avoid triggering AER"), so reinstate the patch again.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

The addition of do_kernel_power_off_prepare() is not clear from
your patch, it would be easier to review and therefore detect
regressions more easily if you first moved the the code without
modifications and then after make another change in another patch.

  Luis
