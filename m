Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED454BE77D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355512AbiBULLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:11:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355563AbiBULKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:10:23 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53157765B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:42:00 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 82D832223E;
        Mon, 21 Feb 2022 11:41:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645440119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/oFMNHJ9Vt/cbN7UZwsXwP2TGn4Fh6S9plzC8KDPhWw=;
        b=Vkqt80mzuse0ER9la84yeucxS3JKND+I1DI/w9usr/Hjm9HGfo8KLwkCAn3/C6Q3gZUZMR
        3ySdi7+9VcM51vKGTwh5ShkhCGdbgFw3/u2WeSfUIMcq+Zt2p7CiVe2qTtuKxogCPj6AAN
        dEzuYLUpC/tDZmGgtN8xFWgZeNn24rs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Feb 2022 11:41:58 +0100
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 0/7] soc: fsl: guts: cleanups and serial_number support
In-Reply-To: <20220209163242.430265-1-michael@walle.cc>
References: <20220209163242.430265-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <1e46ae6508997c2bb3f1f0c922ae81d8@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

any news here? Through which tree is this supposed to go?

Am 2022-02-09 17:32, schrieb Michael Walle:
> This series converts the guts driver from a platform driver to just an
> core_initcall. The driver itself cannot (or rather should never) be
> unloaded because others depends on detecting the current SoC revision
> to apply chip errata. Other SoC drivers do it the same way. Overall I
> got rid of all the global static variables.
> 
> The last patch finally adds unique id support to the guts driver. But
> because the binding [1] for the security fuse processor is still 
> pending,
> it is marked as RFC.

As I was about to resend this series without the RFC tag, I noticed
that I forgot to mark patch 7/7 as RFC in v2 anyway. So no need for
resending.

The binding was acked by Rob and already picked up via the nvmem tree.

-michael

> 
> [1] 
> https://lore.kernel.org/linux-devicetree/20220127163728.3650648-2-michael@walle.cc/
> 
> changes since v1:
>  - call kfree() in error case, thanks Dan
>  - add missing of_node_put(np), thanks Dan
> 
> Michael Walle (7):
>   soc: fsl: guts: machine variable might be unset
>   soc: fsl: guts: remove module_exit() and fsl_guts_remove()
>   soc: fsl: guts: embed fsl_guts_get_svr() in probe()
>   soc: fsl: guts: allocate soc_dev_attr on the heap
>   soc: fsl: guts: use of_root instead of own reference
>   soc: fsl: guts: drop platform driver
>   soc: fsl: guts: add serial_number support
> 
>  drivers/soc/fsl/guts.c | 219 ++++++++++++++++++++++-------------------
>  1 file changed, 118 insertions(+), 101 deletions(-)
