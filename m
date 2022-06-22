Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192155489E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354683AbiFVLDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353850AbiFVLDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:03:39 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700B39B81
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:03:37 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7271A22238;
        Wed, 22 Jun 2022 13:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1655895815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBtd961AtvmJMz12rN1xdgEhy6lx5FNcxorgMS7aEYk=;
        b=l5mm9mk8jW1WKydNdLijg4SMlz53lnrVVQOXqiE5Ql70KDKnf+W2Paawv4CAzycYsJTYjh
        VNT74Hw8oTPepOgBqb05gvIkWxz4aXuwaJy0oJAPnbUeWaDgGpChvwv/nkZ8AqN54LJH8i
        lf6sleRhgncqfm7/P84gbI9jRneWltI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jun 2022 13:03:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH RESEND v2 0/7] soc: fsl: guts: cleanups and serial_number
 support
In-Reply-To: <20220404095609.3932782-1-michael@walle.cc>
References: <20220404095609.3932782-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0bde7550b0bbd1b0a478139d296f92a2@walle.cc>
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

Am 2022-04-04 11:56, schrieb Michael Walle:
> [Resend because of new development cycle. Shawn, can this series get
> through your tree? Sorry you weren't on CC on the former submissions.]
> 
> This series converts the guts driver from a platform driver to just an
> core_initcall. The driver itself cannot (or rather should never) be
> unloaded because others depends on detecting the current SoC revision
> to apply chip errata. Other SoC drivers do it the same way. Overall I
> got rid of all the global static variables.
> 
> The last patch finally adds unique id support to the guts driver. DT
> binding can be found at:
>   Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
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

There goes another kernel release without any comments on this
series :(

Shawn, can you pick this up and give it some time in linux-next?

-michael
