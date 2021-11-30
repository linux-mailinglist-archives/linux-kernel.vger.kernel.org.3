Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD8463CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbhK3Rj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhK3RjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:39:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1BFC061574;
        Tue, 30 Nov 2021 09:36:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y13so89950178edd.13;
        Tue, 30 Nov 2021 09:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Oywvq+utTerFq6V8S/x70IeHU0QO5TyY6jTfAnkHZ9I=;
        b=cfojqhysDIMRwY+mqnD9kh3WDnYnhLEiUMTbj+w3NNvkofPxAL0FuELgxKL/o9Jqvc
         1twq8TqzePvIO+ya7YgXvK/2bJul8eN13GdklzL75WmOk8bf7btZoTtZqHPRpswx8E9h
         BCYfi9mtp+FoTixbdaVD0VDX6Jbk8wjWuJAtFIKXyEueo4+E5ipefcQu6wTdf5EIq4X8
         X4sh7jWhd+8X//LKwLTkDwqlDqEMpLbI9/qbRQ3HAxoAjV907M7DpCJLh48agnXXrfiV
         rpJsCnp9/yUrBe+MTnfRUJ85UDVpv4VeJIrKFmq6V+H4wIUmvp8bvMfPg2h/1OaPtlfj
         tl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Oywvq+utTerFq6V8S/x70IeHU0QO5TyY6jTfAnkHZ9I=;
        b=tLqneVtGT1eS9BJIf1M/JcScxuqkvEF5kFQ8lTLEaeoMNS3I9LsiUl1GmGKmm5plow
         tqVmgnm8qhVhcgKK2Ft5VlIO+6xAg1+2C7rrpjaVvIg2WHzBTHx7q0XvINzM0lMS7RhF
         gdfTKGYAbqxqH/7j4p9uvgn5sD7UO2FahU1UCrbQsVZlfVEs7GIshj+ZmTINzDjcRMTE
         Wv5RXGMUpu9UkUk8XTKv4xBMjRcErfH7ghraSSUxYNAxRPUOVoivLWB6KGB3TirAwDvj
         go3kedWN0qYiQCxzOcYjaKL1Qasff1BrCkJRwtEQ0Rg9BzPPP2eQ5BXWa6l4+vVYNhtX
         vCJQ==
X-Gm-Message-State: AOAM5301DitPnOvIfgQML/GmW5gItzsJ95wDR+3F5z3jPhWlUUm+gJpe
        G2LLmRNHmFgibvcG6GgfOKU=
X-Google-Smtp-Source: ABdhPJwX+VqmCvUvIH+Vrzn67m5keK1nVizErpKsz9xY5hMnklBKQ0T/tH8iHItv+tP4C3Zz7cXSsg==
X-Received: by 2002:a50:ce46:: with SMTP id k6mr532940edj.45.1638293760775;
        Tue, 30 Nov 2021 09:36:00 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id oz11sm9583941ejc.81.2021.11.30.09.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 09:36:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <ecb2f3c6-af8c-dd43-1dcf-0b5e8a9d8848@redhat.com>
Date:   Tue, 30 Nov 2021 18:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] scsi: virtio_scsi: Fix a NULL pointer dereference in
 virtscsi_rescan_hotunplug()
Content-Language: en-US
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matt Lupfer <mlupfer@ddn.com>,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130171901.202229-1-zhou1615@umn.edu>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211130171901.202229-1-zhou1615@umn.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 18:19, Zhou Qingyang wrote:
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -337,7 +337,11 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>   	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
>   	int result, inquiry_len, inq_result_len = 256;
>   	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
> -
> +	if (!inq_result) {
> +		pr_err("%s:no enough memory for inq_result\n",
> +			__func__);
> +		return;
> +	}
>   	shost_for_each_device(sdev, shost) {
>   		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
>   

In practice this will never happen, since the kmalloc is very small, so 
I think it's easier to just return early without a printk.  On the other 
hand, if the out-of-memory really could happen, this should be a 
pr_err_ratelimited.

Paolo
