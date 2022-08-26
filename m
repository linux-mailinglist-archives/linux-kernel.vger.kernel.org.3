Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38F45A223B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbiHZHsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbiHZHsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:48:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC286C2EB9;
        Fri, 26 Aug 2022 00:48:04 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:48:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661500083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJDu6zCHTXsME6CZWLgdPNi6X1pwdx8lv49rwGgdVAk=;
        b=UGHB04unjwFwj5pQPdB7XoFHJD1V8Qx1rBqhvvV73Pa9duVKBFLM7KS7pwE20KP7scQMEi
        9yxH/Jf/FclOYF9pxDEGAyl/V6PKrsiUJTI8OLhW79nAiVCBZd7Lur7zo7HMQb1o2wu8XN
        RcIaf83DGyApc/UbCztbL+hCjDMItnIVi/O+XR2sh+0twcXMmbQGk2MFp1QbazDFN/w7J5
        7RESJFHgO0a0TtBXDCZlkjrk/UOjPHPzIJO8Hx6sUydmbStMvKTVtY2bPz33VUFQsadDC3
        W2AlMFkhyth+3XAphuJVBFxLq5+MhjmzUBOD2TL5jGeh1Ui71QhyvkAOmUGsAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661500083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJDu6zCHTXsME6CZWLgdPNi6X1pwdx8lv49rwGgdVAk=;
        b=/aWdheSkZzYraSdOrvd3S4j9MCl9NQiedCcwVmm0V/xg8NR1Me7JNgotAubIUWiWPUF2AJ
        Bg5xnhSfxCToOQCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v2 17/25] usb: gadget: f_tcm: Handle abort command
Message-ID: <Ywh6sUom7d9HqAx6@linutronix.de>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <099a4bd5ed02f4c48f4640347379b5127075e453.1658192351.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <099a4bd5ed02f4c48f4640347379b5127075e453.1658192351.git.Thinh.Nguyen@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 18:27:51 [-0700], Thinh Nguyen wrote:
> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -1278,6 +1278,22 @@ static void usbg_queue_tm_rsp(struct se_cmd *se_cmd)
>  
>  static void usbg_aborted_task(struct se_cmd *se_cmd)
>  {
> +	struct usbg_cmd *cmd = container_of(se_cmd, struct usbg_cmd, se_cmd);
> +	struct f_uas *fu = cmd->fu;
> +	struct uas_stream *stream = cmd->stream;
> +	int ret = 0;
> +
> +	if (stream->req_out->status == -EINPROGRESS)
> +		ret = usb_ep_dequeue(fu->ep_out, stream->req_out);
> +	else if (stream->req_in->status == -EINPROGRESS)
> +		ret = usb_ep_dequeue(fu->ep_in, stream->req_in);
> +	else if (stream->req_status->status == -EINPROGRESS)
> +		ret = usb_ep_dequeue(fu->ep_status, stream->req_status);
> +
> +	if (ret)
> +		pr_err("Unable to dequeue se_cmd out %p\n", se_cmd);

I know I wasn't the best example here. But if you continue to work on
that one, if would be nice if you could replace all the pr_err() here
with a dev_err() (or so) so it is bound to an actual device and the
reader can actually pin point the message to the actually device/
subsystem. I'm not sure if we lack a device or I was extremely lazy.
Again, not something you need change now.

> +	cmd->state = UASP_QUEUE_COMMAND;
>  }
>  
>  static const char *usbg_check_wwn(const char *name)

Sebastian
