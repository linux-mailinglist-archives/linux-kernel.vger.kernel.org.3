Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16250EEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbiDZCvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiDZCvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:51:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6338B3E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:48:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p6so1661727pjm.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k6kRcGJz9dVpsAtnzdLvYmb6duk9K6l9ThccGQ9GQn4=;
        b=B6naSCDpsluc76Xy2g0jxTZ034VrK5FMtXEhko1UHokT2hVLLZCpnxR6XfFT/jmssM
         HoszvWjdBsQZJhHL4V8pMU1iLPalmP6xmbJb9mLeW+JFYWJja5OBMbpP8IamDATue/jw
         q137NY9U/VgPA7GaM1CrxKpaRBIIToNhoC9okbwImTKaYTOWmpcNCKIAqAW30QMjNGLy
         yNiHH1MdJVDnM9dOIYDGp9aMH5AvXwEhGYs4YUA7+O9ZQnMEGRz/2FMiumfnZUNMaL+i
         bk9Uh+dncqN7+4aH7BNDyC0J+79BGPqsQmZS0DfKmkS3722IrRmRSqXKvFilVwOHBn/l
         roGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k6kRcGJz9dVpsAtnzdLvYmb6duk9K6l9ThccGQ9GQn4=;
        b=jxzBxTmI2URKN+sPDiWUex4zb+ECbapVbqwrhnuMCL39aBilyrQnW6GFGSEMCstvxl
         cfU1iKsQFt7KGfxwCALTcFYycFQnfAmXRiA/zkj7fb4rAGjqYLO5ddEVT82r38UKTP4g
         Chg38urbstIdoAqbC23h/hjnGhg+xedeJRhy1g+kqxPCknaHh9XB5adWFqoWtrdU8frG
         yHNmdcidsF4/9FoQzjvYXWAi80yagt6VfmdnUccvFVZlC1Bdpoci8opmCZHFXsEHV9RM
         upzbCE7ZUpVwnbtzq189uwurEUobN31YW/M7U+/n1EN13UIF2hnOu+AchgGRK+8ZAEE3
         Y/HQ==
X-Gm-Message-State: AOAM532y4RbNuR2r4MGpff4Ue7OIudewPeURaEHwYsRqmwjFfnEtoGz5
        tbpCTfU61k5tj0/vkFkmrLE=
X-Google-Smtp-Source: ABdhPJyTxQNYKaBR17QTALDZ+wo1JPimr81AGXXZMYx5ahZPsXK9A2h6r3K5hW1ffy4GTnMV/5LUxw==
X-Received: by 2002:a17:90b:1b52:b0:1d2:8d55:ad6d with SMTP id nv18-20020a17090b1b5200b001d28d55ad6dmr24502351pjb.223.1650941304365;
        Mon, 25 Apr 2022 19:48:24 -0700 (PDT)
Received: from ArchDesktop ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id f63-20020a62db42000000b0050d35bcdbc0sm6602551pfg.181.2022.04.25.19.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 19:48:23 -0700 (PDT)
Date:   Tue, 26 Apr 2022 10:48:20 +0800
From:   Solomon Tan <wjsota@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] staging: r8188eu: KASAN: slab-out-of-bounds in
 rtw_cmd_thread
Message-ID: <YmdddDRsHM9lNX7h@ArchDesktop>
References: <67e2d10b-7f0f-9c5a-ce31-376b83ffba9e@gmail.com>
 <YmU+cqEZfrGz5XsT@ArchDesktop>
 <c2296090-2e9b-fafb-35da-e01b025b53b7@gmail.com>
 <20220425154138.GQ2462@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425154138.GQ2462@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 06:41:38PM +0300, Dan Carpenter wrote:
