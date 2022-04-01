Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9A4EED6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345969AbiDAMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbiDAMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:50:03 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC5D279725
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:48:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ke15so1886574qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=xe47BId8FG+UXcgp+7n4Gi6HT1T1Ri6vaJkb35OI79E=;
        b=FBydJEEFg2JnreasDcvN+X3Fq2AX2Cs4fSs/4d70XuBUcAihS42Jlr1aVS8XHW7YOr
         yqONMeg57T9UGPkKnjAqZicVRiwKDRz+iqJj44F3jnslTpCPtd6aklA56Q8LSZ1sSdiu
         hZ7dWImKzxdcQ9Y95O55H9qi8sEtoOL7De/v8pwrpZlWNqQmuefmdiVqA2L4OIgTfFUd
         gmMT7p6izyDL3RZMSOPH1sBJp1UTxTw6PaIKuiRs6+GNDndlJG9nq6hJc4SkFxbk+SLi
         ByG5DD+UgNMKrieXWTWNAICDaXx219aIGoEEPFlRNznLCQvmruBbWclbp4KiyOcjGygJ
         6rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=xe47BId8FG+UXcgp+7n4Gi6HT1T1Ri6vaJkb35OI79E=;
        b=XfWhxg5mJov3ZU+vBgqGvAzqJO8GoPm2vTGAB9sMUU/ys07Ny+kwwfOuWS9MbjvGLW
         DagJatk9tjIicUPIJr4FA9R4t3CfP+BSnphv2IS8ks6XctxKPRltftEyWIjnnQp1KEAp
         rG0xqSUfWTdPW16bmchuqpRFiXejFihcJalSeRpzcMNfqcXIxPlCzLxmpmr8/SAjSXPa
         dRv5EOeM3bYNd2Xv7pD+U1s74o8lvgPxbcFeiBRaUoazA1MhPa+HVONae15UcHd9IAYE
         elk2GW0lzxKyzo0EgAyGvOVLnXP0pxi1aW4GlJL/r4E5laGKqUQJzPfUrRuc2bDmN4jz
         ibzg==
X-Gm-Message-State: AOAM533g9+J77WS8m4rKbGBTtQFTsYXyuptcaBhjWm/PLtepQhXCTk0N
        I8MoJeWvqI3UTsFdoCEtLA==
X-Google-Smtp-Source: ABdhPJx8tlteUME04IRt0HIMAZ9xccnNs1UTSFwNMRwSF4eO8B8on1fFqquHG3wS3X6XiJ8VpL1CdA==
X-Received: by 2002:a05:6214:e45:b0:441:718f:e14e with SMTP id o5-20020a0562140e4500b00441718fe14emr7602001qvc.105.1648817292858;
        Fri, 01 Apr 2022 05:48:12 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm1694591qtx.89.2022.04.01.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 05:48:11 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:18b8:c103:5b12:b0c4])
        by serve.minyard.net (Postfix) with ESMTPSA id C8E621800BB;
        Fri,  1 Apr 2022 12:48:10 +0000 (UTC)
Date:   Fri, 1 Apr 2022 07:48:09 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: ssif: potential NULL dereference in
 msg_done_handler()
Message-ID: <20220401124809.GF29333@minyard.net>
Reply-To: minyard@acm.org
References: <1648783665-19237-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648783665-19237-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:27:45AM +0800, Haowen Bai wrote:
> msg could be null without checking null and return, but still dereference
> msg->rsp[2] and will lead to a null pointer trigger.

Actually:

  If you look at the big picture (how the rest of the code works), it's
  not possible for msg to be NULL in these cases.  However, being
  defensive here is probably a good idea.

  There are two of these cases, why didn't you fix both of them?

  This still doesn't fix the problem.  There is an "else if" in both
  cases that also uses msg.

You can't just look at the output of some code analysis tool and make a
blind decision like this.  You have to look at the big picture.  And you
have to analyze the code carefully.

The right way to be defensive here is to add:
	if (!msg) {
		ipmi_ssif_unlock_cond(ssif_info, flags);
		break;
	}
in both cases.  And probably add a log, since this means something else
went wrong.

Anyway, I'll add a patch for defensive measure and give you credit for
pointing it out.

-corey

> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index f199cc1..9383de3 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -814,7 +814,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  		break;
>  
>  	case SSIF_GETTING_EVENTS:
> -		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
> +		if ((result < 0) || (len < 3) || (msg && (msg->rsp[2] != 0))) {
>  			/* Error getting event, probably done. */
>  			msg->done(msg);
>  
> -- 
> 2.7.4
> 
