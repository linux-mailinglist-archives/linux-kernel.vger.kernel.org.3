Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79E4B9FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiBQMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:06:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbiBQMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:06:15 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 166C92AD667;
        Thu, 17 Feb 2022 04:06:00 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2CB5692009D; Thu, 17 Feb 2022 13:05:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2664092009C;
        Thu, 17 Feb 2022 12:05:58 +0000 (GMT)
Date:   Thu, 17 Feb 2022 12:05:58 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     kbuild@lists.01.org, Jiri Slaby <jirislaby@kernel.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mike Skoog <mskoog@endruntechnologies.com>,
        Mike Korreng <mkorreng@endruntechnologies.com>,
        info@endruntechnologies.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
In-Reply-To: <202202130027.ZKBCgtm5-lkp@intel.com>
Message-ID: <alpine.DEB.2.21.2202171009440.34636@angie.orcam.me.uk>
References: <202202130027.ZKBCgtm5-lkp@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022, Dan Carpenter wrote:

> url:    https://github.com/0day-ci/linux/commits/Maciej-W-Rozycki/serial-8250-Fixes-for-Oxford-Semiconductor-950-UARTs/20220212-164255
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220213/202202130027.ZKBCgtm5-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/tty/serial/8250/8250_pci.c:1171 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'tcr'.
> drivers/tty/serial/8250/8250_pci.c:1172 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'quot'.
> drivers/tty/serial/8250/8250_pci.c:1180 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'cpr'.

 These variables do get assigned to in the first iteration of the loop, 
because the deviation calculated (`srem') is normalised to the range of 
[0,spre/2] and that divided by the original divisor (`spre') always works 
out at within [0,0.5], so `squot' will be within [0,32768].  I guess the 
static analyser is too dumb to figure it out, so I'll see how to paper it 
over unless someone has a better proposal.

 Greg: shall I send an update patch or a replacement v4 of the series?

  Maciej
