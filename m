Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE95AF6C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIFV1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIFV1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:27:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C72B5E68
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z8Gxtn/5Mdie1i/tik+XaG0WZ+Bolm1Vdi7iewRca7U=; b=RqbwdFPVrGOjJodWAEScKPbeze
        gf+Dzcbqo8vb5ATRc8FgAL0XJc/wZp2eta2DYPK6zl3PdLfxYV23zIoSDum1RrkWsGvNglBENgAt/
        jiK3Wby4AU2AlDwgB5DRmwKQ8Ed7GburBavynL4vHfNq8Jf9ec2yXPvuNYEyI7+UMLSjVt1gWJdRM
        bgh5QiVUcOBWkO4M0UNdAHyV/F6Zvi8RCAFEzuu94vhrqxtxPZeouxxysCZsfO9TGQZycRSlJz0VB
        0RLEao04Ie7XPbY0krtbQ8R5rjt4QjYPpaN/0AWs/yb7SxMjEHaPXFaX9HFyFHpcPF4L59AU5VnNT
        nrNiao/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34154)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oVg6R-0004Uz-EO; Tue, 06 Sep 2022 22:27:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oVg6P-0000Aq-Hy; Tue, 06 Sep 2022 22:27:25 +0100
Date:   Tue, 6 Sep 2022 22:27:25 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Gabriel Francisco <frc.gabriel@gmail.com>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Saravana Kannan <saravanak@google.com>,
        patches@armlinux.org.uk, Guenter Roeck <linux@roeck-us.net>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] amba: Fix use-after-free in amba_read_periphid()
Message-ID: <Yxe7PQR4/s4MlvYE@shell.armlinux.org.uk>
References: <20220818172852.3548-1-isaacmanjarres@google.com>
 <094b6125-6b3e-1b8e-024f-a924e4775305@gmail.com>
 <CABfwK12ChYDmhvR2EO1q2NUS4Zhd1WO8UWWoSVNY331wwbKS0w@mail.gmail.com>
 <0d2875d6-280f-c901-a7b4-92ea6a84e966@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2875d6-280f-c901-a7b4-92ea6a84e966@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:58:55PM +0200, Gabriel Francisco wrote:
> I'm afraid the issue is still showing up (looks similar when I tested with
> 6.0-rc2 + your patch and it went away when combining with Zhen Lei's one).
> 
> I added the dmesg log at
> https://bugzilla.kernel.org/attachment.cgi?id=301756

Bugzilla's all great and all, but not with firefox. Firefox wants me
to open that attachment in Libreoffice Writer... so wget -O - ... |less
to the rescue.

So you have an oops in __clk_put(), which suggests you don't have
"amba: Fix use-after-free in amba_read_periphid()" from Isaac Manjarres
applied. I haven't sent it upstream yet, but even if I had, 6.0-rc2
would be too old. Please try with Isaac's patch applied, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
