Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD6529873
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiEQD5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiEQD5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:57:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0134665
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:57:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k16so9039255pff.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RA/GUWzgAi0lwcfXCy8dlx+jGczfHJXUzSsauTL7va8=;
        b=BeY8zMiMW/X7WmzuCHmm965ikZQBIMdHFO0I2g7IFpQ/ePUkEQrrbK1b7NOv03NgJy
         jUgWTBWWp3kBDafKOX1jHwQM0owBrZLkeuGN2XSMwL80ZByHsYivfiFBkgJwqxmQtTEB
         32JfrkJUSOkiHW4FZ+uaFMe3qwYV1PWn0AOBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RA/GUWzgAi0lwcfXCy8dlx+jGczfHJXUzSsauTL7va8=;
        b=beHwn3lOUEGLTILx/jIrzaRIVV9sJYTe/FN0Z16XqRi1OWI9WTZo8lHS33DD9fz5ML
         HQ8TDfRkJJ+4eVbLU8g8lYDGGA9DKHcP7lO4burtAAiAyGhP2vUHsviQkncTSx4R8Hu9
         ULDyIVQ+9rDj9KeJoUPV+Wr0El+LkMGE04HilT8mDnBP9rDpXDrKqoFYC1ntLVHNb0pB
         Tc0hoOup31//692NTfu82/iykRjpdNCWLXhPsAxjn+dY4BQC8ISLL7Rh9HL/P1cA1dA8
         T5w/au8B2L+o2bY3iYmqSJ1lRQYWG2Fyz8hxSIhfeB2Rdo96lUHNJal6/3w0GsUXxOgb
         F4LQ==
X-Gm-Message-State: AOAM530GtoKRxEdif/zingi3ibuX/CKcqDWegwEJXegTZDRCWbnJoaFs
        dwr4PXRWA8Z++5fyJozm+og5fjGtGfiv5Q==
X-Google-Smtp-Source: ABdhPJx7EyLV14gnE/eybLsCaXASC+lPagUlZeJRA4bfE1u5jFeEF85vrcWSpco4cEgBtHask9Z3Bw==
X-Received: by 2002:a63:1904:0:b0:3c6:3fd3:4c28 with SMTP id z4-20020a631904000000b003c63fd34c28mr17768518pgl.308.1652759863198;
        Mon, 16 May 2022 20:57:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902900100b0015e8d4eb2dfsm7711105plp.297.2022.05.16.20.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:57:42 -0700 (PDT)
Date:   Mon, 16 May 2022 20:57:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/32] brcmfmac: Use mem_to_flex_dup() with struct
 brcmf_fweh_queue_item
Message-ID: <202205162056.F8D1BF3E@keescook>
References: <20220504014440.3697851-1-keescook@chromium.org>
 <20220504014440.3697851-6-keescook@chromium.org>
 <b197ca6d-4285-5310-7e98-918c885a2e38@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b197ca6d-4285-5310-7e98-918c885a2e38@broadcom.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:49:21PM +0200, Arend van Spriel wrote:
> On 5/4/2022 3:44 AM, Kees Cook wrote:
> > As part of the work to perform bounds checking on all memcpy() uses,
> > replace the open-coded a deserialization of bytes out of memory into a
> > trailing flexible array by using a flex_array.h helper to perform the
> > allocation, bounds checking, and copying.
> > 
> Reviewed-by: Arend van Spriel <aspriel@gmail.com>

Thanks!

> > [...]
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> > index bc3f4e4edcdf..bea798ca6466 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> > @@ -32,8 +32,8 @@ struct brcmf_fweh_queue_item {
> >   	u8 ifidx;
> >   	u8 ifaddr[ETH_ALEN];
> >   	struct brcmf_event_msg_be emsg;
> > -	u32 datalen;
> > -	u8 data[];
> > +	DECLARE_FLEX_ARRAY_ELEMENTS_COUNT(u32, datalen);
> > +	DECLARE_FLEX_ARRAY_ELEMENTS(u8, data);
> >   };
> > [...]
> > @@ -414,8 +414,7 @@ void brcmf_fweh_process_event(struct brcmf_pub *drvr,
> >   	    datalen + sizeof(*event_packet) > packet_len)
> >   		return;
> > -	event = kzalloc(sizeof(*event) + datalen, gfp);
> > -	if (!event)
> > +	if (mem_to_flex_dup(&event, data, datalen, gfp))
> >   		return;
> >   	event->code = code;
> > @@ -423,8 +422,6 @@ void brcmf_fweh_process_event(struct brcmf_pub *drvr,
> >   	/* use memcpy to get aligned event message */
> >   	memcpy(&event->emsg, &event_packet->msg, sizeof(event->emsg));
> > -	memcpy(event->data, data, datalen);
> > -	event->datalen = datalen;
> 
> So does mem_to_flex_dup() store event->datalen?
> 
> Don't have the entire thread so missing bits and pieces, but at least this
> raises questions for me.

Yes, that's part of the internal workings here -- the flex array counter
is declared and will be set as part of the copy.

-- 
Kees Cook
