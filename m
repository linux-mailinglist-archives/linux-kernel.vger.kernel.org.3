Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF0A54AF3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbiFNLVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiFNLVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6281324586
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655205669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7SxsmV/cct0OfUWiXlAK240sm6l//STTN9BwQ5eJ0Zo=;
        b=Xc3nLvL4+3AZWmIDceA88racEa1PkEEbhjdN19kHsG0U9C40kpaspglxcTh9rMWegJd2lT
        RMrrWyHsCdrqghlyHKmQWo+3tdpbLQz1/M5qV/1RysRaycP7qJmmLsbrF9UU2H242XWaDK
        ZUf2VWTE81U4Bo+iMaNkyLeNoIu3jao=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616--E2vS65XPvCS4LxiiuMC4w-1; Tue, 14 Jun 2022 07:21:08 -0400
X-MC-Unique: -E2vS65XPvCS4LxiiuMC4w-1
Received: by mail-qv1-f69.google.com with SMTP id kk8-20020a056214508800b004645738eff6so5721267qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7SxsmV/cct0OfUWiXlAK240sm6l//STTN9BwQ5eJ0Zo=;
        b=oAawfvNQgarZg0gntD1zpf8ajMHYW+9QHAZ4WIxJthvbFWwxtotwgHawJlGgJVBjHK
         odfa/42isSg9XSjABK9YcFwpd8theI0rFOy5VghhJ+TIj8mgWdH8ys3NSU4o8K9URRLw
         9GfpAoeMn1X50oXkHMiA786FV3xq4fZqCEZ1qlivTmOZYornn+wmy6jWMnPpLnygRTJQ
         UXcbY2x+ODH9/4cZex/q3mkI6UyA1o2dx3Mtoqm8yyv7hX1TvGqJuXlKVnll/z9gKJcc
         8s05tytVrPstFCRtYDbazv/Mgnn5GSSKxVHmsOoZMHf/rghlxZf7Myb6cYH90OXhece3
         gGgg==
X-Gm-Message-State: AOAM532kVCf4B8c918/VExNXHsDl+ChCWDEIbhXrZYBa/UWzLtH0kMK9
        tFk+Sqm4rfMRh3UUvL+hoXyvlQHvCLRJfq7Rc5WoKcZl7v1GAeuX8+8hd777zLuFxqFJdluFDVh
        7JSydpaV9DRUWhDocDZ4sog+p
X-Received: by 2002:a05:620a:24d4:b0:6a7:1d74:d8e6 with SMTP id m20-20020a05620a24d400b006a71d74d8e6mr3309165qkn.379.1655205667840;
        Tue, 14 Jun 2022 04:21:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDl47tobdeW5TSFOvVnSdU5ZMQsmZTonzmmgKmcL5N8ZINIiP2+jeWdXrxkoVv8MfhRl3TJg==
X-Received: by 2002:a05:620a:24d4:b0:6a7:1d74:d8e6 with SMTP id m20-20020a05620a24d400b006a71d74d8e6mr3309146qkn.379.1655205667506;
        Tue, 14 Jun 2022 04:21:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a455500b006a6edbbca84sm8323602qkp.94.2022.06.14.04.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:21:07 -0700 (PDT)
