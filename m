Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CCC582631
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiG0MOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiG0MON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6C4B0CF;
        Wed, 27 Jul 2022 05:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6857D60B8F;
        Wed, 27 Jul 2022 12:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445A1C433C1;
        Wed, 27 Jul 2022 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658924050;
        bh=kq4PGN6FO5ju1m+LZGy88ckRUdYAbjus9z6ZNANXHmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2nhAuYSjGRfv4l+97f+9WKvkkRc3KGeRCVAuP/wn9/7FD0gaacks5VirYOTcwZb5
         XPxfML2vTfZ6R+jFZFN+7z8v6gHoNGKKuFTtv4Yj5hDv3xouSLpRT5Y5KD8Ez4rILo
         0izjvZIJjoJkhYElmiNzgnMrRYbML9yELrljegrc=
Date:   Wed, 27 Jul 2022 14:14:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jack Pham <quic_jackp@quicinc.com>
Cc:     3090101217@zju.edu.cn, balbi@kernel.org, colin.king@intel.com,
        jbrunet@baylibre.com, jleng@ambarella.com,
        pavel.hofman@ivitera.com, pawell@cadence.com,
        ruslan.bilovol@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4] usb: gadget: f_uac2: fix superspeed transfer
Message-ID: <YuEsEKA3+4rmbYB+@kroah.com>
References: <Yg5onoldRY3ygW7v@kroah.com>
 <20220218095948.4077-1-3090101217@zju.edu.cn>
 <20220720230425.GA8843@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720230425.GA8843@jackp-linux.qualcomm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:26:59PM -0700, Jack Pham wrote:
> Hi Greg,
> 
> On Fri, Feb 18, 2022 at 05:59:48PM +0800, 3090101217@zju.edu.cn wrote:
> > From: Jing Leng <jleng@ambarella.com>
> > 
> > On page 362 of the USB3.2 specification (
> > https://usb.org/sites/default/files/usb_32_20210125.zip),
> > The 'SuperSpeed Endpoint Companion Descriptor' shall only be returned
> > by Enhanced SuperSpeed devices that are operating at Gen X speed.
> > Each endpoint described in an interface is followed by a 'SuperSpeed
> > Endpoint Companion Descriptor'.
> > 
> > If users use SuperSpeed UDC, host can't recognize the device if endpoint
> > doesn't have 'SuperSpeed Endpoint Companion Descriptor' followed.
> > 
> > Currently in the uac2 driver code:
> > 1. ss_epout_desc_comp follows ss_epout_desc;
> > 2. ss_epin_fback_desc_comp follows ss_epin_fback_desc;
> > 3. ss_epin_desc_comp follows ss_epin_desc;
> > 4. Only ss_ep_int_desc endpoint doesn't have 'SuperSpeed Endpoint
> > Companion Descriptor' followed, so we should add it.
> > 
> > Fixes: eaf6cbe09920 ("usb: gadget: f_uac2: add volume and mute support")
> > Signed-off-by: Jing Leng <jleng@ambarella.com>
> > ---
> > ChangeLog v3->v4:
> > - Add "Fixes:" tag in the changelog area
> > ChangeLog v2->v3:
> > - Remove static variables which are explicitly initialized to 0
> > - Remove redundant modification "case USB_SPEED_SUPER_PLUS:"
> > ChangeLog v1->v2:
> > - Update more detailed description of the PATCH
> 
> I don't see this patch in any of your trees, so I'm assuming it must not
> have made it into your inbox.  If that's the case I would like to
> resubmit on Jing's behalf as it does fix a legitimate issue with
> enabling the UAC2 gadget in SuperSpeed.

Thank you.  Reviewing the other patches sent by this author would also
be greatly appreciated as I have not accepted them due to them no one
else speaking up.

thanks,

greg k-h
