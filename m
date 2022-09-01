Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ADF5A96AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiIAMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiIAMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D4B7CB5F;
        Thu,  1 Sep 2022 05:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E7D61DF4;
        Thu,  1 Sep 2022 12:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8588C433C1;
        Thu,  1 Sep 2022 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662035117;
        bh=GBVFSBe0bo4VRzuItQqKjxBIRrfeZYQb6FobCyqvZrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dkwg05ef965iTl/gPTXT3Ps+w2WjWBy199KgzzKW1hAMJ0uSk1P0yVpZjrk1AFU7A
         gAfNRDuvn5FMUt6xqUVfpiOJ8EOcwcnk44dlNZUAOWxgqq5vx9YhSXPfVbapCnMMrh
         kbtfe7Fhpwa3DlJZoSlW6wRNAl1R+tlyhNKvqy3U=
Date:   Thu, 1 Sep 2022 14:25:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tty: serial: introduce transmit helper generators
Message-ID: <YxCkqmz32qMAZAPh@kroah.com>
References: <20220901110657.3305-1-jslaby@suse.cz>
 <20220901110657.3305-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901110657.3305-2-jslaby@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:06:55PM +0200, Jiri Slaby wrote:
> Many serial drivers do the same thing:
> * send x_char if set
> * keep sending from the xmit circular buffer until either
>   - the loop reaches the end of the xmit buffer
>   - TX is stopped
>   - HW fifo is full
> * check for pending characters and:
>   - wake up tty writers to fill for more data into xmit buffer
>   - stop TX if there is nothing in the xmit buffer
> 
> The only differences are:
> * how to write the character to the HW fifo
> * the check of the end condition:
>   - is the HW fifo full?
>   - is limit of the written characters reached?
> 
> So unify the above into two helper generators:
> * DEFINE_UART_PORT_TX_HELPER_LIMITED() -- it performs the above taking
>   the written characters limit into account, and
> * DEFINE_UART_PORT_TX_HELPER() -- the same as above, except it only
>   checks the HW readiness, not the characters limit.
> 
> The HW specific operations (as stated as "differences" above) are passed
> as arguments to the macros. They are:
> * tx_ready() -- returns true if HW can accept more data.
> * put_char() -- write a character to the device.
> * tx_done() -- when the write loop is done, perform arbitrary action
>   before potential invocation of ops->stop_tx() happens.
> 
> Note that the above macros are generators. This means the code is
> generated in place and the above 3 arguments are "inlined". I.e. no
> added penalty by generating call instructions for every single
> character. Nor any indirect calls. (As in previous versions of this
> patchset.)
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> 
> Notes:
>     [v2] instead of a function (uart_port_tx_limit()) in serial_core,
>          generate these in-place using macros. Thus eliminating "call"
>          penalty.

Much nicer, but:

> +#define __DEFINE_UART_PORT_TX_HELPER(name, port, ch, tx_ready, put_char,  \
> +		tx_done, for_test, for_post, ...)			  \

Do you really need "port" and "ch" as part of this macro?  You always
set that to the same thing in your patches, so is it really needed?

thanks,

greg k-h
