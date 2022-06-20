Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387855139B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbiFTJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbiFTJCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A822D12AD7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KutNP87mEdmzVEh5HM6usoc+W6jsUHdBwtS1GSPQBo=;
        b=aQpKkbgPN7uB3DpApubyvo+ggvnOpt25o2q8+4L1SxP1lNrbxTkq2H3ImK9cXto8GjaYRJ
        bT0C2e/nZ1rAgfbOt+rXAvstCUEAyAPuOHRIJY+LsckVD23v68brTNJ4ZA6XjyAj8vq5qx
        R4NnEE/vYIKB8kmCULY04SvQuPqE5VU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-wM7ftj6eNcKK0JOP-BaK0Q-1; Mon, 20 Jun 2022 05:02:18 -0400
X-MC-Unique: wM7ftj6eNcKK0JOP-BaK0Q-1
Received: by mail-ed1-f71.google.com with SMTP id v7-20020a056402348700b004351fb80abaso8190978edc.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8KutNP87mEdmzVEh5HM6usoc+W6jsUHdBwtS1GSPQBo=;
        b=ZizOMN4DpMtCz+VzDSYh5N1kKXXUSDsaNo+7n8aWF68bVjVglAUVgdrxtC3LMNlX3i
         Qoj8H7L30QhfRaDIeWdXOr3TOBXowUJLfmEczYe+2hjdO/gkF00LAiVaPo3tdV9tcDRW
         jdEQBvDiNESJycHVn632qLxgAneraPRIDCUSM5Hjy3rVpUXivaQjkA6V6L7v+/pvguKb
         VdthXGvVwsNuVSLVEW/7a2d8emKgrm1YOa6vT/6DChTOQvDrRfJcK53FwZPRfBdZYv+0
         a3BFMEBJ+Lwf3kh5SG9IPWtsE0XHpe60IG8FZyCYCE8W10F41FdFdFYctuyUiETj4K8S
         /eDA==
X-Gm-Message-State: AJIora/xHfqhx1PdwoCzApFFSxX//51z9pEhsa2X1zz0GbU0Azk22E+B
        O3I+LlG1pif0+ijERTHHMGhV/iEe/U7BS6OnQ9nj+QiAULXdNGk1KPW/kMp++j6spEACxiqldEw
        nJGddL24wAK2DJ5xt0kwUdXZP
X-Received: by 2002:a17:906:649b:b0:711:fde7:be43 with SMTP id e27-20020a170906649b00b00711fde7be43mr20472757ejm.294.1655715737165;
        Mon, 20 Jun 2022 02:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tPXmAbToR3ak+wgdkzp7EGRsPgSxWRRwgKsNkupEZuHxwRpIFG37n4x3C4s+uvJ5cIxrZtDA==
X-Received: by 2002:a17:906:649b:b0:711:fde7:be43 with SMTP id e27-20020a170906649b00b00711fde7be43mr20472737ejm.294.1655715736936;
        Mon, 20 Jun 2022 02:02:16 -0700 (PDT)
Received: from [10.87.1.19] ([145.15.244.207])
        by smtp.gmail.com with ESMTPSA id q23-20020a170906b29700b00708e906faecsm5560653ejz.124.2022.06.20.02.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 02:02:16 -0700 (PDT)
Message-ID: <a1decfb3-fd32-a8d1-e627-23430099565a@redhat.com>
Date:   Mon, 20 Jun 2022 11:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] staging: r8188eu: an incorrect return value made the
 function always return fail
Content-Language: en-US
To:     Kate Hsuan <hpa@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220620085413.948265-1-hpa@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220620085413.948265-1-hpa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kate,

Good catch!

On 6/20/22 10:54, Kate Hsuan wrote:
> Since _SUCCESS (1) and _FAIL (0) are used to indicate the status of the
> functions. The previous commit 8ae7bf782eacad803f752c83a183393b0a67127b

This is the commit hash from one of the stable series backports, you
should always use the commit hash from Linus' master branch which is
f94b47c6bde6 and the format for referencing commits in a commit-message is:

commit <12 char hash> ("commit subject")

so in this case this should have been:

commit f94b47c6bde6 ("staging: r8188eu: add check for kzalloc")

Note that checkpatch.pl would have complained about the wrong format
(but not the wrong hash)

> fixed and prevented dereferencing a NULL pointer through checking the
> return pointer. The NULL pointer check work properly but the return
> values (-ENOMEM on fail and 0 on success). This work fixed the return
> values to make sure the caller function will return the correct status.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2097526
> Signed-off-by: Kate Hsuan <hpa@redhat.com>

This should have a fixes tag:

Fixes: f94b47c6bde6 ("staging: r8188eu: add check for kzalloc")

But while looking up the torvalds/master branch hash I noticed
someone alreayd beat you to it. Linus' master already has
a fix for this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/r8188eu?id=5b7419ae1d208cab1e2826d473d8dab045aa75c7

So this patch can be dropped since it is a duplicate.

Regards,

hans



> ---
>  drivers/staging/r8188eu/core/rtw_xmit.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index f4e9f6102539..2f8720db21d9 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -180,10 +180,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>  
>  	res = rtw_alloc_hwxmits(padapter);
> -	if (res) {
> -		res = _FAIL;
> +	if (res == _FAIL)
>  		goto exit;
> -	}
>  
>  	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>  
> @@ -1510,7 +1508,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
>  
>  	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
>  	if (!pxmitpriv->hwxmits)
> -		return -ENOMEM;
> +		return _FAIL;
>  
>  	hwxmits = pxmitpriv->hwxmits;
>  
> @@ -1528,7 +1526,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
>  	} else {
>  	}
>  
> -	return 0;
> +	return _SUCCESS;
>  }
>  
>  void rtw_free_hwxmits(struct adapter *padapter)

