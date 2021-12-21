Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37447C793
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhLUTjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:39:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36780 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhLUTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:39:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BLJctab003942;
        Tue, 21 Dec 2021 13:38:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640115535;
        bh=kxlTsvQ14/FMb4Iz0aWnvKzaGod9t//Snzz1vZNca1U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=M1pygQ99dJaV0qJru8DI2dVhY8BisHDjGozgz8s371zl46eNutTJsTVaGZCZGIGhE
         BA+mSQGSp7mhWpox12+FlMJc2soCYuevS8YU9BewVVGYMKRv40aAki/aH88oY9qUzN
         hmjgeyPGIWe9PefeLsOUmly8AUKtC+I68cTI8e5w=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BLJctBl114542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 13:38:55 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 13:38:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 13:38:55 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BLJcsdF056610;
        Tue, 21 Dec 2021 13:38:55 -0600
Date:   Wed, 22 Dec 2021 01:08:54 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sudeep.holla@arm.com>,
        <james.quinlan@broadcom.com>, <Jonathan.Cameron@Huawei.com>,
        <f.fainelli@gmail.com>, <etienne.carriere@linaro.org>,
        <vincent.guittot@linaro.org>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v8 01/11] firmware: arm_scmi: Add configurable polling
 mode for transports
Message-ID: <20211221193852.pmb4nu43zzu6trqt@ti.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
 <20211220195646.44498-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211220195646.44498-2-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/12/21 07:56PM, Cristian Marussi wrote:
> SCMI communications along TX channels can optionally be provided of a
> completion interrupt; when such interrupt is not available, command
> transactions should rely on polling, where the SCMI core takes care to
> repeatedly evaluate the transport-specific .poll_done() function, if
> available, to determine if and when a request was fully completed or
> timed out.
> 
> Such mechanism is already present and working on a single transfer base:
> SCMI protocols can indeed enable hdr.poll_completion on specific commands
> ahead of each transfer and cause that transaction to be handled with
> polling.
> 
> Introduce a couple of flags to be able to enforce such polling behaviour
> globally at will:
> 
>  - scmi_desc.force_polling: to statically switch the whole transport to
>    polling mode.
> 
>  - scmi_chan_info.no_completion_irq: to switch a single channel dynamically
>    to polling mode if, at runtime, is determined that no completion
>    interrupt was available for such channel.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

This patch breaks linux-next build for me with LLVM.

drivers/firmware/arm_scmi/driver.c:869:6: error: variable 'i_' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
        if (IS_POLLING_ENABLED(cinfo, info))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/driver.c:59:33: note: expanded from macro 'IS_POLLING_ENABLED'
                        IS_TRANSPORT_POLLING_CAPABLE(i_));              \
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/firmware/arm_scmi/driver.c:45:19: note: expanded from macro 'IS_TRANSPORT_POLLING_CAPABLE'
        typeof(__i) i_ = __i;                                           \
                    ~~   ^~~
1 error generated.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
