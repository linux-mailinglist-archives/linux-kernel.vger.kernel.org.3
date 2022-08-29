Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA05A54BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH2Tt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiH2TtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:49:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E887E80E;
        Mon, 29 Aug 2022 12:49:22 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:49:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661802560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkPMw4JsQ1oG6kbv2aAIz2c3TvpxBTukrq3ZfWbFv9M=;
        b=SD4C2j1CeUAOQkbLQnLIgyr6thz6fB1AtSJdMT62jLF0cXUO8DahmmQk+YFkwZa6sBcDDg
        ZrJp0vHf+nUEMhb/cctCMT1C8WXVwmVrvNVTY3de3BXSJMjPvRXblq44oPDtj38vdUkngR
        frQWAirhICwwI0nb8yPEYthpIlbM3XEbHHwo6pYl+zhzoHif8Om1+nP33EfyjugK19MqMa
        tGRs43biwAsS1L9IxnqDS0QrTjArpjuL7rL/JPH4vVmrB/63CsLngBmir9sqQhbDtK9XRo
        YYq8b4IZ19sojERGdrLyyw5JgrnjcTjz8A887qUCEcRcywW3HaShNX9e0vNqxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661802560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkPMw4JsQ1oG6kbv2aAIz2c3TvpxBTukrq3ZfWbFv9M=;
        b=HPVoLoZMMB4dtcyFtDmT6JKHErJhxFcVUX+qEhsif3JG66AoMr1/kxqFt1DcKNLGXNylHY
        1LF2h2zGiTdiY+CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH v2 11/25] usb: gadget: f_tcm: Execute command on write
 completion
Message-ID: <Yw0YP1qUYAw6inMJ@linutronix.de>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <b030d10834c13aa09bbbba7b33b1957d5ba3664c.1658192351.git.Thinh.Nguyen@synopsys.com>
 <YwhvmpdbG8WXhhZ0@linutronix.de>
 <20220826183732.vxogtdlwqiqbcg2t@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220826183732.vxogtdlwqiqbcg2t@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-26 18:37:36 [+0000], Thinh Nguyen wrote:
> On Fri, Aug 26, 2022, Sebastian Andrzej Siewior wrote:
> > On 2022-07-18 18:27:12 [-0700], Thinh Nguyen wrote:
> > > index 6fea80afe2d7..ec83f2f9a858 100644
> > > --- a/drivers/usb/gadget/function/f_tcm.c
> > > +++ b/drivers/usb/gadget/function/f_tcm.c
> > > @@ -955,7 +949,7 @@ static void usbg_data_write_cmpl(struct usb_ep *e=
p, struct usb_request *req)
> > >  				se_cmd->data_length);
> > >  	}
> > > =20
> > > -	complete(&cmd->write_complete);
> > > +	target_execute_cmd(se_cmd);
> >=20
> > usbg_data_write_cmpl() is invoked from interrupt service routing which
> > may run with disabled interrupts. From looking at target_execute_cmd():
>=20
> It will always be called with interrupts disabled as documented in
> usb_request API.
>=20
> > | void target_execute_cmd(struct se_cmd *cmd)
> > | {
> > =E2=80=A6
> > |         spin_lock_irq(&cmd->t_state_lock);
> > =E2=80=A6
> > |         spin_unlock_irq(&cmd->t_state_lock);
> > =E2=80=A6
> > | }
> >=20
> > which means interrupts will remain open after leaving
> > target_execute_cmd(). Now, why didn't the WARN_ONCE() in
> > __handle_irq_event_percpu() trigger? Am I missing something?
> >=20
> > >  	return;
> >=20
>=20
> Since target_execute_cmd() is called in usbg_data_write_cmpl(),
> interrupts are still disabled.

but you do realize that target_execute_cmd() will leave with enabled
interrupts and this is not desired? I _think_ this was the reason why I
ended up with the wait+complete construct instead of invoking this
function directly.
An _irqsave() in target_execute_cmd() would probably be all you need
here.

> Thanks,
> Thinh

Sebastian
