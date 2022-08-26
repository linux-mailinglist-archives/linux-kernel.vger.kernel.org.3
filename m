Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD305A2612
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbiHZKrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244472AbiHZKq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:46:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA17A763;
        Fri, 26 Aug 2022 03:46:56 -0700 (PDT)
Date:   Fri, 26 Aug 2022 12:46:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661510814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLKW8+/j05XzobomCTWDjC7GAsM4Tiaeh1yzbn0SKPY=;
        b=gzamVHIfjCARprpeBnwWFwV8NV7x+ZWKLyNsaIEzWeJwBBPDQ8XnPvE7erQIRyFWMkphZu
        FBnwv9hzRF/qcSs4HeG43p8xvXWoaA0ZgrcQhw54fD5yBa7hTbjw74/Swqq+b/MqJhD3eG
        AZWYov5/UJBA9iwshksEWqf+IHkrOYn+Pr5dRo97a0GFd9nkJnu0q6ejlY9/T01u/jyPXw
        T5rlgvsHF+x98SoiE84wE8CA8dTmjnpwDHjxkrA6FfWXA0pEwfU1uoW/ay4BIalSPcXrGm
        VkuKKhHAnRaJuiQv1uw+tcuf1H3p4kPo3wNWt+ra82+6rxypPcXVSyIf+oUyVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661510814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLKW8+/j05XzobomCTWDjC7GAsM4Tiaeh1yzbn0SKPY=;
        b=SECI0838/ZKT7qQsWIPRnpqe8wMBBUBmLIQU13YyL3w29zETQp/fIG9RpmlF2Ff6j3KVeW
        ThwgW/tQXcSeLyDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v2 24/25] usb: gadget: f_tcm: Check overlapped command
Message-ID: <YwikndRzQM+ToQV5@linutronix.de>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <0150d7b669ad80e94596b371cbce0460a327ce7c.1658192351.git.Thinh.Nguyen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0150d7b669ad80e94596b371cbce0460a327ce7c.1658192351.git.Thinh.Nguyen@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 18:28:34 [-0700], Thinh Nguyen wrote:
> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
> index 8b99ee07df87..dfa3e7c043a3 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -1214,6 +1233,51 @@ static void usbg_cmd_work(struct work_struct *work)
>  	return;
>  
>  skip:
> +	if (cmd->tmr_rsp == RC_OVERLAPPED_TAG) {
> +		struct se_session *se_sess;
> +		struct uas_stream *stream;
> +
> +		se_sess = cmd->fu->tpg->tpg_nexus->tvn_se_sess;
> +		stream = uasp_get_stream_by_tag(cmd->fu, cmd->tag);
> +
> +		/*
> +		 * There's no guarantee of a matching completion order between
> +		 * different endpoints. i.e. The device may receive a new (CDB)
> +		 * command request completion of the command endpoint before it
> +		 * gets notified of the previous command status completion from
> +		 * a status endpoint. The driver still needs to detect
> +		 * misbehaving host and respond with an overlap command tag. To
> +		 * prevent false overlapped tag failure, give the active and
> +		 * matching stream id a short time (1ms) to complete before
> +		 * respond with overlapped command failure.
> +		 */
> +		msleep(1);

How likely is it for this to happen? Is there maybe some synchronisation
missing? If I see this right, in order to get here, you will already
spill the message "Command tag %d overlapped" which does not look good.
Why should the host re-use a tag which did not yet complete?

Sebastian
