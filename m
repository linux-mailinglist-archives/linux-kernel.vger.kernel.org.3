Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8583F524648
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350614AbiELHAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiELHAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:00:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32CB4A3FF;
        Thu, 12 May 2022 00:00:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 825EA1F91B;
        Thu, 12 May 2022 07:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652338816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qppk/eycRG8UmCYQVIByFr5dV8L34E8F44pWDD/iM7Y=;
        b=Qw6+ozlFIQ/cD2ayEv1gDY60xV7NqRh+P7G3l7lpXtryWI5ywu1/0CF9Gsxrxz31eNGh6D
        pmKC+8Q/EAdC0sfUuNWCH8AkRkuJqcRlIqzhXwKoXjQ1o2wE4hdRGjaswG3mJCFeN3I0HR
        HqFG3JWCFCt2KmDQ6Iq4+7MfrURQ9uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652338816;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qppk/eycRG8UmCYQVIByFr5dV8L34E8F44pWDD/iM7Y=;
        b=CnWF3XAM029nSzPha0PHofmionce+xos7vCSDRLdY50+Taid0KvXDXgtbfRdhJCJr66C/0
        zVPDuqrt4+JBp5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E3E313A97;
        Thu, 12 May 2022 07:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id imaWDoCwfGILWwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 07:00:16 +0000
Message-ID: <12c73812-c544-5859-3fc0-38b65785f987@suse.de>
Date:   Thu, 12 May 2022 09:00:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 14/23] ata: libahci: Discard redundant force_port_map
 parameter
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
 <20220511231810.4928-15-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-15-Sergey.Semin@baikalelectronics.ru>
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
> Currently there are four port-map-related fields declared in the
> ahci_host_priv structure and used to setup the HBA ports mapping. First
> the ports-mapping is read from the PI register and immediately stored in
> the saved_port_map field. If forced_port_map is initialized with non-zero
> value then its value will have greater priority over the value read from
> PI, thus it will override the saved_port_map field. That value will be
> then masked by a non-zero mask_port_map field and after some sanity checks
> it will be stored in the ahci_host_priv.port_map field as a final port
> mapping.
> 
> As you can see the logic is a bit too complicated for such a simple task.
> We can freely get rid from at least one of the fields with no change to
> the implemented semantic. The force_port_map field can be replaced with
> taking non-zero saved_port_map value into account. So if saved_port_map is
> pre-initialized by the low level drivers (platform drivers) then it will
> have greater priority over the value read from PI register and will be
> used as actual HBA ports mapping later on. Thus the ports map forcing task
> will be just transferred from the force_port_map to saved_port_map field.
> 
> This modification will perfectly fit into the feature of having OF-based
> initialization of the HW-init HBA CSR fields we are about to introduce in
> the next commit.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>   drivers/ata/ahci.c             |  2 +-
>   drivers/ata/ahci.h             |  1 -
>   drivers/ata/libahci.c          | 10 ++++++----
>   drivers/ata/libahci_platform.c |  2 +-
>   4 files changed, 8 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
