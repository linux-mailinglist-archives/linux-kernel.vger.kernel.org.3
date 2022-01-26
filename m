Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813A049C069
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiAZBCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiAZBCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:02:20 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED139C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:02:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1304273wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6sjSjP62PezolO+qqL2E3W+n3YY4S6gi9mjjXoie9YY=;
        b=Pgjnuw6JxN+1gZJMQOsU2qB606MO9ag2kv/NL2ZJMBeQCqtqb/FS3rjMZpQe2bju4/
         edXI6CXigLPOQakp6iuH/SY8+KT+5H3tSskRH0dQ0pfSzkaCcLxgNWgyU3uxJYvwhAJd
         dVVaIs3CT79fB4GtXw5nTQxrEJnA6MOcYdOyfY6jt67PgqXcJrsRSJk2eTQ4Zhwr+lGP
         gn2oaYolcqJytqNCC4DpzxDF80V2NLgiWtYjo/EdiDX6bF1+qu1P7T5omaIdTTaqox4j
         9uobosXitYOEN/uSdcqrBEJzwMYbZM4+4DZg18SLMP/qsTVPvjnFoS2vIEP7naWjRJcN
         4vRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6sjSjP62PezolO+qqL2E3W+n3YY4S6gi9mjjXoie9YY=;
        b=kWQkWnRRb7WNmjvlCzE4zofAf5EC56kweBQekJA2w7VnbMwhIpdZVyaAtrAYliXXuB
         mkhyMcLnsUqmLhxBMq4TvBiKEC5P8E5oOZcRtu3jOMEOV0xyjSMpd5dHdLZiiwWpu6v0
         FKXtysR3uRj5xmyeiDzXaIZFKV6zLJ09zaILOA5lnR5w0Pttdg0wRD+QbAV4qeW3N0ze
         /RSJ+jtKWsoWYHdjHBFdRtK00WA9SPvL5TDZi88BVW5umbkIdAtBDjy6G3l8uAnzK9Aj
         AZCxH78JUIVZxzwO/dgcNQtHllt9Vdqt+1El8hrHw5BryHOq0Kvrxitgfkc+uxqpfSUz
         Ul1w==
X-Gm-Message-State: AOAM5326ht/iIXYp6BEP7r44CN5hled83Jow+hbzNL2Tzs0gPcjZZUkK
        dSiHCEQPmvEpN4QfMFQrKKniPg==
X-Google-Smtp-Source: ABdhPJwlKGZfLRcxsgE1HKDm4LMB3q6VY8slT9c4jl/aaG+PqLLeyuCVFmg8ksVxHyw4MbpjtJOmFg==
X-Received: by 2002:a7b:ca55:: with SMTP id m21mr5278623wml.114.1643158938566;
        Tue, 25 Jan 2022 17:02:18 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id p2sm1723803wmc.33.2022.01.25.17.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 17:02:17 -0800 (PST)
Date:   Wed, 26 Jan 2022 01:02:16 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] staging: r8188eu: remove DBG_88E calls from
 core/rtw_mlme_ext.c
Message-ID: <YfCdmPervlyjf0aU@equinox>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-4-phil@philpotter.co.uk>
 <f766f910-4f7c-d3b5-d7a8-4d0d9de33a66@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f766f910-4f7c-d3b5-d7a8-4d0d9de33a66@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 09:31:27PM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> On 1/25/22 01:44, Phillip Potter wrote:
> > Remove all DBG_88E calls from core/rtw_mlme_ext.c, including the commented
> > one, as they do not conform to kernel coding standards and are
> > superfluous. Also restructure where appropriate to remove no longer needed
> > code left behind by removal of these calls. This will allow the eventual
> > removal of the DBG_88E macro itself.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> 
> [code snip]
> 
> >   static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
> > @@ -7141,18 +6905,11 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
> >   static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
> >   {
> >   	u32 rx_dma_status =  rtw_read32(padapter, REG_RXDMA_STATUS);
> > -	u8 fw_status;
> > -	if (rx_dma_status != 0x00) {
> > -		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
> > +	if (rx_dma_status != 0x00)
> >   		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
> > -	}
> > -	fw_status = rtw_read8(padapter, REG_FMETHR);
> > -	if (fw_status == 1)
> > -		DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
> > -	else if (fw_status == 2)
> > -		DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
> > +	rtw_read8(padapter, REG_FMETHR);
> >   }
> 
> Unused read. Can be dropped
> 
> 
> 
> With regards,
> Pavel Skripkin

Thanks - good point, will remove in v2.

Regards,
Phil
