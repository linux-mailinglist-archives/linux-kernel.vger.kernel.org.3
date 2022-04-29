Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDC51535C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379913AbiD2SKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379890AbiD2SKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:10:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E031539
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:07:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p12so15420342lfs.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2Bod++nC0Kk+aQssi3umh6aHjPXr2Qr5aaJpsWFhO1I=;
        b=GXQX2nKZwVNheR4CvTVkfcyO6lHX51/Xa8Z3jo9Rs+MwSdf6Ja6EizxFGdQ5akg63G
         1XXwO5x34IveFMiIjnaMD9MRrfMwMALEKJamNTYMJYNnLayjMcmUot1IzOcySEwN7Ays
         C4M3QABL5Xvd6h7CRVxGzkaSRLjWgFFt9Psnr0AuqA/A83Lav0T4GrxnLdbC+u9lsDWf
         Xp5kQVhSXloD4OG5usw9qu8JQrJvOJn0wsCPgSxJsQkmWqFRUSx261TtS3OZflHr2vQW
         sFTlklvrhzlBkP5YqeKFFF0NSwZWRxDz9/gH4Qr7iGKE5haIG2FgokKaQVVNw2OlHMJX
         tqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2Bod++nC0Kk+aQssi3umh6aHjPXr2Qr5aaJpsWFhO1I=;
        b=k+tr8zaIDIvvTVa4qIK9BBRGP6aMXbA7sH+MM1mac/DCcHgM9GeTYufnVw/sqLWdFt
         oSPPUwvc2eDQlm1YFpOQOJLoxCDlMOuQEUp/0o+M/jRWaFkYMd136+mH1jnztW2bK6Bo
         L8B1ECclukS8huKLnPnuhQp+8Ep4k0fUyNxoBHqMDSiMvtfiLP+Cb4QMBek5IflkhaWs
         90+zOjRQjOcTL3ERSmzhWFN8H1eJkY94QqW3XjHx0FpDnxjvRzTT3guFc7k2nxHgyMlq
         bF21iKz0xX4yhOGRqU2PzrvaxjJNSHS3A8u5Jr6ISnl12H9ebPhlmJ79jKVI3m7Bd/tQ
         L+Iw==
X-Gm-Message-State: AOAM531C0Tn5JrjxQ6wIc/0A/wiXqp8kydRWACD44M6fpyDthuxj0mpa
        BwaaCI/3NUFvYDdRGpokiys=
X-Google-Smtp-Source: ABdhPJwxdZIYiQZIv5z+o6u5Pjt2obFs9wpBIYt6fLDmJl64mXj5FdMnWGjm935gx8cthCrX5x5YQg==
X-Received: by 2002:a19:ca06:0:b0:472:3b31:1ade with SMTP id a6-20020a19ca06000000b004723b311ademr314003lfg.162.1651255629583;
        Fri, 29 Apr 2022 11:07:09 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id r16-20020a2eb890000000b0024f3d1daf00sm332318ljp.136.2022.04.29.11.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 11:07:09 -0700 (PDT)
Subject: Re: [PATCH v2 18/19] xen/sndfront: use xenbus_setup_ring() and
 xenbus_teardown_ring()
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-19-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <91b8b63c-46f0-326e-4092-5bb6c8f681db@gmail.com>
Date:   Fri, 29 Apr 2022 21:07:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220428082743.16593-19-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.04.22 11:27, Juergen Gross wrote:

Hello Juergen, all

> Simplify sndfront's ring creation and removal via xenbus_setup_ring()
> and xenbus_teardown_ring().
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

I am not familiar with SOUND bits of this driver, but a little bit
familiar with Xen bits this patch only touches and I have environment to
test.

Xen specific changes looks good to me. Also I didn't see any issues when 
testing virtulized sound driver with current series except one I have 
already pointed out in PATCH v2 08/19.


root@salvator-x-h3-4x2g-xt-domu:~# dmesg | grep vsnd
[    0.432181] Initialising Xen vsnd frontend driver


root@salvator-x-h3-4x2g-xt-domu:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: vsnd [], device 0: dev1 [Virtual card PCM]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

root@generic-armv8-xt-dom0:~# xenstore-ls -f | grep vsnd
/local/domain/1/backend/vsnd = ""
/local/domain/1/backend/vsnd/6 = ""
/local/domain/1/backend/vsnd/6/0 = ""
/local/domain/1/backend/vsnd/6/0/frontend = "/local/domain/6/device/vsnd/0"
/local/domain/1/backend/vsnd/6/0/frontend-id = "6"
/local/domain/1/backend/vsnd/6/0/online = "1"
/local/domain/1/backend/vsnd/6/0/state = "4"
/local/domain/6/device/vsnd = ""
/local/domain/6/device/vsnd/0 = ""
/local/domain/6/device/vsnd/0/backend = "/local/domain/1/backend/vsnd/6/0"
/local/domain/6/device/vsnd/0/backend-id = "1"
/local/domain/6/device/vsnd/0/state = "4"
/local/domain/6/device/vsnd/0/long-name = "Virtual sound card"
/local/domain/6/device/vsnd/0/short-name = "VCard"
/local/domain/6/device/vsnd/0/sample-rates = 
"8000,11025,16000,22050,32000,44100,48000"
/local/domain/6/device/vsnd/0/sample-formats = "s16_le"
/local/domain/6/device/vsnd/0/buffer-size = "65536"
/local/domain/6/device/vsnd/0/0 = ""
/local/domain/6/device/vsnd/0/0/name = "dev1"
/local/domain/6/device/vsnd/0/0/0 = ""
/local/domain/6/device/vsnd/0/0/0/unique-id = "pulse"
/local/domain/6/device/vsnd/0/0/0/type = "p"
/local/domain/6/device/vsnd/0/0/0/ring-ref = "2070"
/local/domain/6/device/vsnd/0/0/0/event-channel = "18"
/local/domain/6/device/vsnd/0/0/0/evt-ring-ref = "2071"
/local/domain/6/device/vsnd/0/0/0/evt-event-channel = "19"
/libxl/6/device/vsnd = ""
/libxl/6/device/vsnd/0 = ""
/libxl/6/device/vsnd/0/frontend = "/local/domain/6/device/vsnd/0"
/libxl/6/device/vsnd/0/backend = "/local/domain/1/backend/vsnd/6/0"
/libxl/6/device/vsnd/0/frontend-id = "6"
/libxl/6/device/vsnd/0/online = "1"
/libxl/6/device/vsnd/0/state = "1"


