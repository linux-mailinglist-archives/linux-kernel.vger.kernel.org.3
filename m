Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC64E4035
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiCVOJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiCVOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A39960D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647958035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKHL9IfU8rsbWgmlsBY7UeKDRyHZ9mbeqT00XEDZRos=;
        b=jNz1vfgoV3suy73GnW5D883muVvYV67iKSqImmdVNsOC6WXRSw6AzLvW1fbUk7Gmoxp7bf
        MWpZdumrKkd5O9g4qj9k0WW9+Oysyima1HcafDuLIH7847rOd9DR9+7eEsxoISb9K77sH3
        kKwry6r2aO5mU/Q+M5WhGi3hOj1thF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-2bBCQytOPR6p-t5ziwnITQ-1; Tue, 22 Mar 2022 10:07:13 -0400
X-MC-Unique: 2bBCQytOPR6p-t5ziwnITQ-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b003815245c642so1352957wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKHL9IfU8rsbWgmlsBY7UeKDRyHZ9mbeqT00XEDZRos=;
        b=wK/jUl58+lLeEUi4wtAVYQlJPsEGIL4cfUtotNd3lWvouicsM30JusKfPQXg8CKG9z
         llJlOI5jcLCHqjNVilVQcjqS9wrMkpuNxGKyXJJ2NeZBculfVlqyPl81ikLjCjj762YY
         dimGpoCdEFOKJd63r4ELw1CCdOUG51V05sefl3mFiG9fy17WezoXi4/6DZtpnRIfQDok
         lHwVXo+dlltRpaBETQuFVPU3vbtcFBeob9bEbAWHLn3VlRNDmFpNLxfhqATjYu8IqxrL
         7tuu41f9rCwEGfTNnkMIv0csKxHwf5GdCeuXzp5C009wOJKlkvo8IXGlYXSLm234Q9i3
         r7Vg==
X-Gm-Message-State: AOAM533DPe29uB/A/+TSF9sILMTDah3imZKhFb4TZgwswGx/k97mjBad
        biwRGm5pffQ4XLqybdDJ1+OHAMBxPHBcGlmWbMBbauJuGrnjnqp6j8lpwhyQ0r+uTVrTEOf1072
        tnpqjvZax9TLq7nUDUvNmx32t
X-Received: by 2002:a5d:40c8:0:b0:205:2a3b:c2c with SMTP id b8-20020a5d40c8000000b002052a3b0c2cmr2630284wrq.13.1647958031628;
        Tue, 22 Mar 2022 07:07:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpUT4GTrICCXrARvwlWmXcr/WqvuOsVfXAI5wRSHV+YMDxvpl+mz5oT10MHN/wvskk0SFTJw==
X-Received: by 2002:a5d:40c8:0:b0:205:2a3b:c2c with SMTP id b8-20020a5d40c8000000b002052a3b0c2cmr2630265wrq.13.1647958031363;
        Tue, 22 Mar 2022 07:07:11 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm9357838wrz.29.2022.03.22.07.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:07:10 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:07:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220322100635-mutt-send-email-mst@kernel.org>
References: <20220322114313.116516-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322114313.116516-1-sgarzare@redhat.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 12:43:13PM +0100, Stefano Garzarella wrote:
> After waking up a suspended VM, the kernel prints the following trace
> for virtio drivers which do not directly call virtio_device_ready() in
> the .restore:
> 
>     PM: suspend exit
>     irq 22: nobody cared (try booting with the "irqpoll" option)
>     Call Trace:
>      <IRQ>
>      dump_stack_lvl+0x38/0x49
>      dump_stack+0x10/0x12
>      __report_bad_irq+0x3a/0xaf
>      note_interrupt.cold+0xb/0x60
>      handle_irq_event+0x71/0x80
>      handle_fasteoi_irq+0x95/0x1e0
>      __common_interrupt+0x6b/0x110
>      common_interrupt+0x63/0xe0
>      asm_common_interrupt+0x1e/0x40
>      ? __do_softirq+0x75/0x2f3
>      irq_exit_rcu+0x93/0xe0
>      sysvec_apic_timer_interrupt+0xac/0xd0
>      </IRQ>
>      <TASK>
>      asm_sysvec_apic_timer_interrupt+0x12/0x20
>      arch_cpu_idle+0x12/0x20
>      default_idle_call+0x39/0xf0
>      do_idle+0x1b5/0x210
>      cpu_startup_entry+0x20/0x30
>      start_secondary+0xf3/0x100
>      secondary_startup_64_no_verify+0xc3/0xcb
>      </TASK>
>     handlers:
>     [<000000008f9bac49>] vp_interrupt
>     [<000000008f9bac49>] vp_interrupt
>     Disabling IRQ #22
> 
> This happens because we don't invoke .enable_cbs callback in
> virtio_device_restore(). That callback is used by some transports
> (e.g. virtio-pci) to enable interrupts.
> 
> Let's fix it, by calling virtio_device_ready() as we do in
> virtio_dev_probe(). This function calls .enable_cts callback and sets
> DRIVER_OK status bit.
> 
> This fix also avoids setting DRIVER_OK twice for those drivers that
> call virtio_device_ready() in the .restore.
> 
> Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> 
> I'm not sure about the fixes tag. That one is more generic, but the
> following one I think introduced the issue.
> 
> Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")

Jason what should we do about this one BTW? Just revert? We have other
issues ...


> Thanks,
> Stefano
> ---
>  drivers/virtio/virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 22f15f444f75..75c8d560bbd3 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
>  			goto err;
>  	}
>  
> -	/* Finally, tell the device we're all set */
> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
> +	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		virtio_device_ready(dev);
>  
>  	virtio_config_enable(dev);
>  
> -- 
> 2.35.1

