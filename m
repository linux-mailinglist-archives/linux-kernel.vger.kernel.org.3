Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACC752469B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350805AbiELHN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350775AbiELHNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:13:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB567D30;
        Thu, 12 May 2022 00:13:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 044DC1F8F4;
        Thu, 12 May 2022 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652339629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyxbLfNOJw/BbaFY8V1NilJt4bYAp/bOtoENiqM21v0=;
        b=qF2J1z0ztypZ0jvPu8RTEwNWgm8C2I2ME127w/TMQwEe/qozCsw0YXnpR/18s0tWQda400
        k0urc5hE186YHcuHGF0dETKGnLf4H40Po0Wf3CL+MCOOldPAgV9Ikuv8r4ll4x5UevI/hd
        Z+agi8VAW8xMokn2vrSoF0LyBdHMlYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652339629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyxbLfNOJw/BbaFY8V1NilJt4bYAp/bOtoENiqM21v0=;
        b=ky4YRyVQFlkia8sX75soOxA710QX+rZWpz7S/Cwcjj3zDZSm9Bi0WNHb2gUZ2NxQGVmXMl
        2Ar0zhoFw3DeQcDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4BF613A97;
        Thu, 12 May 2022 07:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1NdSL6yzfGK+YAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 07:13:48 +0000
Message-ID: <9598f7c1-e238-39cc-e1c9-66a63083965c@suse.de>
Date:   Thu, 12 May 2022 09:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 22/23] ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface
 support
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
 <20220511231810.4928-23-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-23-Sergey.Semin@baikalelectronics.ru>
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
> It's almost fully compatible DWC AHCI SATA IP-core derivative except the
> reference clocks source, which need to be very carefully selected. In
> particular the DWC AHCI SATA PHY can be clocked either from the pads
> ref_pad_clk_{m,p} or from the internal wires ref_alt_clk_{m,n}. In the
> later case the clock signal is generated from the Baikal-T1 CCU SATA PLL.
> The clocks source is selected by means of the ref_use_pad wire connected
> to the CCU SATA reference clock CSR.
> 
> In normal situation it would be much more handy to use the internal
> reference clock source, but alas we haven't managed to make the AHCI
> controller working well with it so far. So it's preferable to have the
> controller clocked from the external clock generator and fallback to the
> internal clock source only as a last resort. Other than that the
> controller is full compatible with the DWC AHCI SATA IP-core.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Rename 'syscon' property to 'baikal,bt1-syscon'.
> - Change the local objects prefix from 'dwc_ahci_' to 'ahci_dwc_',
>    from 'bt1_ahci_' to 'ahci_bt1_'. (@Damien)
> ---
>   drivers/ata/Kconfig    |  1 +
>   drivers/ata/ahci_dwc.c | 87 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 88 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