Message-ID: <ebc26df487674f25803d59a39ceb7018ab5df4fc.camel@redhat.com>
Subject: Re: [PATCH] Fix a use-after-free bug
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wentao_Liang <Wentao_Liang_g@163.com>, jdmason@kudzu.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jun 2022 13:21:02 +0200
In-Reply-To: <20220614012853.10560-1-Wentao_Liang_g@163.com>
References: <20220614012853.10560-1-Wentao_Liang_g@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 09:28 +0800, Wentao_Liang wrote:
> The pointer vdev points to a memory region adjacent to a net_device
> structure ndev, which is a field of hldev. At line 4740, the invocation
> to vxge_device_unregister unregisters device hldev, and it also releases
> the memory region pointed by vdev->bar0. At line 4743, the freed memory
> region is referenced (i.e., iounmap(vdev->bar0)), resulting in a
> use-after-free vulnerability. We can fix the bug by calling iounmap
> before vxge_device_unregister.
> 
> 4721.      static void vxge_remove(struct pci_dev *pdev)
> 4722.      {
> 4723.             struct __vxge_hw_device *hldev;
> 4724.             struct vxgedev *vdev;
> …
> 4731.             vdev = netdev_priv(hldev->ndev);
> …
> 4740.             vxge_device_unregister(hldev);
> 4741.             /* Do not call pci_disable_sriov here, as it
> 						will break child devices */
> 4742.             vxge_hw_device_terminate(hldev);
> 4743.             iounmap(vdev->bar0);
> …
> 4749              vxge_debug_init(vdev->level_trace, "%s:%d
> 								Device unregistered",
> 4750                            __func__, __LINE__);
> 4751              vxge_debug_entryexit(vdev->level_trace, "%s:%d
> 								Exiting...", __func__,
> 4752                          __LINE__);
> 4753.      }
> 
> This is the screenshot when the vulnerability is triggered by using
> KASAN. We can see that there is a use-after-free reported by KASAN.
> 
> /***********************report begin***************************/
> 
> root@kernel:~# echo 1 > /sys/bus/pci/devices/0000:00:03.0/remove
> [  178.296316] vxge_remove
> [  182.057081]
>  ==================================================================
> [  182.057548] BUG: KASAN: use-after-free in vxge_remove+0xe0/0x15c
> [  182.057760] Read of size 8 at addr ffff888006c76598 by task bash/119
> [  182.057983]
> [  182.058747] CPU: 0 PID: 119 Comm: bash Not tainted 5.18.0 #5
> [  182.058919] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  182.059463] Call Trace:
> [  182.059726]  <TASK>
> [  182.060017]  dump_stack_lvl+0x34/0x44
> [  182.060316]  print_report.cold+0xb2/0x6b7
> [  182.060401]  ? kfree+0x89/0x290
> [  182.060478]  ? vxge_remove+0xe0/0x15c
> [  182.060545]  kasan_report+0xa9/0x120
> ...
> [  182.070606]
>  ==================================================================
> [  182.071374] Disabling lock debugging due to kernel taint
> 
> /************************report end***************************/

It's better to include a complete backtrace

> 
> After fixing the bug as done in the patch, we can find KASAN do not report
>  the bug and the device(00:03.0) has been successfully removed.
> 
> /************************report begin*************************/
> 
> root@kernel:~# echo 1 > /sys/bus/pci/devices/0000:00:03.0/remove
> root@kernel:~#
> 
> /************************report end***************************/
> 
> Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>

Please include a 'Fixes' tag pointing to the commit introducing the
bug, and please specify the relevant target tree and driver in the
patch subj. It should be something alike:

[PATCH net v2] vxge: fix a use-after-free bug

Thanks,

Paolo

> ---
>  drivers/net/ethernet/neterion/vxge/vxge-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/neterion/vxge/vxge-main.c b/drivers/net/ethernet/neterion/vxge/vxge-main.c
> index fa5d4ddf429b..092fd0ae5831 100644
> --- a/drivers/net/ethernet/neterion/vxge/vxge-main.c
> +++ b/drivers/net/ethernet/neterion/vxge/vxge-main.c
> @@ -4736,10 +4736,10 @@ static void vxge_remove(struct pci_dev *pdev)
>  	for (i = 0; i < vdev->no_of_vpath; i++)
>  		vxge_free_mac_add_list(&vdev->vpaths[i]);
>  
> +	iounmap(vdev->bar0);
>  	vxge_device_unregister(hldev);
>  	/* Do not call pci_disable_sriov here, as it will break child devices */
>  	vxge_hw_device_terminate(hldev);
> -	iounmap(vdev->bar0);
>  	pci_release_region(pdev, 0);
>  	pci_disable_device(pdev);
>  	driver_config->config_dev_cnt--;

