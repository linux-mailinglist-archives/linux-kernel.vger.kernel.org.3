Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7D55D07C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiF0Gxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiF0Gx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C0626DD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83843612F0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D95C341C8;
        Mon, 27 Jun 2022 06:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656312807;
        bh=YMnpQ22y+MGXt/JGuvFPSGFaB2wfRaxnM06BIxHzmEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1Ambt0wQ2JMXXFBCJ0nadm5S4JHO8OJMYGoFHoA7yNXk17o5LtVaW+lL8eQla4ki
         qNkVznnc1vvBpnQ8ZMblOjOSjokBIYlf3BX0gooAPxi8yzrzcYIVJWHJHK7U+Mno38
         5GWTiPAXmMCfJM6/c9HSjesq5AynhHkSso8RxosNrUJgA0k57injl69edb2AAuvv5+
         qnEc4GmLDzovq62U+aiPOrruv9tH3z6fGl+OxieVqhmxkuu28Bq5VfzugnjNht8/Yw
         f179pcdCCejndqKPePCdciL2cTMvErAwZ8D3pon8gjIm0QBsNMhTT3Bf1lDbqwIdoy
         AGjQLTmwjCwFw==
Date:   Mon, 27 Jun 2022 14:53:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH RESEND v2 0/7] soc: fsl: guts: cleanups and serial_number
 support
Message-ID: <20220627065321.GA819983@dragon>
References: <20220404095609.3932782-1-michael@walle.cc>
 <0bde7550b0bbd1b0a478139d296f92a2@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bde7550b0bbd1b0a478139d296f92a2@walle.cc>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 01:03:33PM +0200, Michael Walle wrote:
> Am 2022-04-04 11:56, schrieb Michael Walle:
> > [Resend because of new development cycle. Shawn, can this series get
> > through your tree? Sorry you weren't on CC on the former submissions.]
> > 
> > This series converts the guts driver from a platform driver to just an
> > core_initcall. The driver itself cannot (or rather should never) be
> > unloaded because others depends on detecting the current SoC revision
> > to apply chip errata. Other SoC drivers do it the same way. Overall I
> > got rid of all the global static variables.
> > 
> > The last patch finally adds unique id support to the guts driver. DT
> > binding can be found at:
> >   Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> > 
> > changes since v1:
> >  - call kfree() in error case, thanks Dan
> >  - add missing of_node_put(np), thanks Dan
> > 
> > Michael Walle (7):
> >   soc: fsl: guts: machine variable might be unset
> >   soc: fsl: guts: remove module_exit() and fsl_guts_remove()
> >   soc: fsl: guts: embed fsl_guts_get_svr() in probe()
> >   soc: fsl: guts: allocate soc_dev_attr on the heap
> >   soc: fsl: guts: use of_root instead of own reference
> >   soc: fsl: guts: drop platform driver
> >   soc: fsl: guts: add serial_number support
> > 
> >  drivers/soc/fsl/guts.c | 219 ++++++++++++++++++++++-------------------
> >  1 file changed, 118 insertions(+), 101 deletions(-)
> 
> There goes another kernel release without any comments on this
> series :(
> 
> Shawn, can you pick this up and give it some time in linux-next?

Okay, I just picked the series up to IMX tree.

Leo, let me know if you want to drop it from IMX tree.

Shawn
