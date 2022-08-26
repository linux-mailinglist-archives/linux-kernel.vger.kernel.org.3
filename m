Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640C15A23B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbiHZJGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245227AbiHZJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:06:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03DD6304;
        Fri, 26 Aug 2022 02:06:36 -0700 (PDT)
Date:   Fri, 26 Aug 2022 11:06:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661504795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bWmtCR9K7g8WGM5dbPXeabsChqiWPGxtgX1i922KQpo=;
        b=VnrvzOJWE1hyoW45ywyZ99N/BWqSF9eAuSZuxEMJxti8RImvw7Lt+CD9mNVet84Ip5N0gG
        C2LadHZuBIaJRh6PULR17EDSLJ1eRFXI6kUfVWma7hVCLDEeVojvIzhxu9z5HHKR/MNXjp
        eBpQp4riVw1IuKqyC9xLuVSRevAKWvMB3d5ovkVks++Shw3VW4TqsufjjnCJsavI0jFOlK
        +buAl2R8h995WOW4HGYqGD+fIly0Kt4+zCpmoyxHnqDSE+1TJFAWLMZDfhu1ptBjVMCynL
        mBBFVgufrJHU+6mrCDPDTIVjkaUftayTEcIVLeUtTss4L8AKuXY4vYQQHOrB9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661504795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bWmtCR9K7g8WGM5dbPXeabsChqiWPGxtgX1i922KQpo=;
        b=DoKhqbgdm7w9bGMz/o276aFnYc4vVcFHzC9Pns3HMgBTlVPB/ajJmpSfvqpcndATAhMEZo
        +crRx60ffDudEcCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v2 21/25] usb: gadget: f_tcm: Get stream by tag
Message-ID: <YwiNGK3ZZeYi2lN7@linutronix.de>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <3fbae6ecb8e9f31807635152a377b076e86fb12e.1658192351.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fbae6ecb8e9f31807635152a377b076e86fb12e.1658192351.git.Thinh.Nguyen@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 18:28:16 [-0700], Thinh Nguyen wrote:
> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
> index 084143213176..a10e74290664 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -506,6 +506,22 @@ static void uasp_cleanup_old_alt(struct f_uas *fu)
>  	uasp_free_cmdreq(fu);
>  }
>  
> +static struct uas_stream *uasp_get_stream_by_tag(struct f_uas *fu, u16 tag)
> +{
> +	/*
> +	 * For simplicity, we use mod operation to quickly find an in-progress
> +	 * matching command tag to check for overlapped command. The assumption
> +	 * is that the UASP class driver will limit to using tag id from 1 to
> +	 * USBG_NUM_CMDS. This is based on observation from the Windows and
> +	 * Linux UASP storage class driver behavior. If an unusual UASP class
> +	 * driver uses a tag greater than USBG_NUM_CMDS, then this method may no
> +	 * longer work due to possible stream id collision. In that case, we
> +	 * need to use a proper algorithm to fetch the stream (or simply walk
> +	 * through all active streams to check for overlap).
> +	 */
> +	return &fu->stream[tag % USBG_NUM_CMDS];

Could you please avoid the assumption what tag actually is?
Please take a look at hashtable.h, hash_add(), hash_del(),
hash_for_each_possible_safe() is probably all you need.
That % looks efficient but gcc will try and remove the div operation
which is something the hash implementation (as of hash_min()) avoids. So
the only additional costs here is the additional hashtable which worth
the price given that you don't assume what tag can be.

Sebastian
