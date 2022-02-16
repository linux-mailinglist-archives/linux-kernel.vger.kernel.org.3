Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC734B85FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiBPKiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:38:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiBPKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:38:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E45165C32;
        Wed, 16 Feb 2022 02:38:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68D74B81E05;
        Wed, 16 Feb 2022 10:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41587C004E1;
        Wed, 16 Feb 2022 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645007919;
        bh=bp9QdxnyVSDvnrj9bh26eluzSkuTukSpZIkl7/v+4SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsF5NjXTv56NKxnfNV6BmCMZ5a+lvby82I07I3NkrEmyp+2/c2dMbspz/5f6JUYpD
         E7daS2s9kmN7rmCHniIX03B/CFt6X+eHXTkHKcYWcnQeUta7gxjKYaRfy/f0GFqEQt
         EHtGNsb5g/6BQbxYtQOZoLGKOOe1bJ9NyglDWq3E=
Date:   Wed, 16 Feb 2022 11:38:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5Ya36Z2Z?= <3090101217@zju.edu.cn>
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        ruslan.bilovol@gmail.com, Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH v3] usb: gadget: f_uac1: add different speed transfers
 support
Message-ID: <YgzUJhcFk1FAKfJV@kroah.com>
References: <YgprpGbtBpojsCmQ@kroah.com>
 <20220215030848.5709-1-3090101217@zju.edu.cn>
 <Yguz4hOBYTXRL35t@kroah.com>
 <13396706.ae161.17f005864cf.Coremail.3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13396706.ae161.17f005864cf.Coremail.3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:24:27AM +0800, 冷静 wrote:
> Hi Greg KH,
> 
> Sorry for the trouble, as a new contributor to kernel.
> Although I have readed the document that how to submit patches,
> I'm still missing some details.
> 
> > Where is the patch version information?
> The new patch adds more detailed patch description and adds
> 'static' before 'struct usb_ss_ep_comp_descriptor ac_int_ep_desc_comp'.

As the documentation states, that goes below the --- line.

Please look at the hundreds of examples of other patch series being sent
with new versions.  And again, the documentation should show you how to
do this.

> > Why are you setting values to 0 when you do not have to as that is the
> > default value?
> This modification is similar to uac2.
> On page 362 of the USB3.2 specification.
> bMaxBurst is 0 means that no burst transfer.
> bmAttributes is 0 means that no mult.

That is not what I was referring to.  If you do not set a field in a
static structure, it is by default set to 0.  You do not have to define
it again.

thanks,

greg k-h
