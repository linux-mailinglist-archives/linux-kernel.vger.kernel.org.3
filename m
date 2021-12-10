Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA374705C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbhLJQfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:35:48 -0500
Received: from marcansoft.com ([212.63.210.85]:47512 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243624AbhLJQfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:35:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A10E1419C2;
        Fri, 10 Dec 2021 16:32:08 +0000 (UTC)
Subject: Re: [PATCH] spi: Fix incorrect cs_setup delay handling
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>
References: <20211210153634.171580-1-marcan@marcan.st>
 <YbN+cBQlsLprirxW@sirena.org.uk>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <3c94fa29-6c21-9fbd-b1f5-eb6c846054bb@marcan.st>
Date:   Sat, 11 Dec 2021 01:32:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YbN+cBQlsLprirxW@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2021 01.21, Mark Brown wrote:
> On Sat, Dec 11, 2021 at 12:36:34AM +0900, Hector Martin wrote:
> 
>> We need to wait *after* asserting CS and before the transfer, not before
>> asserting CS which isn't very useful.
> 
> This needs a better changelog, there's multiple delays being handled
> here and it's not clear from this which are affected here or what the
> problem is.

cs_setup is affected, I thought at least that was clear from the patch 
summary :-)

 From spi.h:

* @cs_setup: delay to be introduced by the controller after CS is asserted

So clearly that delay has to happen at the end of spi_set_cs, *after* 
the assertion, not at the beginning before it.

If you prefer, I can resend it with a reference to the spi.h comment.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
