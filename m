Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B050C524630
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350589AbiELGyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiELGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:54:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5941F21F1F9;
        Wed, 11 May 2022 23:54:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18B4B21C97;
        Thu, 12 May 2022 06:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652338482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOwIOvq9h82O6Kf9zmG0oPYVnBBO3fd3gQ7NdWfuTsY=;
        b=jdtrMGEIE/XUM1k9S6P6YjCGCtva0SelKbt5tyAt7nc2QOx6VL8+6Lq4T3M2TQWkRZbImC
        D1a5TIV9Wdn8lNcOutxxUfaUEtCnGnwhSXubvpm3Sp8L0MJzexeuVYHqjvc7UrwgZNmq0d
        qP78xDyxKC7iBiulumbHEiTpi1xpEBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652338482;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOwIOvq9h82O6Kf9zmG0oPYVnBBO3fd3gQ7NdWfuTsY=;
        b=1NW8T78kjhRQRC/d1+MmA4WyWEwNRj3Vfc5RzdXtAu+ThA7J9gbTNbKXC3mu5NNU3iUaFU
        bOTdARje4LPapPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8B6B13A97;
        Thu, 12 May 2022 06:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BkoLNjGvfGJtWAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:54:41 +0000
Message-ID: <447f74bb-e1d7-3f6c-9cf8-1db774582803@suse.de>
Date:   Thu, 12 May 2022 08:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 11/23] ata: libahci_platform: Introduce reset
 assertion/deassertion methods
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-12-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-12-Sergey.Semin@baikalelectronics.ru>
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

On 5/12/22 01:17, Serge Semin wrote:
> Currently the ACHI-platform library supports only the assert and deassert
> reset signals and ignores the platforms with self-deasserting reset lines.
> That prone to having the platforms with self-deasserting reset method
> misbehaviour when it comes to resuming from sleep state after the clocks
> have been fully disabled. For such cases the controller needs to be fully
> reset all over after the reference clocks are enabled and stable,
> otherwise the controller state machine might be in an undetermined state.
> 
> The best solution would be to auto-detect which reset method is supported
> by the particular platform and use it implicitly in the framework of the
> ahci_platform_enable_resources()/ahci_platform_disable_resources()
> methods. Alas it can't be implemented due to the AHCI-platform library
> already supporting the shared reset control lines. As [1] says in such
> case we have to use only one of the next methods:
> + reset_control_assert()/reset_control_deassert();
> + reset_control_reset()/reset_control_rearm().
> If the driver had an exclusive control over the reset lines we could have
> been able to manipulate the lines with no much limitation and just used
> the combination of the methods above to cover all the possible
> reset-control cases. Since the shared reset control has already been
> advertised and couldn't be changed with no risk to breaking the platforms
> relying on it, we have no choice but to make the platform drivers to
> determine which reset methods the platform reset system supports.
> 
> In order to implement both types of reset control support we suggest to
> introduce the new AHCI-platform flag: AHCI_PLATFORM_RST_TRIGGER, which
> when passed to the ahci_platform_get_resources() method together with the
> AHCI_PLATFORM_GET_RESETS flag will indicate that the reset lines are
> self-deasserting thus the reset_control_reset()/reset_control_rearm() will
> be used to control the reset state. Otherwise the
> reset_control_deassert()/reset_control_assert() methods will be utilized.
> 
> [1] Documentation/driver-api/reset.rst
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Convert the ahci_platform_assert_rsts() method to returning int status
>    (@Damien).
> - Fix some grammar mistakes in the ahci_platform_deassert_rsts() doc
>    (@Damien).
> ---
>   drivers/ata/ahci.h             |  1 +
>   drivers/ata/libahci_platform.c | 50 ++++++++++++++++++++++++++++++----
>   include/linux/ahci_platform.h  |  5 +++-
>   3 files changed, 50 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
