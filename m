Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE852A499
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348698AbiEQOTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiEQOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:19:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D0344FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fQzWuq6EodGqOHx9GjfS0em/RXgWCwpj6VxGmmEdosQ=; b=GSTBgEDKg243NCQCyGxq80aNwY
        UFyU1aun29GdmgxMKObbq2Hbt2UesJp8w7dKQHvVHGRXf67gtQFmxsekfTF+fQVtABv8mDgXc/Icf
        Y9rVTbiiqWz00VT1N9LAWk/eDmZ4v6v2fFdBKW/pU8dkf9m1pLFOqsNF6TpZrnYyWh0CbZ0NUpI9n
        SToxgqngGYftWPXFOiV8Pyp4s+bUygYNahLOMWMGEKS2LOxu0VmyokMbOVQGKgTgSNSEX60hu7eVu
        rwgJ7S98vmojp8OkpyaV5QcgivGOwCpJPO6P97f6CfWPFMCrLpDYXRHdS9HRc4x34nG+NhQVE857h
        viTCLWzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60744)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nqy2Q-0000NU-O8; Tue, 17 May 2022 15:19:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nqy2O-0004VH-36; Tue, 17 May 2022 15:19:00 +0100
Date:   Tue, 17 May 2022 15:19:00 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     alexander.sverdlin@nokia.com, ardb@kernel.org,
        linus.walleij@linaro.org, nico@fluxnic.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: module: Add all unwind tables when load module
Message-ID: <YoOu1Ng53Tv/ec0d@shell.armlinux.org.uk>
References: <20220401131534.241205-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401131534.241205-1-chenzhongjin@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 01, 2022 at 09:15:34PM +0800, Chen Zhongjin wrote:
>  struct mod_arch_specific {
>  #ifdef CONFIG_ARM_UNWIND
> -	struct unwind_table *unwind[ARM_SEC_MAX];
> +	struct unwind_table unwind_list;

Why is this not a:

	struct list_head unwind_list;

because, from what I can tell, the _only_ member that is used in this
struct unwind_table is the "mod_list" member - so everything else is
entirely unused and redundant.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