> On Sun, Apr 24, 2022 at 06:06:32PM +0300, Pavel Skripkin wrote:
> > Hi Solomon,
> > 
> > On 4/24/22 15:11, Solomon Tan wrote:
> > > On Sun, Apr 24, 2022 at 12:00:12PM +0200, Michael Straube wrote:
> > > > Hi,
> > > > 
> > > > It looks like
> > > > commit 0afaa121813e ("staging: r8188eu: use in-kernel ieee channel")
> > > > intoduced a. See KASAN output below.
> > > > 
> > > > That commit replaced the use of struct rtw_ieee80211_channel with struct
> > > > ieee80211_channel.
> > > > 
> > > > There are several calls to memcpy that used sizeof(struct
> > > > rtw_ieee80211_channel)
> > > > and now use sizeof(struct ieee80211_channel) but the sizes of these two
> > > > structures are not equal.
> > > > 
> > > 
> > > Oh no. When does this issue get triggered?
> > > 
> > > > regards,
> > > > Michael
> > > > 
> > > > dmesg:
> > > > 
> > > >  ==================================================================
> > > > [  422.214237] BUG: KASAN: slab-out-of-bounds in rtw_cmd_thread+0x1e8/0x430
> > > > [r8188eu]
> > > > [  422.214277] Write of size 3600 at addr ffff8881e149d200 by task
> > > > RTW_CMD_THREAD/2563
> > > > 
> > > > [  422.214289] CPU: 11 PID: 2563 Comm: RTW_CMD_THREAD Tainted: G C OE
> > > > 5.18.0-rc2-staging+ #47 94e3ca73bebf5b7fec506721475e4fff2a023bb9
> > > > [  422.214301] Hardware name: Gigabyte Technology Co., Ltd. B550M S2H/B550M
> > > > S2H, BIOS F15a 02/16/2022
> > > > [  422.214309] Call Trace:
> > > > [  422.214313]  <TASK>
> > > > [  422.214317]  dump_stack_lvl+0x45/0x5b
> > > > [  422.214327]  print_report.cold+0x5e/0x5dc
> > > > [  422.214335]  ? kasan_set_track+0x21/0x30
> > > > [  422.214342]  ? kasan_set_free_info+0x20/0x40
> > > > [  422.214349]  ? rtw_cmd_thread+0x1e8/0x430 [r8188eu
> > > > 91924fe1575bf49b9b37985ffde2c585d847446d]
> > > > [  422.214386]  kasan_report+0xab/0x120
> > > > [  422.214394]  ? rtw_cmd_thread+0x1e8/0x430 [r8188eu
> > > > 91924fe1575bf49b9b37985ffde2c585d847446d]
> > > > [  422.214430]  kasan_check_range+0xf6/0x1d0
> > > > [  422.214436]  memcpy+0x39/0x60
> > > > [  422.214442]  rtw_cmd_thread+0x1e8/0x430 [r8188eu
> > > > 91924fe1575bf49b9b37985ffde2c585d847446d]
> > > > [  422.214479]  ? rtw_setassocsta_cmdrsp_callback+0xd0/0xd0 [r8188eu
> > > > 91924fe1575bf49b9b37985ffde2c585d847446d]
> > > > [  422.214516]  kthread+0x15d/0x190
> > > > [  422.214523]  ? kthread_complete_and_exit+0x20/0x20
> > > > [  422.214531]  ret_from_fork+0x22/0x30
> > > > [  422.214540]  </TASK>
> > > 
> > > Sorry, I am not familiar with KASAN. How should I interpret this output?
> > > I see the paragraph above has references to rtw_cmd_thread. I assume
> > > that is its way of indicating that rtw_cmd_thread is the cause of the
> > > problem, but the one below refers to other functions. I'm not sure where
> > > I should start looking. I would start looking at `rtw_sitesurvey_cmd` and
> > > `rtw_scan_ch_decision`, which call the memcpy on the
> > > rtw_ieee80211_channel structure, but they are not on the call trace.
> > > 
> > 
> > drivers/staging/r8188eu/core/rtw_cmd.c:276: memcpy() call.
> > 
> 
> What git hash are you on?  Is that the line:
> 
> 	memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct ieee80211_channel));
> 
> Are you sure that's the line which crashes?  According to Smatch and my
> simple grep that's dead code because "ch" is always NULL.
>

I don't think Pavel is referring to that line as it belongs to the
`rtw_sitesurvey_cmd` function. That func didnt appear in the dmesg output.
Rather I think Pavel refers to line 267, which is
`memcpy(pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);` from function
`rtw_cmd_thread`. Changing rtw_ieee80211_channel to ieee80211_channel
must have messed up that line somewhere but I just can't figure out what
or why.
 
> > As Michael said the sizes of structures do not mach and the memcpy writes
> > below allocated buffer.
> 
> I feel a bit bad for not spotting this in review because I was looking
> for that kind of bug.  I still don't immediately spot where the bug is.

Sorry I put you in this position, Dan.

> 
> regards,
> dan carpenter
