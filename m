Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E535A21B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245231AbiHZHWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiHZHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:22:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B5F4DB43;
        Fri, 26 Aug 2022 00:22:40 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:22:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661498558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQJwizWUZDP3BI9K5yZYcBnhISmXQJvntuw2CVta3II=;
        b=KZZpkSO4qaRwW67bSXJjY/YP/HPGu14NbRtLiv2aK+v+sYqEIcgMQkEgDnwBMtm6W5HDNB
        JTzGM5Ne9McUF7ORLicrPYO9ssNEQEoUIlCeb4K9INMi6laExJpeaL5M85XW+lXKw+Pz3Z
        zGKKKlEaCS6WcNKXmf5RWaBsZRUuzIfkSWbUtQQn0CEoCN4TA8WVrvGS2AOqsOsexL2v28
        jpl0p96//YJcKBGbQ/O+1I2GtE/sKnrQIrj7rMkzTgUHRQ2LBhXuHO+qull3FwpUXaGHbq
        4L0baQvDHtybe59BnZXT4LZodIQUJVUnq9R5fHdHlM6/D4CdiQRKiMfFZYxB1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661498558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQJwizWUZDP3BI9K5yZYcBnhISmXQJvntuw2CVta3II=;
        b=u79Zlqto8+LIFUoD2rNHsPmmDaQEm+HcsZsxCrxqtp96SzJ3nfiQj4OiAxDLb6hTW7Qcgt
        7Hv4QPzsuOhCLfAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v2 16/25] usb: gadget: f_tcm: Update state on data write
Message-ID: <Ywh0vQkRLTrSeExk@linutronix.de>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <dd9069e0527f2da04b6567fd17b19545646f4348.1658192351.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd9069e0527f2da04b6567fd17b19545646f4348.1658192351.git.Thinh.Nguyen@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 18:27:45 [-0700], Thinh Nguyen wrote:
> When preparing request for data write state, the next state is
> UASP_SEND_STATUS. When data write completes, the next state is
> UASP_QUEUE_COMMAND. Without this change, the command will transition to
> the wrong state.

Why is this needed now, what is the outcome of not having it?
My point is, was this always broken, worked by chance and broke over
time while code was changed?

> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
>  Changes in v2:
>  - Move a related change from TASK MANAGEMENT updating cmd state to
>    UASP_QUEUE_COMMAND to here.
> 
>  drivers/usb/gadget/function/f_tcm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
> index 1e7d29f8aecb..d7318c84af98 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -934,6 +934,8 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
>  	struct usbg_cmd *cmd = req->context;
>  	struct se_cmd *se_cmd = &cmd->se_cmd;
>  
> +	cmd->state = UASP_QUEUE_COMMAND;
> +
>  	if (req->status < 0) {
>  		pr_err("%s() state %d transfer failed\n", __func__, cmd->state);
>  		goto cleanup;
> @@ -976,6 +978,8 @@ static int usbg_prepare_w_request(struct usbg_cmd *cmd, struct usb_request *req)
>  	req->complete = usbg_data_write_cmpl;
>  	req->length = se_cmd->data_length;
>  	req->context = cmd;
> +
> +	cmd->state = UASP_SEND_STATUS;
>  	return 0;
>  }
>  

Sebastian
