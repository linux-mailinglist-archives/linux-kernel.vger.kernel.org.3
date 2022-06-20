Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB312551F50
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiFTOpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241643AbiFTOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:45:28 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C2536311
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:05:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s16so3785262oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vXVWDTnjO5iC5dEoRI4X2EQajSgnoxnE0S9FMk/nHYU=;
        b=NbkOEcR0dzXkLTMiHTHvNRRd4rEdnU+Lu1co9BuL9idLgD9YJn57kxjahkLCi9nA4g
         ePESFqVcfoiS0stnNjRdsQYtu4OG2a9egIevdIN3qIiqIWPzPYKMCxg2jrEcoC2s+Be0
         sbFTl2vTUH30+60YCoRRzEe6PvmKKWbGTBedUaELE86637ZFnGqQ96nUExzsGH1P7crr
         a7QViE8xQXkevkISzpgAM7Zr5Eo1GEiUPNbJ8fBMhnRCc7wjsvlOv3ag7cuO7unPOc9K
         pN6ELKTqquaA5tSGDWBW3v4jSCjQe46zyg+4RL+is6/yhPWw/dZqrx9wn9MpX+nZNSXd
         T6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vXVWDTnjO5iC5dEoRI4X2EQajSgnoxnE0S9FMk/nHYU=;
        b=HIYiiAM0uyoie7yR/SQ5gknTh/s9zL1MqnZ2ZxEypLYNNAjiLfpHrzTR955kLb9ib9
         PLGbiIqerOzeJFLXSy4ua30Ghnl9urmbnA5dscfaSPzJn5+TTL41f8P0k68WG5ZoKlZU
         j708yJDHQcr+4nRnHQZSl6zD293z4zUo31NpCpkW0rT8Ph+pDFV9xMUFMD9uYCn7k542
         JD0QQBnPszQI8eEtS9w3eITy3SL7QSBjdcq12oAjLDeazKek87l4hjx/pBDsOrPD3KSU
         W+x/YIXomvzJDjlHXGkLtxVKXVTecCOY9XuK1Gz8Gznlc9U9W9FZMJcbdNmXlplC2QMP
         xD0g==
X-Gm-Message-State: AOAM530O7GfRSk8hGzuaEa0U652wv5ZC+KKfwelhNpfTC3LaIHnLevBi
        y53l2IIs7TIStCHoUtBX0Sc=
X-Google-Smtp-Source: ABdhPJyofx0pIxDjkceVGFBbyDpm8AtEBzdR6BLYffZCMarobpN+BC08EpFVKQirxsz+dDA0pi28JQ==
X-Received: by 2002:a05:6808:1989:b0:32e:9e58:7733 with SMTP id bj9-20020a056808198900b0032e9e587733mr15579850oib.270.1655733918795;
        Mon, 20 Jun 2022 07:05:18 -0700 (PDT)
Received: from [192.168.1.108] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r23-20020a056830419700b0060c03836d04sm7651254otu.77.2022.06.20.07.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 07:05:18 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <5396e576-0fbe-430c-d983-a2f4b1569f09@lwfinger.net>
Date:   Mon, 20 Jun 2022 09:05:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] staging: r8188eu: an incorrect return value made the
 function always return fail
Content-Language: en-US
To:     Kate Hsuan <hpa@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220620085413.948265-1-hpa@redhat.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220620085413.948265-1-hpa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 03:54, Kate Hsuan wrote:
> Since _SUCCESS (1) and _FAIL (0) are used to indicate the status of the
> functions. The previous commit 8ae7bf782eacad803f752c83a183393b0a67127b
> fixed and prevented dereferencing a NULL pointer through checking the
> return pointer. The NULL pointer check work properly but the return
> values (-ENOMEM on fail and 0 on success). This work fixed the return
> values to make sure the caller function will return the correct status.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2097526
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>   drivers/staging/r8188eu/core/rtw_xmit.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index f4e9f6102539..2f8720db21d9 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -180,10 +180,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>   	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>   
>   	res = rtw_alloc_hwxmits(padapter);
> -	if (res) {
> -		res = _FAIL;
> +	if (res == _FAIL)
>   		goto exit;
> -	}
>   
>   	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>   

This problem was fixed in mid May with commit 5b7419ae1d20 ("staging: r8188eu: 
fix rtw_alloc_hwxmits error detection for now"). The fix was

@@ -178,8 +178,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct 
adapter *padapter)

         pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;

-       res = rtw_alloc_hwxmits(padapter);
-       if (res) {
+       if (rtw_alloc_hwxmits(padapter)) {
                 res = _FAIL;
                 goto exit;
         }

The "for now" part is that Phillip plans to get rid of _FAIL and _SUCCESS, and 
replace the logic with a normal 1 for fail, etc.; however, this will be a major 
change that must be done carefully.

In any case NACK for this patch.

Larry



