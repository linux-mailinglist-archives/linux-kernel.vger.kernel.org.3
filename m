Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85425A2157
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbiHZHB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245121AbiHZHBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:01:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A0ED274A;
        Fri, 26 Aug 2022 00:00:47 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:00:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661497243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkTtYm2q/9xtcjUEfSGlzSP0DecF5sMix+kg+ulWubI=;
        b=LDdxH5cVjo4V3SbRmuOHNfXIEenNZLUPqsQEFPgzZtqIJIAfqqWQF7aFjKPuMh+e1iAN2u
        wImKeRqbrZF1CUrCadKKyB5vwOeRebtGXS4RV6vTls3rHUKc8c7FLmZRvFqDY014dgU6RF
        N8it/iZ//v6M0vNYbWsZmgFMbbsFWbJ5d1vg5u0f1TC0sTyRp42AjGzrpiqCZvO2MNDwgA
        sUYwQZzGSpBaoP2xXjnjCCHBpbMIhoNWShgy4uqm8tKRMlo0wHOwdt29yLD+RlVTUVF/9s
        mSWFVXEZo6lESKDSt/ceStaBE9HO5nclAUWObcoUzd6UnRzLFvNpwrlNayjKhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661497243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkTtYm2q/9xtcjUEfSGlzSP0DecF5sMix+kg+ulWubI=;
        b=keO7wzubCGo7igl4B1c5pmvEm5kpAYCLkM7HbuBc9brjFSVX60XgSeCl+OLB2sHx0Wo4kp
        Gk1J8w/S9eQJfFBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v2 11/25] usb: gadget: f_tcm: Execute command on write
 completion
Message-ID: <YwhvmpdbG8WXhhZ0@linutronix.de>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <b030d10834c13aa09bbbba7b33b1957d5ba3664c.1658192351.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b030d10834c13aa09bbbba7b33b1957d5ba3664c.1658192351.git.Thinh.Nguyen@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 18:27:12 [-0700], Thinh Nguyen wrote:
> index 6fea80afe2d7..ec83f2f9a858 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -955,7 +949,7 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, s=
truct usb_request *req)
>  				se_cmd->data_length);
>  	}
> =20
> -	complete(&cmd->write_complete);
> +	target_execute_cmd(se_cmd);

usbg_data_write_cmpl() is invoked from interrupt service routing which
may run with disabled interrupts. From looking at target_execute_cmd():
| void target_execute_cmd(struct se_cmd *cmd)
| {
=E2=80=A6
|         spin_lock_irq(&cmd->t_state_lock);
=E2=80=A6
|         spin_unlock_irq(&cmd->t_state_lock);
=E2=80=A6
| }

which means interrupts will remain open after leaving
target_execute_cmd(). Now, why didn't the WARN_ONCE() in
__handle_irq_event_percpu() trigger? Am I missing something?

>  	return;

Sebastian
