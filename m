Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F10543019
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiFHMR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbiFHMRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0831631D0DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654690669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YcjX7Mzre3/CuVSw3ObM9yGuU5oHF1kPeGtO/PJKO5Q=;
        b=KswRAa3Zz20qopMg8tdysRQ2ubqcZxvUhvEXa3FbDk171E6Dp0LYIAu8jGckZkPuF5SdNf
        NDWyVWxTmEaScK1UPDL6tnFi9+NzgqJSeIorJsIDRdcpSFfAK65fRYUUgqD1QRAPGbj1iP
        9TdQ9+PrafAeYdV3PEGId55EHIBIDLo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-lT999sZeMV6RO6N2LR5yDA-1; Wed, 08 Jun 2022 08:17:47 -0400
X-MC-Unique: lT999sZeMV6RO6N2LR5yDA-1
Received: by mail-wm1-f70.google.com with SMTP id c187-20020a1c35c4000000b003970013833aso6886359wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 05:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YcjX7Mzre3/CuVSw3ObM9yGuU5oHF1kPeGtO/PJKO5Q=;
        b=THDtxAHTPuXV9UFgJYToQMBdEbLcbaN7Js8lUaRVeRnb8c1jTwRLa5x49h2mUYlvlB
         X2UkiXVnl55wEtcqBaKDPHRmYBfO4yEAUILujNajDAplgliaYVdeTN3BeNQexyuBFKLs
         Ja1cAO3HSEvJAaDp1E1biOtMX8JbRtMJXyiolisoD+d2QyP4JSk/4j3QsitjV03FoebK
         n0JAyW+zyOgEUsKp5YVcMar3q9mA1/uLxG//fUDvZlztu0ny8WmizhUTByjKPEjJ3iLj
         WDy9ksabvh0x16JWWVfTqVBsX4UixlXfLslOh53jsv9tGu53+EdfO7K8kbG38t53Fueb
         OGuw==
X-Gm-Message-State: AOAM532AwL6SrIjmjQ8KLJ2qhSLYhiS9wPn4JyDDR+xE4TJe0Tx3vUH3
        G1ncGZAhNZtZYBQbIlY6wKn+Jzbv++9vSsbnfcNlvNwI0I4ewYIynxh1KAFbPKLVts5RluZ2/ov
        uPZKLjIqKwGMxgJCRbCEyWp1D
X-Received: by 2002:a7b:c456:0:b0:39c:5d1e:661d with SMTP id l22-20020a7bc456000000b0039c5d1e661dmr6766264wmi.15.1654690665561;
        Wed, 08 Jun 2022 05:17:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhB5F/YKBuA1EQJjZy/6+/2wi5xPPNaYbmj+q+lC1WIQOtuFnB+ySu91ByQwH9OU7QY+fscw==
X-Received: by 2002:a7b:c456:0:b0:39c:5d1e:661d with SMTP id l22-20020a7bc456000000b0039c5d1e661dmr6766240wmi.15.1654690665312;
        Wed, 08 Jun 2022 05:17:45 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.8.70])
        by smtp.gmail.com with ESMTPSA id z14-20020adfd0ce000000b00215bd1680a8sm13919633wrh.79.2022.06.08.05.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 05:17:44 -0700 (PDT)
Message-ID: <8733913f-b04b-f2c7-d7e2-d22740ab99af@redhat.com>
Date:   Wed, 8 Jun 2022 14:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] virtio-rng: make device ready before making request
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com, mpm@selenic.com,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
References: <20220608061422.38437-1-jasowang@redhat.com>
From:   Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20220608061422.38437-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 08:14, Jason Wang wrote:
> Current virtio-rng does a entropy request before DRIVER_OK, this
> violates the spec and kernel will ignore the interrupt after commit
> 8b4ec69d7e09 ("virtio: harden vring IRQ").
> 
> Fixing this by making device ready before the request.
> 
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Reported-and-tested-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/char/hw_random/virtio-rng.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index e856df7e285c..a6f3a8a2aca6 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -159,6 +159,8 @@ static int probe_common(struct virtio_device *vdev)
>   		goto err_find;
>   	}
>   
> +	virtio_device_ready(vdev);
> +
>   	/* we always have a pending entropy request */
>   	request_entropy(vi);
>   

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

