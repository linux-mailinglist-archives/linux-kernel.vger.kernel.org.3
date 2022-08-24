Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB32E5A00E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiHXR6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239804AbiHXR6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF6F4D4C1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iLo/HCTUWn+r4ClX2zkFEpZpMUcQ5Z6K4CQx3YllaL4=; b=CjlbdjlRZ6PbkFyMA53XjRWugt
        mRuxsV+xEm4U5jy65XZhmqiBIir7W6kdxYKGDzKHxi5uvjPtB7bisDHZOOg+A/xmkybE1lCEJRGmZ
        iIaixY9hLKkORxtgyDoZ3Qy4t9HtPCg+xjcWcKAn5uATAzz/kaUwf+P1WH2Y9TS6etJYOPeBFqtSb
        UN0GIWSkIcDI7NEfoqYhjBLUILZUSivdSul8r2HbshXKMBzk6vv+zkVD8B7tvUz1QttTP6SVOLGpV
        D3eiPTypaxi6yfCGKKg5ujZONGxwXUUKxv/nq7CXu9xlmbOlWYrVnWe+0vrJplxgiNcK3lvLigCuC
        xJ23rrPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33916)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oQudq-0004PL-On; Wed, 24 Aug 2022 18:58:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oQudm-0004L7-QO; Wed, 24 Aug 2022 18:58:10 +0100
Date:   Wed, 24 Aug 2022 18:58:10 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
Message-ID: <YwZmsvlFR0cOxvnD@shell.armlinux.org.uk>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-3-yury.norov@gmail.com>
 <CAHp75VdgXBFH_vxUNYZLc2ahOrC8oBj0x=2GWXZr+CLGX1qyTg@mail.gmail.com>
 <YwYpqRZxCe9NLZyk@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwYpqRZxCe9NLZyk@yury-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:37:45AM -0700, Yury Norov wrote:
> Because there is a codebase that relies on existing types, mostly in
> filesystem code. And those fs fixes would require 5 or 6 patches.

Does that mean that are there filesystems that are passing pointers to
the find_bit functions which are _not_ aligned to an "unsigned long" ?

If there are, we should _not_ convert 32-bit ARM to use word loads or
use the generic code; unaligned loads are expensive on older ARM CPUs,
at least not the code for older ARM CPUs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
