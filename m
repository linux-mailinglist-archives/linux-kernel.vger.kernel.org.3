Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99BC5A0F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiHYLrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbiHYLrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:47:14 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 974F07332B;
        Thu, 25 Aug 2022 04:47:13 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0AD4A92009C; Thu, 25 Aug 2022 13:47:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 05F3692009B;
        Thu, 25 Aug 2022 12:47:08 +0100 (BST)
Date:   Thu, 25 Aug 2022 12:47:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] serial: dz: Replace DZ_XMIT_SIZE with
 UART_XMIT_SIZE
In-Reply-To: <20220825091918.8398-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2208251219120.26998@angie.orcam.me.uk>
References: <20220825091918.8398-1-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, Ilpo Järvinen wrote:

> Use the normal UART_XMIT_SIZE directly.

 I gather this is to fix a potential inconsistency with the size of the 
buffer allocated by the serial core (though in reality this driver will 
only be used with 4KiB-page systems), right?  If so, then please state it 
in the change description.

 Also I'd rather:

#define DZ_WAKEUP_CHARS      UART_XMIT_SIZE

and there's no need to include <linux/serial_core.h> in dz.h as the driver 
itself already does that (and dz.h is an auxiliary private header).

 Thanks for your submission.

  Maciej
