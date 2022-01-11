Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C448AC32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiAKLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:10:22 -0500
Received: from marcansoft.com ([212.63.210.85]:37906 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238050AbiAKLKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:10:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 883EA44B2A;
        Tue, 11 Jan 2022 11:10:17 +0000 (UTC)
Message-ID: <f8b4606a-e3ec-e452-f291-7ac36c69f8cd@marcan.st>
Date:   Tue, 11 Jan 2022 20:10:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v1] usb: typec: tipd: keep default interrupts enabled
 during probe()
Content-Language: en-US
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        sven@svenpeter.dev, hdegoede@redhat.com
Cc:     kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220110163559.711404-1-martin.kepplinger@puri.sm>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220110163559.711404-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/11 1:35, Martin Kepplinger wrote:
> Commit 9990f2f6264c ("usb: typec: tipd: Enable event interrupts by default")
> writes a fixed set of interrupts to TPS_REG_INT_MASK1. In case interrupts
> had been enabled by the firmware by default, these get disabled now
> which can break use cases. Only append to what is already enabled instead.
> 

I'm confused. The kernel drives the hardware, it needs to enable only
the interrupts it can handle. Do you have some kind of firmware trying
to share access to the same I2C port that needs other interrupts? That
sounds like a recipe for trouble... or am I misunderstanding things?

If the *kernel* needs other interrupts enabled to make something work,
then they should also be enabled unconditionally, and you'd have to
check the IRQ handler to make sure it actually handles it.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
