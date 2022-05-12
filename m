Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D501C524688
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350768AbiELHKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350737AbiELHKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:10:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473504F458;
        Thu, 12 May 2022 00:09:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55C751F8FC;
        Thu, 12 May 2022 07:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652339398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YTeq3bgzSPaVuLGaqRCjfaRR/vlf82CJNzYdqugFFs=;
        b=tl6Mut03phzMygltCi6JQerbNZ35unhAqsBD2XkyI5zKqEkykH6XSHxtTvwOeyL8iO7z1G
        mR4uyDUTG54UKEdDz7b/UHLKxgkyTU9yNhVgQWcl3XC+SUnpWU7ouyz9hXZpvnqd6xP6De
        k4/qdv3lz0SGc+6Mwsw4kwYGfzprMSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652339398;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YTeq3bgzSPaVuLGaqRCjfaRR/vlf82CJNzYdqugFFs=;
        b=bPl55kAucC1SfgjeAPsHnjFUjWHlVckWJhILe3iQfWBykwT8QO2gBOlQlblYs+q2F3LvPN
        OBqWPTrzWwc+FqCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E60D13A97;
        Thu, 12 May 2022 07:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iAsvB8ayfGL9XgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 07:09:58 +0000
Message-ID: <41c76c4e-dc33-e324-be3b-ba2f3ba4dbd8@suse.de>
Date:   Thu, 12 May 2022 09:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 19/23] ata: ahci: Add DWC AHCI SATA controller support
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-20-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-20-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 01:18, Serge Semin wrote:
> Synopsys AHCI SATA controller can work pretty under with the generic
> AHCI-platform driver control. But there are vendor-specific peculiarities
> which can tune the device performance up and which may need to be fixed up
> for proper device functioning. In addition some DWC AHCI-based controllers
> may require small platform-specific fixups, so adding them in the generic
> AHCI driver would have ruined the code simplicity. Shortly speaking in
> order to keep the generic AHCI-platform code clean and have DWC AHCI
> SATA-specific features supported we suggest to add a dedicated DWC AHCI
> SATA device driver. Aside with the standard AHCI-platform resources
> getting, enabling/disabling and the controller registration the new driver
> performs the next actions.
> 
> First of all there is a way to verify whether the HBA/ports capabilities
> activated in OF are correct. Almost all features availability is reflected
> in the vendor-specific parameters registers. So the DWC AHCI driver does
> the capabilities sanity check based on the corresponding fields state.
> 
> Secondly if either the Command Completion Coalescing or the Device Sleep
> feature is enabled the DWC AHCI-specific internal 1ms timer must be fixed
> in accordance with the application clock signal frequency. In particular
> the timer value must be set to be Fapp * 1000. Normally the SoC designers
> pre-configure the TIMER1MS register to contain a correct value by default.
> But the platforms can support the application clock rate change. If that
> happens the 1ms timer value must be accordingly updated otherwise the
> dependent features won't work as expected. In the DWC AHCI driver we
> suggest to rely on the "aclk" reference clock rate to set the timer
> interval up. That clock source is supposed to be the AHCI SATA application
> clock in accordance with the DT bindings.
> 
> Finally DWC AHCI SATA controller AXI/AHB bus DMA-engine can be tuned up to
> transfer up to 1024 * FIFO words at a time by setting the Tx/Rx
> transaction size in the DMA control register. The maximum value depends on
> the DMA data bus and AXI/AHB bus maximum burst length. In most of the
> cases it's better to set the maximum possible value to reach the best AHCI
> SATA controller performance. But sometimes in order to improve the system
> interconnect responsiveness, transferring in smaller data chunks may be
> more preferable. For such cases and for the case when the default value
> doesn't provide the best DMA bus performance we suggest to use the new
> HBA-port specific DT-properties "snps,{tx,rx}-ts-max" to tune the DMA
> transactions size up.
> 
> After all the settings denoted above are handled the DWC AHCI SATA driver
> proceeds further with the standard AHCI-platform host initializations.
> 
> Note since DWC AHCI controller is now have a dedicated driver we can
> discard the corresponding compatible string from the ahci-platform.c
> module. The same concerns "snps,spear-ahci" compatible string, which is
> also based on the DWC AHCI IP-core.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Note there are three more AHCI SATA drivers which have been created for
> the devices based on the DWC AHCI SATA IP-core. It's AHCI SunXi, St and
> iMX drivers. Mostly they don't support the features implemented in this
> driver. So hopefully sometime in future they can be converted to be based
> on the generic DWC AHCI SATA driver and just perform some
> subvendor-specific setups in their own LLDD (glue) driver code. But for
> now let's leave the generic DWC AHCI SATA code as is. Hopefully the new
> DWC AHCI-based device drivers will try at least to re-use a part of the
> DWC AHCI driver methods if not being able to be integrated in the generic
> DWC driver code.
> 
> Changelog v2:
> - Change the local objects prefix from 'dwc_ahci_' to 'ahci_dwc_'.
>    (@Damien)
> ---
>   drivers/ata/Kconfig         |  10 +
>   drivers/ata/Makefile        |   1 +
>   drivers/ata/ahci_dwc.c      | 395 ++++++++++++++++++++++++++++++++++++
>   drivers/ata/ahci_platform.c |   2 -
>   4 files changed, 406 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/ata/ahci_dwc.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