> ---
>   sound/xen/xen_snd_front_evtchnl.c | 44 +++++++------------------------
>   1 file changed, 10 insertions(+), 34 deletions(-)
>
> diff --git a/sound/xen/xen_snd_front_evtchnl.c b/sound/xen/xen_snd_front_evtchnl.c
> index 3e21369c8216..26d1b3987887 100644
> --- a/sound/xen/xen_snd_front_evtchnl.c
> +++ b/sound/xen/xen_snd_front_evtchnl.c
> @@ -143,12 +143,12 @@ void xen_snd_front_evtchnl_flush(struct xen_snd_front_evtchnl *channel)
>   static void evtchnl_free(struct xen_snd_front_info *front_info,
>   			 struct xen_snd_front_evtchnl *channel)
>   {
> -	unsigned long page = 0;
> +	void *page = NULL;
>   
>   	if (channel->type == EVTCHNL_TYPE_REQ)
> -		page = (unsigned long)channel->u.req.ring.sring;
> +		page = channel->u.req.ring.sring;
>   	else if (channel->type == EVTCHNL_TYPE_EVT)
> -		page = (unsigned long)channel->u.evt.page;
> +		page = channel->u.evt.page;
>   
>   	if (!page)
>   		return;
> @@ -167,10 +167,7 @@ static void evtchnl_free(struct xen_snd_front_info *front_info,
>   		xenbus_free_evtchn(front_info->xb_dev, channel->port);
>   
>   	/* End access and free the page. */
> -	if (channel->gref != INVALID_GRANT_REF)
> -		gnttab_end_foreign_access(channel->gref, page);
> -	else
> -		free_page(page);
> +	xenbus_teardown_ring(&page, 1, &channel->gref);
>   
>   	memset(channel, 0, sizeof(*channel));
>   }
> @@ -196,8 +193,7 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
>   			 enum xen_snd_front_evtchnl_type type)
>   {
>   	struct xenbus_device *xb_dev = front_info->xb_dev;
> -	unsigned long page;
> -	grant_ref_t gref;
> +	void *page;
>   	irq_handler_t handler;
>   	char *handler_name = NULL;
>   	int ret;
> @@ -207,12 +203,9 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
>   	channel->index = index;
>   	channel->front_info = front_info;
>   	channel->state = EVTCHNL_STATE_DISCONNECTED;
> -	channel->gref = INVALID_GRANT_REF;
> -	page = get_zeroed_page(GFP_KERNEL);
> -	if (!page) {
> -		ret = -ENOMEM;
> +	ret = xenbus_setup_ring(xb_dev, GFP_KERNEL, &page, 1, &channel->gref);
> +	if (ret)
>   		goto fail;
> -	}
>   
>   	handler_name = kasprintf(GFP_KERNEL, "%s-%s", XENSND_DRIVER_NAME,
>   				 type == EVTCHNL_TYPE_REQ ?
> @@ -226,33 +219,18 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
>   	mutex_init(&channel->ring_io_lock);
>   
>   	if (type == EVTCHNL_TYPE_REQ) {
> -		struct xen_sndif_sring *sring = (struct xen_sndif_sring *)page;
> +		struct xen_sndif_sring *sring = page;
>   
>   		init_completion(&channel->u.req.completion);
>   		mutex_init(&channel->u.req.req_io_lock);
> -		SHARED_RING_INIT(sring);
> -		FRONT_RING_INIT(&channel->u.req.ring, sring, XEN_PAGE_SIZE);
> -
> -		ret = xenbus_grant_ring(xb_dev, sring, 1, &gref);
> -		if (ret < 0) {
> -			channel->u.req.ring.sring = NULL;
> -			goto fail;
> -		}
> +		XEN_FRONT_RING_INIT(&channel->u.req.ring, sring, XEN_PAGE_SIZE);
>   
>   		handler = evtchnl_interrupt_req;
>   	} else {
> -		ret = gnttab_grant_foreign_access(xb_dev->otherend_id,
> -						  virt_to_gfn((void *)page), 0);
> -		if (ret < 0)
> -			goto fail;
> -
> -		channel->u.evt.page = (struct xensnd_event_page *)page;
> -		gref = ret;
> +		channel->u.evt.page = page;
>   		handler = evtchnl_interrupt_evt;
>   	}
>   
> -	channel->gref = gref;
> -
>   	ret = xenbus_alloc_evtchn(xb_dev, &channel->port);
>   	if (ret < 0)
>   		goto fail;
> @@ -279,8 +257,6 @@ static int evtchnl_alloc(struct xen_snd_front_info *front_info, int index,
>   	return 0;
>   
>   fail:
> -	if (page)
> -		free_page(page);
>   	kfree(handler_name);
>   	dev_err(&xb_dev->dev, "Failed to allocate ring: %d\n", ret);
>   	return ret;

-- 
Regards,

Oleksandr Tyshchenko

