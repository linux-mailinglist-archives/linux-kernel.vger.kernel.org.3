Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C666465744
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhLAUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352995AbhLAUnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:43:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2E2C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:39:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x7so18945005pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JihpeWwnbffmSzfQgXPFy6rVgCaBqhRy0BEqe280cxA=;
        b=cpvBVD7LMaw9qYDhYi2lGHYPXilvgUNFn/xR7q421BAxHOesaXVRp6d+IycLTlLA2P
         MHV+34hzaSw1+xnmu1mSiij/xPlZKWZ2LGI8IbClylS/zq6mDIu16kcsFya4BzLAKdAw
         9paDK4xNaP5NNAUCkoHVCJ/m4rxKTb5/eevGNaSey/PyyjeINtbvTz9+Alqx7zd5Xn3F
         m4Sy0dxut1QXkRQuEg6J/qQ03h+MfjrQGAVj6znAiBqGwIMPqiDPgJmhdZSye8vhC4CJ
         tT9jnhnhNLhbcLjzAUIe+LotVzNBbuVrBORmY9lY1jxzeJheQ0G3JLqWurdSCDTDyu5U
         QMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JihpeWwnbffmSzfQgXPFy6rVgCaBqhRy0BEqe280cxA=;
        b=dq+KzTyVNBUN6J2NCcC1n5N45sNvFwaNMqCBaZe7wv4rCF/UX4X7O1QFCijlGuLWDn
         DLvp+jftDq6VA27lj56tp345fTRcL9ENRi7HAj8rBGLKoXHjSX8jP7d+tdUi/LgVATTc
         lnhqL6PpBpkBYwlil381IrnV6MbODVyeW3uuGf8FwdGZ3cneZkv+hoc58cyAJWoUB4pb
         6Gh46NBxGvWA8W+HP8QCPHxrqVuUZQd0AvszZcqsGAgEz7SqM0qyWNJTBf4685jubdEP
         VdTUSBRWqxXoVazJO0XZlHi5pqu2zEqdRHGnk/Mg1wOAWvX0BqHQvOzwxbj9651+1nMf
         BDsA==
X-Gm-Message-State: AOAM533diMCiVtz0dTBNJ70MdwzEqhMq0F84Y81LIzhR7EdI4alkj4Bi
        yOYH9NZocxQT5MVFDHyxhMo=
X-Google-Smtp-Source: ABdhPJxJVotuM4kn3lvPTPEnYvo6GNLxAMoqoujTrCk15/4LLhQFytkFhVHJP5FBKjlUnS5HucJ4Ag==
X-Received: by 2002:a17:902:c7c2:b0:143:bdf7:1670 with SMTP id r2-20020a170902c7c200b00143bdf71670mr10104784pla.61.1638391198523;
        Wed, 01 Dec 2021 12:39:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id hg4sm189549pjb.1.2021.12.01.12.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 12:39:57 -0800 (PST)
Subject: Re: [PATCH 1/3] phy: usb: Leave some clocks running during suspend
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Vinod Koul <vkoul@kernel.org>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <20211201180653.35097-2-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1c7cdbef-75c7-6ee8-825d-840fa0124633@gmail.com>
Date:   Wed, 1 Dec 2021 12:39:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201180653.35097-2-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 10:06 AM, Al Cooper wrote:
> The PHY client driver does a phy_exit() call on suspend or rmmod and
> the PHY driver needs to know the difference because some clocks need
> to be kept running for suspend but can be shutdown on unbind/rmmod
> (or if there are no PHY clients at all).
> 
> The fix is to use a PM notifier so the driver can tell if a PHY
> client is calling exit() because of a system suspend or a driver
> unbind/rmmod.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
