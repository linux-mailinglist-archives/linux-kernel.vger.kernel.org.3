Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E365245DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350434AbiELGbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350455AbiELGbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:31:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099DC590AE;
        Wed, 11 May 2022 23:31:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F6751F8D1;
        Thu, 12 May 2022 06:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652337096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRQS9L/0bznAdWbDafHhTvbRIqnEumt8vUfzjQrF2aY=;
        b=tBEJeDGa5baSIwxn79Wzt2IGDPoxfom0djedUuiHJPkxhKRjYsQVgbLeW1/RmtdD4qBStd
        JhanFA1ChP2fo9Ap5al2uL8WfYKvYGzqnQI7KsO6sbRKyHyoE5GmyX14hUG+3XcODwC6Q+
        4lcbiUH5GCtzqvnDQykqIDO+tlgTg1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652337096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRQS9L/0bznAdWbDafHhTvbRIqnEumt8vUfzjQrF2aY=;
        b=2yaVCxnnyGHVu31nVMoEONHw/E9ouHo/YIbgDA4UMG1ro591mbKuerkia4J2Lqt9RREeM4
        wXKXdMI3R6sXLhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88C8F13ABE;
        Thu, 12 May 2022 06:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ccnqH8ipfGL5TwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:31:36 +0000
Message-ID: <558a7c85-03a2-8c30-5b2e-80cc88b7e693@suse.de>
Date:   Thu, 12 May 2022 08:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
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
 <20220511231810.4928-8-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-8-Sergey.Semin@baikalelectronics.ru>
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
> In order to simplify the clock-related code there is a way to convert the
> current fixed clocks array into using the common bulk clocks kernel API
> with dynamic set of the clock handlers and device-managed clock-resource
> tracking. It's a bit tricky due to the complication coming from the
> requirement to support the platforms (da850, spear13xx) with the
> non-OF-based clock source, but still doable.
> 
> Before this modification there are two methods have been used to get the
> clocks connected to an AHCI device: clk_get() - to get the very first
> clock in the list and of_clk_get() - to get the rest of them. Basically
> the platforms with non-OF-based clocks definition could specify only a
> single reference clock source. The platforms with OF-hw clocks have been
> luckier and could setup up to AHCI_MAX_CLKS clocks. Such semantic can be
> retained with using devm_clk_bulk_get_all() to retrieve the clocks defined
> via the DT firmware and devm_clk_get_optional() otherwise. In both cases
> using the device-managed version of the methods will cause the automatic
> resources deallocation on the AHCI device removal event. The only
> complicated part in the suggested approach is the explicit allocation and
> initialization of the clk_bulk_data structure instance for the non-OF
> reference clocks. It's required in order to use the Bulk Clocks API for
> the both denoted cases of the clocks definition.
> 
> Note aside with the clock-related code reduction and natural
> simplification, there are several bonuses the suggested modification
> provides. First of all the limitation of having no greater than
> AHCI_MAX_CLKS clocks is now removed, since the devm_clk_bulk_get_all()
> method will allocate as many reference clocks data descriptors as there
> are clocks specified for the device. Secondly the clock names are
> auto-detected. So the LLDD (glue) drivers can make sure that the required
> clocks are specified just by checking the clock IDs in the clk_bulk_data
> array.  Thirdly using the handy Bulk Clocks kernel API improves the
> clocks-handling code readability. And the last but not least this
> modification implements a true optional clocks support to the
> ahci_platform_get_resources() method. Indeed the previous clocks getting
> procedure just stopped getting the clocks on any errors (aside from
> non-critical -EPROBE_DEFER) in a way so the callee wasn't even informed
> about abnormal loop termination. The new implementation lacks of such
> problem. The ahci_platform_get_resources() will return an error code if
> the corresponding clocks getting method ends execution abnormally.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Convert to checking the error-case first in the devm_clk_bulk_get_all()
>    method invocation. (@Damien)
> - Fix some grammar mistakes in the comments.
> ---
>   drivers/ata/ahci.h             |  4 +-
>   drivers/ata/libahci_platform.c | 84 ++++++++++++++++------------------
>   2 files changed, 41 insertions(+), 47 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
