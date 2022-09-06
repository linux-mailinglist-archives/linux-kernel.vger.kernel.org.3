Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FDC5AEE59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiIFPJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbiIFPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:08:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB94B3B06
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=dRpxQ4jjwN1yFtBGpEPXLSbtDHI+DAP32QAWwCSE7yM=; b=v4K4BuErh9R48s3gAbIlnJ7jJk
        m89LeHbJ/8pbR5E5DOEhBRre082ax9NRRGdB2lGdDto9SYoPe3Lg24Rwc+HmeinJWH0tIasU+kbAD
        VpCVj5tY464MtLwHGgTeMwmbTEf/teh+lr6JEnrXtcNyinIvwU9ovMTKne80oziMvNPyXUCXy0Yx+
        zKPXune2C8F8IlitS5VzG6kwpxcQRkUTgJzy0cCFpDcuKLM/Y51l7uuhoNU1TU6EZ/QExYAxohBxA
        7m2qb0LewkLsS1QwYfg7JeraCp+XL/s2l1LcaSJCM7nWYANeOfMeQcoZBp3Z5o1fWNAr3dQ7sFjSa
        Gg0rQppw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVZS9-00AUXk-PE; Tue, 06 Sep 2022 14:21:25 +0000
Date:   Tue, 6 Sep 2022 15:21:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3 0/4] drm: Use full allocated minor range for DRM
Message-ID: <YxdXZbFBHIevYwRz@casper.infradead.org>
References: <20220906140117.409852-1-michal.winiarski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906140117.409852-1-michal.winiarski@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 04:01:13PM +0200, Michał Winiarski wrote:
> 64 DRM device nodes is not enough for everyone.
> Upgrade it to ~512K (which definitely is more than enough).
> 
> To allow testing userspace support for >64 devices, add additional DRM
> modparam (skip_legacy_minors) which causes DRM to skip allocating minors
> in 0-192 range.
> Additionally - one minor tweak around minor DRM IDR locking and IDR lockdep
> annotations.

The IDR is deprecated; rather than making all these changes around
the IDR, could you convert it to use the XArray instead?  I did it
once before, but those patches bounced off the submissions process.

