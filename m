Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9AE5467A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiFJNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245503AbiFJNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:50:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B127E3B560
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67750B83528
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE05C3411D;
        Fri, 10 Jun 2022 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654869021;
        bh=laTvEZD9DA2zNh987KZtMGrDWbd2vtytBDlD61v/1K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3kHAGd6bsE5oc60UMNQn6GydFcdPUDBFsOt3lUfahKAnMf9kqtDyrZ+SEvT6FcrX
         aHmcZkJXL5SyqYaBVCaTaFr8NIfnwEz2M9ocT2JhBMT44c0RUDdTEmtk40pTfVpYs8
         C1ItzJ5LCed34pMGFccRhfk1ZRE7NoYqncnYd8Rs=
Date:   Fri, 10 Jun 2022 15:50:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pascal Terjan <pterjan@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vboxguest: add missing devm_free_irq
Message-ID: <YqNMGgwsjhB7TNzk@kroah.com>
References: <20220609134057.2485190-1-pterjan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609134057.2485190-1-pterjan@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 02:40:57PM +0100, Pascal Terjan wrote:
> This fixes the following warning when unloading the module:
> 
> [249348.837181] remove_proc_entry: removing non-empty directory 'irq/20', leaking at least 'vboxguest'
> [249348.837219] WARNING: CPU: 0 PID: 6708 at fs/proc/generic.c:715 remove_proc_entry+0x119/0x140
> 
> [249348.837379] Call Trace:
> [249348.837385]  unregister_irq_proc+0xbd/0xe0
> [249348.837392]  free_desc+0x23/0x60
> [249348.837396]  irq_free_descs+0x4a/0x70
> [249348.837401]  irq_domain_free_irqs+0x160/0x1a0
> [249348.837452]  mp_unmap_irq+0x5c/0x60
> [249348.837458]  acpi_unregister_gsi_ioapic+0x29/0x40
> [249348.837463]  acpi_unregister_gsi+0x17/0x30
> [249348.837467]  acpi_pci_irq_disable+0xbf/0xe0
> [249348.837473]  pcibios_disable_device+0x20/0x30
> [249348.837478]  pci_disable_device+0xef/0x120
> [249348.837482]  vbg_pci_remove+0x6c/0x70 [vboxguest]
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
>  drivers/virt/vboxguest/vboxguest_linux.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 6e8c0f1c1056..faa4bc9f625c 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -423,6 +423,7 @@ static void vbg_pci_remove(struct pci_dev *pci)
>  	vbg_gdev = NULL;
>  	mutex_unlock(&vbg_gdev_mutex);
>  
> +	devm_free_irq(gdev->dev, pci->irq, gdev);

The whope point of using devm_* calls is so you don't have to do stuff
like this.  Perhaps this should not be using devm_() for the irq at all?

thanks,

greg k-h
