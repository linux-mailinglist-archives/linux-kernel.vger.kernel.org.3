Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22BC54AB65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355587AbiFNIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiFNIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0819E2CDE9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69959613EA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7729EC3411B;
        Tue, 14 Jun 2022 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655193801;
        bh=xNEEaInH/LKZoWtvuDlNJaZfqiWphsqqnVIIBffqYSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIFjPhFu8bPc91HKOrRVeGWc64yPgQgu7Nx798L2QcZin1rlE/8KfDHbDsw0J3lH+
         0ATgSyb5u3AMCxOU4RiaOqTLFgl7m5b7hotaQlJ4f7v/lyeVKhUvFyHgPGT3UYsRrZ
         EmmHQbOvTL/oHlyjWzm/BWTw/IO/GrC//gTtJYDQ=
Date:   Tue, 14 Jun 2022 10:03:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wenhu Wang <wenhu.wang@hotmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] uio:powerpc:mpc85xx: l2-cache-sram uio driver
 implementation
Message-ID: <YqhAxj0dLoUkBZfg@kroah.com>
References: <20220609102855.272270-1-wenhu.wang@hotmail.com>
 <SG2PR01MB295139AA7360917B2C4846E19FA79@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
 <YqHy1uXwCLlJmftr@kroah.com>
 <SG2PR01MB2951EA9ED70E5F766DD26A069FAA9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
 <efebcb50-0481-622a-894c-7000999aacc6@csgroup.eu>
 <c76598b5-2d60-ea22-d590-4cc6998a8830@csgroup.eu>
 <SG2PR01MB29516D3BB7525390ADD5B0829FAA9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR01MB29516D3BB7525390ADD5B0829FAA9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:53:46AM +0000, Wenhu Wang wrote:
> >> >> +
> >> >> +struct mpc85xx_l2ctlr {
> >> >> +     u32     ctl;            /* 0x000 - L2 control */
> >> >
> >> >What is the endian of these u32 values?  You map them directly to
> >> >memory, so they must be specified some way, right?  Please make it
> >> >obvious what they are.
> >> >
> >>
> >> Surely, the values should be u32 here, modified in v2
> >> The controller info could be found in
> >> "QorIQ¢â P2020 Integrated Processor Reference Manual"
> >> "Chapter 6 L2 Look-Aside Cache/SRAM"
> >> See: http://m4udit.dinauz.org/P2020RM_rev0.pdf
> >
> >That's not the answer to my question :)
> >
> >These are big-endian, right?  Please mark them as such and access them
> >properly with the correct functions.
> 
> Yes, they are big-edian.
> Does it work to add comments(about order and access functions) for the structure ahead of it£¿
> And appending like "_be", "_access_be" or "_big_endian"? (struct mpc85xx_l2ctlr_be {¡¦¡¦};

No, not comments, these should be of the type __be32, right?

thanks,

greg k-h
